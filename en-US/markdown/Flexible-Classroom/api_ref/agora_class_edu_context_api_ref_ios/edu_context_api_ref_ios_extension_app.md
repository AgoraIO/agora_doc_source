# Extension App Context

## AgoraExtAppProtocol

### launchExtApp

```kotlin
- (NSInteger)willLaunchExtApp:(NSString *)appIdentifier;
```

Launches an extension application.

| Parameter | Description |
| :-------------- | :-------------- |
| `appIdentifier` | The ID of the extension application. |

### getRegisteredExtApps

```kotlin
fun getRegisteredExtApps(): List<AgoraExtAppInfo>
```

Gets the information of all registered extension applications.
