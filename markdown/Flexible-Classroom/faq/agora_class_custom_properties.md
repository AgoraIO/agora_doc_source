灵动课堂支持自定义用户属性，课堂属性和 widget 属性。你可以结合自身的业务需求，设置任意课堂属性，灵动课堂会将这个属性的变更同步到所有端，以此来实现你自己的扩展业务。

属性包含属性名和属性值，每个属性名有且仅有一个对应的属性值。你可通过全量修改和路径修改两种方式修改自定义用户属性或课堂属性的值。

假设当前你定义了以下属性：

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


如果你想要修改所有属性，可使用全量修改方式。例如，将 `subkey` 的值改为大写，可在调用 API 时传入以下 JSON 数组：

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


如果你只想要修改部分属性，可使用路径修改方式：

- 例如，将 `subkey1` 的值从 `A` 修改为 `a`，可调用 API 时传入 `{"key1.subkey1":"A"}` ，修改后的属性为：

  ```json
  {"key1":
      {"subkey1":"a",
      "subkey2":"B"
      },
    "key2":
      {"subkey3":"C",
      "subkey4":"D"
      }
  }
  ```

- 例如，在 `key1` 中新增一个值为 `E` 的 `subkey5`，可在调用 API 时传入 `{"key1.subkey5":"E"}` 进行路径修改，修改后的属性为：

  ```json
  {"key1":
     {"subkey1":"A",
      "subkey2":"B",
      "subkey5":"E"
     },
   "key2":
     {"subkey3":"C",
      "subkey4":"D"
     }
  }
  ```

  如果你传入 `{ "key1": { "subkey5": "E" } }`，会覆盖所有 `key1` 原先的属性，即修改后的属性为：

    ```json
  {"key1":
     {
      "subkey5":"E"
     },
   "key2":
     {"subkey3":"C",
      "subkey4":"D"
     }
  }
  ```

- 在 `key1` 和 `key2` 中分别增加 `subkey5` 和 `subkey6`，可在调用 API 时传入 `{"key1.subkey5":"E", "key2.subkey6":"F"}`，修改后的属性为：

  ```json
  {"key1":
     {"subkey1":"A",
      "subkey2":"B",
      "subkey5":"E"
     },
   "key2":
     {"subkey3":"C",
      "subkey4":"D",
      "subkey6":"F"
     }
  }
  ```

