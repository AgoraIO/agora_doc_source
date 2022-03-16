## v1.0.1.1

v1.0.1.1 was released on January 19, 2022.

**New features**

This release adds the following features:

- Supports downloading group shared files using the `downloadGroupSharedFile` method.
- Supports retrieving group shared files by pagination using the `fecthGroupSharedFileList` method.

## v1.0.1

v1.0.1 was released on January 14, 2022.

**New features**

This release supports deleting the conversation thread using the `deleteSession` method.

**Improvements**

The release made the following improvements:

- Added a `buildingNumber` parameter in the location message.
- Added `error: type 221` for sending a message to a user that is not a contact.
- Added `error: type 219` for failing to send a message because all the users are muted.

**Issues fixed**

This release fixe the issue that the `onChanelMessage` callback was not triggered and other known issues.

## v1.0.0

v1.0.0 was released on December 10, 2021.

**Improvements**

This release made the following improvmenets:

- Added some error codes.
- Renamed some functions and updated the API annotations.

**Fixed issues**

This release fixed the following issues:
- The delivery acknowledgement was not recieved.
- The group announcement could not be set as null.
- An error was reported when muting a specified user during chat.


