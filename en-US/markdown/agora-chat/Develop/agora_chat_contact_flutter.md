After logging in to Agora Chat, users can start adding contacts and chatting with each other. They can also manage these contacts, for example, by adding, retrieving and removing contacts. They can also add the specified user to the block list to stop receiving messages from that user.

This page shows how to use the Agora Chat SDK to implement contact management.

## Understand the tech

The Agora Chat SDK uses `ChatContactManager` to add, remove and manage contacts. Followings are the core methods:

- `addContact`: Adds a contact.
- `acceptInvitation`: Accepts the contact invitation.
- `declineInvitation`: Declines the contact invitation.
- `deleteContact`: Deletes a contact.
- `getAllContactsFromServer`: Retrieves a list of contacts from the server.
- `getAllContactsFromDB`: Retrieves all contacts from the local database.
- `addUserToBlockList`: Adds the specified user to the block list.
- `removeUserFromBlockList`: Removes the specified user from the block list.
- `getBlockListFromServer`: Retrieves a list of blocked users from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- Have a project that has implemented [the basic real-time chat functionalities](./agora_chat_get_started_flutter?platform=Flutter).
- Have a thorough understanding of the API call frequency limit, the maximum size of all the attributes of a specified user, and the maximum size of all user attribtues in an app. For details, see [Known limitations](./agora_chat_limitation?platform=Flutter).

## Implementation

This section shows how to manage contacts with the methods provided by the Agora Chat SDK.

### Add a contact

This section uses user A and user B as an example to describe the process of adding a peer user as a contact.

User A call `addContact` to add user B as a contact:

```dart
// The user ID that you want to add as a contact
String userId = "foo";
// Reasons for adding the user as a contact
String reason = "Request to add a friend.";
try{
  await ChatClient.getInstance.contactManager.addContact(userId, reason);
} on ChatError catch (e) {
}
```

When user B receives the contact invitation, accept or decline the invitation.

- To accept the invitation

  ```dart
  // The user ID that sends the contact invitation
  String userId = "bar";
  try{
    await ChatClient.getInstance.contactManager.acceptInvitation(userId);
  } on ChatError catch (e) {
  }
  ```

- To decline the invitation

  ```dart
  // The user ID that sends the contact invitation
  String userId = "bar";
  try{
    await ChatClient.getInstance.contactManager.declineInvitation(userId);
  } on ChatError catch (e) {
  }
  ```

User A uses `ChatContactManagerListener` to listen for contact events. 

- If user B accepts the invitation, `onContactInvited` is triggered.

  ```dart
  class _ContactPageState extends State<ContactPage>
      implements ChatContactManagerListener {
    @override
    void initState() {
      super.initState();
      ChatClient.getInstance.contactManager.addContactManagerListener(this);
    }
    @override
    void dispose() {
      ChatClient.getInstance.contactManager.removeContactManagerListener(this);
      super.dispose();
    }
    @override
    void onContactInvited(String userName, String? reason) {}
  }
  ```

- If user B declines the invitation, `onFriendRequestDeclined` is triggered.

  ```dart
  class _ContactPageState extends State<ContactPage>
      implements ChatContactManagerListener {
    @override
    void initState() {
      super.initState();
      ChatClient.getInstance.contactManager.addContactManagerListener(this);
    }
    @override
    void dispose() {
      ChatClient.getInstance.contactManager.removeContactManagerListener(this);
      super.dispose();
    }
    @override
    void onFriendRequestDeclined(String userName, String? reason) {}
  }
  ```

### Retrieve the contact list

You can retrieve the contact list from the server and from the local database. Refer to the following sample code:

```dart
// Call getAllContactsFromServer to retrieve the contact list from the server.
List<String> contacts = await ChatClient.getInstance.contactManager.getAllContactsFromServer();

// Call getAllContactsFromDB to retrieve the contact list from the local database.
List<String> contacts = await ChatClient.getInstance.contactManager.getAllContactsFromDB();
```


### Delete a contact

Call `deleteContact` to delete the specified contact. To prevent mis-operation, we recommend adding a double confirm process before deleting the contact.

```dart
// The user ID
String userId = "tom";
// Whether to keep the conversation when deleting the contact
bool keepConversation = true;
try {
  await ChatClient.getInstance.contactManager.deleteContact(
    userId,
    keepConversation,
  );
} on ChatError catch (e) {
}
```

### Add a user to the block list

Call `addUserToBlockList` to add the specified user to the block list. Once you add a user to the block list, you can no longer receive messages from this user.

<div class="note alert">Users can add any other chat user to their block list, regardless of whether this other user is a contact or not. A contact added to the block list remains in the contact list.</div>

```dart
// The user ID
String userId = "tom";
try {
  await ChatClient.getInstance.contactManager.addUserToBlockList(userId);
} on ChatError catch (e) {
}
```

### Retrieve the block list

To get the block list from the local device, call `getBlockListFromDB`.

```dart
try {
  List<String> list =
      await ChatClient.getInstance.contactManager.getBlockListFromDB();
} on ChatError catch (e) {
}
```

You can also retrieve the block list from the server by calling `getBlockListFromServer`.

```dart
try {
  List<String> list =
      await ChatClient.getInstance.contactManager.getBlockListFromServer();
} on ChatError catch (e) {
}
```

### Remove a user from the block list

To remove the specified user from the block list, call `removeUserFromBlockList`. 

```dart
String userId = "tom";
try {
  await ChatClient.getInstance.contactManager.removeUserFromBlockList(userId);
} on ChatError catch (e) {
}
```