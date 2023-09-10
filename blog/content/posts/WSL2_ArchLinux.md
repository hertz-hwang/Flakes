---
title: "Windows11 WSL2 安装 ArchLinux"
author: "Hertz Hwang"
description: "Windows11 WSL2 安装 ArchLinux"
categories: [
    "WSL/WSL2",
]
tags: [
    "Windows",
    "Linux",
    "WSL/WSL2",
]

date: 2023-07-13T10:24:11+08:00
draft: false
---

## 一、安装配置 WSL2 环境
```shell
~> wsl --install
```
完成后重启一下电脑
```shell
~> wsl --list
Windows Subsystem for Linux Distributions:
Arch (Default)
Ubuntu
```

## 二、安装 ArchLinux
### 2.1 下载 ArchLinux rootfs tarball
Github上的[ ArchWSL ](https://github.com/yuk7/ArchWSL)项目已经帮我们把 ArchLinux 集成好了，可以到下载页面下载最新的[ Arch.zip ](https://github.com/yuk7/ArchWSL/releases/download/22.10.16.0/Arch.zip)文件：[ 下载页面 ](https://github.com/yuk7/ArchWSL/releases)。
### 2.2 解压、安装
解压 Arch.zip ，双击 Arch.exe 安装，等待 ArchLinux 子系统自动部署完成，因为该项目已搁置许久，而 ArchLinux 又是比较激进的滚动更新的 GNU/Linux 发行版，所以在刷新 GPG 可信密钥的过程会耗时较久，请耐心等待。
### 2.3 设置 ArchLinux 为 WSL2 的默认子系统
```shell
~> wsl --unregister Ubuntu
Unregistering.
操作成功完成。
~> wsl --set-default Arch
操作成功完成。
```
### 2.4 ArchLinux 初始化设置
```bash
## 配置国内软件镜像站
cat << EOF >> /etc/pacman.d/mirrorlist
Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch
EOF

## 初始化 pacman key
pacman-key --init
pacman-key --populate
pacman -Sy archlinux-keyring

## 更新系统
pacman -Syy
pacman -Syu

## 增加 archlinuxnc 源
cat << EOF >> /etc/pacman.conf

[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
EOF
pacman -Sy archlinuxcn-keyring

## 配置 root 密码
passwd root

## 新建本地普通用户
pacman -S fish opendoas
groupadd wsladmin
useradd -m -G wsladmin -s /bin/fish hertz
passwd hertz

## 配置 doas
cat << EOF >> /etc/doas.conf
permit keepenv :wsladmin
EOF

## 暂时先退出 wsl
exit
```
退回到 Windows 后
```bash
## 修改 ArchLinux 启动后的默认用户
cd ~\Documents\Arch
.\Arch.exe config --default-user hertz
wsl --shutdown  # 这个命令会关闭所有虚拟机
wsl -d Arch
```
