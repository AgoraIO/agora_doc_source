

# Implement the groups lifecycle

Agora Chat supplies complete group and chat room management capabilities. This includes:


- Lifecycle - create and delete groups, update the group name, description and subject. When you create a group you set it to be public or private. You also stipulate if users can request to join the group, or if they can only join on receiving an invitation.  
- Membership - set a group to be invitation only, or open to everyone. Add and remove users to the group, and stop unwanted users from joining the group. You can also block users who have already joined the group. 
- Roles - each user in a group is either a member, an administrator, or one of the owners. Permissions are different for each role.
- Announcements - publishing group announcements.

This BETA documentation shows you how to implement Agora Chat group functionality in your app. 

## Understand the tech

When a user creates a group, they are automatically the group owner. This gives them total control of all activity in a group. That is, to add, remove, mute and communicate with any and all members of the group. A group owner can appoint another member of the group to be an administrator. Other than appoint other administrators and destroy the group, administrators have the same rights as group owners. 

Groups are public or private. Public groups are open to any users in your Agora Chat app. However, you can configure a group so that users who request to join require approval from a group member. Private groups are invitation only. Depending on the group type, invitations are sent by the owner only, or by any member of the group.    

All members of a group have to listen for events in the group in order to see and react to actions performed by themselves and other members of the group. 

The following figure shows the lifecycle of a private group and the commands issued by the different roles:

![Groups workflow](images/chat-groups.png)


When the member of a group is offline, new messages to the group are sent to the offline member using push notifications.

## Prerequisites

In order to follow the procedure in this page, you must have:

- Completed [Get started with Agora Chat](agora_chat_android.md)


## Add group functionality to your app

A group is a way to interact with multiple other users in the same way and th e same time. To add group functionality into your app you need to:

* Update your app UI for groups - add elements to create and update a group.
* Manage the group lifecycle - create, update and delete a group. 
* Manage group membership - add and remove users from private groups. Enable users to join public groups. 
* Send messages to the group - this works in the same way as chat messages
* Manage user roles - add administrators to a group and change the group owner. 
* Listen to and handle group events - override the Agora Chat group event model to enable your users to easily interact with the group. 

Most calls in Agora Chat SDK retrieve or update data about your Agora Chat network from the cloud. In order that your Android App runs correctly, either use the *async* methods or run Agora Chat SDK calls in a separate thread.  

This section explains the different group functionality and shows you how to implement this functionality with basic code examples.

### Update your app UI for groups

In order to manage groups, you need to enable your user to read and input the correct information about groups. For example, if you extend the code you created in [Get started with Agora Chat](agora_chat_android.md), the fewest elements you need to create and update groups in your UI to AgoraChat are:

![Basic groups ui](images/basic-groups-ui.png)

To add this form of UI to your app you need: 

