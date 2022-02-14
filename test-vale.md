Test vale linter configurations.

## Legal characters

Chinese characters：。；，‘“

Valid characters: ",.?-\_™

。。。。。。。，，，，，“！

## Spelling

Typo: teh is a typo.
[if it rains, i will not go]

Agora should be OK.

Try spelling error niiiiice, laaunch

## MDITA

The [sdk-name] enables you to develop rapidly to enhance your social, work, education, and IoT apps with real-time engagements.

This page shows the minimum code you need to add [feature] into your app by using the [sdk-name] for [platform].

[this](somelink)

<p conref="conref/integrate-the-sdk-apple.dita#integrate-the-sdk/cocoapods"></p>

You need to use different integration methods to integrate different versions of the SDK.

1. According to your requirements, choose one of the following methods to copy the `AgoraRtcKit.framework`, `Agorafdkaac.framework`, <ph props="video live lives">`Agoraffmpeg.framework`, </ph>and `AgoraSoundTouch.framework` dynamic libraries to the `./project_name` folder in your project (`project_name` is an example of your project name):

<ul>
<li>If you do not need to use a simulator to run the project, copy the above dynamic libraries under the path of <code>./libs</code> in the SDK package.</li>
<li>If you need to use a simulator to run the project, copy the above dynamic libraries under the path of <code>./libs/ALL_ARCHITECTURE</code> in the SDK package. The dynamic libraries under this path contains the x86-64 architecture, you need to remove the x86-64 architecture in the libraries before uploading the app to the App Store.
In Terminal, run the following command to remove the x86-64 architecture. Remember to replace <code>ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit</code> with the path of the dynamic library in your project.
<pre>lipo -remove x86-64 ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit -output ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit</pre>
</li>
</ul>

## Ignore customized fragments and variables

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

$$
98945f90-0bcb-11ec-8e65-856920855d60
{
"sdk":"voice"
}
$$

<% if (platform == "Android" || platform == "iOS" || platform == "macOS" || platform == "Windows") { %>

-   When setting the source channel information, ensure that you set `uid` as 0, and the `uid` that you use to generate the token should also be set as 0.<% } %>

## Style check

It's a contraction.

Agora's voice sdk
if it rains, i will not go
this callback will be triggered
