---
title: Start a chat session using Agora Chat UIKit
platform: iOS
updatedAt: 2021-09-14 07:51:16
---

Instant messaging connects people wherever they are and allows them to communicate with others in real time. Agora Chat enables you to embed real-time messaging in any app, on any device, anywhere.

Agora Chat UIKit is a library that combines Agora real-time messaging functionality into a customizable user interface. Have another coffee, we have done all the work for you.

This page shows a sample code to add peer-to-peer messaging into your app using the Agora Chat UIKit

IAIN: UPDATE IMAGE

![](https://web-cdn.agora.io/docs-files/1630581321338)

This page shows the minimum code you need to add a real-time messaging interface into your app using Agora Chat UIKit.

## Understand the tech


The following figure shows the callflow you integrate into your app in order to integrate real-time messaging using Agora Chat UIKit.

IAIN: UPDATE IMAGE
![](https://web-cdn.agora.io/docs-files/1630581329292)

To start a call using Agora Chat UIKit, you implement the following steps in your app:

1. **Join a channel**

   The `join` command joins the channel, publishes the local audio and video streams to Agora and handles audio and video for anyone else who joins the call in a default UI.


Yes, you read that right. After initializing an `IAIN - SOMETHING` instance, you manage a call with one line of code. 


## Prerequisites

- Xcode 11.3 or later.
- An iOS device running iOS 13 or later.
- A computer that can access the Internet.

    Ensure that no firewall is deployed in your network environment, otherwise the project fails.

- A valid [Agora account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up) and an Agora project.


## Project setup

In order to create the environment necessary to integrate Agora Chat into your app using Agora Chat UIKit, do the following:

1. In Xcode, [create a new project](https://help.apple.com/xcode/mac/current/#/dev07db0e578) for an iOS app using the **Single View App** template in `<root-directory>`. Make sure you select **Storyboard** as the user interface.

   If you have not added any team information, you see the <b>Add account...</b> button. Click it, input your Apple ID, and click <b>Next</b>. Your team information is added to the project. 

2. [Enable automatic signing](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for your project.

3. [Set the target devices](https://help.apple.com/xcode/mac/current/#/deve69552ee5) to deploy your iOS app.

4. Add project permissions for camera, microphone, network and photo album access.

   Open `Info` in the project navigation panel, then add the following properties to the [property list](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6):

   | key                                  | type   | value                                                                                       |
      | :----------------------------------- | :----- | :------------------------------------------------------------------------------------------ |
   | NSCameraUsageDescription    | String | Take photos and send them in Agora Chat |
   | NSMicrophoneUsageDescription | String | Record and send voice messages in Agora Chat      |
   | NSAllowsArbitraryLoads| String | Send attachments in Agora Chat |
   | NSPhotoLibraryUsageDescription | String | Send photos from your library in Agora Chat |
   

5. Integrate the Agora Chat UIKit into your project.

   1. Clone Agora Chat UIKit to your local machine. In the terminal:
      ```terminal
      cd <root-directory>
      git clone https://github.com/easemob/easeui_ios.git
      ```
   2. Create a podfile in your Xcode project:
      ```terminal
      cd <root-directory>/<project-directory>
      pod init
      ```
      Cocoapods creates `Podfile`.
   
   3. Import Agora Chat UIKit into your project. Open `Podfile` and link to the root folder of your local version of Agora Chat UIKit.  For example:
      ```pod
         # Uncomment the next line to define a global platform for your project
         platform :ios, '13.0'
         
         target 'Agora Chat UIKit' do
            # Comment the next line if you don't want to use dynamic frameworks
            use_frameworks!
   
            # Pods for Agora Chat UIKit
            pod 'EaseIMKit',  :path => "../easeui_ios"
         end
      ```
   4. import Agora Chat UIKit into your project. 
        ```terminal
      pod install
      ``` 
      CocoaPods installs Agora Chat UIKit and dependant libraries. When you look in XCode, you see `Pods-Agora Chat UIKit.*` in the `Pods` folder.

Your project now has the libraries you need to create an Agora Chat app. 

## Implement a client for messaging

This section shows how to use Agora Chat UIKit to implement Agora Chat into your app step-by-step.

To integrate real-time messaging in a ready-made user interface into your app:

1. Import the Agora classes:

   In `ViewController`, add the following line after the imports:
   ```swift
   IAIN: Add the imports here
   Theoretically, #import <EaseChatKit/EaseChatKit.h> 
   BUT, not included in the library. I found EaseIMKit which does not include. The demo included with the library uses another include totally. 
   
   ```
2. Create the variables that you use to initiate and join a channel:

    In `ViewController`, add the following lines after `class ViewController: UIViewController {`:
   ```swift
    //IAIN, update this for working code 
   
    // Update with the App ID of your project in Agora Console.
    let appId = <#Agora App Id#>

   ```

3. Create a function that initializes an `AgoraVideoViewer` instance and joins a channel: 
    
   In `ViewController`, add the following line after ` let appId = ...`:

   ```swift
    //IAIN, update this for working code    
   
    func initializeAndJoinChannel(){

      IAIN UPDATE
    }
   ```

5.	 When the user leaves the channel, clean up all the resources used by your app.
    In `ViewController`, add the `viewDidDisappear`function. For example:

    ```swift
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           IAIN: UPDATE FOR REAL CODE
       }
    ```
   
4. Start and stop your app.

   When the view is loaded, call `initializeAndJoinChannel` to join a channel. 
	 In `ViewController.swift`, update the `viewDidLoad` function. For example:
   ```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeAndJoinChannel()
    }
   ```


## Test your app

To check that your code works, use two virtual machines run a chat session in your app. To test real-time messaging with your app:

IAIN: UPDATE

1. [Generate a temporary token](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All#generate-a-temporary-token) in Agora Console.

2. In your browser on another device, navigate to the [Basic Communication sample app](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/), update _App ID_, _Channel_ and _Token_ with the values for your temporary token, then click *JOIN*.

3. In XCode, in `ViewController`, update `appId`, `channelName` and `token` with the values for your temporary token.

4. Run your app.

You can now talk to yourself between different devices. Try it out with some friends, the conversation may be better. 
