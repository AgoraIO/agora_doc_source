# SDK Logs

To output logs on the console, you need to enable the debug mode by setting `debugModel` to `true` during SDK initialization.

```typescript
chatlog.log(`${ChatClient.TAG}: login: `, userName, "******", isPassword);
```
