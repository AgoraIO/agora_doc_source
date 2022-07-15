## v1.0.1.1

v1.0.1.1 was released on December 30, 2021.

This release fixed an issue where the database failed to load under extreme conditions.

## v1.0.1

v1.0.1 was released on December 27, 2021.

#### New features

v1.0.1 adds the following features:

- Supports setting the building name when creating a location message.
- Supports deleting local messages before a specific time.
- Supports getting the count of messages in one conversation.

#### Fixed issues

This release fixed the following issues:

- Some crash issues occurred.
- An issue occurred in the database encryption.

#### API changes

v1.0.1 adds the following APIs:

- `createLocationSendMessage` [1/2]
- `deleteMessagesBeforeTimestamp`
- `getAllMsgCount`

## v1.0.0

v1.0.0 was released on December 6, 2021.

<div class="alert warning">This release has an issue that the database occasionally fails to load. Agora recommends you upgrade to the latest version as soon as possible.</div>

#### New features

This release supports getting the users' login status through the `isLoggedIn` and `isLoggedInBefore` methods.

#### Improvements

This release makes the following improvements:

- Optimizes the logic of renewing push tokens, reducing server request times.
- Improves the login speed.
- Uses only HTTPS for REST operations by default.
- Optimizes the logic of token expiration.

#### Fixed issues

This release fixed the following issues:

- The fetched history messages were incomplete.
- Crashes occurred in certain scenarios.
- An issue occurred in displaying the unread status of messages.