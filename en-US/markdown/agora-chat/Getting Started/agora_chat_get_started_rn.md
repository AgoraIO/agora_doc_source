Instant messaging connects people wherever they are and allows them to communicate with others in real time. The Agora Chat SDK enables you to embed real-time messaging in any app, on any device, anywhere.

This page shows a sample code to add peer-to-peer messaging into a Windows project by using the Agora Chat SDK.

## Understand the tech

~338e0e30-e568-11ec-8e95-1b7dfd4b7cb0~

## Prerequisites

Before proceeding, ensure that your development and run environment meet the following requirements.

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

Open `token_login_demo/App.js`, and replace the code with the following:

```javascript
// Import depend packages.
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

// The App Object.
const App = () => {
  // variable defines.
  const title = 'AgoraChatQuickstart';
  const requestGetTokenUrl = 'https://a41.easemob.com/app/chat/user/login';
  const requestRegistryAccountUrl =
    'https://a41.easemob.com/app/chat/user/register';
  const [appKey, setAppKey] = React.useState('81446724#514456');
  const [username, setUsername] = React.useState('');
  const [password, setPassword] = React.useState('');
  const [userId, setUserId] = React.useState('');
  const [content, setContent] = React.useState('');
  const [logText, setWarnText] = React.useState('Show log area');

  // Output console logs.
  useEffect(() => {
    logText.split('\n').forEach((value, index, array) => {
      if (index === 0) {
        console.log(value);
      }
    });
  }, [logText]);

  // Output UI logs.
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

  const requestHttp = url => {
    return fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        userAccount: username,
        userPassword: password,
      }),
    });
  };
  const requestGetToken = () => {
    return requestHttp(requestGetTokenUrl);
  };
  const requestRegistryAccount = () => {
    return requestHttp(requestRegistryAccountUrl);
  };

  // Register listeners for messaging.
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

    ChatClient.getInstance().chatManager.removeAllMessageListener();
    ChatClient.getInstance().chatManager.addMessageListener(msgListener);
  };

  // Initilize the SDK.
  // Initialize any interface before calling it.
  const init = () => {
    let o = new ChatOptions({
      autoLogin: false,
      appKey: appKey,
    });
    ChatClient.getInstance().removeAllConnectionListener();
    ChatClient.getInstance()
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
            rollLog('login success.');
            setMessageListener();
          },
          onDisconnected(errorCode) {
            rollLog('login fail: ' + errorCode);
          },
        };
        ChatClient.getInstance().addConnectionListener(listener);
      })
      .catch(error => {
        rollLog(
          'init fail: ' +
            (error instanceof Object ? JSON.stringify(error) : error),
        );
      });
  };

  // Register an account for login.
  const registerAccount = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    rollLog('start register account ...');
    requestRegistryAccount()
      .then(response => {
        rollLog(`register success: userName = ${username}, password = ******`);
      })
      .catch(error => {
        rollLog('register fail: ' + JSON.stringify(error));
      });
  };

  // Log in with an account ID and token.
  const loginWithToken = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    rollLog('start request token ...');
    requestGetToken()
      .then(response => {
        rollLog('request token success.');
        response
          .json()
          .then(value => {
            rollLog(
              `response token success: username = ${username}, token = ******`,
            );
            const token = value.accessToken;
            rollLog('start login ...');
            ChatClient.getInstance()
              .loginWithAgoraToken(username, token)
              .then(() => {
                rollLog('login operation success.');
              })
              .catch(reason => {
                rollLog('login fail: ' + JSON.stringify(reason));
              });
          })
          .catch(error => {
            rollLog('response token fail:' + JSON.stringify(error));
          });
      })
      .catch(error => {
        rollLog('request token fail: ' + JSON.stringify(error));
      });
  };

  // Log out from server.
  const logout = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    rollLog('start logout ...');
    ChatClient.getInstance()
      .logout()
      .then(() => {
        rollLog('logout success.');
      })
      .catch(reason => {
        rollLog('logout fail:' + JSON.stringify(reason));
      });
  };

  // Send a text message to somebody.
  const sendmsg = () => {
    if (this.isInitialized === false || this.isInitialized === undefined) {
      rollLog('Perform initialization first.');
      return;
    }
    let msg = ChatMessage.createTextMessage(
      userId,
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
    ChatClient.getInstance()
      .chatManager.sendMessage(msg, callback)
      .then(() => {
        rollLog('send message: ' + msg.localMsgId);
      })
      .catch(reason => {
        rollLog('send fail: ' + JSON.stringify(reason));
      });
  };

  // Render the UI.
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
            placeholder="Enter appkey"
            onChangeText={text => setAppKey(text)}
            value={appKey}
          />
        </View>
        <View style={styles.buttonCon}>
          <Text style={styles.btn2} onPress={init}>
            INIT SDK
          </Text>
        </View>
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
            placeholder="Enter password"
            onChangeText={text => setPassword(text)}
            value={password}
          />
        </View>
        <View style={styles.buttonCon}>
          <Text style={styles.eachBtn} onPress={registerAccount}>
            SIGN UP
          </Text>
          <Text style={styles.eachBtn} onPress={loginWithToken}>
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
            onChangeText={text => setUserId(text)}
            value={userId}
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

### Build and run your project

You are now ready to build and run the project you have built.

To build and run the project on an iOS device, take the following steps:

1. Connect an iPhone device to your computer, and set the device to Developer mode.
2. Open `token_login_demo/ios`, and open `token_login_demo.xcworkspace` with Xcode.
3. In **Targets** > **token_login_demo** > **Signing & Capabilities**, set the signing of the project.
4. Click `Build` in Xcode to build the project. When the build succeeds, Xcode runs the project and installs it on your device. You see the app user interface.

To build and run the project on an iOS virtual device, take the following steps:

1. Open `token_login_demo/ios`, and open `token_login_demo.xcworkspace` with Xcode.
2. In Xcode, set `iPhone 13` as the iOS simulator.
3. Click `Build` in Xcode to build the project. When the build succeeds, Xcode runs the project and installs it on the simulator. You see the app user interface.

To build and run the project on an Android device, take the following steps:

1. Open `token_login_demo/android` in Android Studio.
2. Connect an Android device to your computer, and set the device to USB debugging mode.
3. In terminal, type in `adb reverse tcp:8081 tcp:8081` to set up data forwarding.
4. Run the following command to execute `"start": "react-native start"` in `package.json`:

   ```sh
   yarn start
   ```

5. Click `Build` in Android Studio to build the project. When the build succeeds, Android Studio runs the project and installs it on the device. You see the app interface.

  ![](https://web-cdn.agora.io/docs-files/1655259772037)

## Test your app

Refer to the following steps to register a Chat account, log in to Agora Chat and send and receive a message.

1. On one device or simulator, enter a username and password, and click **SIGN UP** to register a Chat account.
2. Click **SIGN IN** to log in to Agora Chat.
3. On a second device or simulator, repeat the above steps to create another account and log in to Agora Chat. Ensure that you use a different user ID (username) on this device or simulator.
4. From the first device or simulator, enter the username you set in step 3, type in the text message you want to send, and click **SEND TEXT**. You can receive the text message on the other device or simulator.

You can also read from the logs on the UI to see whether you have successfully signed up, signed in, and sent a text message.

## Next steps

For demonstration purposes, Agora Chat provides an app server that enables you to quickly retrieve a token using the App Key given in this guide. In a production context, the best practice is for you to deploy your own token server, use your own [App Key](./enable_agora_chat?platform=React%20Native#get-the-information-of-the-agora-chat-project) to generate a token, and retrieve the token on the client side to log in to Agora. For how to implement a server that generates and serves tokens on request, see [Generate a User Token](./generate_user_tokens?platform=React%20Native).