* UI elements in `activity_main.xml`. For example:

   As you see in this layout, each `Button` is linked to a method using the `android:onClick` element. 
    ```xml
            <EditText
                android:id="@+id/et_group"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_marginStart="20dp"
                android:layout_marginTop="10dp"
                android:layout_marginEnd="20dp"
                android:hint="Group or user name"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@id/btn_send_message" />

            <EditText
                android:id="@+id/et_description"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_marginStart="20dp"
                android:layout_marginTop="10dp"
                android:layout_marginEnd="20dp"
                android:hint="Add description"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@id/et_group" />

            <EditText
                android:id="@+id/et_reason"
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_marginStart="20dp"
                android:layout_marginTop="10dp"
                android:layout_marginEnd="20dp"
                android:hint="Add reason"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toRightOf="parent"
                app:layout_constraintTop_toBottomOf="@id/et_description" />

            <Button
                android:id="@+id/btn_group"
                android:layout_width="95dp"
                android:layout_height="43dp"
                android:layout_marginTop="4dp"
                android:onClick="createGroup"
                android:text="Create"
                app:layout_constraintHorizontal_bias="0.408"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toLeftOf="@id/btn_sign_out"
                app:layout_constraintTop_toBottomOf="@id/et_reason" />

            <Button
                android:id="@+id/btn_usr_add"
                android:layout_width="95dp"
                android:layout_height="43dp"
                android:layout_marginTop="40dp"
                android:onClick="addUsers"
                android:text="Add"
                app:layout_constraintHorizontal_bias="0.408"
                app:layout_constraintLeft_toLeftOf="parent"
                app:layout_constraintRight_toLeftOf="@id/btn_sign_out"
                app:layout_constraintTop_toBottomOf="@id/et_reason" />

            <Button
                android:id="@+id/btn_update_group"
                android:layout_width="98dp"
                android:layout_height="40dp"
                android:layout_marginLeft="4dp"
                android:layout_marginTop="4dp"
                android:onClick="updateGroup"
                android:text="Update"
                app:layout_constraintLeft_toRightOf="@id/btn_group"
                app:layout_constraintTop_toBottomOf="@id/et_reason" />

            <Button
                android:id="@+id/btn_update_group2"
                android:layout_width="98dp"
                android:layout_height="44dp"
                android:layout_marginLeft="4dp"
                android:layout_marginTop="40dp"
                android:onClick="removeUser"
                android:text="Remove"
                app:layout_constraintLeft_toRightOf="@id/btn_group"
                app:layout_constraintTop_toBottomOf="@id/et_reason" />

            <Button
                android:id="@+id/btn_delete_group"
                android:layout_width="91dp"
                android:layout_height="42dp"
                android:layout_marginLeft="8dp"
                android:layout_marginTop="4dp"
                android:onClick="deleteGroup"
                android:text="Delete"
                app:layout_constraintLeft_toRightOf="@id/btn_update_group"
                app:layout_constraintTop_toBottomOf="@id/et_reason" />

            <Button
                android:id="@+id/btn_group_join"
                android:layout_width="92dp"
                android:layout_height="45dp"
                android:layout_marginLeft="8dp"
                android:layout_marginTop="40dp"
                android:onClick="joinGroup"
                android:text="Join"
                app:layout_constraintLeft_toRightOf="@id/btn_update_group"
                app:layout_constraintTop_toBottomOf="@id/et_reason" />

            <Switch
                android:id="@+id/sw_private_group"
                android:layout_width="96dp"
                android:layout_height="26dp"
                android:layout_marginLeft="12dp"
                android:text="Private"
                app:layout_constraintLeft_toRightOf="@id/btn_delete_group"
                app:layout_constraintTop_toBottomOf="@id/et_reason"
                tools:layout_editor_absoluteY="511dp" />

            <Switch
                android:id="@+id/sw_group_invite"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginLeft="12dp"
                android:text="Invite"
                app:layout_constraintLeft_toRightOf="@id/btn_delete_group"
                app:layout_constraintTop_toBottomOf="@id/sw_private_group"
                tools:layout_editor_absoluteY="541dp" />
   ```

* Packages in `MainActivity`. For example:

   The minimum packages you need to implement Agora Chat group functionality are:
   ```java
    import io.agora.chat.Group;
    import io.agora.chat.GroupManager;
    import io.agora.chat.GroupOptions;
    import io.agora.GroupChangeListener;
    import io.agora.chat.MucSharedFile;
    import io.agora.ValueCallBack;
   ```
* Variables to hold updates to the UI and retain group information. For example:
   ```java
    private EditText et_group;
    private EditText et_description;
    private EditText et_reason;
    private Switch sw_private_group;
    private Switch sw_group_invite;
    private Group currentGroup;
    private List<String> groupMembers;
  ```
* Connection between the variables to the UI elements in your `initView()` method. For example:
   ```java
   // Group UI items
   et_group = findViewById(R.id.et_group);
   et_description = findViewById(R.id.et_description);
   et_reason = findViewById(R.id.et_reason);
   sw_private_group = findViewById(R.id.sw_private_group);
   sw_group_invite = findViewById(R.id.sw_group_invite);
  ```

With elements such as these in your app, you can create and update group functionality. 

### Manage the group lifecycle

