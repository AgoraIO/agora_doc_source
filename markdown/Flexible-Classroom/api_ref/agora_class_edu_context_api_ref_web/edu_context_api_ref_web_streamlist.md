# StreamListContext

`StreamListContext` 提供流相关能力。

## streamList

```javascript
streamList: EduStream[],
```

全部媒体数据流列表。

## teacherStream

```javascript
teacherStream: any,
```

教师媒体流列表。

## studentStreams

```javascript
studentStreams: EduMediaStream[],
```

学生媒体流列表。

## onPodiumStudentStreams

```javascript
onPodiumStudentStreams: EduMediaStream[],
```

当前上台的学生媒体流列表。

## muteAudio

```javascript
muteAudio: (userUuid: string, isLocal: boolean) => void,
```

禁用指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## unmuteAudio

```javascript
unmuteAudio: (userUuid: string, isLocal: boolean) => void,
```

取消禁用指定用户的音频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## muteVideo

```javascript
muteVideo: (userUuid: string, isLocal: boolean) => void,
```

禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## unmuteVideo

```javascript
unmuteVideo: (userUuid: string, isLocal: boolean) => void,
```

取消禁用指定用户的视频。

| 参数       | 描述             |
| :--------- | :--------------- |
| `userUuid` | 用户 ID。        |
| `isLocal`  | 是否为本地用户。 |

## revokeUserPermission

```javascript
revokeUserPermission: (userUuid: string) => void,
```

取消指定用户的白板权限。

| 参数       | 描述      |
| :--------- | :-------- |
| `userUuid` | 用户 ID。 |

## localStream

```javascript
localStream: EduStream,
```

本地用户的媒体数据流。

## grantUserPermission

```javascript
grantUserPermission: (userUuid: string) => void,
```

授予指定用户白板权限。
