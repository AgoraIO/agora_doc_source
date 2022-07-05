# Extension App Context

## AgoraExtAppProtocol

## AgoraExtAppProtocol

### launchExtApp

```kotlin
- (NSInteger)willLaunchExtApp:(NSString *)appIdentifier;
```

启动扩展应用。

| 参数            | 描述            |
| :-------------- | :-------------- |
| `appIdentifier` | 扩展应用的 ID。 |

### getRegisteredExtApps

```kotlin
fun getRegisteredExtApps(): List<AgoraExtAppInfo>
```

获取当前注册的所有扩展应用的信息。
