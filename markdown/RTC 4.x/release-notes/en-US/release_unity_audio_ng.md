# v4.2.1

This version was released on June 21, 2023.

## Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio interactions.

## Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `SetAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- Occational crash after calling the `DestroyMediaPlayer` method. (iOS)

