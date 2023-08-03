After logging in to Agora Chat, users can start adding contacts and chatting with each other. They can also manage these contacts, for example, by adding, retrieving and removing contacts. They can also add the specified user to the block list to stop receiving messages from that user.

This page shows how to use the Agora Chat SDK to implement contact management.

## Understand the tech

The Agora Chat SDK uses `IAgoraChatContactManager` to add, remove and manage contacts. Followings are the core methods:

- `addContact`: Adds a contact.
- `deleteContact`: Deletes a contact.
- `getContactsFromServerWithCompletion`: Retrieves a list of contacts from the server.
- `addUserToBlackList`: Adds the specified user to the block list.
- `removeUserFromBlackList`: Removes the specified user from the block list.
- `getBlackListFromServerWithCompletion`: Retrieves a list of blocked users from the server.

## Prerequisites

Before proceeding, ensure that you meet the following requirements:

- You have integrated the Agora Chat SDK, initialized the SDK and implemented the functionality of registering accounts and login. For details, see [Get Started with Agora Chat](./agora_chat_get_started_ios?platform=iOS).
- You understand the API call frequency limits as described in [Limitations](./agora_chat_limitation?platform=iOS).

## Implementation

This section shows how to manage contacts with the methods provided by the Agora Chat SDK.

### Manage the contact list

Use this section to understand how to send a contact invitation, listen for contact events, and accept or decline the contact invitation.

#### Send a contact invitation

Call `addContact` to add the specified user as a contact:

```objective-c
/*
 *  Adds a contact.
 *
 *  @param aUsername        The username to be added as a contact
 *  @param aMessage         The invitation message
 *  @param aCompletionBlock The completion block of this method
 */        
[[AgoraChatClient sharedClient].contactManager addContact:@"aUsername" message:@"Message" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Adding the contact succeeds %@",aUsername);
    } else {
        NSLog(@"Adding the contact fails %@", aError.errorDescription);
    }
}];
```

#### Listen for contact events

Use `ContactListener` to add the following callback events. When a user receives a contact invitation, you can accept or decline the invitation.

```objectivec
// Adds a contact manager delegate.
[[AgoraChatClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
// Removes the contact manager delegate.
[[AgoraChatClient sharedClient].contactManager removeDelegate:self];
	@@ -57,11 +57,20 @@
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage
{ }
// The peer user accepts the contact invitation.
- (void)friendRequestDidApproveByUser:(NSString *)aUsername
{ }
// The peer user declines the contact invitation.
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername
{ }
// The contact is deleted.
- (void)friendshipDidRemoveByUser:(NSString *)aUsername
{ }
```

#### Accept or decline the contact invitation

After receiving `friendRequestDidReceiveFromUser`, call `approveFriendRequestFromUser` or `declineFriendRequestFromUser` to accept or decline the invitation. The peer user receives the `friendRequestDidApprove` or `friendRequestDidDecline` callback.

```objective-c
/*
 *  Approves the contact invitation.
 *
 *  @param aUsername        The username that sends the contact invitation
 *  @param aCompletionBlock The completion block of this method
 */                          
[[AgoraChatClient sharedClient].contactManager approveFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Approving the contact invitation succeeds");
    } else {
        NSLog(@"Approving the contact invitation fails because of--- %@", aError.errorDescription);
    }
}];
```

```objective-c
/*
 *  Declines the contact invitation.
 *
 *  @param aUsername        The username that sends the contact invitation
 *  @param aCompletionBlock The completion block of this method
 */
[[AgoraChatClient sharedClient].contactManager declineFriendRequestFromUser:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Declining the contact invitation succeeds.");
    } else {
        NSLog(@"Declining the contact invitation fails because of %@", aError.errorDescription);
    }
}];
```

Once you accept or decline the contact invitation, the user that sends the invitation receives the `friendRequestDidApprove` or `friendRequestDidDecline` callback

```objective-c
/*
 * Occurs when the peer user accepts your contact invitation.
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername
{ }
```

```objective-c
/*
 * Occurs when the peer user declines your contact invitation.
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername
{ }
```

#### Delete a contact

Call `deleteContact` to delete the specified contact. 

```objective-c
/*
 *  Deletes the contact.
 *
 *  @param aUsername                The username of the contact to be removed
 *  @param aIsDeleteConversation    Whether to delete the conversation with the contact
 *  @param aCompletionBlock         The completion block for this method
 */
[[AgoraChatClient sharedClient].contactManager deleteContact:@"aUsername" isDeleteConversation:aIsDeleteConversation completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Removing the contact succeeds");
    } else {
        NSLog(@"Removing the contact fails %@", aError.errorDescription);
    }
}];
```

Once the contact is deleted, both users receive the `friendshipDidRemoveByUser` callback.

```objective-c
/*
 * Occurs when the contact is removed.
 */
- (void)friendshipDidRemoveByUser:(NSString *)aUsername
{ }
```

#### Retrieve the contact list

To get the contact list, you can call `getContactsFromServerWithCompletion` to retrieve contacts from the server. After that, you can also call `getContacts` to retrieve contacts from the local database.

```objective-c
// Retrieves a list of contacts from the server
[[AgoraChatClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Retrieving the contact list succeeds %@",aList);
    } else {
        NSLog(@"Retrieving the contact list fails because of %@", aError.errorDescription);
    }
}];
```

```objective-c
// Retrieves a list of contacts from the local database
NSArray *userlist = [[AgoraChatClient sharedClient].contactManager getContacts];
```

### Manage the block list

You can add any other users to the block list, regardless of whether they are on the contact list or not. Contacts are still displayed on the contact list even if they are added to the block list. After adding users to the block list,  you can still send messages to them, but will not receive messages from them as they cannot send messages or friend requests to you.

#### Add a user to the block list

Call `addUserToBlackList` to add the specified user to the block list.

```objective-c
/*
 *  Adds the user to the block list.
 *
 *  @param aUsername        The usernames to be added to the block list
 *  @param aCompletionBlock The completion block of this method
 */              
[[AgoraChatClient sharedClient].contactManager addUserToBlackList:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Adding the contact to the block list succeeds");
    } else {
        NSLog(@"Adding the contact to the block list fails because of %@", aError.errorDescription);
    }
}];
```

#### Remove a user from the block list

To remove the specified user from the block list, call `removeUserFromBlackList`.

```objective-c
/*
 *  Removes the user from the block list.
 *
 *  @param aUsername        The usernames to be removed from the block list
 *  @param aCompletionBlock The completion block for this method call
 */
[[AgoraChatClient sharedClient].contactManager removeUserFromBlackList:@"aUsername" completion:^(NSString *aUsername, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Removing the user from the block list succeeds");
    } else {
        NSLog(@"Removing the user from the block list fails because of %@", aError.errorDescription);
    }
}]; 
```

#### Retrieve the block list from the server

To get the block list, call `getBlackListFromServerWithCompletion` to retrieve a list of blocked users from the server. 

```objective-c
/*
 *  Retrieve the block list fromn server
 */
[[AgoraChatClient sharedClient].contactManager getBlackListFromServerWithCompletion:^(NSArray *aList, AgoraChatError *aError) {
    if (!aError) {
        NSLog(@"Retrieving the block list from server succeeds %@",aList);
    } else {
        NSLog(@"Retrieving the block list from server fails %@", aError.errorDescription);
    }
}];
```

After retrieving the block list from the server, you can also call `getBlackList` to retrieve the block list from the local database.

```objective-c
NSArray *blockList = [[AgoraChatClient sharedClient].contactManager getBlackList];
```