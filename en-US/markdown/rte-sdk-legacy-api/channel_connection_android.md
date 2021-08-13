# Channel Connection

During a real-time engagement session, the connection state between an app client and Agora SD-RTN<sup>TM</sup> changes as the client joins and leaves an Agora channel, or go offline due to network or authentication reasons. 

This page includes introductions to the various connection states and how they change, as well as the reasons behind these changes.

## Understand the tech

The Agora SDK provides an `onConnectionStateChanged` callback that occurs everytime the connection state changes. The following diagram illustrates the various states and how the states change:

