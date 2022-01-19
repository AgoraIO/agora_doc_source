# See also

This section provides additional information for your reference:

<section id="audience-event" props="live lives">
<title>Listening for audience events</title>
<p>The <ph keyref="sdk-name"></ph> does not report events of an audience member in a live streaming channel. Refer to <xref href="https://docs.agora.io/en/Interactive%20Broadcast/faq/audience_event" scope="external" format="html">How can I listen for an audience joining or leaving an interactive live streaming channel</xref> if your scenario requires so.</p>
</section>

## Sample project

Agora provides an open source sample project <xref keyref="start-sample-project-ios" props="ios"></xref><xref keyref="start-sample-project-mac" props="mac"></xref> on GitHub that implements [feature] for your reference.

## Other approaches to integrate the SDK {#othermethods}

In addition to integrating the [sdk-name] for <ph keyref="recommended-method"></ph>, you can also import the SDK into your project
<ph props="ios">through CocoaPods or </ph>by manually copying the SDK files.

<b props="ios">Automatically integrate the SDK with CocoaPods</b>

<p props="ios" conref="conref/integrate-the-sdk-apple.dita#integrate-the-sdk/cocoapods"></p>

<b>Manually copy the SDK files</b>

1. Go to <xref keyref="downloads">SDK Downloads</ph>, download the latest version of the [sdk-name], and extract the files from the downloaded SDK package.

2. From the `libs` folder of the downloaded SDK package, copy the files or subfolders you need to the root of your project folder.

    <note type="attention">Certain files and subfolders under the <code>libs</code> folder are optional. See <xref href="https://docs.agora.io/en/Voice/faq/reduce_app_size_rtc?platform=iOS#extension_libraries" scope="external" format="html">extension libraries</xref> for details.</note>

3. In Xcode, [link your target to the frameworks or libraries](https://help.apple.com/xcode/mac/current/#/dev51a648b07) you have copied. Be sure to choose **Embed & Sign** from the pop-up menu in the Embed column.

 <note type="attention">
 <ul>
 <li>Apple does not allow an app extension to contain any dynamic library. If you are integrating the Agora SDK to an app extension, choose <b>Do Not Embed</b> in the Embed column.</li>
 <li>The Agora SDK uses libc++ (LLVM) by default. Contact <xref href="mailto:support@agora.io">support@agora.io</xref> if you want to use libstdc++ (GNU). The SDK provides FAT image libraries with multi-architecture support for both 32/64-bit audio emulators and 32/64-bit audio and video real devices.</li>
 </ul>
 </note>

## Objective-C code sample

To implement [product-name] in your app using Objective-C:

1. Replace the contents in the `ViewController.h` file with the following:

 <p conref="conref/get-started-sample-code-apple.dita#get-started-sample-code/oc-1"/>

2. Replace the contents in the `ViewController.m` file with the following:

 <p conref="conref/get-started-sample-code-apple.dita#get-started-sample-code/oc-2"/>
