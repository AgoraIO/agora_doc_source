# ClassroomStatsContext

## cpuUsage

```typescript
cpuUsage: number,
```

> Since v1.1.5.

CPU 使用情况。

## networkQuality

```typescript
networkQuality: string,
```

> Since v1.1.5.

Network quality types.

## networkLatency

```typescript
networkLatency: number,
```

> Since v1.1.5.

网络延时（毫秒）。

## packetLostRate

```typescript
packetLostRate: number,
```

> Since v1.1.5.

网络丢包率（百分比）。

## rxPacketLossRate

```typescript
rxPacketLossRate: number;
```

> Since v1.1.5.

音视频下行丢包率。

## txPacketLossRate

```typescript
txPacketLossRate: number;
```

> Since v1.1.5.

The upstream packet loss rate of the sent audio.

## rxNetworkQuality

```typescript
rxNetworkQuality: string;
```

> Since v1.1.5.

The downlink last-mile network probe test result.

## txNetworkQuality

```typescript
txNetworkQuality: string;
```

> Since v1.1.5.

The uplink last-mile network probe test result.

# LiveRoomStatsContext

## liveClassStatus

```typescript
liveClassStatus: {
    classState: string;
    duration: number;
};
```

> Since v1.1.5.

The classroom state.

| Parameter | Description |
| ------------ | -------------------- |
| `classState` | The classroom state. |
| `duration` | 课堂持续时间（秒）。 |