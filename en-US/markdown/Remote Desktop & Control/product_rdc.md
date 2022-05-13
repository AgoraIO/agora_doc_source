# Agora Remote Desktop & Control Overview

Agora Remote Desktop & Control (RDC) enables a speedy and secure cross-platform remote desktop sharing and message control service that supports remote access, remote support, and remote management to any devices, anytime and anywhere.

## Understand the tech

The Agora RDC SDK works with the [Agora Real-time Communication (RTC) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=Electron) and [Agora Real-time Messaging (RTM) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=Android) to enable the remote control service.

The following figure shows how these three SDKs work together:

![](https://web-cdn.agora.io/docs-files/1652409218831)

## Features

The Agora RDC service boasts the following features:

### One-to-many remote control

Each host side can enable secure access to multiple controlled sides simultaneously. The host side can operate the controlled sides by either using its own mouse and keyboard, or calling API methods. The host side can perform multiple operations, for example, set the environment variables, configure the network connections, install softwares, create files, and debug codes.

### Cross-device drag-and-drop

The Agora RDC service supports file transfer across different devices and platforms. The seamless drag-and-drop feature enables you to drag a file from a host side and drop it on controlled sides.

### Cross-device copy-and-paste

The Agora RDC service supports copying and pasting across different devices and platforms. The seamless copy-and-paste feature enables you to copy texts from a host side and paste them on the notebooks, documents, or code editors of controlled sides.

### Web page recording

You can use the Agora RDC service with [Agora Web Page Recording](https://docs.agora.io/en/cloud-recording/cloud_recording_webpage_mode?platform=RESTful) to capture screens during remote access, so that you can reproduce scenarios afterwards.

### Interactive whiteboard

You can use the Agora RDC service with [Agora Interactive Whiteboard](https://docs.agora.io/en/whiteboard/product_whiteboard?platform=Android). Interactive Whiteboard provides versatile editing tools for drawing, writing, and marking on canvas. You can use them to visualize your ideas and enhance the collaborations during online education, online meetings, and other scenarios.

### Cross-platform compatibility

The Agora RDC service allows for cross-platform connections. The following table lists the supported platforms and versions:
- Windows 7 or later  
  The Windows SDK supports the following architecture:
    - x86
    - x86-64
- Android 4.1 or later
- macOS 10.15 or later
- Electron 1.8.3 or later

## Scenarios

The Agora RDC service fits the following scenarios:

### Online education

In scenarios such as an online course in programming or design, the Agora RDC service enables a teacher to access and operate the devices of students.

Besides, in tandem with the Agora Interactive Whiteboard and the Agora RTC service, the Agora RDC service allows for face-to-face communications and hands-on instruction in order to better simulate a physical classroom.

### Online technical support

In scenarios such as remote technical support and online conferencing, the Agora RDC service enables a technical support specialist to access and operate the devices of customers. This service allows technical support specialists to help customers by troubleshooting and dealing with complex technical issues remotely.

### Remote work

In scenarios such as remote work and IT operations, the Agora RDC service enables employees to access their office computers anytime and anywhere. Employees can access the company intranet without VPNs and complete their work remotely.

This supports a flexible work style that not only ensures the continuity of online business but also increases work efficiency.

### IoT device management

IoT is widely used in families, business, and healthcare. In such scenarios, the Agora RDC service enables remote control among IoT devices, which simplifies the monitoring and management process.

## Advantages

The Agora RDC service holds the following advantages:

### Stability and reliability

The Agora RDC service functions based on Agora Software Defined Real-time Network (SD-RTN™), which covers more than 200 countries and regions around the world. With excellent resilience to packet loss and congestion control algorithms, the Agora RDC service ensures 99.9% uptime.

### Low latency and high quality

With the engine and algorithms developed by Agora, the Agora RDC service can reduce transmission of redundant data and deliver latency as low as 300 ms while occupying less bandwidth.

Besides, the Agora RDC service provides a smooth real-time communication experience with 1080p resolution and a frame rate of 10 to 60 fps. To achieve the optimal video quality, the Agora RDC service supports resolutions up to 4k.

### User friendliness

With the easy-to-use Agora RDC SDK, you can implement the remote control feature through simple API calling. More than that, in conjunction with the Agora RTC and RTM services, the Agora RDC provides unified service that eases your effort to build real-time communication scenarios.

### Security and compliance

The Agora RDC service provides multiple security protection guarantees, including channel separation, data and transmission encryption in AES-128 mode, and token authentication. Agora also adheres to GDPR, HIPAA, CCPA, COPPA, and other compliance requirements and privacy laws of many different countries, in addition to being certified to ISO/IEC 27001, 27017, 27018, and 27701.

## Pricing

Fees are incurred by the Agora RTC and RTM services that you use along with the Agora RDC service. For details, see [Pricing for RTC](https://docs.agora.io/en/Interactive%20Broadcast/billing_rtc?platform=Android) and [Pricing for RTM](https://docs.agora.io/en/Real-time-Messaging/billing_rtm?platform=Android).
