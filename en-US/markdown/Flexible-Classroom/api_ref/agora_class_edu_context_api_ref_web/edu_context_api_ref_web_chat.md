`ChatContext` enables developers to implement the chat function in the flexible classroom.

## isHost

```typescript
isHost: boolean,
```

Whether the local user is the teacher or teaching assistant.

## getHistoryChatMessage

```typescript
getHistoryChatMessage: (data: {
    nextId: string;
    sort: number;
})=>Promise<any>,
```

Fetches the message history.

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
sendMessage: (message: any) => Promise<{
    id: string,
    ts: number,
    text: any,
    account: string,
    sender: boolean,
    messageId: string,
    fromRoomName: string,
}>,
```
Sends a message.


| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |


## muteChat

```typescript
muteChat: () => void,
```
Disables the chat function.

## unmuteChat

```typescript
unmuteChat: () => void,
```

Enables the chat function.

## chatCollapse

```typescript
chatCollapse: boolean,
```

Whether is the chat box is folded.

## toggleChatMinimize

```typescript
toggleChatMinimize(): void
```

Folds or expands the chat box.

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
addChatMessage: (args: any) => void
```

Adds a message to the message list.

| Parameter | Description |
| :----- | :--------------------------------- |
| `args` | Passes in the object which is returned in the method of sending a message. |