## cpuUsage

```typescript
cpuUsage: number,
```

> 自 v1.1.5 起新增。

CPU 使用情况。

## networkQuality

```typescript
networkQuality: string,
```

> 自 v1.1.5 起新增。

网络质量。

## networkLatency

```typescript
networkLatency: number,
```

> 自 v1.1.5 起新增。

网络延时（毫秒）。

## packetLostRate

```typescript
packetLostRate: number,
```

> 自 v1.1.5 起新增。

网络丢包率（百分比）。

## rxPacketLossRate

```typescript
rxPacketLossRate: number;
```

> 自 v1.1.5 起新增。

音视频下行丢包率。

## txPacketLossRate

```typescript
txPacketLossRate: number;
```

> 自 v1.1.5 起新增。

音视频上行丢包率。

## rxNetworkQuality

```typescript
rxNetworkQuality: string;
```

> 自 v1.1.5 起新增。

下行网络质量。

## txNetworkQuality

```typescript
txNetworkQuality: string;
```

> 自 v1.1.5 起新增。

上行网络质量。

## liveClassStatus

```typescript
liveClassStatus: {
    classState: string;
    duration: number;
}
```

> 自 v1.1.5 起新增。

课堂状态。

| 参数         | 描述                 |
| ------------ | -------------------- |
| `classState` | 课堂状态。           |
| `duration`   | 课堂持续时间（秒）。 |