Groups have a standard [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) lifecycle. Group Owners only have the rights to create and delete groups. Administrators can update the group name or group description. Standard users cannot change anything about the group.  

In order to manage groups, in `MainActivity`, create the methods called when users click the buttons in your UI. In the following code examples, the group the user creates becomes the current group. Further CRUD operations are made to that group.  

The main group lifecycle actions are: 

* **Create**: enable users to create a group of a standard size where they choose privacy options:   

   ```java
    public void createGroup(View view) {
        //Retrieve the name and details for the group from the UI.
        String groupName = et_group.getText().toString().trim();
        String description = et_group.getText().toString().trim();
        String reason = et_group.getText().toString().trim();
        groupMembers = new ArrayList<String>();
        //In a production app, you retrieve the possible members from the current users contacts
        //groupMembers.add("gnn");

        if (TextUtils.isEmpty(groupName) || TextUtils.isEmpty(description) || TextUtils.isEmpty(reason)) {
            LogUtils.showErrorToast(MainActivity.this, tv_log, getString(R.string.username_or_pwd_miss));
            return;
        }
        //Set the group options
        GroupOptions options = new GroupOptions();
        options.maxUsers = 200;
        options.inviteNeedConfirm = true;

        //If the group is public, can all members or only the Owner approve new joiners
        if (sw_private_group.isChecked()) {
            if (sw_group_invite.isChecked()) {
                options.style = GroupManager.GroupStyle.GroupStylePublicOpenJoin;
            } else {
                options.style = GroupManager.GroupStyle.GroupStylePublicJoinNeedApproval;
            }
        } else {
            //If group is private, only the owner can invite
            options.style = sw_group_invite.isChecked() ? GroupManager.GroupStyle.GroupStylePrivateMemberCanInvite
                    : GroupManager.GroupStyle.GroupStylePrivateOnlyOwnerInvite;
        }
        LogUtils.showErrorLog(tv_log, "Start create group:" + groupName);
        //Create a new group with these options
        try {
              ChatClient.getInstance().groupManager().asyncCreateGroup(groupName, description, groupMembers.toArray(new String[0]), reason, options, new ValueCallBack<Group>() {
                @Override
                public void onSuccess(Group value) {
                    currentGroup = value;
                    updateGroupList();
                }

                @Override
                public void onError(int error, String errorMsg) {
                    LogUtils.showLog(tv_log, "create failure: " + error + " reason: " + errorMsg);
                }
            });

        } catch (final Exception e) {
            e.printStackTrace();
            LogUtils.showLog(tv_log, "create failure" + e.getLocalizedMessage());
        }
        LogUtils.showErrorLog(tv_log, "End create group:" + groupName);
    }
   ```

* **Modify**: the group owner only can update the group name and description. No event is sent when group information is updated. 
   ```java
    public void updateGroup(View view) {
        //If you have not created a group, exit
        if (currentGroup == null) {
            LogUtils.showErrorToast(MainActivity.this, tv_log, "Create a group first.");
            return;
        }
        //Retrieve the name and details for the group from the UI.
        String groupName = et_group.getText().toString().trim();
        String description = et_group.getText().toString().trim();

        String currentGroupId = currentGroup.getGroupId();
        String oldGroupName = currentGroup.getGroupName();

        LogUtils.showErrorLog(tv_log, "Start create update:" + oldGroupName + " to " + currentGroup + " and description to " + description);
        if (TextUtils.isEmpty(groupName) || TextUtils.isEmpty(description) || TextUtils.isEmpty(oldGroupName)) {
            LogUtils.showErrorToast(MainActivity.this, tv_log, getString(R.string.username_or_pwd_miss));
            return;
        }
        //Update the group with the new details
        try {
            //Check the current user has owner permissions
            if (ChatClient.getInstance().getCurrentUser().equals(currentGroup.getOwner())) {
                ChatClient.getInstance().groupManager().asyncChangeGroupName(currentGroupId,groupName , new CallBack() {
                    @Override
                    public void onSuccess() {
                        LogUtils.showToast(MainActivity.this, tv_log, "Group " + oldGroupName + "changed to " + groupName + ".");
                        updateGroupList();
                    }

                    @Override
                    public void onError(int code, String error) {
                        LogUtils.showErrorToast(MainActivity.this, tv_log, "Cannot update " + oldGroupName + ".");
                    }

                    @Override
                    public void onProgress(int progress, String status) {

                    }
                });
            } else {
                LogUtils.showErrorLog(tv_log, "Only the group owner can update the group name and description");
            }
        } catch (final Exception e) {
            e.printStackTrace();
            LogUtils.showLog(tv_log, "Update failure" + e.getLocalizedMessage());
        }
        LogUtils.showErrorLog(tv_log, "End update group:" + groupName);
    }
   ```
