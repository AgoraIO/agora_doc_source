# 元数据 API 参考

RTM 1.6.0 版本为你提供元数据功能，助力您搭建创新、可靠、易用、可扩展的应用。

使用该功能，你无需搭建自己的数据库，即可存储应用中用户和频道的元数据；此外，当数据库中的元数据发生变更时，客户可以实时监听事件回调并相应更新前端应用。


## 创建元数据项

### createMetadataItem

创建 `RtmMetadataItem` 实例。

```javascript
  createMetadataItem(): RtmMetadataItem;
```

#### 返回值

一个 `RtmMetadataItem` 实例。详见 [RtmMetadataItem](#rtmmetadataitem)。

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("mode");
item1.setValue("mode");
item2.SetKey("gender");
item2.setValue("male");
```


## 配置用户的元数据

### setLocalUserMetadata

设置本地用户的元数据项。

<div class="alert note">该方法会覆盖当前用户的元数据。</div>

```javascript
  setLocalUserMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。   |
| `options`     | `RtmMetadataOptions`  | 否  | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("mode");
item1.setValue("mode");
item2.SetKey("gender");
item2.setValue("male");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await setLocalUserMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### getUserMetadata

获取指定用户的元数据项。

```javascript
  getUserMetadata(uid: string): Promise<RtmMetadata>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `uid`      | String   |  是      |  用户登陆 RTM 系统的 UID。 |

#### 返回值

一个 `RtmMetadata` 实例。详见 [RtmMetadata](#rtmmetadata).

<div class="alert note">如果指定的 <code>uid</code> 尚未设置用户元数据，该方法调用后，会返回空 <code>{}</code>。</div>

#### 使用示例

```javascript
try{
    const rtmMetadata = await getUserMetadata("Tony");
    console.log(rtmMetadata);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### addLocalUserMetadata

添加本地用户的元数据项。

```javascript
  addLocalUserMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。<div class="alert note">请确保新增的键值唯一。如果指定的键值对已存在用户的元数据中，方法调用失败。</div>   |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("mode");
item1.setValue("mode");
item2.SetKey("gender");
item2.setValue("male");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await addLocalUserMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### deleteLocalUserMetadata

删除本地用户的元数据项。

```javascript
  deleteLocalUserMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

> Caution：This operation will always excute regardless of the existing of metadata items
// TODO: 没太懂这里想强调什么信息

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。   |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("mode");
item2.SetKey("gender");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await deleteLocalUserMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### updateLocalUserMetadata

更新本地用户的元数据项。

```javascript
  updateLocalUserMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。<div class="alert note">该方法仅用于更新已有元数据，请确保指定的键值对已存在本地用户的元数据中，否则方法调用失败。</div>   |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |


#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("mode");
item1.setValue("mode");
item2.SetKey("gender");
item2.setValue("male");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await updateLocalUserMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### clearLocalUserMetadata

清除本地用户的元数据项。

<div class="alert note">该方法会清除本地用户的全部元数据，请谨慎操作。</div>

```javascript
  clearLocalUserMetadata(options?: RtmMetadataOptions): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const metadataOption = {
        majorRevision: 1234567;
};

try{
    await clearLocalUserMetadata(metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### subscribeUserMetadata

订阅特定用户的用户元数据更新事件。

```javascript
  subscribeUserMetadata(uid: string): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `uid`      | String   |  是      |  用户登陆 RTM 系统的 UID。 |

#### 使用示例

```javascript
try{
    await subscribeUserMetadata("Tony");
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### unsubscribeUserMetadata

取消订阅特定用户的用户元数据更新事件。

```javascript
  unsubscribeUserMetadata(uid: string): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `uid`      | String   |  是      |  用户登陆 RTM 系统的 UID。 |

#### 使用示例

```javascript
try{
    await unsubscribeUserMetadata("Tony");
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### UserMetaDataUpdated

用户元数据变更回调。

在调用上述方法设置、更新、添加、删除和清除本地用户的元数据时，SDK 均会触发该回调通知远端订阅方。

```javascript
  UserMetaDataUpdated: (uid: string, data: RtmMetadata) => void;
```

#### 参数

| 名称       | 类型     |      描述          |
| :--------- | :------- | :-------------- |
| `uid`      | String   |  输出参数。元数发生变更的用户 ID。 |
| `data`      | RtmMetadata   |  输出参数。详见 [RtmMetadata](#rtmmetadata)。 |

#### 使用示例

```javascript
UserMetaDataUpdated: (uid: string, data: RtmMetadata) => {
    // handle the event
}
```



## 配置频道元数据

### setChannelMetadata

设置频道的元数据项。

<div class="alert note">该方法会覆盖当前频道的元数据。</div>

```javascript
  setChannelMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 频道元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。   |
| `options`     | `RtmMetadataOptions`  | 否 | 频道元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("Announcement");
item1.setValue("Welcome to RTM");
item2.SetKey("Channel_type");
item2.setValue("Public");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await setChannelMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### addChannelMetadata

向频道添加新的元数据项。

```javascript
  addChannelMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。<div class="alert note">请确保新增的键值唯一。如果指定的键值对已存在频道的元数据中，方法调用失败。</div>   |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("Announcement");
item1.setValue("Welcome to RTM");
item2.SetKey("Channel_type");
item2.setValue("Public");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await addChannelMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### clearChannelMetadata

清除频道的元数据项。

<div class="alert note">该方法会清除当前频道的全部元数据，请谨慎操作。</div>

```javascript
  clearChannelMetadata(options?: RtmMetadataOptions): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const metadataOption = {
        majorRevision: 1234567;
};

try{
    await clearChannelMetadata(metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### updateChannelMetadata

更新频道的元数据项。

```javascript
  updateChannelMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。<div class="alert note">该方法仅用于更新已有元数据，请确保指定的键值对已存在频道的元数据中，否则方法调用失败。</div>   |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("Announcement");
item1.setValue("Welcome to RTM!");
item2.SetKey("Channel_Type");
item2.setValue("Public");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await updateChannelMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### deleteChannelMetadata

删除频道的元数据项。

```javascript
  deleteChannelMetadata(
    items: RtmMetadataItem[],
    options?: RtmMetadataOptions
  ): Promise<void>;
```

#### 参数

| 名称       | 类型     |  是否必须  |      描述          |
| :--------- | :------- | :-------- |:----------------- |
| `items`         | Array(`RtmMetadataItem`) | 是 | 元数据的键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。   |
| `options`     | `RtmMetadataOptions`  | 否 | 元数据的可选属性，详见 [RtmMetadataOptions](#rtmmetadataoptions)。      |

#### 使用示例

```javascript
const item1 = createMetadataItem();
const item2 = createMetadataItem();
item1.setKey("Announcement");
item2.SetKey("Channel_Type");
const metadataOption = {
        majorRevision: 1234567;
        enableRecordTs: true;
        enableRecordUserId: true;
};

try{
    await deleteChannelMetadata([item1,item2],metadataOption);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### getChannelMetadata

获取当前频道的元数据项。

```javascript
  getChannelMetadata(): Promise<RtmMetadata>;
```

#### 返回值

一个 `RtmMetadata` 实例。详见 [RtmMetadata](#rtmmetadata).

<div class="alert note">如果当前频道尚未设置元数据，该方法调用后，会返回空 <code>{}</code>。</div>      

#### 使用示例

```javascript
try{
    const channelMetadata = await getChannelMetadata("my_channel");
    console.log(channelMetadata);
}catch(status){
    if (status){
        const {code,message} = status;
        console.log(code,message);
    }
}
```


### ChannelMetaDataUpdated

频道元数据变更回调。

加入频道后，你会自动监听频道的元数据变更事件，该回调在调用上述方法设置、更新、添加、删除和清除频道元数据时，均会触发。

```javascript
  ChannelMetaDataUpdated: (data: RtmMetadata) => void;
```

#### 参数

| 名称       | 类型     |      描述         |
| :--------- | :------- | :-------------- |
| `data`      | Array   |  输出参数。详见 [RtmMetadata](#rtmmetadata)。 |

#### 使用示例

```javascript
channel.on('ChannelMetaDataUpdated', (data) => {
    console.log(data); // 
});
```



## 类型定义

### RtmMetadataItem

元数据项，用户和频道元数据的基本单位。

```javascript
export declare class RtmMetadataItem {

  setKey(key: string): void;

  getKey(): string;

  setValue(value: string | null): void;

  getValue(): string | null;

  setRevision(revision: number): void;

  getRevision(): number;

  getUpdateTs(): number;

  getAuthorUserId(): string;
}
```

#### 参数

|  名称    |  类型   |   描述           |
| -------- | -------- | -------------- |
| `setKey(key: string): void` |     方法     |  设置元数据项的键。 <br>**参数**<br>`key`<br>元数据项的键。该字符串不可超过 32 字节。以下为支持的字符集范围：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", " {", "}", "|", "~", ","</li></ul><div class="alert note"><ul><li>请不要将 key 设为""，或字符串 "null"。</li><li>key 不支持 <code>number</code> 类型。建议调用 <code>toString()</code> 方法转化非 string 型 key。</li></ul></div>                        |
| `getKey(): string`          |     方法     |  获取元数据项的键。                        |
| `setValue(value: string\| null): void` |  方法     |  设置元数据项的值。该字符串不可超过 16 KB。        |
| `getValue(): string\| null`            |  方法     |  获取元数据项的值。                |
| `setRevision(revision: number): void`  |  方法     |  设置元数据项的版本。 // TODO: revision 是否有限制信息？此外是否还有其他限制信息？              |
| `getRevision(): number`                |  方法     |  获取元数据项的版本。               |
| `getUpdateTs(): number`                |  方法     |  获取元数据项上次更新时间的时间戳。   |
| `getAuthorUserId(): string`            |  方法     |  获取对最新元数据项进行更新的用户的 ID。 |


### RtmMetadata

元数据。

```javascript
export interface RtmMetadata {
  items: RtmMetadataItem[];
  majorRevision: number;
}
```

#### 参数

| 名称   |  类型      | 描述                   |
|:-------|:-----------------|:-------------------|
| `items`     | Array(`RtmMetadataItem`) | 用户的元数据键值对，详见 [RtmMetadataItem](#rtmmetadataitem)。    |
| `majorRevision` | Number      |  用户的元数据主版本。    |


### RtmMetadataOptions

元数据可选属性。

```javascript
export interface RtmMetadataOptions {
  majorRevision?: number;
  enableRecordTs?: boolean;
  enableRecordUserId?: boolean;
}
```

#### 参数

| 名称   |  类型      | 描述                   |
|:-------|:-----------------|:-------------------|
| `majorRevision`      | Number |   用户的元数据主版本。when the `majorRevision` you supplied is as same as the one in the storage, this operation will success. //TODO: 看起来是用来做校验的？是否需要展开说明主版本和单个版本对校验的作用？ |
| `enableRecordTs`     | Bool   | 是否自动记录元数据项最近一次更新的时间：<ul><li>`true`：是</li><li>`false`：(默认值) 否</li></ul>  |
| `enableRecordUserId` | Bool   | 是否自动记录元数据项最近一次更新的用户：<ul><li>`true`：是</li><li>`false`：(默认值) 否</li></ul>   |



//TODO: 好像缺一些错误码/状态码的枚举类？
### MetaDataOperationError

### MetaDataSubscriptionError