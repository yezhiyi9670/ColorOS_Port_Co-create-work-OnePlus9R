# 为 OnePlus 9R CN 移植 ColorOS 16 实验记录

移植脚本仓库：[GitHub - xwdy114514/ColorOS_Port_Co-create: OnePlus 8/8Pro/8T/9/9Pro/9R Ace3V ColorOS/OxgenOS 14-16 porting project · GitHub](https://github.com/xwdy114514/ColorOS_Port_Co-create)

受体：LE2100_14.0.0.605-CN01（OnePlus 9R CN，[大侠阿木资源站可下载](https://yun.daxiaamu.com/OnePlus_Roms/%E4%B8%80%E5%8A%A09R/ColorOS%20LE2100_14.0.0.605(CN01)%20H.28/)）

供体：PKX110_16.0.3.502-CN01（OnePlus 13T CN，[DanielSpringer OTA 下载器可下载](https://roms.danielspringer.at/index.php?view=ota)）

操作系统：Ubuntu 24.04

移植测试中的 TWRP 和内核取自 @wcedla 的 ColorOS 16 移植包。链接：[123云盘](https://www.123865.com/s/Hn93jv-xSzUA?pwd=NC51#)

> **⚠️ 注意**
>
> ColorOS 14 的原装内核不能启动 Android 16，因此 ColorOS 16 移植版必须使用自定义内核启动。此处使用 @wcedla 的 ColorOS 16 移植内核，意义在此。

## 功能情况

### 声音与振动

|功能项|结果|备注|
|-|-|-|
|扬声器|✅|
|有线耳机（数字信号解码器）|✅|
|有线耳机（模拟信号转接头）|❔|未测试，因为没有测试器材|
|多音量|✅|
|杜比全景声|✅|
|空间音频|❌|选择后无效果，且会自动切回「原声」模式|
|人声突显|❔|未测试|
|振动|ℹ️|密码安全键盘振动反馈缺失，其余正常|

### 电话与移动网络

|功能项|结果|备注|
|-|-|-|
|移动网络|✅|
|电话|✅|
|短信|✅|
|紧急呼叫|❔|未测试|
|4G|✅|
|5G|✅|
|双卡|❔|未测试|

### 系统安全

|功能项|结果|备注|
|-|-|-|
|SELinux 强制模式|✅|
|用户数据加密（FBE）|✅|
|无内置 root|✅|可选择刷入带 SukiSU Ultra 的内核|

- **非官方系统**：支付宝等应用可能会认为该系统构建是第三方系统，因此无法提供高级安全功能，例如指纹支付。

- **USB 调试每次重启都会自动启用，即使开发者选项已关闭**：这是原版 ColorOS 的 bug，在 Bootloader 解锁的情况下会发作。adb shell 执行命令 `setprop persist.sys.adb.engineermode 0` 即可持久修复，恢复出厂设置会使该修复失效。

### 连接

|功能项|结果|备注|
|-|-|-|
|Wi-Fi|✅|
|Wi-Fi 5GHz|✅|
|个人热点|✅|
|USB 主设备|✅|
|USB 文件传输|✅|
|USB 网络共享|❔|未测试|
|USB MIDI 设备|❔|未测试|
|USB 3.x 速度|✅|
|蓝牙|✅|
|蓝牙网络共享|❔|未测试|
|蓝牙耳机|❔|未测试|
|蓝牙文件传输|✅|
|NFC 识别|✅|
|NFC 门禁卡|✅|
|一加互传|✅|

### 定位

|功能项|结果|备注|
|-|-|-|
|卫星定位|✅|
|网络定位服务|✅|

### 相机

|功能项|结果|备注|
|-|-|-|
|后置主摄像头|✅|
|后置额外摄像头|✅|其余 3 个摄像头均能工作|
|前置摄像头|✅|
|自动对焦|✅|
|OIS|✅|
|录像 4K 60fps|✅|
|慢动作|✅|
|人像虚化|✅|

- **相机应用未做移植**：注意相机应用仍为官方 ColorOS 14 中的版本。

- **相机界面亮度异常**：打开系统内置相机应用，屏幕不会自动增强亮度，只有当在相机应用中查看照片时，屏幕才会进入增强亮度状态。返回拍照界面后再返回主屏幕，增强亮度也不会自动失效，此时通过亮度滑杆也无法有效降低亮度，只能关闭自动亮度功能暂时缓解，或等待数分钟，等到增强亮度超时关闭。（如果直接从相机内的照片查看界面返回主屏幕，则增强亮度会正确关闭）

### 显示与触控

|功能项|结果|备注|
|-|-|-|
|基本显示与触控|✅|
|隔膜触控|❔|设置中有该选项但不确定是否有效|
|屏幕挖孔位置|✅|
|高刷新率|✅|
|亮度调节|✅|
|自动亮度|✅|
|环境色自适应|❌|一加 9R 硬件不支持此功能|
|sRGB 模式|✅|此功能位于「屏幕色彩模式 → 自然」|
|降低白点值|✅|此功能位于「辅助功能 → 无障碍 → 视觉」|
|舒眠模式（节律色温）|⚠️|能工作但会无视当前色彩模式的白点值|
|护眼模式暖色滤镜|✅|
|护眼模式纸质纹理|✅|
|明眸低频闪|❔|设置中有该选项但不确定是否有效|
|正常 DPI|✅|与官方 ColorOS 14 相同，宽度为 360dp|
|注视时不息屏|❌|没有此功能|
|HDR 显示|⚠️|亮度补偿 HDR 可工作，但切出时吃闪光弹|

- **流体云最小化状态下不可见**：由于挖孔在左上角，顶部中间无挖孔，流体云在最小化状态下会完全不可见。在状态栏上滑动仍能使其取消最小化。

- **最低亮度过暗**：这是有意的。最低亮度被刻意设置为明显低于原厂系统的最低亮度，现在大致与一加 13 的最低亮度相同。如果认为自动亮度在暗处经常将屏幕调得过暗，可在设置中调节自动亮度的最低允许值。

- **舒眠模式不会正确考虑当前色彩模式的白点值**：具体表现为「生动」模式下色温会略偏冷，「自然」模式下色温会明显偏暖，均不准确。「鲜艳」模式下色温大致正常，但该色彩模式不适合日用。

### 生物识别

|功能项|结果|备注|
|-|-|-|
|指纹|✅|
|人脸|✅|

- **指纹与显示滤镜的冲突**：光学指纹就绪状态时，色彩模式校准失效；光学指纹工作状态时，护眼模式、极暗、降低白点值等滤镜也会失效。这是原版 ColorOS 的 bug。

### 传感器

|功能项|结果|备注|
|-|-|-|
|环境光|✅|
|加速度/重力|✅|
|陀螺仪|❔|未测试|
|邻近传感器|✅|
|三段式开关|✅|

### 电源管理

|功能项|结果|备注|
|-|-|-|
|高性能模式|❔|设置中有该选项但不确定是否有效|
|省电模式|✅|
|省电选项|✅|
|自动省电模式|✅|
|超级省电模式|✅|
|紧急超级省电|❌|没有此功能|
|视频长续航|❔|设置中有该选项但不确定是否有效|
|电池健康度|❔|设置中有该界面，但不确定值是否正确|
|充电上限|❔|设置中有该选项但不确定是否有效|
|旁路供电|⚠️|设置中有该选项但似乎效果不明显|
|关机充电界面|✅|


### 其他问题

- **游戏助手启动动画异常**：启动游戏时，游戏助手的启动动画不会正常播放，而是会导致整个界面黑屏约 3 秒。

- **AI 消除不可用**：无论是否有网络连接，相册中的 AI 消除功能都会失败。

## 已解决的问题记录

### OTA 格式的刷机包打包失败

```
2026-03-19 10:22:54 - common.py - WARNING : Failed to read SYSTEM/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read VENDOR/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read PRODUCT/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read SYSTEM_EXT/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read ODM/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read VENDOR_DLKM/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read VENDOR_DLKM/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read build.prop for partition vendor_dlkm
2026-03-19 10:22:54 - common.py - WARNING : Failed to read ODM_DLKM/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read ODM_DLKM/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read build.prop for partition odm_dlkm
2026-03-19 10:22:54 - common.py - WARNING : Failed to read SYSTEM_DLKM/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read SYSTEM_DLKM/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read build.prop for partition system_dlkm
2026-03-19 10:22:54 - common.py - WARNING : Failed to read MY_PRODUCT/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read MY_PRODUCT/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read build.prop for partition my_product
2026-03-19 10:22:54 - common.py - WARNING : Failed to read MY_MANIFEST/etc/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read MY_MANIFEST/build.prop
2026-03-19 10:22:54 - common.py - WARNING : Failed to read build.prop for partition my_manifest
2026-03-19 10:22:54 - common.py - WARNING : Unable to get boot image timestamp: no system/etc/ramdisk/build.prop in ramdisk
2026-03-19 10:22:54 - common.py - WARNING : Failed to read IMAGES/init_boot.img
Traceback (most recent call last):
  File "<frozen runpy>", line 198, in _run_module_as_main
  File "<frozen runpy>", line 88, in _run_code
  File "/redacted_path/ColorOS_Port_Co-create/otatools/bin/ota_from_target_files/__main__.py", line 12, in <module>
  File "<frozen runpy>", line 198, in _run_module_as_main
  File "<frozen runpy>", line 88, in _run_code
  File "ota_from_target_files.py", line 1548, in <module>
  File "ota_from_target_files.py", line 1525, in main
  File "non_ab_ota.py", line 621, in GenerateNonAbOtaPackage
  File "non_ab_ota.py", line 207, in WriteFullOTAPackage
  File "common.py", line 3142, in FullOTA_InstallBegin
  File "common.py", line 3132, in _DoCall
  File "/redacted_path/ColorOS_Port_Co-create/out/target/product/OnePlus9R/META/releasetools.py", line 53, in FullOTA_InstallBegin
    self.output_zip.write(os.path.join(TARGET_DIR, "storage-fw/ffu_tool"), "ffu_tool")
  File "internal/python3.11/zipfile.py", line 1775, in write
  File "internal/python3.11/zipfile.py", line 532, in from_file
FileNotFoundError: [Errno 2] No such file or directory: '/redacted_path/ColorOS_Port_Co-create/out/target/product/OnePlus9R/storage-fw/ffu_tool'
/redacted_path/ColorOS_Port_Co-create
md5sum: out/OnePlus9R-ota_full-11_C.85-user-16.0.zip: No such file or directory
mv: cannot stat 'out/OnePlus9R-ota_full-11_C.85-user-16.0.zip': No such file or directory
```

故障原因：

- 不明。

解决方法：

- 放弃按 OTA 包格式进行打包。在 `bin/port_config` 中将 `pack_method` 改为 `super`，从而改用 super 镜像刷写器的方式打包。

- 直接刷写打包过程中生成的 `build/portrom/images/super.img` 文件，不使用最终打包产物。因此当脚本执行到「成功打包 super.img」时即可 Ctrl+C 中断，不需要到最终打包完成。

> **⚠️ 注意**
> 
> 按照原本的设计，super 刷写器应当是一个混合式刷机包，可以使用 `adb sideload` 通过 TWRP 刷入，也可以直接解压，使用包内附带的刷写脚本（bat 或 sh 文件）刷入。但是：
> 
> - 已知 Windows 刷写脚本有误，根本无法正常刷写。就算修正其中明显的错误，这个脚本依旧没有考虑到一加 9R 的 `firmware-update` 中镜像名与实际分区名不完全相同这一点，因此许多固件分区无法刷入。更严重的是，这个脚本没有对一加 9R 的 LPDDR4X 和 LPDDR5 版本进行判断，有可能刷写错误的 xbl 镜像导致黑砖（但是上一条错误导致根本不会刷入 xbl 镜像，因此只要你不尝试修复上一条……）。
> 
> - 通过 TWRP 刷入，所执行的操作到底是「刷写 super」还是「刷写 super + fireware-update」，不明确。但是已知该过程不会刷入 boot 镜像。
> 
> 这些原因使得我选择直接刷写 super，不使用最终产生的刷机包。

### 亮度条异常

> **💡 提示**
> 
> 可以使用工程模式（拨号输入 `*#899#`，然后点击「手动测试」）中的「媒体测试 → 屏幕亮度调节」功能较为准确地观察手动亮度调节曲线的情况，并能读出亮度等级和寄存器值。

具体表现：

- 亮度条约 0%—10% 区域，亮度完全不变，寄存器值恒为 7；

- 亮度条约 10%—15% 区域，亮度几乎「突跃式」地改变，寄存器值为 7—大约 350；

- 亮度条约 15%—100% 区域，亮度正常渐变，寄存器值为大约 350—2047；

- 自动亮度仍会假定手动亮度曲线是正常的，并以此为依据自动搓亮度条，因此正常环境下屏幕会明显偏亮，昏暗环境下容易出现亮度突跃，极暗环境下会偏暗。

故障原因：

- 纯属毫无依据的推测：一加 9R 底包中使用的亮度曲线配置文件（`/my_product/vendor/etc/display_config_samsung_1024.xml`）中使用 `lux_table_mode=6`，这种模式下，系统会自动推定亮度等级和寄存器值之间的映射，而由于 ColorOS 16 改变了推断机制，不能正确推断一加 9R 的屏幕亮度。

解决方法：

- 使用取自 @wcedla 的 ColorOS 16 移植包中的同名配置文件（使用 `lux_table_mode=8`，文件中直接包含亮度等级和寄存器值的映射），放置到 `devices/OnePlus9R/overlay/my_product/vendor/etc/` 中，用以在构建过程中自动覆盖原配置文件。

### 部分 GCam 移植版会发生闪退

严格来讲，这不是系统的 bug，而是这些 GCam 移植版的 bug——它们在直接点击桌面图标启动时工作正常，但在通过快捷方式或锁屏右下角相机图标启动时却会崩溃。分析表明，它们在用这些方式启动时，如果系统缺少 `com.google.android.feature.PIXEL_2019_EXPERIENCE` 特性，会执行特定逻辑，作用可能是某些兼容性调整或功能限制，但这部分逻辑有问题，会导致崩溃。

既然构建出的系统本身已经允许用户选择第三方相机应用来接管锁屏右下角的相机图标，那么不妨也在系统中直接添加 `com.google.android.feature.PIXEL_2019_EXPERIENCE` 特性，顺便修复这个问题。

解决方法：

- 添加 `devices/OnePlus9R/overlay/my_product/etc/permissions/com.google.android.feature.PIXEL_2019_EXPERIENCE.xml` 文件（内容略）以声明该特性。

### 系统中缺少受体机型的自带壁纸

构建出的系统只会包含供体设备的自带壁纸。

故障原因：

- 壁纸存放于 `/my_product/decouping_wallpaper`。对于受体设备（底包为 ColorOS14），这个文件夹仅包含设备默认壁纸，额外自带的若干壁纸以及不同颜色版本的机型的默认壁纸配置；对于供体设备（ColorOS 15/16），这个文件夹还包括自带的其他壁纸集和灵感主题的资源文件。

解决方法：方便起见仍采用预制 overlay 的方式，构造方法如下，

- 将原设备附带的静态壁纸（包括动态壁纸的静态部分）均转成 webp。这是因为新机型的自带静态壁纸均为 webp 格式，要想覆盖掉它们，文件必须有相同的文件名，否则会同时存在 png 和 webp，此时 webp 会优先。

- 原设备附带的动态壁纸所对应的静态部分，放到 `common/` 中，并更新 `wallpaper_info.xml`。

- 原设备的缺省壁纸放到 `default/` 中。

- 原设备附带的动态壁纸的视频部分，放到 `default/liveWallpaper/` 中，并更新 `default/liveWallpaper/mix_wallpaper_config.json`。

- 原设备附带的无动态形式的静态壁纸，以及供体机型（任选）`common/wallpaper_group/00_ColorOS15/` 中的壁纸，均合并到 `common/wallpaper_group/00_ColorOS15/` 中，并更新 `common/wallpaper_group/00_ColorOS15/wallpaper_config.json`。这部分壁纸会出现在「流光溢彩」壁纸集中。这样做的原因是，纯静态壁纸放入 `common/` 文件夹中似乎并不会正常出现在壁纸选择器中，即使其文件名已在 `wallpaper_info.xml` 中声明。

- 原设备的 `default/phone_color_default_theme_maps.xml` 也加入 overlay 中。这一文件定义不同颜色版本的机型各自的默认壁纸。内容无须修改。顺带一提，这一文件是「售后页面 → 电池盖颜色」中的颜色列表的来源。

> **ℹ️ 备注**
> 
> 这里做了额外两处改动：
> 
> - 供体机型的 `00_ColorOS15` 壁纸集中有一个绿色的 `ColorOS1504.webp`，但是却没有在 `wallpaper_config.json` 中声明，从而不可用。此处手动构建的 overlay 中补全了这个壁纸。
> 
> - 一加 9R 的 `phone_color_default_theme_maps.xml` 文件从 ColorOS 12 开始就缺少该机型的「青宇」配色。此处手动构建的 overlay 中结合 ColorOS 11 和 ColorOS 14 中该文件的信息手动补全了「青宇」配色的信息。

### 工程模式包含供体而非受体机型的功能

解决方法：见 `port.sh` 中以 `# Engineer mode` 开头的部分。具体而言，将受体机型的工程模式 APK 转移到移植包中，并且将 `my_product` 中相关配置文件也转移过去。

### 不应当在生产环境中添加的调试用 prop

脚本原先添加了这些：

```bash
sed -i -e '$a\'$'\n''persist.adb.notify=0' build/portrom/images/system/system/build.prop
sed -i -e '$a\'$'\n''persist.sys.usb.config=mtp,adb' build/portrom/images/system/system/build.prop
sed -i -e '$a\'$'\n''persist.sys.disable_rescue=true' build/portrom/images/system/system/build.prop
```

这些东西不应该出现在最终发布的包中。

### 构建结果中包含红外遥控 app，但由于硬件不支持无法使用

解决方法：删除，见 `port.sh` 中以 `# ConsumerIRApp (useless since not working on OP8/9 series)` 开头的部分。

### 无法工作的 features

以下 features 会添加相关设置界面但却无法实际工作，不应当添加：

- `oplus.software.display.intelligent_color_temperature_support` 环境色自适应

- `oplus.hardware.display.no_bright_eyes_low_freq_strobe` 全亮度低频闪

- `oplus.software.audio.super_volume_4x` 400% 超级音量

- `oplus.software.systemui.pin_task` 钉到流体云

- `oplus.hardware.display.motion_sickness` 晕动舒缓显示

- `com.oplus.eyeprotect.ai_intelligent_eye_protect_support` AI 护眼（在 16.0.5.701 系统上还会导致「明眸护眼」页面崩溃）

### 可以工作的 features

以下 features 在构建过程中被注释掉或移除，但实际测试表明功能可用，应予以保留：

- `oplus.software.display.eyeprotect_paper_texture_support` 护眼模式纸质纹理
