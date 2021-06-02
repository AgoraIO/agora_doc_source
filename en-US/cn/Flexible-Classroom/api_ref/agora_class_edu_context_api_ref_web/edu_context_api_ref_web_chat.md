# useChatContext

`useChatContext()` enables developers to implement the chat function in the flexible classroom.

You can import `useChatContext` by `import { useChatContext } from 'agora-edu-core';` and then use `const {...} = useChatContext()` to implement the functions and events related to classroom management.

This page lists all the functions and events provided by `useChatContext()`.

## isHost

```typescript
isHost: boolean,
```

Whether the role is the teacher or teaching assistant.

## getHistoryChatMessage

```typescript
async getHistoryChatMessage(data: {
    nextId: string,
    sort: number
}): array
```

Fetch the message history.

Example:` getHistoryChatMeassage({nextId:"idstring", sort: 1})`

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `nextId` | You can fetch message history in batches with this parameter. When you call this method for the first time, leave this parameter empty or set it as null. You can set this parameter as the `nextId` that you get in the response of the previous method call. |
| `sort` | <li>`0`: Fetch message history in ascending order.<li>`1`: Fetch message history in descending order. |

## messageList

```typescript
messageList: array,
```
The message list.

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
Send a message.


| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `message` | The message. |


## muteChat

```typescript
async muteChat(): void
```
Disable the chat function.

## unmuteChat

```typescript
async unmuteChat(): void
```

Enable the chat function.

## chatCollapse

```typescript
chatCollapse: boolean,
```

Whether is the chatbox is folded.

## toggleChatMinimize

```typescript
toggleChatMinimize(): void
```

Fold or expand the chatbox.

## unreadMessageCount

```typescript
unreadMessageCount: number,
```

The number of unread messages.

## canChatting

```typescript
canChatting: boolean,
```

Whether the chat function is enabled.

## addChatMessage

```typescript
addChatMessage(args: any): void
```

Add a message to the message list.

| Parameter | Description |
| :----- | :--------------------------------- |
| `args` | Pass in the object returned in the method of sending a message. |