<div align="center">

#  ColorOS/OxygenOS 移植项目

简体中文&nbsp;&nbsp;|&nbsp;&nbsp;[English](/README_en-US.md) 

</div>

## 简介
- ColorOS/OxygenOS 一键自动移植打包

## 支持机型

- 一加8系列（OnePlus8、OnePlus8Pro、OnePlus8T、OnePlus9R）
- 一加9系列（OnePlus9、OnePlus9RT、OnePlus9Pro）
- OPPOFindX3、OPPOFindX3Pro

## 测试机型及版本

> **本仓库针对的实例**：
> 
> - OP13T → OP9R, ColorOS 16.0.3--16.0.5，[查看测试报告](./test_report/Report_OnePlus9R_16.0.3.md)
>
> - OP10P → OP9R, ColorOS 16.0.3，测试报告暂缺（与上一条相似，但不存在无效的「空间音频」功能，且系统默认设置更匹配设备性能）
>
> - OP13T → OP9R, ColorOS 16.0.7，[查看测试报告](./test_report/Report_OnePlus9R_16.0.7.md)

BASE:
- OnePlus 8T (ColorOS_14.0.0.600)
- OnePlus 8 (ColorOS_13.1.190)
- OnePlus 8Pro (ColorOS_13.1.0.190)
- OnePlus 9（ColorOS_14.0.0.1901）
- OnePlus 9Pro（ColorOS_14.0.0.1901）
- OnePlus 9RT（ColorOS_14.0.0.2401）

PORT:
- OnePlus 12 (ColorOS_14.0.0.800)
- OnePlus 13（ColorOS_15.0.0.840）
- OnePlusAce6T（ColorOS_16.0.3.503）
- OnePlus 12 (ColorOS_16.0.3.500)

## 正常工作
- 人脸
- 挖孔
- 指纹
- 相机
- NFC
- 自动亮度
- 小布语音唤醒
- 关机充电
- etc

## BUG
- AOD亮度太低
- 有线耳机不可用（存疑）
- 亮度条异常（C16）

## 如何使用
- 在Ubuntu、Deepin等Linux下
（WSL环境下的Linux也可以）
```shell
    sudo apt update && sudo apt upgrade -y
    sudo apt install git -y
    # 克隆项目
    git clone https://github.com/xwdy114514/ColorOS_Port_Co-create.git
    cd ColorOS_Port_Co-create
    # 安装依赖
    sudo ./setup.sh
    # 开始移植
    ./port.sh <底包路径> <移植包路径>
```
- 路径可以是系统包链接，将路径替换为系统包下载链接即可
- 请确保设备的运行内存足够使用，通常需要16G以上，存储空间请预留大约160G

## 感谢
> 本项目使用了以下开源项目的部分或全部内容，感谢这些项目的开发者（排名顺序不分先后）。

- [「BypassSignCheck」by Weverses](https://github.com/Weverses/BypassSignCheck)
- [「contextpatch」 by ColdWindScholar](https://github.com/ColdWindScholar/TIK)
- [「fspatch」by affggh](https://github.com/affggh/fspatch)
- [「gettype」by affggh](https://github.com/affggh/gettype)
- [「lpunpack」by unix3dgforce](https://github.com/unix3dgforce/lpunpack)
- [「miui_port」by ljc-fight](https://github.com/ljc-fight/miui_port)
- etc

## 注
- 严禁以商品形式将该项目的任何内容（包括打包后的移植包）转卖出去，这是极其无耻的，没有道德底线的行为
- 我们在任何平台发现这种情况，将会选择创建一个文档，将这类情况集中收集到文档中
- 欢迎大佬或者有能力的人发送issue为我们项目提供帮助，该项目永久开源
- 在此处向所有曾经为本项目付出努力的人致以最崇高的感谢，同时也向所有移植作者致以最崇高的感谢
