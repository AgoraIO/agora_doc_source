Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into a Windows project by using the Agora Chat SDK.

## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

In order to follow the procedure in this page, you must have the following:

- A valid Agora [account](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-account)
- An Agora [project](https://docs.agora.io/en/video-calling/reference/manage-agora-account/#create-an-agora-project) with an [App Key](https://docs.agora.io/en/agora-chat/get-started/enable#get-the-information-of-the-chat-project) that has [enabled the Chat service](https://docs.agora.io/en/agora-chat/get-started/enable) 

If your target platform is iOS:

- macOS 10.15.7 or later
- Xcode 12.4 or later, including command line tools
- React Native 0.63.4 or later
- NodeJs 16 or later, including npm package management tool
- CocoaPods package management tool
- Yarn compile and run tool
- Watchman debugging tool
- A physical or virtual mobile device running iOS 10.0 or later

If your target platform is Android:

- macOS 10.15.7 or later, or Windows 10 or later
- Android Studio 4.0 or later, including JDK 1.8 or later
- React Native 0.63.4 or later
- CocoaPods package management tool if your operating system is macOS.
- Powershell 5.1 or later if your operating system is Windows.
- NodeJs 16 or later, including npm package management tool
- Yarn compile and run tool
- Watchman debugging tool
- A physical or virtual mobile device running Android 6.0 or later

For more information, see [Setting up the environment](https://reactnative.dev/docs/environment-setup).

## Token generation

This section introduces how to register a user at Agora Console and generate a temporary token.

### Register a user

To register a user, do the following:

1. On the **Project Management** page, click **Config** for the project that you want to use.

	![](https://web-cdn.agora.io/docs-files/1664531061644)

2. On the **Edit Project** page, click **Config** next to **Chat** below **Features**.

	![](https://web-cdn.agora.io/docs-files/1664531091562)

3. In the left-navigation pane, select **Operation Management** > **User** and click **Create User**.

	![](https://web-cdn.agora.io/docs-files/1664531141100)

<a name="userid"></a>

4. In the **Create User** dialog box, fill in the **User ID**, **Nickname**, and **Password**, and click **Save** to create a user.

	![](https://web-cdn.agora.io/docs-files/1664531162872)


### Generate a user token

To ensure communication security, Agora recommends using tokens to authenticate users who log in to the Agora Chat system.

For testing purposes, Agora Console supports generating temporary tokens for Agora Chat. To generate a user token, do the following:

1. On the **Project Management** page, click **Config** for the project that you want to use.

	![](https://web-cdn.agora.io/docs-files/1664531061644)

2. On the **Edit Project** page, click **Config** next to **Chat** below **Features**.

	![](https://web-cdn.agora.io/docs-files/1664531091562)

3. In the **Data Center** section of the **Application Information** page, enter the [user ID](#userid) in the **Chat User Temp Token** box and click **Generate** to generate a token with user privileges.

	![](https://web-cdn.agora.io/docs-files/1664531214169)

<div class="alert note">Register a user and generate a user token for a sender and a receiver respectively for <a href="https://docs.agora.io/en/agora-chat/get-started/get-started-sdk#test">test use</a> later in this demo.</div>


## Project setup

Follow these steps to create a React Native project and add Agora Chat into your app.

1. Make sure you have set up the development environment based on your operating system and target platform.
2. In your terminal, run the following command to create a React Native project:

   ```sh
   npx react-native init token_login_demo
   cd token_login_demo
   yarn
   ```

   A successful execution of this command generates a project named `token_login_demo` in the directory where you run the command.

3. Run the following command to import the Chat SDK using yarn:

   ```sh
   yarn add react-native-agora-chat
   ```

4. If your target platform is iOS, run the following command to execute the tools:

   ```sh
   cd ios && pod install && cd ..
   ```

## Implementation

This section introduces the codes you need to add to your project to start one-to-one messaging.

### Implement one-to-one messaging

To send a one-to-one message, users must register a Chat account, log in to Agora Chat, and send a text message.

<a name="sign-in"></a>

Open `token_login_demo/App.js`, and replace the code with the following:

```javascript
// Imports dependencies.
import React, {useEffect} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';
import {
  ChatClient,
  ChatOptions,
  ChatMessageChatType,
  ChatMessage,
} from 'react-native-agora-chat';
// Defines the App object.
const App = () => {
  // Defines the variable.
  const title = 'AgoraChatQuickstart';
  // Replaces <your appKey> with your app key.
  const appKey = '<your appKey>';
  // Replaces <your userId> with your user ID.
  const [username, setUsername] = React.useState('<your userId>');
  // Replaces <your agoraToken> with your Agora token.
  const [chatToken, setChatToken] = React.useState('<your agoraToken>');
  const [targetId, setTargetId] = React.useState('');
  const [content, setContent] = React.useState('');
  const [logText, setWarnText] = React.useState('Show log area');
  const chatClient = ChatClient.getInstance();
  const chatManager = chatClient.chatManager;
  // Outputs console logs.
  useEffect(() => {
    logText.split('\n').forEach((value, index, array) => {
      if (index === 0) {
        console.log(value);
      }
    });
  }, [logText]);
  // Outputs UI logs.
  const rollLog = text => {
    setWarnText(preLogText => {
      let newLogText = text;
      preLogText
        .split('\n')
        .filter((value, index, array) => {
          if (index > 8) {
            return false;
          }
          return true;
        })
        .forEach((value, index, array) => {
          newLogText += '\n' + value;
        });
      return newLogText;
    });
  };
  useEffect(() => {
    // Registers listeners for messaging.
    const setMessageListener = () => {
      let msgListener = {
        onMessagesReceived(messages) {
          for (let index = 0; index < messages.length; index++) {
            rollLog('received msgId: ' + messages[index].msgId);
          }
        },
        onCmdMessagesReceived: messages => {},
        onMessagesRead: messages => {},
        onGroupMessageRead: groupMessageAcks => {},
        onMessagesDelivered: messages => {},
        onMessagesRecalled: messages => {},
        onConversationsUpdate: () => {},
        onConversationRead: (from, to) => {},
      };
      chatManager.removeAllMessageListener();
      chatManager.addMessageListener(msgListener);
    };
    // Initializes the SDK.
    // Initializes any interface before calling it.
    const init = () => {
      let o = new ChatOptions({
        autoLogin: false,
        appKey: appKey,
      });
      chatClient.removeAllConnectionListener();
      chatClient
        .init(o)
        .then(() => {
          rollLog('init success');
          this.isInitialized = true;
          let listener = {
            onTokenWillExpire() {
              rollLog('token expire.');
            },
            onTokenDidExpire() {
              rollLog('token did expire');
            },
            onConnected() {
              rollLog('onConnected');
              setMessageListener();
            },
            onDisconnected(errorCode) {
              rollLog('onDisconnected:' + errorCode);
            },
          };
          chatClient.addConnectionListener(listener);
        })
        .catch(error => {
          rollLog(
            'init fail: ' +
              (error instanceof Object ? JSON.stringify(error) : error),
          );
        });
    };
    init();
  }, [chatClient, chatManager, appKey]);

  // Logs in with an account ID and a token.
  const login = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    rollLog('start login ...');
    chatClient
      .loginWithAgoraToken(username, chatToken)
      .then(() => {
        rollLog('login operation success.');
      })
      .catch(reason => {
        rollLog('login fail: ' + JSON.stringify(reason));
      });
  };
  // Logs out from server.
  const logout = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    rollLog('start logout ...');
    chatClient
      .logout()
      .then(() => {
        rollLog('logout success.');
      })
      .catch(reason => {
        rollLog('logout fail:' + JSON.stringify(reason));
      });
  };
  // Sends a text message to somebody.
  const sendmsg = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    let msg = ChatMessage.createTextMessage(
      targetId,
      content,
      ChatMessageChatType.PeerChat,
    );
    const callback = new (class {
      onProgress(locaMsgId, progress) {
        rollLog(`send message process: ${locaMsgId}, ${progress}`);
      }
      onError(locaMsgId, error) {
        rollLog(`send message fail: ${locaMsgId}, ${JSON.stringify(error)}`);
      }
      onSuccess(message) {
        rollLog('send message success: ' + message.localMsgId);
      }
    })();
    rollLog('start send message ...');
    chatClient.chatManager
      .sendMessage(msg, callback)
      .then(() => {
        rollLog('send message: ' + msg.localMsgId);
      })
      .catch(reason => {
        rollLog('send fail: ' + JSON.stringify(reason));
      });
  };
  // Renders the UI.
  return (
    <SafeAreaView>
      <View style={styles.titleContainer}>
        <Text style={styles.title}>{title}</Text>
      </View>
      <ScrollView>
        <View style={styles.inputCon}>
          <TextInput
            multiline
            style={styles.inputBox}
            placeholder="Enter username"
            onChangeText={text => setUsername(text)}
            value={username}
          />
        </View>
        <View style={styles.inputCon}>
          <TextInput
            multiline
            style={styles.inputBox}
            placeholder="Enter chatToken"
            onChangeText={text => setChatToken(text)}
            value={chatToken}
          />
        </View>
        <View style={styles.buttonCon}>
          <Text style={styles.eachBtn} onPress={login}>
            SIGN IN
          </Text>
          <Text style={styles.eachBtn} onPress={logout}>
            SIGN OUT
          </Text>
        </View>
        <View style={styles.inputCon}>
          <TextInput
            multiline
            style={styles.inputBox}
            placeholder="Enter the username you want to send"
            onChangeText={text => setTargetId(text)}
            value={targetId}
          />
        </View>
        <View style={styles.inputCon}>
          <TextInput
            multiline
            style={styles.inputBox}
            placeholder="Enter content"
            onChangeText={text => setContent(text)}
            value={content}
          />
        </View>
        <View style={styles.buttonCon}>
          <Text style={styles.btn2} onPress={sendmsg}>
            SEND TEXT
          </Text>
        </View>
        <View>
          <Text style={styles.logText} multiline={true}>
            {logText}
          </Text>
        </View>
        <View>
          <Text style={styles.logText}>{}</Text>
        </View>
        <View>
          <Text style={styles.logText}>{}</Text>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};
// Sets UI styles.
const styles = StyleSheet.create({
  titleContainer: {
    height: 60,
    backgroundColor: '#6200ED',
  },
  title: {
    lineHeight: 60,
    paddingLeft: 15,
    color: '#fff',
    fontSize: 20,
    fontWeight: '700',
  },
  inputCon: {
    marginLeft: '5%',
    width: '90%',
    height: 60,
    paddingBottom: 6,
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
  },
  inputBox: {
    marginTop: 15,
    width: '100%',
    fontSize: 14,
    fontWeight: 'bold',
  },
  buttonCon: {
    marginLeft: '2%',
    width: '96%',
    flexDirection: 'row',
    marginTop: 20,
    height: 26,
    justifyContent: 'space-around',
    alignItems: 'center',
  },
  eachBtn: {
    height: 40,
    width: '28%',
    lineHeight: 40,
    textAlign: 'center',
    color: '#fff',
    fontSize: 16,
    backgroundColor: '#6200ED',
    borderRadius: 5,
  },
  btn2: {
    height: 40,
    width: '45%',
    lineHeight: 40,
    textAlign: 'center',
    color: '#fff',
    fontSize: 16,
    backgroundColor: '#6200ED',
    borderRadius: 5,
  },
  logText: {
    padding: 10,
    marginTop: 10,
    color: '#ccc',
    fontSize: 14,
    lineHeight: 20,
  },
});
export default App;
```

<a name="build"></a>

### Build and run your project

You are now ready to build and run the project you have built.

To build and run the project on an iOS device, take the following steps:

1. Connect an iPhone device to your computer, and set the device to Developer mode.
2. Open `token_login_demo/ios`, and open `token_login_demo.xcworkspace` with Xcode.
3. In **Targets** > **token_login_demo** > **Signing & Capabilities**, set the signing of the project.
4. Click `Build` in Xcode to build the project. When the build succeeds, Xcode runs the project and installs it on your device.

To build and run the project on an iOS virtual device, take the following steps:

1. Open `token_login_demo/ios`, and open `token_login_demo.xcworkspace` with Xcode.
2. In Xcode, set `iPhone 13` as the iOS simulator.
3. Click `Build` in Xcode to build the project. When the build succeeds, Xcode runs the project and installs it on the simulator.

To build and run the project on an Android device, take the following steps:

1. Open `token_login_demo/android` in Android Studio.
2. Connect an Android device to your computer, and set the device to USB debugging mode.
3. In terminal, type in `adb reverse tcp:8081 tcp:8081` to set up data forwarding.
4. Run the following command to execute `"start": "react-native start"` in `package.json`:

   ```sh
   yarn start
   ```

5. Click `Build` in Android Studio to build the project. When the build succeeds, Android Studio runs the project and installs it on the device. 

If the project runs properly, the following user interface appears:

![](https://web-cdn.agora.io/docs-files/1665304069738)


<a name="test"></a>

## Test your app

<div class="alert note">You can log in to the app by either modifying the fields in the <code>App.js</code> file as stated below, or entering the required fields in the user interface.</div>

To validate the peer-to-peer messaging you have just integrated into your app using Agora Chat, perform the following operations:

1. Log in  
a. In the [`App.js`](#sign-in) file, replace the placeholders of `appKey`, `username`, and `chatToken` with the App Key, user ID, and Agora token of the sender.  
b. Run and [build](#build) your app.  
c. On your simulator or physical device, click **SIGN IN** to log in with the sender account.

2. Send a message  
Fill in the user ID of the receiver in the **Enter the username you want to send** box, type in te message to send in the **Enter content** box, and click **SEND TEXT** to send the message.

3. Log out  
Click **SIGN OUT** to log out of the sender account.

4. Receive the message  
a. After signing out, change the values of `appKey`, `username`, and `chatToken` to the user ID, Agora token, and App Key of the receiver in the [`App.js`](#sign-in) file.  
b. Run the app on another device or simulator with the receiver account and receive the message sent in step 2.

You can also read from the logs on the UI to see whether you have successfully signed in, signed out, and sent and received a text message.

## Next steps

For demonstration purposes, Agora Chat uses temporary tokens generated from Agora Console for authentication in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=React%20Native#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. For how to implement a server that generates and serves tokens on request, see [Generate a User Token](../Develop/Authentication).

## Reference
For details, see the [sample code](https://github.com/AgoraIO/Agora-Chat-API-Examples/tree/main/Chat-RN/quick_start_demo) for getting started with Agora Chat.