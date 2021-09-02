灵动课堂支持自定义用户属性和课堂属性。属性包含属性名和属性值，每个属性名有且仅有一个对应的属性值。

你可调用以下方法通过全量修改和路径修改两种方式修改自定义用户属性或课堂属性的值：

- 调用 UserContext 中的 `updateFlexUserProps` 修改自定义用户属性。修改后，远端会收到 `onFlexUserPropertiesChanged` 回调。
- 调用 RoomContext 中的 `updateFlexRoomProps` 修改自定义课堂属性。修改后，远端会收到 `onFlexRoomPropertiesChanged` 回调。

假设当前自定义用户或课堂属性为：

```json
{"key1":
   {"subkey1":"a",
    "subkey2":"b"
   },
 "key2":
   {"subkey3":"c",
    "subkey4":"d"
   }
}
```

如果你想要将所有 `subkey` 的值改为大写，可在调用 API 时传入以下 JSON 数组进行全量修改：

```json
{"key1":
   {"subkey1":"A",
    "subkey2":"B"
   },
 "key2":
   {"subkey3":"C",
    "subkey4":"D"
   }
}
```

如果你只想要将 `subkey1` 的值从 `a` 修改为 `A`，可调用 API 时传入以下 JSON 对象进行路径修改：

```json
{"key1.subkey1":"A"}
```