* **Disband**: the group owner only can delete the group. When a group is destroyed, an `onGroupDestroyed (String groupId, String groupName)` event is sent to all members of this group. 
   ```java
    public void deleteGroup(View view) {

        //If you have not created a group, exit
        if (currentGroup == null) {
            LogUtils.showErrorToast(MainActivity.this, tv_log, "Create a group first.");
            return;
        }
        //Retrieve the name and details for the group from the UI.
        String currentGroupId = currentGroup.getGroupId();
        String groupName = currentGroup.getGroupName();
        LogUtils.showErrorLog(tv_log, "Start delete:" + groupName);
        try {
            //Check the current user has owner permissions
            if (ChatClient.getInstance().getCurrentUser().equals(currentGroup.getOwner())) {
                ChatClient.getInstance().groupManager().asyncDestroyGroup(currentGroupId,new CallBack() {
                    @Override
                    public void onSuccess() {
                        LogUtils.showToast(MainActivity.this, tv_log, "Group " + groupName + " deleted.");
                        updateGroupList();
                    }

                    @Override
                    public void onError(int code, String error) {
                        LogUtils.showErrorToast(MainActivity.this, tv_log, "Canoot delete " + groupName + ".");
                    }

                    @Override
                    public void onProgress(int progress, String status) {

                    }
                });
            } else {
                LogUtils.showErrorLog(tv_log, "Only the group owner can update the group name and description");
            }

        } catch (final Exception e) {
            e.printStackTrace();
            LogUtils.showLog(tv_log, "Update failure" + e.getLocalizedMessage());
        }
        LogUtils.showErrorLog(tv_log, "End update group:" + groupName);
    }
   ```

### Manage group membership

By default, only the group owner has rights to invite users to a private group. However, you can enable all members of a private group to invite their Agora Chat contacts to the group. By default, when a user accepts an invitation to a private group, Agora Chat automatically adds them to the group.

In open groups, any user in your Agora Chat space may request to join a group. Membership is either granted automatically or approved by group members.  

The workflow for group membership is:

- **For private groups**:

   The group owner adds and removes users from the current group:
   1. Add users to a private group:
      ```java
       public void addUsers(View view) {
       //If you have not created a group, exit
       if (currentGroup == null) {
         LogUtils.showErrorToast(MainActivity.this, tv_log, "Create a group first.");
         return;
       }
       //Retrieve the name and details for the group from the UI.
       String[] userNames = et_group.getText().toString().trim().split(",");
       String currentGroupId = currentGroup.getGroupId();

        LogUtils.showErrorLog(tv_log, "Start add user:" + userNames);
        new Thread(new Runnable() {
            @Override public void run() {
                try {
                    if (ChatClient.getInstance().getCurrentUser().equals(currentGroup.getOwner())) {
                        ChatClient.getInstance().groupManager().addUsersToGroup(currentGroupId, userNames);
                    } else {
                        ChatClient.getInstance().groupManager().inviteUser(currentGroupId, userNames, null);
                    }
                } catch (final ChatException e) {
                    e.printStackTrace();
                    LogUtils.showLog(tv_log, "Add failure" + e.getLocalizedMessage());
                }
            }
        }).start();
        LogUtils.showErrorLog(tv_log, "End add to group:" + userNames);
       }
      ```

   2. Remove users from a private group. 

       This is essentially the same procedure as adding a user. Check the current user is the group owner, then remove `userName` from the group.    

       ```java
       public void removeUser(View view) {

         //If you have not created a group, exit
         if (currentGroup == null) {
            LogUtils.showErrorToast(MainActivity.this, tv_log, "Create a group first.");
            return;
         }
         //Retrieve the name and details for the group from the UI.
         String userName = et_group.getText().toString().trim();
         String currentGroupId = currentGroup.getGroupId();
         LogUtils.showErrorLog(tv_log, "Start remove user:" + userName);
         new Thread(new Runnable() {
            @Override public void run() {
                try {
                    if (ChatClient.getInstance().getCurrentUser().equals(currentGroup.getOwner())) {
                        ChatClient.getInstance().groupManager().removeUserFromGroup(currentGroupId, userName);
                    } else {
                        LogUtils.showLog(tv_log, "Have to be the owner to remove someone from the group" );
                    }
                } catch (final ChatException e) {
                    e.printStackTrace();
                    LogUtils.showLog(tv_log, "Remove failure" + e.getLocalizedMessage());
                }
            }
         }).start();
         LogUtils.showErrorLog(tv_log, "End update group:");
       }
       ```

