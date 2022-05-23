Before using the acceleration service, you need to create an FPA service for your project in the Agora console.

## Implementation

### Step 1: Create an Agora Project

See [Creating and Managing Projects](/en/Agora%20Platform/manage_projects?platform=All%20Platforms) for details.

When you create a project, you can choose App ID authentication or App ID+Token authentication:

- **App ID** authentication: Suitable for scenarios with low security requirements. In this mode, you can quickly implement the SDK acceleration mode without deploying a token generator on the app server. Specify your app ID in the token parameter in the SDK.
- **App ID+Token** authentication: Suitable for scenarios with high security requirements. In this mode, you need to deploy the token generator on the app server and pass the generated token to the SDK.

### Step 2: Configure origin site information

1. Click **Enable** on the **Edit Project** page of the created project to go to the **Create FPA Service** page.
2. In the **Origin Site Information** section, select the origin site type and configure the corresponding the domain name/IP, region, and origin site port. Click **Next**.

![](https://web-cdn.agora.io/docs-files/1653012507356)

### Step 3: Set up the FPA service type

You can create an FPA service and enable IPA mode or SDK mode for the service. For details on the two modes, see [Product Overview](/en/global-accelerator/agora_ga_overview?platform=all%20platforms).

**Enable SDK mode**

Set the acceleration mode to SDK and click **Finish**.

![](https://web-cdn.agora.io/docs-files/1653012657171)

**Enable IPA mode**

1. Set the acceleration mode to **IPA Mode**.
2. Select the acceleration region and click **Finish**.

	![](https://web-cdn.agora.io/docs-files/1653012622623)

### Step 4: View FPA service information

After the activation is completed, the **Apply for activation** button under the **Edit Project** page changes to the **View Details** button. You can click the button to view information about your acceleration channels.

### Step 5: Get the necessary information

**SDK mode: Get the origin IP/domain name, port, and chain ID of the FPA service**

For the SDK mode, you need to get the origin IP/domain name, origin port, and chain ID of the FPA service as SDK parameters. 

1. On the **Edit Project**  page, click the **View Details** button to enter the FPA details page. 
2. Select the **SDK Management** tab. The ID value in the table is the chain ID of the FPA service. Each FPA service corresponds to a chain ID. 

	![](https://web-cdn.agora.io/docs-files/1653012860201)

3. In the **SDK Management** tab, find the corresponding Origin site ID through the chain ID of the acceleration channel. 
4. Select the **Origin Site Management** tab. The values in the **Port** and **Origin site** fields corresponding to the origin site ID in the table are the port and domain name/IP of the origin site corresponding to the chain ID. 

![](https://web-cdn.agora.io/docs-files/1653012903073)

**IPA mode: Get the acceleration point IP**

For the IPA mode, you need to get the acceleration point IP as the target address for domain name resolution. 

1. On the **Edit Project** page, click **View Details** button to enter the FPA details page. 
2. Select the **Chain Management** tab. The value of the **Gateway IP** field in the table is the acceleration point IP. 

	![](https://web-cdn.agora.io/docs-files/1653012779501)

