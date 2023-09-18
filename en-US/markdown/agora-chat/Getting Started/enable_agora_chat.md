# Enable and configure Chat

Before using Chat, you need to enable and configure it through [Agora Console](https://console.agora.io/#onboarding).

## [Prerequisites](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#prerequisites)

To enable Chat, make sure that you have the following:

- A valid [Agora account](https://docs.agora.io/en/agora-chat/reference/manage-agora-account#create-an-agora-account).
- An [Agora project](https://docs.agora.io/en/agora-chat/reference/manage-agora-account#create-an-agora-project) that uses **App ID** and **Token** for authentication.
- A Chat pricing plan. For details on how to subscribe, see [Subscribe to the pricing plan](https://docs.agora.io/en/agora-chat/reference/pricing#subscribe-to-the-pricing-plan).

## [Enable Chat](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#enable-)

1. Log in to the [Agora Console](https://console.agora.io/).

2. In the left navigation bar, click **Project Management** and click **Configure** for the project that you want to use.

3. In the **Features** section of the **Edit Project** page, click **Enable/Configure** next to **Chat** to enable the service.

[/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/enable_chat.png]

If this is your first Agora project, you need to first enable **Primary Certificate** and delete **No Certificate** in the **Security** section.

[/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/enable_primary_certificate.png]

4. Select a data center closest to where most of your end users are located.

  Once selected, the data center cannot be changed.

  [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/select_data_center.png]

5. Enable the advanced Chat features based on your business requirements.

  [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/enable_advanced features.png]   

For details about these advanced features, see the following:

- [Message Callback](https://docs.agora.io/en/agora-chat/develop/setup-webhooks)
- [Message Thread](https://docs.agora.io/en/agora-chat/client-api/threading/thread-management)
- [Reaction](https://docs.agora.io/en/agora-chat/client-api/reaction)
- [Presence](https://docs.agora.io/en/agora-chat/client-api/presence)
- [Translation](https://docs.agora.io/en/agora-chat/client-api/messages/translate-messages)
- [Moderation](https://docs.agora.io/en/agora-chat/develop/content-moderation)

## [Get Chat project information](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#get-chat-project-information)

Agora Console assigns the following information to each project that enables Chat:

- **Data Center**: Agora provides several data centers for the service in different regions, including Singapore, Frankfurt (Germany), and Virginia (USA). After the plan is changed, the data center remains unchanged.
- **AppKey**: The unique identifier that Chat assigns to each app. The **AppKey** is of the form `${OrgName}#{AppName}`.
- **OrgName**: The unique identifier that Chat assigns to each enterprise (organization).
- **AppName**: The name that Chat assigns to each app. Each app under the same enterprise (organization) must have a unique App Name.
- **API request url**: The domain of the WebSocket and RESTful API request that Agora assigns to each project.

Follow these steps to get the project information:

1. Find your Chat-enabled project on the [Project management](https://console.agora.io/projects) page at Agora Console and click **Configure**.
2. On the project edit page, find **Chat** and click **Enable/Configure**.
3. On the Chat config page, get the values of **Data Center**, **AppKey**, **OrgName**, **AppName**, **WebSocket Address**, and **REST API**.

## [Manage users and generate tokens](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#manage-users-and-generate-tokens)

For development purposes, Agora enables you to manage users and generate Chat user authentication tokens using Agora Console. In a production environment, you use the [RESTful API](https://docs.agora.io/en/agora-chat/restful-api/user-system-registration) to manage users and a token server to [generate user authentication tokens](https://docs.agora.io/en/agora-chat/develop/authentication).

This section shows you how to register Chat users and generate temporary tokens using Agora Console.

### [Register a user](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#register-a-user)

To register a user, do the following:

1. On the **Project Management** page, click **Configure** for the project that you want to use.

   [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/configure_project.png]

2. On the **Edit Project** page, click **Enable/Configure** next to **Chat** in the **Features** section.

  [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/enable_chat.png]

3. In the left-navigation pane, select **Operation Management** > **User** and click **Create User**.

   ![img](https://web-cdn.agora.io/docs-files/1664531141100)

4. In the **Create User** dialog box, fill in the **User ID**, **Nickname**, and **Password**, and click **Save** to create a user.

   ![img](https://web-cdn.agora.io/docs-files/1664531162872)

### [Generate a user token](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#generate-a-user-token)

To ensure communication security, Agora recommends using tokens to authenticate users who log in to Chat.

For testing purposes, Agora Console supports generating temporary tokens for Chat. To generate a user token, do the following:

1. On the **Project Management** page, click **Configure** for the project that you want to use.

   [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/configure_project.png]

2. On the **Edit Project** page, click **Enable/Configure** next to **Chat** in the **Features** section.

   ![img](https://web-cdn.agora.io/docs-files/1664531091562)

3. In the **Data Center** section of the **Application Information** page, enter the [user ID](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#userid) in the **Chat User Temp Token** box and click **Generate** to generate a token with user privileges.

   ![img](https://web-cdn.agora.io/docs-files/1664531214169)

## [Change the Chat plan](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#change-the--plan)

1. Log in to the [Agora Console](https://console.agora.io/).

2. In the left navigation bar, click **Package**.

3. On the **Subscribe** tab, you can change your Chat plan by clicking **Subscribe** next to the desired plan.

   [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/subscribe_chat.png]

   **Note:**

   - The plan change takes effect immediately.
   - Agora doesn't recommend plan downgrading, as it could impact the capacity of your applications and availability of certain features.

## [Disable Chat](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#disable-)

1. Log in to the [Agora Console](https://console.agora.io/).

2. In the left navigation bar, click **Project Management** and click **Configure** for the project that you want to use.

3. In the **Features** section of the **Edit Project** page, click **Enable/Configure** next to **Chat**.

4. On the **Application Information** page, disable Chat in the **Chat Service Status** section.

   **Note:** When you disable Chat, the Chat-related data is still stored in the Chat data center, and you are still charged for the plan activation fee.

   ![img](https://web-cdn.agora.io/docs-files/1665387330975)

## [Unsubscribe Chat](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#unsubscribe-)

Before unsubscribing Chat, disable all projects that have Chat enabled.

1. Log in to the [Agora Console](https://console.agora.io/).

2. In the left navigation bar, click **Package**.

3. On the **Subscribe** tab, scroll down to the bottom and click **Unsubscribe**.

   [/agora_doc_source/en-US/markdown/agora-chat/images/enablechat/unsubscribe_chat.png]

   **Note:**

   When you unsubscribe Chat:

   - All Chat-related data is purged.
   - You are still billed with a pro-rated monthly fee and the usage that occurred during that month.

## [Next steps](https://docs.agora.io/en/agora-chat/get-started/enable?platform=android#next-steps)

After enabling and configuring Chat, the Chat-related features in Agora Analytics are enabled by default to help you keep track of usage trends and quality details. For more information, see [Data Insights](https://docs.agora.io/en/agora-chat/reference/agora-analytics/data-insights) and [Data Metrics](https://docs.agora.io/en/agora-chat/reference/agora-analytics/data-metrics).