- **For public groups**:

   All users can retrieve the list of public groups and request access using the group ID: 
    1. Retrieve the list of public groups:
          ```java
          //Get the list of public groups
          //pageSize is the number of groups to fetch 
          //USe cursor to tell the server where to start fetching. Null means start at the beginning. 
          int pageSize = 20;
          CursorResult<GroupInfo> result = ChatClient.getInstance().groupManager().getPublicGroupsFromServer(pageSize, null);//Asynchronous processing is required
          final List<GroupInfo> returnGroups = result.getData();
          ```
    2. In your UI, present the list of groups so the current user can choose one to join. 
    3. Request access to the group.
          ```java
            public void joinGroup(View view) {
              //Retrieve the group ID from the UI.
              //In a production level UI, you would list the groups and
              //Retrieve the groups from the list
              String groupID = et_group.getText().toString().trim();
              Group groupToJoin = null;
              //In a production app you would retrieve a list of groups so the user can choose one in the UI
              if (TextUtils.isEmpty(groupID)) {
                LogUtils.showErrorToast(MainActivity.this, tv_log, "Add a valid group ID");
                return;
              }
              //Retrieve the group from Agora Chat. Check if the current user is not already a member. If not, join.
              ChatClient.getInstance().groupManager().asyncGetGroupFromServer(groupID, new ValueCallBack<Group>() {
                @Override
                public void onSuccess(Group value) {
                  final Group groupToJoin = value;
                  //Ask to join a members only group or join a public group directly.
                  try {
                    if (groupToJoin.isMemberOnly()) {
                      ChatClient.getInstance()
                          .groupManager()
                          .applyJoinToGroup(groupToJoin.getGroupId(), "apply to join");
                    } else {
                      ChatClient.getInstance().groupManager().joinGroup(groupToJoin.getGroupId());
                    }
                  } catch (ChatException e) {
                    e.printStackTrace();
                  }
              }

              @Override
              public void onError(int error, String errorMsg) {
                LogUtils.showLog(tv_log, "Group does not exist: " + error + " reason: " + errorMsg);
              }
            });

        }
       ```
    4. If a user is not interested in the activity in a group, they can easily leave:
          ```java
          //List the groups the current user is member of.
          List<Group> grouplist = ChatClient.getInstance().groupManager().getJoinedGroupsFromServer();

          //In your UI, present the current user's group list and enable them to easily leave the group. 

           ChatClient.getInstance().groupManager().leaveGroup(groupId);//Asynchronous processing is required
          ```

### Send messages to the group

Sending messages to a group works in exactly the same way as sending a message to a user. You send a message to the group ID rather than the user:

```java
//Retrieve the Id of the group your user wants to send a message to
String currentGroupId = currentGroup.getGroupId();
String content = <Retrieve the text from your UI>;
//Create a text message. 
ChatMessage message = ChatMessage.createTxtSendMessage(content, currentGroupId);
//If it is a group chat, set the chat type. Default is single chat
if (chatType == CHATTYPE_GROUP)
    message.setChatType(ChatType.GroupChat);
//Send a message
ChatClient.getInstance().chatManager().sendMessage(message);
```

