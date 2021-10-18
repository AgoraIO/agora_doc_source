# Extension App Context Extension App Context

## AgoraExtAppProtocol AgoraExtAppProtocol

## AgoraExtAppProtocol AgoraExtAppProtocol

### launchExtApp launchExtApp

```kotlin
- (NSInteger)willLaunchExtApp:(NSString *)appIdentifier;
```

Launches an extension application. Launches an extension application.

| Parameter Parameter | Description Description |
| :-------------- | :-------------- |
| `appIdentifier ``appIdentifier` | The ID of the extension application. The ID of the extension application. |

### getRegisteredExtApps getRegisteredExtApps

```kotlin
fun getRegisteredExtApps(): List<AgoraExtAppInfo>
```

Gets the information of all registered extension applications. Gets the information of all registered extension applications.
