# Agora Remote Desktop & Control Overview

Agora Remote Desktop & Control (RDC) enables a speedy and secure cross-platform remote desktop sharing and command control service, which supports remote access, support, and management to any devices, anytime, and anywhere.

## Understand the tech

The Agora RDC SDK combines the [Agora Real-time Communication (RTC) SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=Electron) and [Agora Real-time Messaging (RTM) SDK](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=Android) to build the remote control service.

The following figure shows how the three SDKs work together:
<img src="https://web-cdn.agora.io/docs-files/1651725244136" style="zoom:40%" />

## Features

The Agora RDC service boasts the following features:

### One-to-many remote control

Each master device can enable secure access to multiple slave devices simultaneously. The master device can either use its own mouse and keyboard or call API methods, to perform operations on the slave devices. For example, set the environment variables, configure the network connections, install softwares, create files, and debug codes.

### Cross-device drag-and-drop

The Agora RDC service supports file transfer across different devices and platforms. The seamless drag-and-drop feature enables you to drag a file from a master device and drop it on slave devices.

### Cross-device copy-and-paste

The Agora RDC service supports copypaste across different devices and platforms. The seamless copy-and-paste feature enables you to copy texts from a master device and paste them on the notebooks, documents, or code editors of slave devices.

### Webpage recording

You can integrate the Agora RDC service with [Agora Web Page Recording](https://docs.agora.io/en/cloud-recording/cloud_recording_webpage_mode?platform=RESTful) to capture screens during remote access, so that reproduce scenarios afterwards.

### Interactive whiteboard

You can integrate the Agora RDC service with [Agora Interactive Whiteboard](https://docs.agora.io/en/whiteboard/product_whiteboard?platform=Android). Interactive Whiteboard provides versatile editing tools for drawing, writing, and marking on canvas. You can use them to visualize your ideas to enhance the collaborations during online education, online meetings, and other scenarios.

### Cross-platform compatibility

Agora RDC allows for cross-platform connections. The following table lists the supported platforms and their versions:

| Platform     | Supported Version                                      |
| :------- | :-------------------------------------------- |
| Windows  | ≥ Windows 7<br>The Windows SDK supports the following architecture:<li>x86<li>x86-64 |
| Android | ≥ 4.1                         |
| macOS | ≥ 10.15                         |
| Electron | ≥ Electron 1.8.3                         |

## Scenarios

The Agora RDC service fits the following scenarios:

### Online education

In scenarios such an online programming course and online design course, the Agora RDC service enables a teacher to access and operate the devices of students.

Besides, with the Agora Interactive Whiteboard and the Agora RTC service, the Agora RDC service allows for face-to-face communications and hand-by-hand tuitions that simulate a real classroom environment.

### Online technical support

In scenarios such as remote technical supports and online conferences, the Agora RDC service enables a technical support specialist to access and operate the devices of customers. This service allows the technical support to help the customers by troubleshooting and dealing with complex technical issues remotely.

### Remote work

In scenarios such as remote work and IT operations, the Agora RDC service enables employees to access their office computers anytime and anywhere. Employees can access the company intranet without VPNs and complete their work remotely.

This flexible working pattern not only ensures the continuity of online business but also achieves higher work efficiency.

### IoT device management

IoT is widely used in families, business, and healthcare. In such scenarios, the Agora RDC services enables remote control among IoT devices, which simplifies the monitoring and management process.

## Advantages

The Agora RDC service holds the following advantages:

### Stability and reliability

The Agora RDC service functions based on Agora Software Defined Real-time Network (SD-RTN™), which covers more than 200 countries and regions around the world. Besides, with excellent resilience to packet loss and congestion control algorithm, the Agora RDC service ensures 99.9% uptime throughout the year.

### Low latency and high quality

With the engine and algorithms developed by Agora, the Agora RDC service can reduce transmission of redundant data and deliver latency as low as 300 ms, enabling smooth real-time communication that uses less bandwidth.

The Agora RDC service provides smooth experience with 1080p resolution rate and 10-60 frame rate. To achieve the optimal video quality, the Agora RDC service supports resolution up to 4k.

### User friendliness

With the easy-to-use Agora RDC SDK, you can implement the remote control feature through simple API calling. Besides, with the Agora RTC service and Agora RTM service

The Agora RDC provides one-stop service that allows you to build a real-time interactive scenarios.

### Security and compliance

The Agora RDC service provides multiple security protection guarantees, which include chanel separation, data and transmission encryption in AES-128 mode, and token authentication. Besides, Agora adheres to GDPR, HIPAA, CCPA, COPPA, and other compliance requirements and privacy laws of different countries, in addition to being certified to ISO/IEC 27001, 27017, 27018, 27701.

## Pricing

Fees are incurred by the Agora RTC service and Agora RTM service that you use along with the Agora RDC service. For details, see [Pricing for RTC](https://docs.agora.io/en/Interactive%20Broadcast/billing_rtc?platform=Android) and [Pricing for RTM](https://docs.agora.io/en/Real-time-Messaging/billing_rtm?platform=Android).