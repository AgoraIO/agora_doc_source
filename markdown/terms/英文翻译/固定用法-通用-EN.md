## 仅适用

中文描述中，“仅适用于{平台名称}“在英文翻译时处理为“({platform} only)”

## 请改用

中文描述中，“请改用{API 名称}”在英文翻译时处理为“Use {API name with code font} instead.”

## 详见

中文描述中，“详见{API 名称}“在英文翻译时处理为"See {API name with code font}."

## 返回值描述

中文的返回值根据实际情况按照下列示例来描述

### 示例 1

```input
- 0：方法调用成功。
- < 0：方法调用失败。
```

```output
- 0: Success.
- < 0: Failure.
```

### 示例 2

```
input
- 方法调用成功：返回 {api name} 对象。
- 方法调用失败：返回空指针。
```

```output
- The {api name} object, if the method call succeeds.
- An empty pointer , if the method call fails.
```

## 详见详情

在中文描述中，“详见{业务描述}了解详情和解决建议。” 翻译为“See {placeholder} for details and resolution suggestions.”

## 异常

在 android 平台的 API 中文返回值描述中，“方法成功调用时，无返回值；方法调用失败时，会抛出 {placeholder} 异常，你需要捕获异常并进行处理。” 翻译为“When the method call succeeds, there is no return value; when fails, the {placeholder} exception is thrown. You need to catch the exception and handle it accordingly.”

## 加入频道前后均可调用

在中文描述中，“该方法在加入频道前后均可调用。”翻译为“You can call this method either before or after joining a channel.”

## 分发回调至主队列

在中文描述中，“设置是否分发回调至主队列”翻译为“Sets whether to dispatch delegate methods to the main queue.”

## 频道外调用该方法

在中文描述中，“声网建议你在频道外调用该方法。”翻译为“Agora recommends that you call this method before joining a channel.”

## 在{API name}之后调用

在中文描述中，“该方法需要在{API name}之后调用”翻译为“Call this method after {api name with code font}".

## 设置{API name}回调数据的格式

在中文描述中，“该方法设置{api name}回调数据的格式。”翻译为“Sets the data format for the {callback name with code font} callback.”

## 方法调用被拒绝

在中文描述中，“方法调用被拒绝”翻译为“This method call was rejected."

## 输出参数

如果某个参数的中文描述是“输出参数，{实际业务描述}”翻译时处理为“An output parameter.{实际业务描述。Use a complete sentence}”

## @since

在中文描述中，"{该方法/API/struct/}自 vX.Y.Z 新增"，翻译时处理为 “Available since vX.Y.Z.”

## value range

在翻译时，把参数的数值取值范围处理为数学表达式：

-   **闭区间**：`[1,100]` 而不是 "1 to 100" 或 "from 1 to 100"
-   **开区间**：`(0,1)` 表示不包含端点的区间
-   **半开区间**：`[0,1)` 或 `(0,1]`

### 示例

```
- "The range is [1,100]"
- "Values from (0, 200]"
```
