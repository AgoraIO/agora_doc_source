---
title: Security Best Practices
platform: All Platforms
updatedAt: 2021-02-26 00:35:38
---
Security and compliance are essential for real-time engagements through technology. In order to provide safe and reliable cloud services, Agora adheres to the compliance requirements of different countries, regions, and industries, in addition to being certified to ISO/IEC 27001. For more information, see [ISO Certificates](iso_cert).

Agora products and services are designed and built with multiple protection measures against attacks commonly seen in the real-time engagement industry. This article describes some of the security best practices that Agora has adopted, as well as security tools it provides for developers, as follows:

| Protection measures | Applied by default | Recommended scenarios |
| ---------------- | ---------------- | ---------------- |
| Project isolation      | Yes      | All real-time scenarios.      |
| Channel independence | Yes | All real-time scenarios. |
| End-user authentication | No | All real-time apps in a production environment should use token-based end-user authentication. |
| Encryption | No | Real-time scenarios that require confidentiality. |
| Network geofencing | No | Real-time scenarios where customers wish to restrict access to Agora servers to within a specified region. |

<a name="project"></a>
## Project isolation

Before using any Agora SDK or service, customers need to create a project in [Agora Console](https://console.agora.io/). Agora assigns an App ID for each project as its identifier. Projects with different App IDs are kept from each other and cannot communicate with each other.

## Channel independence

Agora creates an independent and isolated channel for each audio, video, or messaging data transmission. With a fixed App ID, only users in the same channel can access and interact with this data.

## End-user authentication

Agora provides the following two approaches for end-user authentication:

- A basic method that relies on App IDs, as described in [Project isolation](#project).
- A token-based approach that uses the App ID and App Certificate to generate dynamic tokens on a customer's app server.

The security of these tokens is guaranteed through the following means:

- Tokens use the industry-standard HMAC-SHA256 encryption algorithm to encrypt the App ID and channel name, which prevents the information from being leaked.
- Agora supports customizing the time that a token remains valid. Once generated, a token is valid for 24 hours by default. Customers are encouraged to customize this duration according the needs of their particular usage scenarios.
- Agora also supports customizing the service permissions and privileges for tokens.

For how to generate a token and relevant considerations, see [Generate a Token](token_server).

## Encryption

For scenarios that require confidentiality, Agora supports transmission encryption and data encryption.

### Transmission encryption

To guarantee data confidentiality during transmission, Agora uses a transmission encryption mechanism that covers the entire data link and is based on industry-standard encryption algorithms. For example:

- The RTC Native SDK and RTM Native SDK use the TLS (Transport Layer Security) encryption protocol.
- The RTC Web SDK and the RTM Web SDK use the SSL (Secure Sockets Layer) encryption protocol.

### Data encryption

The following diagrams show how encrypted data is transferred for the RTC SDK:

- The Native SDK

![](https://web-cdn.agora.io/docs-files/1613296081033)

- The Web SDK

![](https://web-cdn.agora.io/docs-files/1607583291443)

#### Built-in encryption

The Agora RTC SDK provides multiple built-in encryption algorithms for customers to encrypt the transmitted audio and video data from end to end. Audio and video data is encrypted on the sending device, transmitted as ciphertext, and decrypted on the receiving device. Therefore, customers retain sole management of how encryption keys are generated, stored, transmitted, and verified. Apart from scenarios involving the WebRTC service, Agora has no access to the encryption key or the encryption method.

When the WebRTC service is used, Agora decrypts and transmits data on the server. Here, Agora implements a secure mechanism for encryption key transmission and usage to prevent the keys from being leaked.

#### Customized encryption

Customers using the Agora RTC Native SDK can implement the customized encryption function. Once this function is enabled, the SDK sends audio and video data to the app through callbacks after encoding and before decoding the data. The app then uses a customized encryption algorithm to encrypt or decrypt the data. Under such circumstances, Agora has no access to any encryption information.

Refer to the following guides for descriptions of how to enable built-in and customized encryption:

- [Android](https://docs.agora.io/en/Interactive%20Broadcast/channel_encryption_android?platform=Android)
- [iOS](https://docs.agora.io/en/Interactive%20Broadcast/channel_encryption_apple?platform=iOS)
- [macOS](https://docs.agora.io/en/Interactive%20Broadcast/channel_encryption_apple?platform=macOS)
- [Windows](https://docs.agora.io/en/Interactive%20Broadcast/channel_encryption_windows?platform=Windows)
- [Web](https://docs.agora.io/en/Interactive%20Broadcast/channel_encryption_web_ng?platform=Web)

## Network geofencing

To conform to the laws and regulations of different countries and regions, the Agora RTC SDK and the RTM SDK support network geofencing, which limits the transmission of data to within a specified region.

These SDKs support network geofencing in the following regions: global (default), North America, Europe, Asia (excluding Mainland China), Japan, India, and Mainland China. Once a customer specifies a region using geofencing, no audio, video, or message can access Agora servers outside that region.

Refer to the following guides for descriptions of how to use network geofencing:

- The RTC SDK:
	- [Android](https://docs.agora.io/en/Interactive%20Broadcast/region_java_rtc?platform=Android)
	- [iOS](https://docs.agora.io/en/Interactive%20Broadcast/region_oc_rtc?platform=iOS)
	- [macOS](https://docs.agora.io/en/Interactive%20Broadcast/region_oc_rtc?platform=macOS)
	- [Windows](https://docs.agora.io/en/Interactive%20Broadcast/region_cpp_rtc?platform=Windows)
	- [Web](https://docs.agora.io/en/Interactive%20Broadcast/region_web_rtc?platform=Web)
- The RTM SDK:
  - [Android](https://docs.agora.io/en/Real-time-Messaging/region_java_rtm?platform=Android)
  - [iOS](https://docs.agora.io/en/Real-time-Messaging/region_oc_rtm?platform=iOS)
  - [macOS](https://docs.agora.io/en/Real-time-Messaging/region_oc_rtm?platform=macOS)
  - [Windows](https://docs.agora.io/en/Real-time-Messaging/region_cpp_rtm?platform=Windows)
  - [Web](https://docs.agora.io/en/Real-time-Messaging/region_web_rtm?platform=Web)
  - [Linux C++](https://docs.agora.io/en/Real-time-Messaging/region_cpp_rtm?platform=Linux)
  - [Linux Java](https://docs.agora.io/en/Real-time-Messaging/region_java_linux_rtm?platform=Linux)