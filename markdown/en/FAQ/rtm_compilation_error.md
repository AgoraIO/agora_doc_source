---
title: Why do errors occur when compiling the Agora RTM Linux Java SDK?
platform: ["Linux"]
updatedAt: 2020-05-09 18:15:11
Products: ["Real-time-Messaging"]
---
## Problem

The following error occurs when compiling the Agora RTM Linux Java SDK in Linux:

```shell
Exception in thread “main” java.lang.UnsatisfiedLinkError:no agora_rtm_sdk in java.library.path
```

## Reason

The `agora_rtm_sdk` library is not included in the environment variable.

## Solution

You can use one of the following solutions to solve this problem. For either solution, you must replace `<path>` with the absolute path to the RTM Linux Java SDK.

### Update environment variables

Add the following line to any file that configures Linux environment variables, such as `~/.bashrc`, `~/bash_profile`, or `/etc/profile`.

```shell
export LD_LIBRARY_PATH=<path>/agora/rtm/sdk:$LD_LIBRARY_PATH
```

### Update Java command line arguments

You can launch Java with the `Djava.library.path` argument to add the absolute path to the RTM Linux Java SDK to the library path:

```shell
java -Djava.library.path=<path>/agora/rtm/sdk
```