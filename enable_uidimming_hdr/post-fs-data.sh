#!/system/bin/sh

MODPATH="${0%/*}"

# set -x
# exec > "$MODPATH/log.txt" 2>&1

# ==========================================
# 挂载函数 (定义在最前方便调用)
# Credits: https://github.com/TTTTTony32/OnePlus-13-Brightness-Tweaks
# ==========================================
mount_file() {
    local mod_file="$1"
    local target_file="$2"
    
    if [ -s "$mod_file" ] && [ -f "$target_file" ]; then
        mount -o bind "$mod_file" "$target_file"
        chmod 0644 "$mod_file"
        chcon u:object_r:system_file:s0 "$mod_file" 2>/dev/null
    fi
}

# ==========================================
# 编辑 XML 添加特性
# Credits: The port script
# ==========================================
add_feature_v2() {
    type=$1
    shift # 移除第一个参数
    file_path=$1
    shift

    case "$type" in
        oplus_feature)
            root_tag="oplus-config"
            node_tag="oplus-feature"
            attr_prefix='name='
            ;;
        app_feature)
            root_tag="extend_features"
            node_tag="app_feature"
            attr_prefix='name=' # 后面拼上 args
            ;;
        permission_feature)
            root_tag="permissions"
            node_tag="feature"
            attr_prefix='name='
            ;;
        permission_oplus_feature)
            root_tag="oplus-config"
            node_tag="oplus-feature"
            attr_prefix='name='
            ;;
        *)
            echo "❌ Invalid type: $type"
            return 1
            ;;
    esac

    if [[ ! -f "$file_path" ]]; then
        echo "❌ File not exist: $file_path"
        return 2
    fi

    for entry in "$@"; do
        feature=$(echo "$entry^" | cut -d'^' -f1)
        comment=$(echo "$entry^" | cut -d'^' -f2)
        extra=$(echo "$entry^" | cut -d'^' -f3)
        
        [[ "$feature" == "$comment" ]] && comment=""
        
        [[ -z "$extra" ]] && extra=""

        found=0
        if grep -n "$feature" "$file_path" | grep -vq "<!--"; then
            echo "Feature $feature exists, skipping..."
            found=1
            break
        fi

        if [[ $found == 0 ]]; then
            echo "Add feature: $feature"

            attrs="name=\"$feature\""
            [[ -n "$extra" ]] && attrs="$attrs $extra"

            # 写入备注
            if [[ -n "$comment" ]]; then
                sed -i "/<\/$root_tag>/i\\\t<!-- $comment -->" "$file_path"
            fi
            # 写入 feature 节点
            sed -i "/<\/$root_tag>/i\\\t<$node_tag $attrs\/>" "$file_path"
        fi
    done
}

if [[ ! -d "$MODPATH/generated" ]]; then
    mkdir "$MODPATH/generated"
fi

# 使用 find 或者直接 shell 通配符遍历
for target_file in "/my_product/etc/extension/com.oplus.oplus-feature.xml"; do
    if [ -f "$target_file" ]; then
        echo "Handling file: $target_file"

        filename=$(basename "$target_file")
        mod_file="$MODPATH/generated/$filename"
        
        # 复制原文件
        cp "$target_file" "$mod_file"
        
        # 添加 feature
        add_feature_v2 oplus_feature "$mod_file" oplus.software.display.enhance_brightness_with_uidimming
        
        # 挂载
        mount_file "$mod_file" "$target_file"
    else
        echo "File not found: $target_file"
    fi
done