### Manage user roles

The user who creates a group is automatically the group owner. The group owner has the rights to make other members of the group administrators. The administrator can do anything the group owner can apart from delete the group. 

The workflow for user roles in a group is:

1. The group owner adds another user as administrator:
   ```java
    ChatClient.getInstance().groupManager().addGroupAdmin(groupId, userID);
   ```
    The owner and the administrator have rights to:
   - Update the group announcement:
      ```java
       ChatClient.getInstance().groupManager().updateGroupAnnouncement(groupId, "The announcement has changed");
      ```
   - Mute and unmute other members in the group:
      ```java
       //Mute group members
       ChatClient.getInstance().groupManager().muteGroupMembers( groupId, muteMemberList, duration);
       //Unmute 
       ChatClient.getInstance().groupManager().unMuteGroupMembers(groupId, unmuteMemberList);
      ```
   - Remove members from the group:
      ```java
       ChatClient.getInstance().groupManager().removeUserFromGroup(groupId, username);
      ```
   - Block and unblock all members from sending messages to the group:
      ```java
        //Block messaging
        ChatClient.getInstance().groupManager().blockGroupMessage(groupId);
        //Unblock messaging
        ChatClient.getInstance().groupManager().unblockGroupMessage(groupId);
      ```
   - Block and unblock users from joining the group:
      ```java
      //Block
     ChatClient.getInstance().groupManager().blockUser(groupId, username);
     // List the users blocked in the group 
     ChatClient.getInstance().groupManager().getBlockedUsers(groupId);
     //Unblock 
     ChatClient.getInstance().groupManager().unblockUser(groupId, username);
     ```     
3. The group owner chooses another member of the group to be group owner. 
   ```java
   ChatClient.getInstance().groupManager().changeOwner( groupId, newOwner);
   ```

### Listen to and handle group events

Groups involve interaction between group owners, administrators, members, and future members. In order to react to other users, your app must listen for events generated by the group. AgoraChat SDK supplies the `io.agora.GroupChangeListener` class that you override to catch group events and interact with your UI.

To add a groups listener to your app:

