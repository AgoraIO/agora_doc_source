Agora Server Gateway SDK supports int user ID and string user ID. This page introduces how to use string user id.

## Implementation

1. When initializing the `IAgoraService` object, set `AgoraServiceConfiguration.useStringUid` to true.

    ```C++
    // Creates an IAgoraService object
    auto service = createAgoraService();
    // Initializes the IAgoraService object
    agora::base::AgoraServiceConfiguration scfg;
    // Sets Agora App ID
    scfg.appId = appid;
    // Enables the audio processing module
    scfg.enableAudioProcessor = enableAudioProcessor;
    // Disables the audio device module (Normally we do not directly connect audio capture or playback devices to a server)
    scfg.enableAudioDevice = enableAudioDevice;
    // Whether to enable video
    scfg.enableVideo = enableVideo;
    // Enables user IDs in string format (the character can be digits, letters or special symbols) so that user ID can  contain digits, letters or special symbols
    scfg.useStringUid = enableuseStringUid;
    if (service->initialize(scfg) != agora::ERR_OK) {
        return nullptr;
    }
    ```

2. Call `connect` to connect to the RTC channel.

    ```c++
    if (connection->connect(options.appId.c_str(), options.channelId.c_str(),
                        options.userId.c_str())) {
    AG_LOG(ERROR, "Failed to connect to Agora channel!");
    return -1;
    }
    ```

## Considerations

- The supported character set of int user IDs includes:

  - 10 digits: 0-9

- The supported character set of string user IDs includes:

  - Lowercase English letters
  - Uppercase English letters
  - 10 digits: 0-9
  - The space character
  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","

- String user IDs can only communicate with string user IDs. Unknown errors occur when both string user IDs and int user IDs connect to a channel.

- Different from int user IDs, when you call the `connect` method, you must specify the `userId` parameter. 

- A string user ID must be unique in a channel.