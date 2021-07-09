To use Agora Interactive Whiteboard, you need to enable and configure the whiteboard service in [Agora Console](https://console.agora.io/#onboarding).


## Prerequisites

Before using Agora Console, ensure that you have a valid Agora account.

Follow the steps in the table below according to your current account status:

| Account status | Steps |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| No Netless account or Agora account | See [Sign up for an Agora account](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up?platform=AllPlatforms). |
| A Netless account and no Agora account | Follow these steps to create an Agora account using your Netless account: Log in to Agora Console using the email address linked with your Netless account, and click **Send Email**. Then, reset your password via the email you received. |
| A Netless account and an Agora account (both accounts are linked with the same email address) | Log in to Agora Console, follow the on-screen instructions, and click **Migrate**. Agora will automatically move projects under your Netless account into your Agora account. |
| A Netless account and an Agora account (each account is linked with a different email address) | In this case, Agora automatically creates a new Agora account using your Netless account. You can select either the new Agora account or the older Agora account for Netless project migration:<li>To migrate to the new Agora account: Log in to Agora Console using the email address linked with your Netless account, and click **Send Email**. Then, reset your password via the email you received.<li>To migrate to the older Agora account: Contact sales@agora.io. |

## Enable the whiteboard service

Follow these steps to enable the whiteboard service in Agora Console:

1. Log in to [Agora Console](https://console.agora.io/), and click the **Project Management** icon on the left navigation panel.

2. On the **Project Management** page, find the project for which you want to enable the whiteboard service, and click **Edit**.

   <div class="alert note"> To create a project, see <a href="https://docs.agora.io/cn/AgoraPlatform/manage_projects?platform=AllPlatforms">Manage Projects</a >.</div>
3. On the **Edit Project** page, find **Whiteboard**, and click **Enable**.
4. Read the pop-up prompt carefully, and click **Confirm**. 
After enabling the whiteboard service, the **Enable** button is replaced by the **Config** button, which allows you to configure the whiteboard service.

## Get basic information on a whiteboard project

### Get an App Identifier

Agora assigns a unique App Identifier to each project that has the whiteboard service enabled. An App Identifier is required when initializing the whiteboard SDK.

Refer to the following steps to get the App Identifier of a whiteboard project:

1. On the [Project Management](https://console.agora.io/projects) page in Agora Console, find the whiteboard project, and click **Edit**.

2. On the **Edit Project** page, find **Whiteboard**, and click **Config**.

3. On the **Whiteboard Configuration** page, find **AppIdentifier**. Click the eye icon on the right to copy the App Identifier, and save it in a secure location.![](https://web-cdn.agora.io/docs-files/1616656656727)



### Get an access key pair

Agora assigns a pair of access keys, an AK (Access Key) and an SK (Secret Key), to each whiteboard project. These keys are used to generate the SDK Token.

Refer to the following steps to get the AK and SK for a whiteboard project:

1. On the [Project Management](https://console.agora.io/projects) page in Agora Console, find the whiteboard project, and click **Edit**.
2. On the **Edit Project** page, find **Whiteboard**, and click **Config**.
3. On the **Whiteboard Configuration** page, find **AK** and **SK**. Click the eye icons on the right to copy the **AK** and **SK**, respectively, to a secure location.![](https://web-cdn.agora.io/docs-files/1616656748111)


<div class="alert note">Unexpected exposure of these access keys can cause severe security problems. To enhance security, Agora recommends the following precautions:

- Do not send the access keys to your app clients or hard-code the access keys in your app. Ensure that only your app server is allowed to read the access keys from the configuration file.
- If you believe there may be a risk that your access keys have been exposed, contact support@agora.io to get new access keys.</div>

### Get an SDK Token

To enhance security, Agora uses an [SDK Token (a dynamic key)](/cn/whiteboard/whiteboard_token_overview) for user authentication.

For testing purposes, you can generate an SDK Token in Agora Console by performing the following steps:

1. Go to the [Project Management](https://console.agora.io/projects) page in Agora Console, find the whiteboard project, and click **Edit**.

2. On the **Edit Project** page, find **Whiteboard**, and click **Config**.

3. On the **Whiteboard Configuration** page, click **Generate sdk Token** to get a permanently valid SDK Token that is assigned an `admin` role.![](https://web-cdn.agora.io/docs-files/1616656760399)


4. Read the pop-up prompt carefully, click **Copy sdkToken**, and save the SDK Token in a secure location.


<div class="alert note">Because such SDK Tokens grant a high level of permission, do not send them to your app clients. Otherwise there might be a risk of leakage.</div>

In a production environment, you need to generate the SDK Token from your app server using one of the following methods:

- Use code. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server). (Recommended)
- Call the Interactive Whiteboard RESTful API. See [Generate a SDK Token (POST)](/cn/whiteboard/generate_whiteboard_token).

## Enable server-side supporting features

Agora Interactive Whiteboard provides the following server-side supporting features:

- [File conversion](/cn/whiteboard/file_conversion_overview) (Convert to image and Convert to web page)

> Agora charges for these file-conversion services. See [Pricing](/cn/whiteboard/billing_whiteboard).

- [Screenshot](/cn/whiteboard/whiteboard_screenshot)

Follow these steps to enable one or more supporting features and configure the storage settings:

1. Go to the [Project Management](https://console.agora.io/projects) page in Agora Console, find the whiteboard project, and click **Edit**.

2. On the **Edit Project** page, find **Whiteboard**, and click **Config**.****

3. Under **Services**, select **Enabled** for **Docs to Picture**, **Docs to web**, or **Screenshot**.![](https://web-cdn.agora.io/docs-files/1616656791539)


4. Click the arrowhead to the right of **Storage**, and select a storage space in the drop-down list:

   - **default - white-cn-doc-convert**: The default storage space provided by the whiteboard service.
   - **A previously configured third-party storage service**: If you have added and configured a third-party storage space, you can see its name in the list.
   - **New Storage Config**: If you do not want to use the default storage space and have not yet added a third-party storage space, select this option. See Step 5.

![](https://web-cdn.agora.io/docs-files/1616656819276)

5. Click **New Storage Config**, and follow the on-screen instructions to fill in the following information:
   - **Vendor**: (Required) Third-party service providers, including [AliCloud](https://www.aliyun.com/product/oss) (recommended), [Qiniu Cloud](https://www.qiniu.com/products/kodo), and [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1) Object Storage Service (OSS).
   - **Region**: (Required) The location of the data center you specified when creating a bucket.
   - **accessKey**: (Required) The Access Key provided by the OSS provider, which is used by the OSS provider to identify visitors.
   - **secretKey**: (Required) The Secret Key provided by the OSS provider, which is used to authenticate signatures.
   - **bucket**: (Required) The name of the storage space.
   - **Storage path**: The path used to save the resources in the storage space. The default is the root directory.
   - **Domain**: The domain name used to access the OSS service. This field is required if you use Qiniu Cloud. Otherwise, Agora cannot access the storage service.
   <div class="alert note">
		 <ul>
	 <li>To get the above information about a third-party storage service, see the documentation of the OSS provider you are using.</li>
		<li>You should enable <b>public access</b> or higher permission for third-party storage spaces so that your app clients can access files saved in the space.</li>
		 </ul>
</div>

6. Click **Save**, read the pop-up prompt carefully, and click **Confirm**.