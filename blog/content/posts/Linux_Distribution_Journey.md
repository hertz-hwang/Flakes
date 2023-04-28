---
title: "我的 Linux 发行版历程"
author: "Hertz Hwang"
description: "我个人使用 Linux 发行版的历程，其实远不只文中的这些，就实体机上安装过的，如：DEB 系有 Ubuntu、Debian、Deepin；RPM 系有 CentOS、Fedora、OpenSuse；Arch 系有：ArchLinux、BlackArch、Antergos、ArcoLinux、ArchBang、Manjaro、Garuda、EndeavourOS；还有一些独立的发行版有 LFS、Void Linux、Guix GNU/Linux 等等。"
categories: [
    "Linux",
]
tags: [
    "CentOS",
    "Mint",
    "ArchLinux",
    "Gentoo",
    "NixOS",
]
cover: "https://camo.githubusercontent.com/b23b2cd305b912884d9499af165bbd1f0aad0ec86bb6fdd122e8e4d07c6b2821/68747470733a2f2f6e69786f732e6f72672f6c6f676f2f6e69786f732d68697265732e706e67"

date: 2022-03-16T10:24:32+08:00
draft: false
---

## 我的 Linux 发行版历程？
> ***CentOS*** -> ***Linux Mint*** -> ***ArchLinux*** -> ***Gentoo Linux*** -> ***NixOS***

CentOS: 
大学的一门实践课程，编写开发板 LED 驱动吧（貌似），导师教学使用 Linux 来做驱动开发，当时电脑上均通过 VMware Workstation Pro 安装的 CentOS ，版本似乎还是 6.4 还是 6.5 来着。这也是我第一次接触到 Linux 这个操作系统，感觉很新鲜，虽然装有 GUI ，但是我还是跟着导师的教学，在 Gnome 的 Terminal 上学习 ls/pwd/touch/mkdir/vi... 等命令. 当时大部分同学可能觉得不适应这种命令行的方式管理文件，大都通过 Gnome 的 GUI 来操作文件。

Linux Mint: 这个发行版也是在和 CentOS 同时接触到的。接触到 CentOS 的第一天就被 Linux 深深吸引了。下课一回宿舍就开始百度学习 Linux 系统。当时就看到了贴吧里说 “在 distrowatch 上热度第一的发行版是 Linux Mint ”。于是乎，脑子一热，直接把笔记本上的 Windows7 格式化了安装 Linux Mint ，还别说，驱动什么的都不用折腾，确实时 out-of-box 开箱即用的发行版，整体 UI 对比上课的 Gnome 也是有一些差别，更接近 Windows 一些。试验课程的后续学习开发也都在 Linux Mint 上完成的。不过其中的一些小插曲就是，开发环境的安装倒是折腾了一两天，不过最终也满足了课程的学习和开发。课程结束之后，实践宽松了，就开始折腾 Cinnamon 桌面的美化。

ArchLinux: 罪恶的开始【嘿嘿~】！ Linux Mint 使用了几个月后，贴吧都在疯传一个叫做 “ArchLinux” 的发行版，我向来对新鲜的事物总是充满了好奇，我很好奇这个发行版是如何做到像“邪教”一样的传播开来的。第一步，我打开了 ArchLinux 的官方网站，一下被这个像塔一样的蓝色 logo 吸引了。于是开开心心从 USTC 镜像站下载了 iso ，烧录进 USB ，直接开机进了U盘引导。跑完引导后，出现在眼前的不是像 Linux Mint 那样的安装指引，而是 archiso 的 tty ，没有任何指引，瞬间傻眼了。后来打开手机，到 ArchLinux Wiki 查看 Installation guide ，照着文档安装，经过几番折腾，总算是安装上了，跟着常用推荐，安装上了 Gnome 桌面。这过程，简直令人着迷~

Gentoo: 这是一个比 ArchLinux 更加疯狂的发行版。在 ArchLinux 的使用期间，就对 Gentoo 多有耳闻，很多爱好者都去尝试，结果吓退了很大部分人。我当时也是年轻，不信邪，也尝试加入新阵营。有了 ArchLinux 的经验基础，在安装 Gentoo 的前期都挺顺利的，直到 ***编译内核*** ，当时真的卡在这里了，好几周都没有找到解决方法。灰头土脸回了 ArchLinux 。再到后来尝试切换到 Gentoo 就是在两三年前了，那时候官方提供了 ***gentoo-kernel-bin*** 的二进制内核软件包，这对于我来说简直是福音。终于不出意外的安装上了磨人的 Gentoo 。到了选择 DE 的时候，"eselect profile set " 选择了 Gnome ，本以为 ***sudo emerge -avuDN @world*** 之后就有桌面环境了，结果后来才知道 profile 只是提供一个基础的环境，对应的环境编译完成后，还需要安装相应的 DE 包：gnome-base/gnome 或者 kde-plasma/plasma-meta。

NixOS: 主角登场~~ ！就在几个月之前，和 TG 群组里的小伙伴们讨论：究竟哪个发行版安装和学习的曲线最陡峭？很多群友都说 LFS 是最难安装的。其实我不以为然，因为我装过，全程照着 LFS 的文档复制粘贴，流程也和 ArchLinux/Gentoo 等所差无几，可能就和 Gentoo build from Stage1 一个难度，称不上有多难。其中有三两个群友提到了 NixOS ，这就很新鲜了，因为在此之前，我完全没有听到过这个发行版。于是乎，我马上开始查询了解这个发行版，得知其因 ***可复现*** 、***声明式*** 以及 ***安全可靠*** 而出名。其系统完全基于它自身的一种 ***函数式编程：Nix语言*** 构建的，因此要安装 NixOS ，~~~必须学习一门编程语言~~~(似乎从22.11版本开始，LiveCD 有了 GUI 的安装引导程序)，可谓是高门槛了。另外，还了解到其实现安全可靠的方法，即：每次构建系统都会生成一个 generation，每一个 generation 都会对应到 grub、systemd-boot、refind 等引导程序中的 boot entry，所以如果新的一次构建导致了系统不 work 了，那么完全可以通过引导上一次的 generation ，来引导上一次 work 的系统，然后再次折腾，完全不需要 LiveCD 来做紧急救援。NixOS 采用的是非 FHS 标准结构( Filesystem Hierarchy Standard )，系统的所有二进制文件以及配置文件均存储在 /nix/store 目录下，能够做到自动调整 $PATH 环境变量，加入软件包的 bin 路径，以实现用户能够直接调用软件包二进制指令，配置文件也是同理，都是通过系统自动软连接实现。可复现的实现原理是通过实验性功能 Flakes ，通过锁定软件版本及配置来构建，即同样的 inputs 一定能够得到同样的 outputs 。

NixOS有趣的地方还有很多很多，后续文章再细说。本文主要描述了我的 Linux 发行版使用的经历。
