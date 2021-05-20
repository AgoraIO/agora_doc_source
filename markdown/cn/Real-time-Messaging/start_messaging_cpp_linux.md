---
title: 快速实现消息发送和接收
platform: Linux
updatedAt: 2021-03-29 04:05:24
---
本文详细介绍如何建立一个简单的项目并使用 Agora RTM SDK 实现消息发送与接收。

## 前提条件

- Ubuntu 14.04 LTS 64 位或更高版本、CentOS 7.0 64 位或更高版本。如果你的网络环境部署了防火墙，请根据[应用企业防火墙限制](https://docs.agora.io/cn/AgoraPlatform/firewall?platform=AllPlatforms)打开相关端口。
- CMake 2.8 及以上。
- glibc 2.14 及以上 (Agora RTM SDK 1.4.2 需要 glibc 2.25 及以上)。
- C++ 11 及以上。
- 有效的 Agora [开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up)。

## 获取 App ID 和 App 证书

#### 获取 App ID

Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。

在 [Agora 控制台](https://console.agora.io/)的**项目管理**页面，找到你的项目，点击 App ID 右侧的眼睛图标就可以直接复制项目的 App ID。

![](https://web-cdn.agora.io/docs-files/1612762728108)

#### 获取 App 证书

点击**编辑**进入**编辑项目**页面，你可以点击眼睛图标查看并复制 App 证书。

![img](https://web-cdn.agora.io/docs-files/1592488920717)

## 生成 Token

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将加入 RTM 系统的用户进行鉴权。

为了方便测试，Agora 提供生成临时 RTM Token 的功能，具体步骤如下：

1. 访问 [https://webdemo.agora.io/token-builder/](https://webdemo.agora.io/token-builder/)。
2. 填入 App ID，App 证书和用于登录 RTM 系统的用户 ID。

<div class="alert note">临时 Token 仅作为演示和测试用途，有效期为 24 小时。在生产环境中，你需要自行部署服务器签发 Token，详见<a href="https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms">生成 RTM Token</a>。</div>

## 实现步骤

### 1. 新建项目

新建一个目录 `RTM_quickstart`，目录中包含以下文件夹：

```
RTM_quickstart/
├── include
└── lib
```

### 2. 集成 SDK

1. 下载最新版[实时消息 Linux C++ SDK](https://docs.agora.io/cn/AgoraPlatform/downloads) 并解压。将 SDK 包中的 `*.so` 文件复制到 `lib` 目录下，将 `*.h` 文件复制到 `include` 目录下。

2. 在 `RTM_quickstart` 目录下新建 `CMakeLists.txt` 文件，用于使用 CMake 编译项目。文件内容如下：

   ```
   cmake_minimum_required (VERSION 2.8)
   project()

   set(TARGET_NAME rtmQuickstart)
   set(SOURCES rtmQuickstart.cpp)
   set(HEADERS)

   set(TARGET_BUILD_TYPE "Debug")
   set(CMAKE_CXX_FLAGS"-fPIC -O2 -g -std=c++11 -msse2")

   include_directories(${CMAKE_SOURCE_DIR}/include)
   link_directories(${CMAKE_SOURCE_DIR}/lib)

   add_executable(${TARGET_NAME} ${SOURCES} ${HEADERS})
   target_link_libraries(${TARGET_NAME} agora_rtm_sdk pthread)
    ```

### 3. 实现消息发送和接收的基本逻辑

在 `RTM_quickstart` 目录下新建 `rtmQuickstart.cpp` 文件，并按照以下步骤实现基本逻辑：

1. 导入以下库：

   ```c++
   #include <iostream>
   #include <memory>
   #include <vector>
   #include <string>
   #include <thread>
   #include <sstream>
   #include <unistd.h>
   #include <pthread.h>
   #include <vector>
   #include <map>
   #include <algorithm>

   #include "IAgoraRtmService.h"

   using namespace std;
   ```

2. 设置 App ID 和 Token。

   ```c++
   string APP_ID = "";
   string Token = "";
	 ```

3. 重载 `IRtmServiceEventHandler` 类，自定义以下用户事件的通知消息并返回至命令行：

   ```c++
   class RtmEventHandler: public agora::rtm::IRtmServiceEventHandler {
       public:
       RtmEventHandler() {}
       ~RtmEventHandler() {}
       // 登录成功
       virtual void onLoginSuccess() override {
             cout << "on login success"<< endl;
             }
      // 登录失败
      virtual void onLoginFailure(agora::rtm::LOGIN_ERR_CODE errorCode) override {
          cout << "on login failure: errorCode = "<< errorCode << endl;
          }
      // 登出成功
      virtual void onLogout(agora::rtm::LOGOUT_ERR_CODE errorCode) override {
          cout << "on logout" << endl;
          }
      // 连接状态变化
      virtual void onConnectionStateChanged(agora::rtm::CONNECTION_STATE state,
                  agora::rtm::CONNECTION_CHANGE_REASON reason) override {
          cout << "on connection state changed: state = " << state << endl;
      }
      // 点对点消息发送状态
      virtual void onSendMessageResult(long long messageId,
                  agora::rtm::PEER_MESSAGE_ERR_CODE state) override {
          cout << "on send message messageId: " << messageId << " state: " << state << endl;
      }
      // 收到点对点消息
      virtual void onMessageReceivedFromPeer(const char *peerId,
                  const agora::rtm::IMessage *message) override {
          cout << "on message received from peer: peerId = " << peerId
               << " message = " << message->getText() << endl;
      }
    };


4. 重载 `IChannelEventHandler` 类，自定义以下频道事件的通知消息并返回至命令行：

   ```c++
   class ChannelEventHandler: public agora::rtm::IChannelEventHandler {
       public:
         ChannelEventHandler(string channel) {
             channel_ = channel;
        }
        ~ChannelEventHandler() {}
        // 加入频道成功
        virtual void onJoinSuccess() override {
            cout << "on join channel success" << endl;
        }
        // 加入频道失败
        virtual void onJoinFailure(agora::rtm::JOIN_CHANNEL_ERR errorCode) override{
            cout << "on join channel failure: errorCode = " << errorCode << endl;
        }
        // 离开频道
        virtual void onLeave(agora::rtm::LEAVE_CHANNEL_ERR errorCode) override {
            cout << "on leave channel: errorCode = "<< errorCode << endl;
        }
        // 收到频道消息
        virtual void onMessageReceived(const char* userId,
                            const agora::rtm::IMessage *msg) override {
            cout << "receive message from channel: "<< channel_.c_str()
                 << " user: " << userId << " message: " << msg->getText()
                 << endl;
        }
        // 用户加入频道通知
        virtual void onMemberJoined(agora::rtm::IChannelMember *member) override {
            cout << "member: " << member->getUserId() << " joined channel: "
                 << member->getChannelId() << endl;
        }
        // 用户离开频道通知
        virtual void onMemberLeft(agora::rtm::IChannelMember *member) override {
            cout << "member: " << member->getUserId() << " lefted channel: "
                 << member->getChannelId() << endl;
        }
        // 获取频道成员列表
        virtual void onGetMembers(agora::rtm::IChannelMember **members,
                        int userCount,
                        agora::rtm::GET_MEMBERS_ERR errorCode) override {
            cout << "list all members for channel: " << channel_.c_str()
                 << " total members num: " << userCount << endl;
            for (int i = 0; i < userCount; i++) {
                cout << "index[" << i << "]: " << members[i]->getUserId();
            }
        }
        // 频道消息发送状态
        virtual void onSendMessageResult(long long messageId,
                        agora::rtm::CHANNEL_MESSAGE_ERR_CODE state) override {
            cout << "send messageId: " << messageId << " state: " << state << endl;
        }
        private:
            string channel_;
    };
    ```

5. 定义主方法类，包含以下成员方法：

   - 创建、初始化、释放客户端实例。
   - 登录、登出
   - 私聊、群聊、发送点对点消息、频道消息

     ```c++
     class Quickstart {
         public:
            // 构造函数，创建 IRtmService 实例
            Quickstart() {
                eventHandler_.reset(new RtmEventHandler());
                agora::rtm::IRtmService* p_rs = agora::rtm::createRtmService();
                rtmService_.reset(p_rs, [](agora::rtm::IRtmService* p) {
                    p->release();
                });

                if (!rtmService_) {
                    cout << "Failed to create RTM service! Check your App ID" << endl;
                    exit(0);
                }

                if (rtmService_->initialize(APP_ID.c_str(), eventHandler_.get())) {
                    cout << "Failed to initialize RTM service!" << endl;
                    exit(0);
                }
        }
        // 析构函数，释放 IRtmService 实例
        ~Quickstart() {
            rtmService_->release();
        }

        public:
            // 登录 RTM 系统
            bool login() {
                cout << "Please enter userID:"
                     << endl;
                     string userID;
                     getline(std::cin, userID);
                     if (rtmService_->login(Token.c_str(), userID.c_str())) {
                         cout << "login failed!" << endl;
                         return false;
                     }
                     cout << "here" << endl;
                     return true;
            }
            // 登出 RTM 系统
            void logout() {
                rtmService_->logout();
                cout << "log out!" << endl;
            }
            // 一对一聊天
            void p2pChat(const std::string& dst) {
                    string msg;
                    while(true) {
                        cout << "please input message you want to send, or input \"quit\" "
                             << "to leave p2pChat" << endl;
                             getline(std::cin, msg);
                             if(msg.compare("quit") == 0) {
                                return;
                             } else {
                                 sendMessageToPeer(dst, msg);
                             }
                    }
            }
            // 在频道内聊天
            void groupChat(const std::string& channel) {
                string msg;
                channelEvent_.reset(new ChannelEventHandler(channel));
                agora::rtm::IChannel * channelHandler =
                    rtmService_->createChannel(channel.c_str(), channelEvent_.get());
                if (!channelHandler) {
                    cout << "create channel failed!" << endl;
                }
                channelHandler->join();
                while(true) {
                    cout << "please input message you want to send, or input \"quit\" "
                         << " to leave groupChat, or input \"members\" to list members"
                         << endl;
                    getline(std::cin, msg);
                    if (msg.compare("quit") == 0) {
                    channelHandler->leave();
                    return;
                    } else if (msg.compare("members") == 0) {
                        channelHandler->getMembers();
                    } else {
                        sendMessageToChannel(channelHandler, msg);
                    }
                }
            }
            // 发送点对点消息
            void sendMessageToPeer(std::string peerID, std::string msg) {
                agora::rtm::IMessage* rtmMessage = rtmService_->createMessage();
                rtmMessage->setText(msg.c_str());
                int ret = rtmService_->sendMessageToPeer(peerID.c_str(),
                                                rtmMessage);
                rtmMessage->release();
                if (ret) {
                    cout << "send message to peer failed! return code: " << ret
                         << endl;
                }
            }
            // 发送频道消息
            void sendMessageToChannel(agora::rtm::IChannel * channelHandler,
                                    string &msg) {
                agora::rtm::IMessage* rtmMessage = rtmService_->createMessage();
                tmMessage->setText(msg.c_str());
                channelHandler->sendMessage(rtmMessage);
                rtmMessage->release();
            }
            private:
                std::unique_ptr<agora::rtm::IRtmServiceEventHandler> eventHandler_;
                std::unique_ptr<ChannelEventHandler> channelEvent_;
                std::shared_ptr<agora::rtm::IRtmService> rtmService_;
        };
        ```


6. 定义 main 函数，包含客户端实例创建数、功能选择（单聊、群聊、退出登录）、退出参数。

    ```c++
    int main(int argc, const char * argv[]) {
    // 选择实例创建数
    int count;
    while(true) {
        cout << "Please input the number which indicates how many RTM instances "
             << "will be created... Limit 3 instances for this demo" << endl;
        string input;
        getline(std::cin, input);
        try {
            count = std::stoi(input);
        } catch (...) {
            cout << "invalid input" << endl;
            continue;
        }
        if (count <= 0 || count > 3) {
            cout << "valid range: 1~3" << endl;
            continue;
        }
        break;
    }
    // 定义功能列表，可以通过在命令行输入数字选择功能
    std::vector<std::unique_ptr<Quickstart>> FunctionList;
    std::vector<bool> loginStatus;
    for (int i = 0; i < count; i++) {
        std::unique_ptr<Quickstart> tmp;
        tmp.reset(new Quickstart());
        FunctionList.push_back(std::move(tmp));
        loginStatus.push_back(false);
    }
    int index;

    // 选择已创建的 RTM 实例
    while(true) {
        cout << "Please input which RTM instance you want to use range[1,3]"
             << endl;
        string input_idx;
        getline(std::cin, input_idx);
        try {
            index = std::stoi(input_idx);
        } catch (...) {
            cout << "invalid input" << endl;
            continue;
        }
        if (index < 1 || index > count) {
            cout << "invalid index range" << endl;
            continue;
        }

        // 选择单聊、群聊、或登出 RTM 系统
        while(true) {
            if (!loginStatus[index-1]) {
                if (!FunctionList[index-1]->login())
                    continue;
                loginStatus[index-1] = true;
            }
            cout << "1: peer to peer chat\n"
                 << "2: group chat\n"
                 << "3: logout"
                 << endl;
            cout << "please input your choice: " << endl;
            string input_choice;
            getline(std::cin, input_choice);
            int choice = 0;
            try {
                choice = std::stoi(input_choice);
            } catch (...) {
                cout << "invalid input" << endl;
                continue;
            }
            if (choice == 1) {
                cout << "please input your destination user id" << endl;
                string dst;
                getline(std::cin, dst);
                FunctionList[index-1]->p2pChat(dst);
                continue;
            } else if (choice == 2) {
                cout << "please input your channel id" << endl;
                string channel;
                getline(std::cin, channel);
                FunctionList[index-1]->groupChat(channel);
                continue;
            } else if (choice == 3) {
                FunctionList[index-1]->logout();
                loginStatus[index-1] = false;
                break;
            } else {
                continue;
            }
        }

        // 退出程序
        cout << "Quit the program? yes/no" << endl;
        string input_quit;
        getline(std::cin, input_quit);
        if (input_quit.compare("yes") == 0) {
            break;
        }
    }

    exit(0);
    }
    ```


## 编译并运行项目

1. 在 `RTM_quickstart` 目录下新建 build 目录并切换到 build 目录：

   ```shell
   mkdir build
   cd build
   ```

2. 使用 CMake 进行编译：

   ```shell
   cmake ..
   make
   ```

3. 编译完成后，运行编译完成的可执行文件：

	 ```shell
   ./ rtmQuickstart
   ```