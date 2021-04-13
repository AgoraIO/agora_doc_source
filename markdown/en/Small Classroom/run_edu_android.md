---
title: Run the Sample Project
platform: Android
updatedAt: 2021-02-20 11:09:41
---
## Introduction

Agora provides an open-source [eEducation](https://github.com/AgoraIO-Usecase/eEducation) sample project on GitHub. This sample project demonstrates how to use the Agora RTC SDK, Agora Cloud Recording, Agora Room Management Service, and third-party Netless Whiteboard SDK to implement the online interactive tutoring scenarios.

This document introduces how to run this project and experience the online interactive tutoring scenarios.

## Prerequisites

- Development environment: 
  - [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html).
  - Android Studio 2.0 or later.
- A mobile device running Android 4.4 or later. Agora recommends you run this sample project on a physical mobile device, as some simulators may not support the full features of this project.
- A valid Agora [account](https://sso.agora.io/en/login/).
- A valid Netless [account](https://console.netless.link/en/login/).

## Procedure

### 1. Create an Agora project

Create a project in [Agora Console](https://console.agora.io/), as follows:

1. Log in to Console, and click ![img](https://web-cdn.agora.io/docs-files/1594283671161) in the left navigation menu to enter the [Project Management](https://console.agora.io/projects) page.

2. Click **Create**.

   [![create button](https://web-cdn.agora.io/docs-files/1594949127367)](https://dashboard.agora.io/projects)

3. Enter your project name, and select **Secure mode: APP ID + Token** for the authentication mechanism in the pop-up window.

4. Click **Submit**. You can see the created project on the **Project Management** page.

### 2. Get an Agora App ID

Agora automatically assigns each project an App ID as a unique identifier.

To copy this App ID, find your project on the [Project Management](https://console.agora.io/projects) page in Agora Console, and click the eye icon to the right of the App ID.

![get app id](https://web-cdn.agora.io/docs-files/1602646621028)



### 3. Get the Agora Customer ID and Customer Secret

Since this sample project uses the RESTful APIs, you need to pass the basic HTTP authentication by generating a Base64-encoded credential with the Customer ID and Customer Secret provided by Agora. Get the Agora Customer ID and Customer Secret, as follows:

1. Log in to [Agora Console](https://console.agora.io/), click the account name on the top right of Agora Console, and click **RESTful API** from the drop-down list to enter the RESTful page.
 ![](https://web-cdn.agora.io/docs-files/1605165111848)

2. Click **Download** to get the Customer ID and Customer Secret.
 ![](https://web-cdn.agora.io/docs-files/1605165129648)


### 4. Get the Netless AppIdentifier and sdkToken

Get the Netless AppIdentifier and sdkToken, as follows:

1. Log in to the [Netless console](https://confluence.agoralab.co/pages/viewpage.action?pageId=695421604), click **Application** in the left navigation menu to enter the project management page, and copy the AppIdentifier.
 ![](https://web-cdn.agora.io/docs-files/1605165315575)
 
2. Click the **configuration** button of the default project, click **Generate sdkToken**, and then copy and record the sdkToken.
 ![](https://web-cdn.agora.io/docs-files/1605165336033)

### 5. Configure the Netless sdkToken for Agora Edu Cloud Service

Configure the Netless sdkToken in Agora Room Management Service, as follows:

1. Log in to [Agora Console](https://console.agora.io/), and click the **Project Management** button in the left navigation menu to enter the [Project Management](https://dashboard.agora.io/projects) page.

2. Find the Agora project that you create during the **Create an Agora project** procedure, and click the **edit** button to the right of this project. Click **Update token**, and enter the sdkToken that you record in the Get the Netless AppIdentifier and sdkToken procedure in the pop-up window.

 ![](https://web-cdn.agora.io/docs-files/1605166492585)

### 6. Configure the sample project

Configure the sample project, as follows:

1. Execute the following command in Terminal to clone the [eEducation](https://github.com/AgoraIO-Usecase/eEducation) sample project:
 ```
git clone https://github.com/AgoraIO-Usecase/eEducation.git
```
2. Open the `eEducation/education_Android/AgoraEducation` folder in Android Studio. The IDE automatically starts the Gradle build.

3. Switch to the Project view, and pass the following parameters in the `app/src/normal/res/values/string_configs.xml` file:
   - The Agora App ID
   - The Agora Customer ID and Customer Secret
   - The Netless AppIdentifier
 ```
<string name="agora_app_id" translatable="false">Your AppId</string>
<string name="agora_customer_id" translatable="false">Your customerId</string>
<string name="agora_customer_cer" translatable="false">Your customerCer</string>
<string name="whiteboard_app_id" translatable="false">Your whiteboard appId</string>
```

### 7. Run the sample project

Connect the device to your computer via USB, and click the **Run** button on the toolbar to build and run the sample project.

![](https://web-cdn.agora.io/docs-files/1603975701953)

After the IDE successfully installs the app on your Android device, you can see the following user interface:

![](https://web-cdn.agora.io/docs-files/1605166648341)

Click **Agree** after reading the privacy terms. Enter a room name, user name, and choose the room type to join a classroom.