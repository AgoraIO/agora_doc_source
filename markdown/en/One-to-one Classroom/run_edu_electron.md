---
title: Run the Sample Project
platform: Electron
updatedAt: 2020-12-23 10:39:11
---
## Introduction

Agora provides an open-source [eEducation](https://github.com/AgoraIO-Usecase/eEducation) sample project on GitHub. This sample project demonstrates how to use the Agora RTC SDK, Agora Cloud Recording, Agora Edu Cloud Service, and third-party Netless Whiteboard SDK to implement the online interactive tutoring scenarios.

This document introduces how to run this project and experience the online interactive tutoring scenarios.

## Prerequisites

- Development environment: 
  - A Windows or macOS computer with access to the Internet.
  - Access to camera, microphone, and screen recording.
  - [Node.js](https://nodejs.org/en/).
- A valid Agora [account](https://sso.agora.io/en/login/).
- A valid Netless [account](https://console.netless.link/en/login/).
- Set up your own Alibaba Cloud Object Storage Service if you need to use the courseware and whiteboard. 

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

Configure the Netless sdkToken in Agora Edu Cloud Service, as follows:

1. Log in to [Agora Console](https://console.agora.io/), and click the **Project Management** button in the left navigation menu to enter the [Project Management](https://dashboard.agora.io/projects) page.

2. Find the Agora project that you create during the **Create an Agora project** procedure, and click the **edit** button to the right of this project. Click **Update token**, and enter the sdkToken that you record in the Get the Netless AppIdentifier and sdkToken procedure in the pop-up window.

 ![](https://web-cdn.agora.io/docs-files/1605166492585)

### 6. Configure the sample project

Configure the sample project, as follows:

1. Execute the following command in Terminal to clone the [eEducation](https://github.com/AgoraIO-Usecase/eEducation) sample project:
 ```
git clone https://github.com/AgoraIO-Usecase/eEducation.git
```
2. Rename the `.env.example file` in the `eEducation/education_web` folder as `.env` and pass the following parameters in this file:
   - The Agora App ID
   - The Agora Customer ID and Customer Secret
   - The Netless AppIdentifier

 ```
REACT_APP_AGORA_APP_ID=agora appId
REACT_APP_AGORA_CUSTOMER_ID=customer_id
REACT_APP_AGORA_CUSTOMER_CERTIFICATE=customer_certificate
REACT_APP_NETLESS_APP_ID=netless appId
```

### 7. Run the sample project

Run the sample project, as follows:
1. Enter the `eEducation/education_web` directory and install dependencies:
 ```
cd eEducation/education_web
npm install
```

2. Execute the following command to run the sample app. The sample app opens in your default browser.

 ![](https://web-cdn.agora.io/docs-files/1605168145637)

 <div class="alert info">If the sample app does not open automatically, you can visit http://localhost:3000 in your browser to open it manually.</div>