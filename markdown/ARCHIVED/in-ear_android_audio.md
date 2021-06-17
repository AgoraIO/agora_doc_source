---
title: 耳返
platform: Android
updatedAt: 2018-11-23 15:12:00
---
## 功能描述
耳返主要实现监听的功能，在低延时的情况下可以给主播一个比较真实的反馈，在演唱会等专业场景里比较常用。
Agora SDK 支持耳返功能，同时支持调节耳返的音量。

## 实现方法
开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端 ](./android_audio)。

```java
 // 设置开启耳返监听功能，默认为 false
 rtcEngine.enableInEarMonitoring(true);

 // 设置耳返的音量，volume的取值范围为0 ~ 100，默认值是 100，代表麦克风录到的原始音量
 int volume = 80;
 rtcEngine.setInEarMonitoringVolume(volume);
	``` 
	
	

## 开发注意事项

以上方法都有返回值，返回值小于 0 表示方法调用失败。

