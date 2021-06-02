# useChatContext

`useChatContext()` 提供消息聊天相关能力。

你可以通过 `import { useChatContext } from 'agora-edu-core';  ` 引入 `useChatContext`，然后使用 `const {...} = useChatContext()` 获取灵动课堂中消息聊天相关能力。

以下具体列出 `useChatContext()` 提供的能力。

## isHost

```typescript
isHost: boolean,
```

角色是否为教师或助教。

## getHistoryChatMessage

```typescript
async getHistoryChatMessage(data: {
    nextId: string,
    sort: number
}): array
```

获取历史聊天消息。

调用示例：`getHistoryChatMeassage({nextId:"idstring", sort: 1})`

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `nextId` | 用于分批获取消息。第一次传空字符串。返回结果里有一个 `nextId` 字段，下一批获取传入该值。 |
| `sort`   | <li>`0`: 正序获取历史聊天消息。 <li>`1` : 倒序获取历史聊天消息。 |

## messageList

```typescript
messageList: array,
```
聊天消息列表。

## sendMessage

```typescript
async sendMessage(message: any): {
    id,
    ts,
    text,
    account,
    sender,
    messageId,
    fromRoomName
}
```
发送聊天消息。


| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `message` | 聊天消息。  |


## muteChat

```typescript
async muteChat(): void
```
禁止聊天。

## unmuteChat

```typescript
async unmuteChat(): void
```

取消禁止聊天。

## chatCollapse

```typescript
chatCollapse: boolean,
```

是否折叠聊天消息框。

## toggleChatMinimize

```typescript
toggleChatMinimize(): void
```

切换折叠状态。

## unreadMessageCount

```typescript
unreadMessageCount: number,
```

未读消息数量。

## canChatting

```typescript
canChatting: boolean,
```

聊天功能是否可用。

## addChatMessage

```typescript
addChatMessage(args: any): void
```

向聊天消息列表新增一条聊天消息。

| 参数   | 描述                               |
| :----- | :--------------------------------- |
| `args` | 传入发送聊天消息方法中返回的对象。 |