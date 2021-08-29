This page tells you how to use the media player APIs to play local or online media locally or to remote users in an Agora channel.

## Prerequisites

Before proceeding, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](https://docs.agora.io/en/Voice/start_call_audio_android?platform=Android) or [Start Interactive Live Audio Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_audio_android?platform=Android).

## Implementation

To implement a media player in your project, refer to the following steps.

1. After initialization, create a `MediaPlayer` object and call `registerPlayerObserver` to register a media observer for the media player.

    ```java
    engine = RtcEngine.create(config);

    ...

    mediaPlayer = engine.createMediaPlayer();
    mediaPlayer.registerPlayerObserver(this);
    ```

2. Implement callbacks for the media player observer.

    ```java
    @Override
    public void onPlayerStateChanged(io.agora.mediaplayer.Constants.MediaPlayerState mediaPlayerState, io.agora.mediaplayer.Constants.MediaPlayerError mediaPlayerError) {
        Log.e(TAG, "onPlayerStateChanged mediaPlayerState " + mediaPlayerState);
        Log.e(TAG, "onPlayerStateChanged mediaPlayerError " + mediaPlayerError);
        if (mediaPlayerState.equals(PLAYER_STATE_OPEN_COMPLETED)) {
            setMediaPlayerViewEnable(true);
        } else if (mediaPlayerState.equals(PLAYER_STATE_IDLE) || mediaPlayerState.equals(PLAYER_STATE_PLAYBACK_COMPLETED) ) {
            setMediaPlayerViewEnable(false);
        }
    }

    @Override
    public void onPositionChanged(long position) {
        Log.e(TAG, "onPositionChanged position " + position);
        if (playerDuration > 0) {
            final int result = (int) ((float) position / (float) playerDuration * 100);
            handler.post(new Runnable() {
                @Override
                public void run() {
                    progressBar.setProgress(Long.valueOf(result).intValue());
                }
            });
        }
    }

    @Override
    public void onPlayerEvent(io.agora.mediaplayer.Constants.MediaPlayerEvent mediaPlayerEvent) {
        Log.e(TAG, " onPlayerEvent mediaPlayerEvent " + mediaPlayerEvent);
    }
    ```

3. Render the local media player view.

    ```java
    VideoCanvas videoCanvas = new VideoCanvas(surfaceView, Constants.RENDER_MODE_HIDDEN, Constants.VIDEO_MIRROR_MODE_AUTO,
    Constants.VIDEO_SOURCE_MEDIA_PLAYER,  mediaPlayer.getMediaPlayerId(), 0);
    engine.setupLocalVideo(videoCanvas);
    ```

4. Before joining the channel, specify the media player ID and enable publishing media player tracks to share media to remote users in an Agora channel.

    ```java
    private ChannelMediaOptions options = new ChannelMediaOptions();

    ...

    options.publishMediaPlayerId = mediaPlayer.getMediaPlayerId();
    options.publishMediaPlayerAudioTrack = true;
    options.publishMediaPlayerVideoTrack = true;

    int res = engine.joinChannel(accessToken, channelId, 0, options);
    ```

5. Open a local or online media file and play the file.

    ```java
    mediaPlayer.open(url, 0);
    mediaPlayer.play();
    ```

5. Stop the media player and destroy the allocated resources when the user leaves the channel.

    ```java
    mediaPlayer.stop();
    mediaPlayer.destroy();
    mediaPlayer.unRegisterPlayerObserver(this);
    ```

## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source [sample project](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/MediaPlayer.java) on GitHub that implements the media player function.

### API reference

- [createMediaPlayer]()
- [destroy]()
- [registerPlayerObserver]()
- [unRegisterPlayerObserver]()
- [getMediaPlayerId]()
- [open]()
- [play]()
- [stop]()