1. Add the following code in the file where you have your listeners.

   ```java
    private void addGroupListener(){

        ChatClient.getInstance().groupManager().addGroupChangeListener( new GroupChangeListener() {
            @Override
            public void onInvitationReceived(String groupId, String groupName, String inviter, String reason) {
                //The current user has been invited to join `groupId` by `inviter`.
            }

            @Override
            public void onRequestToJoinReceived(String groupId, String groupName, String applicant, String reason) {
                //The group owner or administrator receives a request from `applicant` to join `groupId`.
            }

            @Override
            public void onRequestToJoinAccepted(String groupId, String groupName, String accepter) {
                //The current user has been accepted to join `groupId` by `accepter`.
            }

            @Override
            public void onRequestToJoinDeclined(String groupId, String groupName, String decliner, String reason) {
                //The current user's request to join `groupId` has been refused by `decliner`.
            }

            @Override
            public void onInvitationAccepted(String groupId, String inviter, String reason) {
                //`inviter` approved the current user's request to join `groupID`.
            }

            @Override
            public void onInvitationDeclined(String groupId, String invitee, String reason) {
                //`inviter` rejected the current user's request to join `groupID`.
            }

            @Override
            public void onAutoAcceptInvitationFromGroup(String groupId, String inviter, String inviteMessage) {
                //The current user automatically accepts the invitation from `inviter` to join `groupId`.
            }

            @Override public void onUserRemoved(String groupId, String groupName) {
                // The current user has been removed from `groupId`.
            }

            @Override public void onGroupDestroyed(String groupId, String groupName) {
                // `groupID` has been deleted by the group owner.
                // When this event is received, AgoraChat SDK automatically removes this group from
                // the local database and cache.
            }

            @Override
            public void onMuteListAdded(String groupId, final List<String> mutes, final long muteExpire) {
                //The users listed in `mutes` no longer have rights to post massages to `groupId`
                // during `muteExpire`.
            }

            @Override
            public void onMuteListRemoved(String groupId, final List<String> mutes) {
                //The users listed in `mutes` may now post massages to `groupId`.
            }

            @Override
            public void onWhiteListAdded(String groupId, List<String> whitelist) {
                //Users in `whitelist` may talk to other users in `groupId`.
                //Members of `groupId` who are not in the whitelist remain muted.
                //When the group administrator mutes all members of `groupId`, he or she may then
                //add specific users to the whitelist.
            }

            @Override
            public void onWhiteListRemoved(String groupId, List<String> whitelist) {
                //The users listed in `whitelist` no longer have the right to message other
                //members of `groupId`.
            }

            @Override
            public void onAllMemberMuteStateChanged(String groupId, boolean isMuted) {
                //When `isMutes` is `true`, no group members can post messages to `groupId`.
            }

            @Override
            public void onAdminAdded(String groupId, String administrator) {
                //Group member `administrator` now has the admin role in `groupId`.
            }

            @Override
            public void onAdminRemoved(String groupId, String administrator) {
                //Group member `administrator` is no longer admin for `groupId`.
            }

            @Override
            public void onOwnerChanged(String groupId, String newOwner, String oldOwner) {
                //`newOwner` has replaced `oldOwner` as owner of `groupId`.
            }
            @Override
            public void onMemberJoined(final String groupId, final String member){
                //`member` is now part of `groupId`.
            }
            @Override
            public void onMemberExited(final String groupId, final String member) {
                //`member` is no longer part of `groupId`.
            }

            @Override
            public void onAnnouncementChanged(String groupId, String announcement) {
                //The Owner or Administrator of `groupId` has sent an announcement to all
                //members of `groupId`.
            }

            @Override
            public void onSharedFileAdded(String groupId, MucSharedFile sharedFile) {
                //A member of `groupId` has uploaded `sharedFile` to `groupId`.
            }

            @Override
            public void onSharedFileDeleted(String groupId, String fileId) {
                //File `fileId` is removed from files shared with `groupId`.
            }
        });
    }
   ```

2. Initiate your group listener in the `onCreate` method for your groups view. For example:

   ```java
       @Override
       protected void onCreate(Bundle savedInstanceState) {
          super.onCreate(savedInstanceState);
          setContentView(R.layout.activity_main);
          // Add methods for initialization and listen for message and connection events.
          initView();
          initSDK();
          addMessageListener();
          addConnectionListener();
          addGroupListener();
       }
    ```

3. Update your UI to handle group events. 

    For example, whenever a new user joins the group, they should be added to member list for all others in the group. To implement this you:
    1. Create a method to retrieve the list of group members and update the UI:
       ```java
       private void updateMemberList() {
          try {
          //If you have not created a group, exit
          if (currentGroup == null) {
            LogUtils.showErrorToast(MainActivity.this, tv_log, "Create a group first.");
            return;
          }
          String currentGroupId = currentGroup.getGroupId();
          final List<String> list = new ArrayList<>();
          
          //Retrieve the users in the list
          new Thread(new Runnable() {
            @Override public void run() {
              try {
                CursorResult<String> result = ChatClient.getInstance().groupManager().fetchGroupMembers(currentGroupId, "", 200);
                list.addAll(currentGroup.getAdminList());
                list.addAll(result.getData());
              } catch (final ChatException e) {
                e.printStackTrace();
                LogUtils.showLog(tv_log, "Cannot retrieve group members." + e.getLocalizedMessage());
              }
            }
            }).start();

            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    // Update your UI with the users in `list`
                }
            });
          } catch (Exception e) {
            e.printStackTrace();
            return;
          }
        }
        ```
    2. Update the group event listener to call your update method:
       ```java
            @Override
            public void onMemberJoined(final String groupId, final String member) {
                //`member` is now part of `groupId`.
                updateMemberList();
            }
       ```
    

## Reference

Link to the API reference. 
