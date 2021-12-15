灵动课堂支持自定义用户属性和课堂属性。属性包含属性名和属性值，每个属性名有且仅有一个对应的属性值。

你可通过全量修改和路径修改两种方式修改自定义用户属性或课堂属性的值。

假设当前自定义用户或课堂属性为：

```json
{"key1": {"subkey1": "a", "subkey2": "b"}, "key2": {"subkey3": "c", "subkey4": "d"}}
```

有以下几种情况：

- 如果你想要将所有 `subkey` 的值改为大写，可在调用 API 时传入以下 JSON 数组进行全量修改：

  ```json
  {"key1": {"subkey1": "A", "subkey2": "B"}, "key2": {"subkey3": "C", "subkey4": "D"}}
  ```

- 如果你只想要将 `subkey1` 的值从 `a` 修改为 `A`，可调用 API 时传入 `{"key1.subkey1":"A"}` 进行路径修改。

- 如果你想要在 `key1` 中新增一个值为 `E` 的 `subkey5`，可在调用 API 时传入 `{"key1.subkey5":"E"}` 进行路径修改，修改后的属性为：

  ```json
  {"key1": {"subkey1": "A", "subkey2": "B", "subkey5": "E"}, "key2": {"subkey3": "C", "subkey4": "D"}}
  ```

  请注意，如果你传入 `{ "key1": { "subkey5": "E" } }`，会覆盖所有原先的属性。

- 你可以同时新增多个属性，例如调用 API 时传入 `{"key1.subkey5":"E", "key2.subkey6":"F"}` ，修改后的属性为：

  ```json
  {"key1": {"subkey1": "A", "subkey2": "B", "subkey5": "E"}, "key2": {"subkey3": "C", "subkey4": "D", "subkey6": "F"}}
  ```
