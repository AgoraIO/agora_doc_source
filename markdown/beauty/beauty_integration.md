本文介绍如何使用美颜场景化 API。

## 概述

//TODO（介绍美颜场景化 API 是什么，有何好处）

## 示例项目

声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/main) 示例项目供你参考。

## 准备开发环境

### 前提条件

### 创建项目

## 实现美颜


### 1 创建/初始化

```java
enum class CaptureMode {
    AGORA, CUSTOM
}


class BeautyStats {
    public long minCostMs; // 统计区间内的最小值
    public long maxCostMs; // 统计区间内的最大值
    public long averageCostMs; // 统计区间内的平均值
}


interface IEvnetCallback {
    /**
     * 美颜内部统计数据，在UI线程里回调
     *
     * @param stats 统计数据回调
     **/
    void onBeautyStats(BeautyStats stats);
}

class Config {
    public @NoNull RtcEngine rtcEngine; // 由外部传入的rtc对象，不可为空
    public @NoNull BeautyRender beautyRender; // 由外部传入的美颜SDK接口对象(不同厂家不一样)，不可为空
    public @Nullable IEvnetCallback enentCallback; // 事件回调，包含美颜耗时
    public CaptureMode captureMode = AGORA; // 是否由内部自动注册祼数据回调处理
    public long statsDuration = 1000; // 统计区间 1s
    public boolean statsEnable = false; // 是否开启统计
}


class BeautyAPI {

    /**
    * 创建并初始化美颜场景化API，如果外部调用过registerVideoFrameObserver，那initialize必须在此之后调用
    *
    * @param config 配置
    *
    * @return 0: 成功, 非0: 见错误码
    **/
    public int initialize(@NoNull Config config)
    {
        // 当useCustome==false时注册祼数据回调
    }
}
```

### 2 美颜开关

```java
class BeautyAPI {

    /**
    * 美颜开关
    *
    * @param enable 是否打开美颜
    *
    * @return 0: 成功, 非0: 见错误码
    **/
    public int enalbe(boolean enable)
    {

    }
}
```

### 3 本地渲染

```java
class BeautyAPI {

    /**
    * 本地视图渲染，由内部来处理镜像问题
    *
    * @param view 渲染视图
    * @param renderMode 渲染缩放模式
    * @return 0: 成功, 非0: 见错误码
    **/
    public int setupLocalVideo(View view, int renderMode)
    {

    }
}
```

### 4 美颜处理

```java
class BeautyAPI {


    /**
    * 美颜处理方法，当captureMode为CUSTOM时才需要调用，否则会报错
    *
    *
    * @return 0: 成功；非0：见错误码
    **/
    public int onFrame(VideoFrame videoFrame)
    {
        // 将rtc的pixelBuffer/videoFrame传进BeautyAPI，在BeautyAPI内部直接把处理好的pixcelBuffer传给rtc
    }
}
```

### 5 设置美颜默认效果

```java
class BeautyAPI {


    enum class BeautyPreset {
        CUSTOM, // 不使用内部的美颜推荐参数
        DEFAULT // 默认美颜推荐参数
    }


    /**
    * 设置美颜最佳默认参数
    *
    *
    * @param preset 美颜预设值
    * @return 0: 成功；非0：见错误码
    **/
    public int setBeautyPreset(BeautyPreset preset)
    {}
}
```

### 6 释放

```java
class BeautyAPI {


    /**
    * 销毁美颜场景化API。
    * 当创建useCustom==false时，会调用rtcEngine.registerVideoFrameObserver(null)将祼数据回调解绑。
    * 当创建bueautyRender==null，即beautyRender由内部创建时，会释放beautyRender
    *
    * @return 0: 成功；非0: 见错误码表
    **/
    public int release()
    {}

}
```