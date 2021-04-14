---
title: TCP
platform: All Platforms
updatedAt: 2020-09-30 16:30:22
---
TCP (Transmission Control Protocol) is a connection-oriented and reliable transport layer communication protocol.

Connection-oriented means that a connection must be established between the sender and the receiver before data transmission. TCP uses a three-way handshake to establish a connection:

- The first handshake: The sender sends a connection request to the receiver.
- The second handshake: The receiver accepts the request and sends a response to the sender.
- The third handshake: The sender receives the response and sends an acknowledgment to the receiver.

After sending the connection request, if the sender does not receive any response, it keeps sending the request instead of directly sending data.

To ensure reliable transmission, TCP uses a sequence number to identify each data packet. The receiver sends an acknowledgement (ACK) after receiving a data packet successfully. If the sender does not receive the ACK after a reasonable round-trip time (RTT), the packet is resent.

TCP only supports connections between two endpoints. It does not support one-to-many or many-to-many connections. 

TCP is best suited for scenarios that require data integrity more than real-time connection, such as transferring files. Agora Real-time Messaging mainly uses TCP.

<div class="alert info">See also: <a href="./udp">UDP</a>
</div>