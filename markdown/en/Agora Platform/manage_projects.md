---
title: Manage Projects
platform: All Platforms
updatedAt: 2021-03-15 04:20:02
---
This page shows how to create and manage projects in Agora Dashboard.

> The administrator and engineers have access to the **Project Management** page.

## Create a new project

Follow these steps to create a new project:

1. Log in [Agora Dashboard](https://dashboard.agora.io/), click ![](https://web-cdn.agora.io/docs-files/1551254998344) in the left navigation menu to enter the **Project Management** page.

2. Click **Create**. 

![](https://web-cdn.agora.io/docs-files/1565249845657)

3. Enter your project name and select your authentication mechanism ("App ID" or "App ID + App Certificate + Token") in the dialog box.

![](https://web-cdn.agora.io/docs-files/1565249859724)

> We provide two authentication mechanisms: "App ID" and "App ID + App Certificate + Token". For details, see [User Security Keys](https://docs.agora.io/en/Interactive%20Broadcast/token#agoras-authentication-mechanisms). 
>
> We recommend that you use a token for more security:
>
> - In the testing stage, you can generate a temporary token in Dashboard after enabling the App Certificate.
> - In the production stage, you need to deploy a Token Generator on your server. See [Generate a Token](https://docs.agora.io/en/Interactive&20Broadcast/token_server?platform=C++).

4. Click **Submit** and you can see the project on the **Project Management** page.

In the figure above, Project A uses an App ID for authentication and the App Certificate of this project is not enabled. Project B uses a token for authentication and the App Certificate of this project is enabled. For Project B, you can click ![img](https://web-cdn.agora.io/docs-files/1558345848047) to generate a temporary token in the testing stage.

> You can create up to 10 projects with the deleted ones included. If you need to use more projects, please contact us by submitting a ticket.

### Enable the App Certificate

If you use the App ID for authentication when creating the project and want to switch to the "App ID + App Certificate + Token" mechanism, you need to enable the App Certificate first. 

Follow these steps to enable the App Certificate:

1. Click the ![](https://web-cdn.agora.io/docs-files/1551255135678)**edit** button of the targeted project.
2. Click **Enable**. Read **About App Certificate**. We will send you an email. Follow the steps in the email to confirm about enabling the App Certificate.

![](https://web-cdn.agora.io/docs-files/1565249882128)

3. You can see the enabled App Certificate on the **Edit project** page.

## Manage your projects

![](https://web-cdn.agora.io/docs-files/1565250102309)

On the **Project Manage** page, you can also do the following:

- Enter a project name or App ID in the input box and click ![img](https://web-cdn.agora.io/docs-files/1551255111208) to search for the project.
- Click ![img](https://web-cdn.agora.io/docs-files/1551255135678) to edit the project information and get the App ID.
- Click ![](https://web-cdn.agora.io/docs-files/1564048876293) to view the project usage.
- Click ![](https://web-cdn.agora.io/docs-files/1564048991389) to generate a temporary token.
- Check the project states according to the ![img](https://web-cdn.agora.io/docs-files/1551255188685) and ![img](https://web-cdn.agora.io/docs-files/1551255166718) icons.