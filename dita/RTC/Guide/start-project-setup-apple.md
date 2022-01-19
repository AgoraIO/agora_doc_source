# Project setup

For new projects, in **Xcode**, follow the steps to create the environment necessary to add live streaming into your app.

1. Create a new [platform] app and configure the following settings:

    - **Product Name**: Any name you like.
    - **Team**: If you have added a team, choose it from the pop-up menu. If not, you can see the **Add account** button. Click it, input your Apple ID, and click **Next** to add your team.
    - **Organization Identifier**: The identifier of your organization. If you do not belong to an organization, use any identifier you like.
    - **Interface**: Choose **Storyboard**.
    - **Language**: Choose **Swift**.

2. Integrate the [sdk-name] into your project:

<p props="ios" conref="conref/integrate-the-sdk-apple.dita#integrate-the-sdk/swift-package"></p>
<p props="mac" conref="conref/integrate-the-sdk-apple.dita#integrate-the-sdk/cocoapods"></p>

3. [Enable automatic signing](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for your project.
4. Set the deployment target for your app:
    1. In the [project editor](https://help.apple.com/xcode/mac/current/#/devdab46c612), choose your target and click **General**.
    2. In the **Deployment Info** settings, choose the operating system version for your [platform] app from the pop-up menu.
5. Add permissions for microphone and camera usage.

    In the [Project navigator](https://help.apple.com/xcode/mac/current/#/dev7d7220fbb), open the `info.plist` file of your project and [add the following properties](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6):

    - Privacy - Microphone Usage Description
    - Privacy - Camera Usage Description

    <p props="mac">Navigate to <b>TARGETS &gt; Project Name &gt; Signing & Capabilities</b>, and add the following permissions in <b>App Sandbox</b> and <b>Hardened Runtime</b>:
    <ul props="mac">
    <li>App Sandbox &gt; Network: Incoming Connections (Server) and Outgoing Connections (Client)</li>
    <li>App Sandbox &gt; Hardware: Camera and Audio Input</li>
    <li>Hardened Runtime &gt; Resource Access: Camera and Audio Input</li>
    </p>
