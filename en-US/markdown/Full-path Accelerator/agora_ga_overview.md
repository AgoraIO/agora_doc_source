Agora Full-Path Accelerator (FPA), based on Agora SD-RTN™, effectively solves the problem of transmission quality degradation caused by network congestion and operator failure. FPA combines network intelligence, route scheduling, multiple redundancies, and key nodes deployed worldwide to normalize global quality assurance. FPA also improves the connectivity performance in poor network conditions and provides intelligent access through the SDK, which greatly improves the adaptability to poor last-mile quality. Through the efficient collaboration of “cloud” and “end”, FPA can provide a high level of QoS guarantee. Through software-only virtualization, FPA can fully cover all possible Internet nodes and access point requirements and fully support the network requirements of your high-value business.

## Application scenarios

FPA can be applied to the following industries and scenarios:

| Industry                 | Scenario                                                                                                                                                   |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Social and entertainment | <ul><li>Live comments distribution</li> <li> Login connection</li> <li>Online gift distribution</li> <li>Comment sharing</li>     </ul>                                                                            |
| Game                     | <ul><li>Interactive game instruction</li> <li> Game login </li> <li>TCP data interface</li> <li> In-game payment </li>     </ul>                                                                                      |
| Online education         | <ul><li>Interactive whiteboard </li> <li> Self-developed audio and video apps </li> <li> Screen sharing </li> <li> Scenario-based APIs such as service control, muting users, kicking users, and authentication</li> </ul>       |
| Office system            | <ul><li>Remote desktop </li> <li> Email OA </li> <li>Mobile office app  </li>     </ul>                                                                                                                      |
| Cloud service sync       | <ul><li>Data sync </li> <li>Cloud CRM </li> <li>Cloud ERP</li> <li> Cloud login    </li>     </ul>                                                                                                                    |
| Finance                  | <ul><li>Online banking and mobile banking trading </li> <li>Stock trading</li>     </ul>                                                                                                        |

## Product features

After you enable the FPA service, FPA creates one or more optimal acceleration channels according to the acceleration area and source server that you have configured and provides the corresponding acceleration IP and server IP. The app client accesses SD-RTN™ through **the acceleration IP**; the source server accesses SD-RTN™ through **the server IP**.

FPA supports two acceleration modes: IPA acceleration mode and SDK acceleration mode.

Regardless of the acceleration mode used, as long as you have configured the origin server, FPA automatically establishes a connection between the server IP and the origin server. You do not need to do anything with the origin server.

### Acceleration mode comparison

The comparison between IPA acceleration mode and SDK acceleration mode is as follows:

|                    | **IPA Acceleration Mode**                                                                                                                                                                                                                                                      | **SDK Acceleration Mode**                                                                                                                                                                                                                                                                              |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Business scenarios** | Acceleration across regions                                                                                                                                                                                                                                                | Global acceleration                                                                                                                                                                                                                                                                                |
| **Core capabilities**  | Establish a high-speed network connection between the acceleration area (user area) and the origin area (server area) to effectively avoid network problems such as packet loss, connection failure, slow transmission   speed, and improve network quality and stability. | Provide high-speed network services for users in any country or region around the world, effectively solve network problems such as packet loss due to network congestion, poor last-mile quality, connection failure,   slow transmission speed, and comprehensively improve the user experience. |
| **Access method**      | The client app connects to the acceleration point IP. You need to complete the proximity entry scheduling of the client to the acceleration point IP address.                                                                                                              | The client app integrates the client SDK. The SDK automatically completes the proximity entry scheduling of the client to the acceleration point IP address.                                                                                                                                       |

### SDK Acceleration Mode

SDK acceleration mode provides high-quality transmission channels for end-to-cloud collaboration. You need to do the following to implement end-to-cloud acceleration through the SDK acceleration mode:

- The app client integrates the SDK.
- The SDK automatically completes the access scheduling from the client to the IP address of the acceleration point.

![](https://web-cdn.agora.io/docs-files/1652962045479)

### IPA Acceleration Mode

IPA acceleration mode provides point-to-point high-quality acceleration channels. You need to perform the following operations to achieve point-to-point acceleration through IPA acceleration mode:

- The app client connects to the acceleration IP.
- You need to complete the proximity inbound scheduling from the client to the acceleration IP address. In IPA acceleration mode, Agora does not provide domain name resolution, scheduling, or detection services.

![](https://web-cdn.agora.io/docs-files/1652962039067)


### Advantages

FPA has the following advantages:

- **QoS Guarantee**: The 200 ms packet arrival rate exceeds 99.9%, improving end-user access performance by 100% on average.
- **Full path**: FPA provides end-to-cloud acceleration to provide better overall acceleration performance and stability.
- **High availability**: Through redundant resources and network-wide intelligent scheduling algorithms, FPA does not rely on a single physical resource and eliminates availability issues caused by physical line failures.
- **Global coverage**: Covering more than 200 countries and regions, FPA can provide users with stable and high-speed network services anytime, anywhere.