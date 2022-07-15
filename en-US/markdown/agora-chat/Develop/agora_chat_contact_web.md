After logging in to Agora Chat, users can start adding contacts and chatting with each other. They can also manage these contacts, for example, by adding, retrieving and removing contacts. They can also add the specified user to the block list to stop receiving messages from that user.

This page shows how to use the Agora Chat SDK to implement contact management.

## Understand the tech

The Agora Chat SDK uses the Contact module to add, remove and manage contacts. Core methods include the following:

- `addContact`: Adds a contact.
- `acceptContactInvite`: Accepts the contact invitation.
- `declineContactInvite`: Declines the contact invitation.
- `deleteContact`: Deletes a contact.
- `getContacts`: Retrieves a list of contacts.
- `connection.addEventHandler()`: Adds the event handler.
- `addUsersToBlockList`: Adds the specified user to the block list.
- `removeUserFromBlockList`: Removes the specified user from the block list.
- `getBlockList`: Retrieves a list of blocked users from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_web?platform=Web).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=Web).

## Implementation

This section shows how to manage contacts with the methods provided by the Agora Chat SDK.

### Manage the contact list

Use this section to understand how to send a contact invitation, listen for contact events, and accept or decline the contact invitation.

#### Send a contact invitation

Call `addContact` to add the specified user as a contact:

```javascript
let message = 'Hello!';
WebIM.conn.addContact('username', message);   
```

#### Listen for contact events

Use `connection.addEventHandler` to add the following callback events. When a user receives a contact invitation, you can accept or decline the invitation.

```javascript
/**
 * msg indicates the result of triggering the callback
 */
connection.addEventHandler('CONTACT', {
    // Occurs when the contact invitation is received
    onContactInvited: function(msg){}
    // Occurs when the contact is deleted
    onContactDeleted: function(msg){}
    // Occurs when a contact is added
    onContactAdded: function(msg){}
    // Occurs when the contact invitation is declined
    onContactRefuse: function(msg){} 
    // Occurs when the contact invitation is approved
    onContactAgreed: function(msg){} 
})
```

#### Accept or decline the contact invitation

After receiving `onContactInvited`, call `acceptContactInvite` or `declineContactInvite` to accept or decline the invitation.

```javascript
/**
 * Accepts the contact invitation
 */
WebIM.conn.acceptContactInvite('username')

/**
 * Declines the contact invitation
 */
WebIM.conn.declineContactInvite('username')
```

#### Delete a contact

Call `deleteContact` to delete the specified contact. The deleted user receives the `onContactDeleted` callback.

```javascript
WebIM.conn.deleteContact('username');   
```

#### Retrieve the contact list

To get the contact list, you can call `getContacts`.

```javascript
WebIM.conn.getContacts().then( (res) => {
    console.log(res) // res.data > ['user1', 'user2']
}
```

### Manage the block list

You can add a specified user to your block list. Once you do that, you can still send chat messages to that user, but you cannot receive messages from them. 

<div class="note alert">Users can add any other chat user to their block list, regardless of whether this other user is a contact or not. A contact added to the block list remains in the contact list.</div>

#### Add a user to the block list

Call `addUsersToBlockList` to add the specified user to the block list.

```javascript
WebIM.conn.addUsersToBlocklist({
    name: ["user1", "user2"],
});
```


#### Remove a user from the block list

To remove the specified user from the block list, call `removeUserFromBlockList`.

```javascript
WebIM.conn.removeUserFromBlockList({
    name: ["user1", "user2"],
});
```

#### Retrieve the block list from the server

To get the block list, call `getBlocklist`. 

```javascript
WebIM.conn.getBlocklist();
```

## Reference

For detailed information on user attributes, refer to the following API Reference:
- [Contact](./API%20Reference/im_ts/modules/Contact.html)