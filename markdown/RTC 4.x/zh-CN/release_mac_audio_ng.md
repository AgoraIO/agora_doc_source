## v4.1.1 版

该版本于 2023 年 1 月 xx 日发布。



#### 新增特性

**快速出声**

该版本新增 `enableInstantMediaRendering` 方法，用于开启音频帧的加速渲染模式，可加快用户加入频道后的首帧出声速度。



#### 问题修复

该版本修复了以下问题：

- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。


#### API 变更

**新增**

- `enableInstantMediaRendering`
