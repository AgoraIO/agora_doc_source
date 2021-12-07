## cpuUsage

```typescript
cpuUsage: number,
```

> Since v1.1.5.

The CPU usage.

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

Network delay (ms).

## packetLostRate

```typescript
packetLostRate: number,
```

> Since v1.1.5.

Packet loss rate (%).

## rxPacketLossRate

```typescript
rxPacketLossRate: number;
```

> Since v1.1.5.

The downlink audio and video packet loss rate.

## txPacketLossRate

```typescript
txPacketLossRate: number;
```

> Since v1.1.5.

The uplink audio and video packet loss rate.

## rxNetworkQuality

```typescript
rxNetworkQuality: string;
```

> Since v1.1.5.

The downlink network quality.

## txNetworkQuality

```typescript
txNetworkQuality: string;
```

> Since v1.1.5.

The uplink network quality.

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
| `duration` | Class duration (seconds). |