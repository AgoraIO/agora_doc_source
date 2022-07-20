Before using Agora Chat, you need to enable and configure the Agora Chat service at [Agora Console](https://console.agora.io/#onboarding).

## Prerequisites

Before enabling the Agora Chat service, make sure that you have the following:

- A valid [Agora account](https://docs.agora.io/en/AgoraPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-account).
- An [Agora project](https://docs.agora.io/en/AgoraPlatform/get_appid_token?platform=AllPlatforms#create-an-agora-project) that uses  **APP ID + Token** as its authentication.
- An Agora Chat pricing plan. For how to subscribe to a plan, see [Subscribe to the pricing plan](./agora_chat_pricing#subscribe-to-the-pricing-plan).

## Enable the Agora Chat service

For private BETA, you need to contact support@agora.io to enable the Agora Chat service, and provide your [Company ID (CID)](https://console.agora.io/settings/company), Vendor ID (VID), the pricing plan version, and the location of your data center. 

Agora activates the Agora Chat service for you, and send you a link for configuring the Agora Chat service. The format of the link is as follows: 

```http
https://console.agora.io/project/{vid}/Chat
```



## Get the information of the Agora Chat project

Agora Console assigns the following information to each project that enables the Agora Chat service:

- **OrgName**: The unique identifier that the Agora Chat service assigns to each enterprise (organization).
- **AppName**: The name that the Agora Chat service assigns to each app. Each app under the same enterprise (organization) must have a unique App Name.
- **AppKey**: The unique identifier that the Agora Chat service assigns to each app. The rule is `${OrgName}#{AppName}`.
- **Data Center**: Agora provides several data centers for the service in different regions, including Beijing1 (China), Beijing VIP (China),  Sinapore, Frankfurt (Germany), and Virginia (USA).

  After the plan is changed, the data center remains unchanged.

- **API request url**: The domain of the WebSocket and RESTful API request that Agora assigns to each project.

Follow these steps to get the project information:

1. Find the project that has enabled the Agora Chat service on the [Project management](https://console.agora.io/projects) page at Agora Console, and click ![img](https://web-cdn.agora.io/docs-files/1630313361488).
2. Find **Agora Chat IM** on the project configuration page, and click **Configure**.
3. On the project edit page, get the OrgName, AppName, AppKey, data center, and domain.

## Add the push certificate

Before sending push notifications, you need to complete the certificate configuration of each platform. The following platforms are currently supported: Apple and Google FCM. 

After the Agora Chat service is enabled, follow these steps to add the message push certificate:

1. Find the project that has enabled the Agora Chat service on the [Project management](https://console.agora.io/projects) page at Agora Console, and click ![img](https://web-cdn.agora.io/docs-files/1630313361488).

2. Find **Agora Chat** on the project editing page, and click **Configure**.

3. Click **Add Push Certificate** in the **Push Notifications** module on the project configuration page.
   ![](https://web-cdn.agora.io/docs-files/1640072642866)
4. Fill in the pop-up with the certificate name and the push certificate secret needed in the message push of all platforms. Click **Save**.

## Add the real-time callback URL address

Agora Chat provides a real-time callback service. After the callback is configured, your application server receives the messages and events of the types you choose. For details, see [Set up HTTP callbacks](./agora_chat_set_up_webhooks).

After the Agora Chat service is enabled, follow these steps to add the message callback certificate:

1. Find the project that has enabled the Agora Chat service on the [Project management](https://console.agora.io/projects) page at Agora Console, and click ![img](https://web-cdn.agora.io/docs-files/1630313361488).

2. Find **Agora Chat** on the project editing page, and click **Configure**.

3. Click **Add Target Url** in the **Real-time Callback** module on the project configuration page.
![](https://web-cdn.agora.io/docs-files/1640072684075)

4. Fill in the pop-up with the information needed by the callback before or after sending the message. Each rule under a project must have a unique name. Click **Save**.