# useChatContext

`useChatContext()` Provides message chat related capabilities.

You can` use import {useChatContext} from'agora-edu-core';` to introduce `useChatContext`, and then` use const {...} = useChatContext()` to obtain the ability of message chat in the  Flexible Classroom.

The following specifically lists` the capabilities provided by useChatContext()`.

## isHost

```typescript
isHost: boolean,
```

Whether the role is a teacher or a teaching assistant.

## getHistoryChatMessage

```typescript
async getHistoryChatMessage(data: {
    nextId: string,
    sort: number
}): array
```

Get historical chat messages.

Call example:` getHistoryChatMeassage({nextId:"idstring", sort: 1})`

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `nextId` | Used to obtain messages in batches. Pass an empty string for the first time. There is a `nextId `field in the returned result, and the next batch will get this value. |
| `sort` | <li>`0`: Obtain historical chat messages in positive sequence.<li>`1`: Get historical chat messages in reverse order. |

## messageList

```typescript
messageList: array,
```
Chat message list.

## And sendMessage

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
Send chat messages.


| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `message` | Chat message. |


## muteChat

```typescript
async muteChat(): void
```
Chatting is prohibited.

## unmuteChat

```typescript
async unmuteChat(): void
```

Unban chat.

## chatCollapse

```typescript
chatCollapse: boolean,
```

Whether to collapse the chat message box.

## toggleChatMinimize

```typescript
toggleChatMinimize(): void
```

Switch the folded state.

## unreadMessageCount

```typescript
unreadMessageCount: number,
```

The number of unread messages.

## canChatting

```typescript
canChatting: boolean,
```

Whether the chat function is available.

## addChatMessage

```typescript
addChatMessage(args: any): void
```

Add a chat message to the chat message list.

| Parameter | Description |
| :----- | :--------------------------------- |
| `args` | Pass in the object returned in the method of sending chat messages. |