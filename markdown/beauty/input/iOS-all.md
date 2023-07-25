# 美颜场景化API Demo

[English](README.md) | 中文

## 前提条件

- 最低兼容 iOS 11
- Xcode 13及以上版本
- 联系商汤客服拿到商汤的美颜SDK、美颜资源以及证书
- 联系字节火山客户拿到火山SDK、美颜资源以及证书
- 联系相芯客户拿到美颜资源以及证书

## 快速跑通
### 配置美颜SDK

> PS：没有配置项目能正常运行，但是对应美颜不生效

1. 商汤美颜
解压商汤美颜SDK并复制以下文件/目录到对应路径下

| 商汤SDK文件/目录                                                           | 项目路径                                                     |
|----------------------------------------------------------------------|----------------------------------------------------------|
| SenseMe/remoteSourcesLib    | iOS/SenseLib/remoteSourcesLib              |
| SenseMe/st\_mobil\_sdk | iOS/SenseLib/st\_mobile\_sdk  |
|SenseMe/st\_mobil\_sdk/license/SENSEME.lic   | iOS/SenseLib/SENSEME.lic |

2. 相芯美颜
将相芯美颜资源放入对应路径下

相芯SDK文件/目录         | 项目路径                                                  |
|----------------------|-------------------------------------------------------|
| FaceUnity/Lib/Resources | iOS/FULib         |
| 证书authpack.h      | iOS/BeautyAPi/FUBeauty/authpack.h  |

3. 字节/火山美颜
解压字节/火山美颜资源并复制以下文件/目录到对应路径下

| 字节SDK文件/目录                                       | 项目路径                                                  |
|--------------------------------------------------|-------------------------------------------------------|
| BytedEffects/app/Resource                       | iOS/ByteEffectLib/Resource           |
| byted_effect_ios_static/iossample\_static/libeffect-sdk.a                    | iOS/ByteEffectLib/ibeffect-sdk.a           |
| byted_effect_ios_static/iossample\_static/include/BytedEffectSDK                    | iOS/ByteEffectLib/BytedEffectSDK           |

### 配置声网AppID

> PS：这个demo不支持带证书的AppId

1. 在[agora.io](https://www.shengwang.cn/)创建一个开发者账号

2. 前往后台页面，点击左部导航栏的 项目 > 项目列表 菜单

3. 复制后台的 App Id 并备注，稍后启动应用时会用到它

4. 编辑KeyCenter.swift，并配置上
```
AppId=#YOUR APP ID#
```

### 运行项目

1. 编辑BeautyAPi Project， 修改Bundle Identifier成申请美颜时所用包名
2. 运行项目


## 集成到项目

每个美颜可以单独集成到自己的项目，详见对应的集成说明文档

| 美颜  | 集成说明                                         |
|-----|----------------------------------------------|
| 商汤  | [SenseBeauty](BeautyAPi/SenseBeaufy/README.zh.md)  |
| 相芯  | [fuBeauty](BeautyAPi/FUBeauty/README.zh.md)  |
| 字节  | [byteBeauty](BeautyAPi/ByteBeaufy/README.zh.md)  |