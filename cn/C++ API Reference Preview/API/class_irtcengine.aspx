
<!DOCTYPE html
  SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:whc="http://www.oxygenxml.com/webhelp/components" xml:lang="zh-cn" lang="zh-cn" whc:version="22.0">
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta charset="UTF-8" /><meta name="copyright" content="(C) 版权 2021" /><meta name="DC.rights.owner" content="(C) 版权 2021" /><meta name="DC.type" content="reference" /><meta name="description" content="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。" /><meta name="DC.subject" content="IRtcEngine, joinChannelWithUserAccount, createAgoraRtcEngine, initialize, release, setChannelProfile, joinChannel, switchChannel, setClientRole, leaveChannel, renewToken, getConnectionState, enableWebSdkInteroperability, enableAudio, disableAudio, setAudioProfile, setHighQualityAudioParameters, adjustRecordingSignalVolume, adjustUserPlaybackSignalVolume, adjustPlaybackSignalVolume, enableLocalAudio, muteLocalAudioStream, muteRemoteAudioStream, muteAllRemoteAudioStreams, setDefaultMuteAllRemoteAudioStreams, enableVideo, disableVideo, setVideoProfile, setVideoEncoderConfiguration, setupLocalVideo, setupRemoteVideo, setLocalRenderMode, setRemoteRenderMode, startPreview, stopPreview, enableLocalVideo, muteLocalVideoStream, muteRemoteVideoStream, muteAllRemoteVideoStreams, setDefaultMuteAllRemoteVideoStreams, setBeautyEffectOptions, IRtcEngine2, createChannel, startScreenCapture, startScreenCaptureByDisplayId, startScreenCaptureByScreenRect, startScreenCaptureByWindowId, setScreenCaptureContentHint, updateScreenCaptureParameters, updateScreenCaptureRegion, stopScreenCapture, startAudioMixing, stopAudioMixing, pauseAudioMixing, resumeAudioMixing, adjustAudioMixingVolume, adjustAudioMixingPlayoutVolume, adjustAudioMixingPublishVolume, setAudioMixingPitch, getAudioMixingPlayoutVolume, getAudioMixingPublishVolume, getAudioMixingDuration, getAudioMixingCurrentPosition, setAudioMixingPosition, getEffectsVolume, setEffectsVolume, setVolumeOfEffect, playEffect, stopEffect, stopAllEffects, preloadEffect, unloadEffect, pauseEffect, pauseAllEffects, resumeEffect, resumeAllEffects, setLocalVoiceChanger, setLocalVoiceReverbPreset, setLocalVoicePitch, setLocalVoiceEqualization, setLocalVoiceReverb, setVoiceBeautifierPreset, setVoiceBeautifierParameters, setAudioEffectPreset, setAudioEffectParameters, enableSoundPositionIndication, setRemoteVoicePosition, setLiveTranscoding, addPublishStreamUrl, removePublishStreamUrl, startChannelMediaRelay, updateChannelMediaRelay, stopChannelMediaRelay, enableAudioVolumeIndication, enableFaceDetection, setDefaultAudioRouteToSpeakerphone, setEnableSpeakerphone, isSpeakerphoneEnabled, enableInEarMonitoring, setInEarMonitoringVolume, enableDualStreamMode, setRemoteVideoStreamType, setRemoteDefaultVideoStreamType, setLocalPublishFallbackOption, setRemoteSubscribeFallbackOption, setRemoteUserPriority, startEchoTest, stopEchoTest, enableLastmileTest, disableLastmileTest, startLastmileProbeTest, stopLastmileProbeTest, setVideoSource, setExternalAudioSource, setExternalAudioSink, setRecordingAudioFrameParameters, setPlaybackAudioFrameParameters, setMixedAudioFrameParameters, registerMediaMetadataObserver, addVideoWatermark, clearVideoWatermarks, enableEncryption, setEncryptionMode, setEncryptionSecret, registerPacketObserver, startAudioRecording, stopAudioRecording, addInjectStreamUrl, removeInjectStreamUrl, switchCamera, createDataStream, sendStreamMessage, enableLoopbackRecording, setAudioSessionOperationRestriction, setLocalVideoMirrorMode, setCameraCapturerConfiguration, setLogFile, setLogFilter, setLogFileSize, uploadLogFile, getCallId, rate, complain, getVersion, getErrorDescription, queryInterface, setCloudProxy, enableDeepLearningDenoise, sendCustomReportMessage" /><meta name="keywords" content="IRtcEngine, joinChannelWithUserAccount, createAgoraRtcEngine, initialize, release, setChannelProfile, joinChannel, switchChannel, setClientRole, leaveChannel, renewToken, getConnectionState, enableWebSdkInteroperability, enableAudio, disableAudio, setAudioProfile, setHighQualityAudioParameters, adjustRecordingSignalVolume, adjustUserPlaybackSignalVolume, adjustPlaybackSignalVolume, enableLocalAudio, muteLocalAudioStream, muteRemoteAudioStream, muteAllRemoteAudioStreams, setDefaultMuteAllRemoteAudioStreams, enableVideo, disableVideo, setVideoProfile, setVideoEncoderConfiguration, setupLocalVideo, setupRemoteVideo, setLocalRenderMode, setRemoteRenderMode, startPreview, stopPreview, enableLocalVideo, muteLocalVideoStream, muteRemoteVideoStream, muteAllRemoteVideoStreams, setDefaultMuteAllRemoteVideoStreams, setBeautyEffectOptions, IRtcEngine2, createChannel, startScreenCapture, startScreenCaptureByDisplayId, startScreenCaptureByScreenRect, startScreenCaptureByWindowId, setScreenCaptureContentHint, updateScreenCaptureParameters, updateScreenCaptureRegion, stopScreenCapture, startAudioMixing, stopAudioMixing, pauseAudioMixing, resumeAudioMixing, adjustAudioMixingVolume, adjustAudioMixingPlayoutVolume, adjustAudioMixingPublishVolume, setAudioMixingPitch, getAudioMixingPlayoutVolume, getAudioMixingPublishVolume, getAudioMixingDuration, getAudioMixingCurrentPosition, setAudioMixingPosition, getEffectsVolume, setEffectsVolume, setVolumeOfEffect, playEffect, stopEffect, stopAllEffects, preloadEffect, unloadEffect, pauseEffect, pauseAllEffects, resumeEffect, resumeAllEffects, setLocalVoiceChanger, setLocalVoiceReverbPreset, setLocalVoicePitch, setLocalVoiceEqualization, setLocalVoiceReverb, setVoiceBeautifierPreset, setVoiceBeautifierParameters, setAudioEffectPreset, setAudioEffectParameters, enableSoundPositionIndication, setRemoteVoicePosition, setLiveTranscoding, addPublishStreamUrl, removePublishStreamUrl, startChannelMediaRelay, updateChannelMediaRelay, stopChannelMediaRelay, enableAudioVolumeIndication, enableFaceDetection, setDefaultAudioRouteToSpeakerphone, setEnableSpeakerphone, isSpeakerphoneEnabled, enableInEarMonitoring, setInEarMonitoringVolume, enableDualStreamMode, setRemoteVideoStreamType, setRemoteDefaultVideoStreamType, setLocalPublishFallbackOption, setRemoteSubscribeFallbackOption, setRemoteUserPriority, startEchoTest, stopEchoTest, enableLastmileTest, disableLastmileTest, startLastmileProbeTest, stopLastmileProbeTest, setVideoSource, setExternalAudioSource, setExternalAudioSink, setRecordingAudioFrameParameters, setPlaybackAudioFrameParameters, setMixedAudioFrameParameters, registerMediaMetadataObserver, addVideoWatermark, clearVideoWatermarks, enableEncryption, setEncryptionMode, setEncryptionSecret, registerPacketObserver, startAudioRecording, stopAudioRecording, addInjectStreamUrl, removeInjectStreamUrl, switchCamera, createDataStream, sendStreamMessage, enableLoopbackRecording, setAudioSessionOperationRestriction, setLocalVideoMirrorMode, setCameraCapturerConfiguration, setLogFile, setLogFilter, setLogFileSize, uploadLogFile, getCallId, rate, complain, getVersion, getErrorDescription, queryInterface, setCloudProxy, enableDeepLearningDenoise, sendCustomReportMessage" /><meta name="indexterms" content="joinChannelWithUserAccount, joinChannelWithUserAccount, createAgoraRtcEngine, initialize, release, setChannelProfile, joinChannel, joinChannel, switchChannel, switchChannel, setClientRole, setClientRole, leaveChannel, renewToken, getConnectionState, enableWebSdkInteroperability, enableAudio, disableAudio, setAudioProfile, setHighQualityAudioParameters, adjustRecordingSignalVolume, adjustUserPlaybackSignalVolume, adjustPlaybackSignalVolume, enableLocalAudio, muteLocalAudioStream, muteRemoteAudioStream, muteAllRemoteAudioStreams, setDefaultMuteAllRemoteAudioStreams, enableVideo, disableVideo, setVideoProfile, setVideoEncoderConfiguration, setupLocalVideo, setupRemoteVideo, setLocalRenderMode, setLocalRenderMode, setRemoteRenderMode, setRemoteRenderMode, startPreview, stopPreview, enableLocalVideo, muteLocalVideoStream, muteRemoteVideoStream, muteAllRemoteVideoStreams, setDefaultMuteAllRemoteVideoStreams, setBeautyEffectOptions, createChannel, startScreenCapture, startScreenCaptureByDisplayId, startScreenCaptureByScreenRect, startScreenCaptureByWindowId, setScreenCaptureContentHint, updateScreenCaptureParameters, updateScreenCaptureRegion, updateScreenCaptureRegion, stopScreenCapture, startAudioMixing, stopAudioMixing, pauseAudioMixing, resumeAudioMixing, adjustAudioMixingVolume, adjustAudioMixingPlayoutVolume, adjustAudioMixingPublishVolume, setAudioMixingPitch, getAudioMixingPlayoutVolume, getAudioMixingPublishVolume, getAudioMixingDuration, getAudioMixingCurrentPosition, setAudioMixingPosition, getEffectsVolume, setEffectsVolume, setVolumeOfEffect, playEffect, stopEffect, stopAllEffects, preloadEffect, unloadEffect, pauseEffect, pauseAllEffects, resumeEffect, resumeAllEffects, setLocalVoiceChanger, setLocalVoiceReverbPreset, setLocalVoicePitch, setLocalVoiceEqualization, setLocalVoiceReverb, setVoiceBeautifierPreset, setVoiceBeautifierParameters, setAudioEffectPreset, setAudioEffectParameters, enableSoundPositionIndication, setRemoteVoicePosition, setLiveTranscoding, addPublishStreamUrl, removePublishStreamUrl, startChannelMediaRelay, updateChannelMediaRelay, stopChannelMediaRelay, enableAudioVolumeIndication, enableFaceDetection, setDefaultAudioRouteToSpeakerphone, setEnableSpeakerphone, isSpeakerphoneEnabled, enableInEarMonitoring, setInEarMonitoringVolume, enableDualStreamMode, setRemoteVideoStreamType, setRemoteDefaultVideoStreamType, setLocalPublishFallbackOption, setRemoteSubscribeFallbackOption, setRemoteUserPriority, startEchoTest, startEchoTest, stopEchoTest, enableLastmileTest, disableLastmileTest, startLastmileProbeTest, stopLastmileProbeTest, setVideoSource, setExternalAudioSource, setExternalAudioSink, setRecordingAudioFrameParameters, setPlaybackAudioFrameParameters, setMixedAudioFrameParameters, registerMediaMetadataObserver, addVideoWatermark, addVideoWatermark, clearVideoWatermarks, enableEncryption, setEncryptionMode, setEncryptionSecret, registerPacketObserver, startAudioRecording, startAudioRecording, stopAudioRecording, addInjectStreamUrl, removeInjectStreamUrl, switchCamera, createDataStream, createDataStream, sendStreamMessage, enableLoopbackRecording, setAudioSessionOperationRestriction, setLocalVideoMirrorMode, setCameraCapturerConfiguration, setLogFile, setLogFilter, setLogFileSize, uploadLogFile, getCallId, rate, complain, getVersion, getErrorDescription, queryInterface, setCloudProxy, enableDeepLearningDenoise, sendCustomReportMessage" /><meta name="DC.format" content="HTML5" /><meta name="DC.identifier" content="class_rtcengine" />        
      <title>IRtcEngine</title><!--  Generated with Oxygen version 23.0, build number 2020121702.  --><meta name="wh-path2root" content="../" /><meta name="wh-toc-id" content="class_rtcengine-d4991e13748" /><meta name="wh-source-relpath" content="API/class_irtcengine.dita" /><meta name="wh-out-relpath" content="API/class_irtcengine.aspx" />
    <!-- Latest compiled and minified Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../oxygen-webhelp/lib/bootstrap/css/bootstrap.min.css" />
    
    <link rel="stylesheet" href="../oxygen-webhelp/lib/jquery-ui/jquery-ui.min.css" />
    
    <!-- Template default styles  -->
    <link rel="stylesheet" type="text/css" href="../oxygen-webhelp/app/topic-page.css?buildId=2020121702" />
    
    
    <script type="text/javascript" src="../oxygen-webhelp/lib/jquery/jquery-3.5.1.min.js"><!----></script>
    
    <script data-main="../oxygen-webhelp/app/topic-page.js" src="../oxygen-webhelp/lib/requirejs/require.js"></script>
<link rel="stylesheet" type="text/css" href="../oxygen-webhelp/template/cobalt.css?buildId=2020121702" /></head>

    <body class="wh_topic_page frmBody">
        <a href="#wh_topic_body" class="sr-only sr-only-focusable">跳转到主要内容</a>
        <!-- EXM-36950 - Expand the args.hdr parameter here -->
        
        
        
        <header class="navbar navbar-default wh_header" whc:version="23.0">
    <div class="container-fluid">
        <div class="wh_header_flex_container navbar-nav navbar-expand-md navbar-dark">
   <div class="wh_logo_and_publication_title_container">
       <div class="wh_logo_and_publication_title">
  
  <!--
 This component will be generated when the next parameters are specified in the transformation scenario:
 'webhelp.logo.image' and 'webhelp.logo.image.target.url'.
 See: http://oxygenxml.com/doc/versions/17.1/ug-editor/#topics/dita_webhelp_output.html.
  -->
  
  <div class=" wh_publication_title "></div>
  
       </div>
       
       <!-- The menu button for mobile devices is copied in the output only when the 'webhelp.show.top.menu' parameter is set to 'yes' -->
       <button type="button" data-target="#wh_top_menu_and_indexterms_link" id="wh_menu_mobile_button" data-toggle="collapse" class="navbar-toggler collapsed wh_toggle_button" aria-expanded="false" aria-label="切换菜单" aria-controls="wh_top_menu_and_indexterms_link">
  <span class="navbar-toggler-icon"></span>
       </button>
   </div>

   <div class="wh_top_menu_and_indexterms_link collapse navbar-collapse" id="wh_top_menu_and_indexterms_link">
       
       <nav class=" wh_top_menu " aria-label="Menu Container"><ul xmlns:xhtml="http://www.w3.org/1999/xhtml" role="menubar" aria-label="Menu"><li role="menuitem" aria-haspopup="true" aria-expanded="false" class="has-children"><span id="tocId-d4991e13735-mi" data-tocid="tocId-d4991e13735" data-state="not-ready" class=" topicref "><span class="title"><a href="../API/rtc_api_overview.aspx">C++ API Reference for All Platforms</a></span></span></li></ul></nav>
       <div class=" wh_indexterms_link "><a href="../indexTerms.aspx" title="索引" aria-label="转到索引术语页"><span>索引</span></a></div>
       
   </div>
        </div>
    </div>
</header>
        
        <div class=" wh_search_input "><form id="searchForm" method="get" role="search" action="../search.aspx"><div><input type="search" placeholder="搜索 " class="wh_search_textfield" id="textToSearch" name="searchQuery" aria-label="搜索查询" required="required" /><button type="submit" class="wh_search_button" aria-label="搜索"><span class="search_input_text">搜索</span></button></div></form></div>
        
        <div class="container-fluid" id="wh_topic_container">
   <div class="row">

       <nav class="wh_tools d-print-none navbar-expand-md" aria-label="Tools">
  <div data-tooltip-position="bottom" class=" wh_breadcrumb "><ol xmlns:html="http://www.w3.org/1999/xhtml" class="d-print-none"><li><span class="home"><a href="../index.aspx"><span>主页</span></a></span></li><li><span class="topicref"><span class="title"><a href="../API/rtc_api_overview.aspx">C++ API Reference for All Platforms</a></span></span></li><li class="active"><span class="topicref" data-id="class_rtcengine"><span class="title"><a href="../API/class_irtcengine.aspx#class_rtcengine"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengine.html#class_rtcengine"><span class="ph">IRtcEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。</span></p></span></span></span></li></ol></div>

  <div class="wh_right_tools">
      <button class="wh_hide_highlight" aria-label="切换搜索突出显示" title="切换搜索突出显示"></button>
      <button class="webhelp_expand_collapse_sections" data-next-state="collapsed" aria-label="折叠截面" title="折叠截面"></button>
      <div class=" wh_navigation_links "><span id="topic_navigation_links" class="navheader"></span></div>
      <div class=" wh_print_link print d-none d-md-inline-block "><button onClick="window.print()" title="打印此页" aria-label="打印此页"></button></div>
      
      <!-- Expand/Collapse publishing TOC 
  The menu button for mobile devices is copied in the output only when the publication TOC is available
      -->
      <button type="button" data-target="#wh_publication_toc" id="wh_toc_button" data-toggle="collapse" class="custom-toggler navbar-toggler collapsed wh_toggle_button navbar-light" aria-expanded="false" aria-label="Toggle publishing table of content" aria-controls="wh_publication_toc">
 <span class="navbar-toggler-icon"></span>
      </button>
  </div>
       </nav>
   </div>

   <div class="wh_content_area">
       <div class="row">
  
      <nav id="wh_publication_toc" class="collapse col-lg-3 col-md-3 col-sm-12 d-md-block d-print-none" aria-label="Table of Contents Container">
 <div class=" wh_publication_toc " data-tooltip-position="right"><ul role="tree" aria-label="Table of Contents"><span class="expand-button-action-labels"><span id="button-expand-action" aria-label="Expand"></span><span id="button-collapse-action" aria-label="Collapse"></span><span id="button-pending-action" aria-label="Pending"></span></span><li role="treeitem" aria-expanded="true"><span data-tocid="tocId-d4991e13735" class="topicref" data-state="expanded"><span role="button" tabindex="0" aria-labelledby="button-collapse-action tocId-d4991e13735-link" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="tocId-d4991e13735-link">C++ API Reference for All Platforms</a></span></span><ul role="group" class="navbar-nav nav-list"><li role="treeitem"><span data-tocid="api-title-d4991e13736" class="topicref" data-id="api-title" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="api-title-d4991e13736-link">API Overview</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">声网通过全球部署的虚拟网络，提供可以灵活搭配的 API 组合，提供质量可靠的实时音视频通信。</span></p></span></span></span></li><li role="treeitem" class="active"><span data-tocid="class_rtcengine-d4991e13748" class="topicref" data-id="class_rtcengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengine.aspx#class_rtcengine" id="class_rtcengine-d4991e13748-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengine.html#class_rtcengine"><span class="ph">IRtcEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichannel-d4991e15906" class="topicref" data-id="class_ichannel" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichannel.aspx#class_ichannel" id="class_ichannel-d4991e15906-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichannel.html#class_ichannel"><span class="ph">IChannel</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">调用 <a href="../API/class_irtcengine.html#api_createChannel" class="xref"><span class="keyword">createChannel</span></a> 创建一个 <span class="keyword apiname">IChannel</span> 对象。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichanneleventhandler-d4991e16473" class="topicref" data-id="class_ichanneleventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichanneleventhandler.aspx#class_ichanneleventhandler" id="class_ichanneleventhandler-d4991e16473-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichanneleventhandler.html#class_ichanneleventhandler"><span class="ph">IChannelEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IChannelEventHandler</span> 接口类用于 SDK 向 app 发送 <a href="../API/class_ichannel.html#class_ichannel" class="xref"><span class="keyword">IChannel</span></a> 频道的回调事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imediaengine-d4991e16949" class="topicref" data-id="class_imediaengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imediaengine.aspx#class_imediaengine" id="class_imediaengine-d4991e16949-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imediaengine.html#class_imediaengine"><span class="ph">IMediaEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IMediaEngine</span> 类。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ipacketobserver-d4991e17061" class="topicref" data-id="class_ipacketobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ipacketobserver.aspx#class_ipacketobserver" id="class_ipacketobserver-d4991e17061-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ipacketobserver.html#class_ipacketobserver"><span class="ph">IPacketObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IPacketObserver 定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicemanager-d4991e17126" class="topicref" data-id="class_iaudiodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicemanager.aspx#class_iaudiodevicemanager" id="class_iaudiodevicemanager-d4991e17126-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicemanager.html#class_iaudiodevicemanager"><span class="ph">IAudioDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">音频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicecollection-d4991e17443" class="topicref" data-id="class_iaudiodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicecollection.aspx#class_iaudiodevicecollection" id="class_iaudiodevicecollection-d4991e17443-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicecollection.html#class_iaudiodevicecollection"><span class="ph">IAudioDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IAudioDeviceCollection 类。你可以通过该接口类获取音频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideosource-d4991e17560" class="topicref" data-id="class_ivideosource" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideosource.aspx#class_ivideosource" id="class_ivideosource-d4991e17560-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideosource.html#class_ivideosource"><span class="ph">IVideoSource</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoSource 类，可以设置自定义的视频源。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeconsumer-d4991e17664" class="topicref" data-id="class_ivideoframeconsumer" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeconsumer.aspx#class_ivideoframeconsumer" id="class_ivideoframeconsumer-d4991e17664-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeconsumer.html#class_ivideoframeconsumer"><span class="ph">IVideoFrameConsumer</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IVideoFrameConsumer</span> 类，用于让 SDK 接收你采集的视频帧。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicemanager-d4991e17692" class="topicref" data-id="class_ivideodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicemanager.aspx#class_ivideodevicemanager" id="class_ivideodevicemanager-d4991e17692-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicemanager.html#class_ivideodevicemanager"><span class="ph">IVideoDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicecollection-d4991e17788" class="topicref" data-id="class_ivideodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicecollection.aspx#class_ivideodevicecollection" id="class_ivideodevicecollection-d4991e17788-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicecollection.html#class_ivideodevicecollection"><span class="ph">IVideoDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoDeviceCollection 类。你可以通过该接口类获取视频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_rtcengineeventhandler-d4991e17857" class="topicref" data-id="class_rtcengineeventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengineeventhandler.aspx#class_rtcengineeventhandler" id="class_rtcengineeventhandler-d4991e17857-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengineeventhandler.html#class_rtcengineeventhandler"><span class="ph">IRtcEngineEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IRtcEngineEventHandler</span> 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK的事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudioframeobserver-d4991e18897" class="topicref" data-id="class_iaudioframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudioframeobserver.aspx#class_iaudioframeobserver" id="class_iaudioframeobserver-d4991e18897-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudioframeobserver.html#class_iaudioframeobserver"><span class="ph">IAudioFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">语音观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeobserver-d4991e19014" class="topicref" data-id="class_ivideoframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeobserver.aspx#class_ivideoframeobserver" id="class_ivideoframeobserver-d4991e19014-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeobserver.html#class_ivideoframeobserver"><span class="ph">IVideoFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imetadataobserver-d4991e19199" class="topicref" data-id="class_imetadataobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imetadataobserver.aspx#class_imetadataobserver" id="class_imetadataobserver-d4991e19199-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imetadataobserver.html#class_imetadataobserver"><span class="ph">IMetadataObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Metadata 观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="datatype-d4991e19289" class="topicref" data-id="datatype" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_data_type.aspx#datatype" id="datatype-d4991e19289-link">类型定义</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">本页列出 <span class="ph">Windows</span> API 所有的类型定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="错误码和警告码-d4991e20757" class="topicref" data-id="错误码和警告码" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/error_rtc.aspx" id="错误码和警告码-d4991e20757-link">错误码和警告码</a></span></span></li></ul></li></ul></div>
      </nav>
  
  
  <div class="col-lg-7 col-md-9 col-sm-12" id="wh_topic_body">
      <div class=" wh_topic_content body "><main role="main"><article role="article" aria-labelledby="ariaid-title1"><article class="nested0" aria-labelledby="ariaid-title1" id="class_rtcengine">
    <h1 class="- topic/title title topictitle1" id="ariaid-title1"><a href="class_irtcengine.aspx#class_rtcengine"><span class="- topic/ph ph">IRtcEngine</span></a></h1>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_rtcengine__shortdesc">Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。</span></p>
        <section class="- topic/section section" id="class_rtcengine__detailed_desc">
   <p class="- topic/p p"><span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 是 Agora Native SDK 的基础接口类，提供 Agora 实时音视频的主要功能。</p>
   <p class="- topic/p p">在调用其他 API 之前，必须先调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_createagorartcengine" title="创建 IRtcEngine 对象并返回指针。">createAgoraRtcEngine</a> 创建 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 对象。</p>
        </section>
    </div>
<article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title2" id="api_joinchannelwithuseraccount1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title2"><a href="class_irtcengine.aspx#api_joinchannelwithuseraccount1"><span class="- topic/ph ph">joinChannelWithUserAccount</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_joinchannelwithuseraccount1__shortdesc">使用 User Account 加入频道。</span></p><section class="- topic/section section" id="api_joinchannelwithuseraccount1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp">    <strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> joinChannelWithUserAccount(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token,
       <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channelId,
       <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* userAccount) = <span class="hl-number">0</span>;    
      </pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_joinchannelwithuseraccount1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.8.0</dd>
       
   </dl>
   <div class="- topic/p p">该方法允许本地用户使用 User Account 加入频道。成功加入频道后，会触发以下回调：
   <ul class="- topic/ul ul">
       <li class="- topic/li li">本地：<a class="- topic/xref xref" href="api_onlocaluserregistered.aspx" title="本地用户成功注册 User Account 回调。"><span class="- topic/keyword keyword">onLocalUserRegistered</span></a> 和 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess" title="成功加入频道回调。"><span class="- topic/keyword keyword">onJoinChannelSuccess</span></a> 回调。</li>
       <li class="- topic/li li">通信场景下的用户和直播场景下的主播加入频道后，远端会依次触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserjoined" title="远端用户（通信场景）/主播（直播场景）加入当前频道回调。"><span class="- topic/keyword keyword">onUserJoined</span></a> 和 <a class="- topic/xref xref" href="api_onuserinfoupdated.aspx" title="远端用户信息已更新回调。"><span class="- topic/keyword keyword">onUserInfoUpdated</span></a> 回调。</li>
   </ul></div>
   <p class="- topic/p p">用户成功加入频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <span class="+ topic/keyword pr-d/apiname keyword apiname">mute</span> 方法实现。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。</div>
        </section>
        <section class="- topic/section section" id="api_joinchannelwithuseraccount1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">动态秘钥。<ul class="- topic/ul ul">
      <li class="- topic/li li">安全要求不高: 将值设为 <span class="- topic/ph ph">NULL</span>。</li>
      <li class="- topic/li li">安全要求高: 将值设置为 Token。如果你已经启用了 App Certificate, 请务必使用 Token。</li>
  </ul>
      <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
 请务必确保用于生成 token 的 App ID 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法初始化引擎时用的是同一个 App ID，否则会造成旁路推流失败。
      </div>
  </div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channelName</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul" id="api_joinchannelwithuseraccount1__ul_lx4_nrc_h4b">
      <li class="- topic/li li">26 个小写英文字母 a~z</li>
      <li class="- topic/li li">26 个大写英文字母 A~Z</li>
      <li class="- topic/li li">10 个数字 0~9</li>
      <li class="- topic/li li">空格</li>
      <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
  </ul></div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userAccount</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">用户 User Account。该参数为必填，最大不超过 255 字节，不可填 <span class="- topic/ph ph">NULL</span>。请确保注册的 User Account 的唯一性。以下为支持的字符集范围（共 89 个字符）：<ul class="- topic/ul ul">
      <li class="- topic/li li">26 个小写英文字母 a-z</li>
      <li class="- topic/li li">26 个大写英文字母 A-Z</li>
      <li class="- topic/li li">10 个数字 0-9</li>
      <li class="- topic/li li">空格</li>
      <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
  </ul></div></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_joinchannelwithuseraccount1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-3(ERR_NOT_READY): SDK 初始化失败，请尝试重新初始化 SDK。</li>
  <li class="- topic/li li">-5(ERR_REFUSED): 调用被拒绝。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title3" id="api_joinchannelwithuseraccount2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title3"><a href="class_irtcengine.aspx#api_joinchannelwithuseraccount2"><span class="- topic/ph ph">joinChannelWithUserAccount</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_joinchannelwithuseraccount2__shortdesc">使用 User Account 加入频道，并设置是否自动订阅音频或视频流。</span></p><section class="- topic/section section" id="api_joinchannelwithuseraccount2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> joinChannelWithUserAccount(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token,
       <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channelId,
       <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* userAccount,
       <strong class="hl-keyword">const</strong> ChannelMediaOptions&amp; options) = <span class="hl-number">0</span>;  </pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_joinchannelwithuseraccount2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <div class="- topic/p p">该方法允许本地用户使用 User Account 加入频道。成功加入频道后，会触发以下回调：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">本地：<a class="- topic/xref xref" href="api_onlocaluserregistered.aspx" title="本地用户成功注册 User Account 回调。"><span class="- topic/keyword keyword">onLocalUserRegistered</span></a> 和 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess" title="成功加入频道回调。"><span class="- topic/keyword keyword">onJoinChannelSuccess</span></a> 回调。</li>
  <li class="- topic/li li">通信场景下的用户和直播场景下的主播加入频道后，远端会依次触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserjoined" title="远端用户（通信场景）/主播（直播场景）加入当前频道回调。"><span class="- topic/keyword keyword">onUserJoined</span></a> 和 <a class="- topic/xref xref" href="api_onuserinfoupdated.aspx" title="远端用户信息已更新回调。"><span class="- topic/keyword keyword">onUserInfoUpdated</span></a> 回调。</li>
       </ul></div>
   <p class="- topic/p p">用户成功加入频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <span class="+ topic/keyword pr-d/apiname keyword apiname">mute</span> 方法实现。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">相比 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannelwithuseraccount1" title="使用 User Account 加入频道。"><span class="- topic/keyword keyword">joinChannelWithUserAccount</span></a>[1/2]，该方法加了 <span class="+ topic/keyword pr-d/parmname keyword parmname">options</span> 参数，用于配置用户加入频道时是否自动订阅频道内所有远端音视频流。
      默认情况下，用户订阅频道内所有其他用户的音频流和视频流，因此会产生用量并影响计费。如果想取消订阅，可以通过设置 <span class="+ topic/keyword pr-d/parmname keyword parmname">options</span> 参数或相应的 <span class="+ topic/keyword pr-d/apiname keyword apiname">mute</span> 方法实现。</li>
  <li class="- topic/li li">为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_joinchannelwithuseraccount2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">在服务端生成的用于鉴权的动态密钥。详见<a class="- topic/xref xref" href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=Windows" target="_blank" rel="external noopener">从服务端生成 Token</a>。</p>
 <div class="- topic/note note note note_note warning"><span class="note__title">注：</span>  请务必确保用于生成 token 的 App ID 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法初始化引擎时用的是同一个 App ID。 </div>
      </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">channelId</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p" id="api_joinchannelwithuseraccount2__d179e136" data-ofbid="api_joinchannelwithuseraccount2__d179e136">标识频道的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul">
     <li class="- topic/li li">26 个小写英文字母 a~z</li>
     <li class="- topic/li li">26 个大写英文字母 A~Z</li>
     <li class="- topic/li li">10 个数字 0~9</li>
     <li class="- topic/li li">空格</li>
     <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
 </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_joinchannelwithuseraccount2__userAccount">userAccount</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">用户 User Account。该参数为必填，最大不超过 255 字节，不可填 <span class="- topic/ph ph">NULL</span>。请确保注册的 User Account
 的唯一性。以下为支持的字符集范围（共 89 个字符）：<ul class="- topic/ul ul">
     <li class="- topic/li li">26 个小写英文字母 a-z</li>
     <li class="- topic/li li">26 个大写英文字母 A-Z</li>
     <li class="- topic/li li">10 个数字 0-9</li>
     <li class="- topic/li li">空格</li>
     <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
 </ul></div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">options</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道媒体设置选项。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_channelmediaoptions"><span class="- topic/keyword keyword">ChannelMediaOptions</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK) 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0 方法调用失败。 <ul class="- topic/ul ul">
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-3(ERR_NOT_READY): SDK 初始化失败，请尝试重新初始化 SDK。</li>
  <li class="- topic/li li">-5(ERR_REFUSED): 调用被拒绝。可能有如下两个原因： <ul class="- topic/ul ul">
      <li class="- topic/li li">已经创建了一个同名的 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 频道。</li>
      <li class="- topic/li li">已经通过 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 加入了一个频道，并在该 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 频道中发布了音视频流。</li></ul></li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化，就调用该方法。请确认在调用 API 之前已经创建 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象并完成初始化。</li>
       </ul></li>
   </ul>
        </section>
   </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title4" id="api_createagorartcengine">
    <h2 class="- topic/title title topictitle2" id="ariaid-title4">createAgoraRtcEngine</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_createagorartcengine__shortdesc">创建 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象并返回指针。</span></p><section class="- topic/section section" id="api_createagorartcengine__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp">AGORA_API agora::rtc::IRtcEngine *AGORA_CALL createAgoraRtcEngine ()</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_createagorartcengine__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">目前 Agora RTC Native SDK 只支持每个 app 创建一个 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 对象。</p>
        </section>
        <section class="- topic/section section" id="api_createagorartcengine__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   指向 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 对象的指针。
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title5" id="api_initialize">
    <h2 class="- topic/title title topictitle2" id="ariaid-title5"><a href="class_irtcengine.aspx#api_initialize"><span class="- topic/ph ph">initialize</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_initialize__shortdesc">初始化 Agora SDK 服务。</span></p><section class="- topic/section section" id="api_initialize__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> initialize(<strong class="hl-keyword">const</strong> RtcEngineContext&amp; context) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_initialize__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">请确保在调用其他 API 前先调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_createagorartcengine" title="创建 IRtcEngine 对象并返回指针。"><span class="- topic/keyword keyword">createAgoraRtcEngine</span></a> 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">initialize</span> 创建并初始化 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。">IRtcEngine</a>。</p>
        </section>
        <section class="- topic/section section" id="api_initialize__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">context</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">Agora SDK 初始化设置。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rtcengineconfig" title="Agora SDK 初始化设置。">RtcEngineContext</a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_initialize__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用成功。<ul class="- topic/ul ul">
  <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 未提供 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#class_rtcengineeventhandler" title="IRtcEngineEventHandler 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK 的事件通知。">IRtcEngineEventHandler</a> 指针。</li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 初始化失败。请检查 context 内容是否正确。</li>
  <li class="- topic/li li">-22(ERR_RESOURCE_LIMITED): 资源申请失败。当 app 占用资源过多，或系统资源耗尽时，SDK 分配资源失败，会返回该错误。</li>
  <li class="- topic/li li">-101(ERR_INVALID_ID): 不是有效的 App ID。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title6" id="api_release">
    <h2 class="- topic/title title topictitle2" id="ariaid-title6"><a href="class_irtcengine.aspx#api_release"><span class="- topic/ph ph">release</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_release__shortdesc">销毁 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象。</span></p><section class="- topic/section section" id="api_release__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp">AGORA_CPP_API <strong class="hl-keyword">static</strong> <strong class="hl-keyword">void</strong> release (<strong class="hl-keyword">bool</strong> sync = <strong class="hl-keyword">false</strong>);</pre>
      
  </div>
        </section>
        <section class="- topic/section section" id="api_release__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法释放 Agora SDK 使用的所有资源。有些 app 只在用户需要时才进行实时音视频通信，不需要时则将资源释放出来用于其他操作， 该方法适用于此类情况。</p>
   <p class="- topic/p p">调用该方法后，你将无法再使用 SDK 的其它方法和回调。如需再次使用实时音视频通信功能， 你必须依次重新调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_createagorartcengine" title="创建 IRtcEngine 对象并返回指针。"><span class="- topic/keyword keyword">createAgoraRtcEngine</span></a> 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法创建一个新的 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 对象。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如需在销毁后再次创建 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 对象，需要等待 <span class="+ topic/keyword pr-d/apiname keyword apiname">release</span> 方法执行结束后再创建实例。</div>
        </section>
        <section class="- topic/section section" id="api_release__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sync</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li">true: 该方法为同步调用。需要等待 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 资源释放后才能执行其他操作，所以我们建议在子线程中调用该方法，避免主线程阻塞。此外，我们不建议在 SDK 的回调中调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">release</span>，否则由于 SDK 要等待回调返回才能回收相关的对象资源，会造成死锁。SDK 会自动检测这种死锁并转为异步调用，但是检测本身会消耗额外的时间。</li>
 <li class="- topic/li li">false: 该方法为异步调用。不需要等待 <span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngine</span> 资源释放后就能执行其他操作。使用异步调用时要注意，不要在该调用后立即卸载 SDK 动态库，否则可能会因为 SDK 的清理线程还没有退出而崩溃。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title7" id="api_setchannelprofile">
    <h2 class="- topic/title title topictitle2" id="ariaid-title7"><a href="class_irtcengine.aspx#api_setchannelprofile"><span class="- topic/ph ph">setChannelProfile</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setchannelprofile__shortdesc">设置频道场景。</span></p><section class="- topic/section section" id="api_setchannelprofile__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setChannelProfile(CHANNEL_PROFILE_TYPE profile) = <span class="hl-number">0</span>;</pre>
      
  </div>
        </section>
        <section class="- topic/section section" id="api_setchannelprofile__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法用于设置 Agora 频道的使用场景。Agora SDK 会针对不同的使用场景采用不同的优化策略，如通信场景偏好流畅，直播场景偏好画质。</p>
   <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul" id="api_setchannelprofile__ul_mgd_h2l_b4b">
  <li class="- topic/li li">为保证实时音视频质量，我们建议相同频道内的用户必须使用同一种频道场景。</li>
  <li class="- topic/li li">该方法必须在 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 前调用和进行设置，进入频道后无法再设置。</li>
  <li class="- topic/li li">不同的频道场景下，SDK 的默认音频路由和默认视频编码码率是不同的，详见 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setdefaultaudioroutetospeakerphone" title="设置默认的语音路由。"><span class="- topic/keyword keyword">setDefaultAudioRouteToSpeakerphone</span></a> 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvideoencoderconfiguration" title="设置视频编码属性。"><span class="- topic/keyword keyword">setVideoEncoderConfiguration</span></a> 中的说明。
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setchannelprofile__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">profile</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">频道使用场景。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelprofiletype" title="频道使用场景。"><span class="- topic/keyword keyword">CHANNEL_PROFILE_TYPE</span></a>。</p>
      </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setchannelprofile__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK) 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0 方法调用失败。 <ul class="- topic/ul ul">
      <li class="- topic/li li">-2 (ERR_INVALID_ARGUMENT): 参数无效。</li>
      <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化。</li>
  </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title8" id="api_joinchannel">
    <h2 class="- topic/title title topictitle2" id="ariaid-title8"><a href="class_irtcengine.aspx#api_joinchannel"><span class="- topic/ph ph">joinChannel</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_joinchannel__shortdesc">加入频道。</span></p>
        <section class="- topic/section section" id="api_joinchannel__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">
      
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> joinChannel(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channelId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* info, uid_t uid) = <span class="hl-number">0</span>;</pre>
      
  </div>
        </section>
        <section class="- topic/section section" id="api_joinchannel__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法让用户加入通话频道，在同一个频道内的用户可以互相通话，多个用户加入同一个频道，可以群聊。使用不同 App ID 的 app
       是不能互通的。如果已在通话中，用户必须调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 退出当前通话，才能进入下一个频道。</p>
   <p class="- topic/p p">成功调用该方法加入频道后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess" title="成功加入频道回调。"><span class="- topic/keyword keyword">onJoinChannelSuccess</span></a>
       回调；通信场景下的用户和直播场景下的主播加入频道后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserjoined" title="远端用户（通信场景）/主播（直播场景）加入当前频道回调。"><span class="- topic/keyword keyword">onUserJoined</span></a> 回调。</p>
   <p class="- topic/p p">在网络状况不理想的情况下，客户端可能会与 Agora 的服务器失去连接；SDK 会自动尝试重连，重连成功后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrejoinchannelsuccess" title="成功重新加入频道回调。"><span class="- topic/keyword keyword">onRejoinChannelSuccess</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 用户成功加入频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 mute 方法实现。</div>
        </section>
        <section class="- topic/section section" id="api_joinchannel__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">动态秘钥。<ul class="- topic/ul ul">
     <li class="- topic/li li">安全要求不高: 将值设为 <span class="- topic/ph ph">NULL</span>。</li>
     <li class="- topic/li li">安全要求高: 将值设置为 Token。如果你已经启用了 App Certificate, 请务必使用 Token。</li>
 </ul>
 <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
     请务必确保用于生成 token 的 App ID 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法初始化引擎时用的是同一个 App ID，否则会造成旁路推流失败。
 </div>
      </div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">channelId</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul" id="api_joinchannel__ul_lx4_nrc_h4b">
     <li class="- topic/li li">26 个小写英文字母 a~z</li>
     <li class="- topic/li li">26 个大写英文字母 A~Z</li>
     <li class="- topic/li li">10 个数字 0~9</li>
     <li class="- topic/li li">空格</li>
     <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
 </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">info</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">(非必选项) 开发者需加入的任何附加信息。一般可设置为空字符串，或频道相关信息。该信息不会传递给频道内的其他用户。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，32 位无符号整数。建议设置范围：1到 2<sup class="+ topic/ph hi-d/sup ph sup">32</sup>-1，并保证唯一性。如果不指定（即设为 0），SDK 会自动分配一个，并在 <span class="+ topic/keyword pr-d/apiname keyword apiname">onJoinChannelSuccess</span> 回调中返回，应用层必须记住该返回值并维护，SDK 不对该返回值进行维护。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_joinchannel__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK) 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0 方法调用失败。 <ul class="- topic/ul ul">
      <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
      <li class="- topic/li li">-3(ERR_NOT_READY): SDK 初始化失败，请尝试重新初始化 SDK。</li>
      <li class="- topic/li li">-5(ERR_REFUSED): 调用被拒绝。可能有如下两个原因： <ul class="- topic/ul ul">
     <li class="- topic/li li">已经创建了一个同名的 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 频道。</li>
 <li class="- topic/li li">已经通过 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 加入了一个频道，并在该 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 频道中发布了音视频流。</li></ul></li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化，就调用该方法。请确认在调用 API 之前已经创建 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象并完成初始化。</li>
  </ul></li>
   </ul>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title9" id="api_joinchannel2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title9"><a href="class_irtcengine.aspx#api_joinchannel2"><span class="- topic/ph ph">joinChannel</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_joinchannel2__shortdesc">加入频道并设置是否自动订阅音频或视频流。</span></p><section class="- topic/section section" id="api_joinchannel2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> joinChannel(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token,
    <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channelId,
    <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* info,
    uid_t uid,
    <strong class="hl-keyword">const</strong> ChannelMediaOptions&amp; options) = <span class="hl-number">0</span>;</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_joinchannel2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">该方法让用户加入通话频道，在同一个频道内的用户可以互相通话，多个用户加入同一个频道，可以群聊。使用不同 App ID 的 App 是不能互通的。如果已在通话中，必须调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 退出当前通话，才能进入下一个频道。</p>
   <p class="- topic/p p">成功调用该方法加入频道后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess" title="成功加入频道回调。"><span class="- topic/keyword keyword">onJoinChannelSuccess</span></a> 回调。通信场景下的用户和直播场景下的主播加入频道后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrejoinchannelsuccess" title="成功重新加入频道回调。"><span class="- topic/keyword keyword">onRejoinChannelSuccess</span></a> 回调。</p>
   <p class="- topic/p p">在网络状况不理想的情况下，客户端可能会与 Agora 的服务器失去连接；SDK 会自动尝试重连，重连成功后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrejoinchannelsuccess" title="成功重新加入频道回调。"><span class="- topic/keyword keyword">onRejoinChannelSuccess</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 相比 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a>[1/2]，该方法加了 <span class="+ topic/keyword pr-d/parmname keyword parmname">options</span> 参数，用于配置用户加入频道时是否自动订阅频道内所有远端音视频流。默认情况下，用户订阅频道内所有其他用户的音频流和视频流，因此会产生用量并影响计费。
      如果想取消订阅，可以通过设置 <span class="+ topic/keyword pr-d/parmname keyword parmname">options</span> 参数或相应的 <code class="+ topic/ph pr-d/codeph ph codeph">mute</code> 方法实现。
   </div>
        </section>
        <section class="- topic/section section" id="api_joinchannel2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_joinchannel2__token">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">在服务端生成的用于鉴权的动态密钥。详见<a class="- topic/xref xref" href="https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=Windows" target="_blank" rel="external noopener">从服务端生成 Token</a>。</p>
 <div class="- topic/note note note note_note warning"><span class="note__title">注：</span>  请务必确保用于生成 token 的 App ID 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法初始化引擎时用的是同一个 App ID。 </div>
      </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_joinchannel2__channelID"><span class="- topic/ph ph">channelId</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p" id="api_joinchannel2__channelID_desc" data-ofbid="api_joinchannel2__channelID_desc">标识频道的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul">
     <li class="- topic/li li">26 个小写英文字母 a~z</li>
     <li class="- topic/li li">26 个大写英文字母 A~Z</li>
     <li class="- topic/li li">10 个数字 0~9</li>
     <li class="- topic/li li">空格</li>
     <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
 </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_joinchannel2__info"><span class="- topic/ph ph">info</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">(非必选项) 预留参数。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，32 位无符号整数。建议设置范围：1到 2<sup class="+ topic/ph hi-d/sup ph sup">32</sup>-1，并保证唯一性。如果不指定（即设为 0），SDK 会自动分配一个，并在 <span class="+ topic/keyword pr-d/apiname keyword apiname">onJoinChannelSuccess</span> 回调中返回，应用层必须记住该返回值并维护，SDK 不对该返回值进行维护。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_joinchannel2__options">options</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道媒体设置选项。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_channelmediaoptions"><span class="- topic/keyword keyword">ChannelMediaOptions</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_joinchannel2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK) 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0 方法调用失败。 <ul class="- topic/ul ul">
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-3(ERR_NOT_READY): SDK 初始化失败，请尝试重新初始化 SDK。</li>
  <li class="- topic/li li">-5(ERR_REFUSED): 调用被拒绝。可能有如下两个原因： <ul class="- topic/ul ul">
      <li class="- topic/li li">已经创建了一个同名的 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 频道。</li>
      <li class="- topic/li li">已经通过 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 加入了一个频道，并在该 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 频道中发布了音视频流。</li></ul></li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化，就调用该方法。请确认在调用 API 之前已经创建 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象并完成初始化。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title10" id="api_switchchannel1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title10"><a href="class_irtcengine.aspx#api_switchchannel1"><span class="- topic/ph ph">switchChannel</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_switchchannel1__shortdesc">快速切换直播频道。</span></p><section class="- topic/section section" id="api_switchchannel1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> switchChannel(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channelId) = <span class="hl-number">0</span>;</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_switchchannel1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当直播频道中的观众想从一个频道切换到另一个频道时，可以调用该方法，实现快速切换。</p>
   <p class="- topic/p p">成功调用该方切换频道后，本地会先收到离开原频道的回调 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onleavechannel" title="离开频道回调。"><span class="- topic/keyword keyword">onLeaveChannel</span></a>，再收到成功加入新频道的回调 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess" title="成功加入频道回调。"><span class="- topic/keyword keyword">onJoinChannelSuccess</span></a>。</p>
   <p class="- topic/p p">用户成功切换频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <span class="+ topic/keyword pr-d/apiname keyword apiname">mute</span> 方法实现。</p>
        </section>
        <section class="- topic/section section" id="api_switchchannel1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">动态秘钥。<ul class="- topic/ul ul">
      <li class="- topic/li li">安全要求不高: 将值设为 <span class="- topic/ph ph">NULL</span>。</li>
      <li class="- topic/li li">安全要求高: 将值设置为 Token。如果你已经启用了 App Certificate, 请务必使用 Token。</li>
  </ul>
      <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
 请务必确保用于生成 token 的 App ID 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法初始化引擎时用的是同一个 App ID，否则会造成旁路推流失败。
      </div>
  </div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">channelId</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul" id="api_switchchannel1__ul_lx4_nrc_h4b">
 <li class="- topic/li li">26 个小写英文字母 a~z</li>
 <li class="- topic/li li">26 个大写英文字母 A~Z</li>
 <li class="- topic/li li">10 个数字 0~9</li>
 <li class="- topic/li li">空格</li>
 <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
      </ul></div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_switchchannel1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-5(ERR_NOT_INITIALIZED): 调用被拒绝。可能因为用户角色不是观众。</li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化。</li>
  <li class="- topic/li li">-102(ERR_INVALID CHANNEL_NAME): 频道名无效。请更换有效的频道名。</li>
  <li class="- topic/li li">-113(ERR_NOT_IN_CHANNEL): 用户不在频道内。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title11" id="api_switchchannel2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title11"><a href="class_irtcengine.aspx#api_switchchannel2"><span class="- topic/ph ph">switchChannel</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_switchchannel2__shortdesc">快速切换直播频道，并设置是否自动订阅音频流或视频流。</span></p><section class="- topic/section section" id="api_switchchannel2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> switchChannel(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channelId, <strong class="hl-keyword">const</strong> ChannelMediaOptions&amp; options) = <span class="hl-number">0</span>;</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_switchchannel2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">当直播频道中的观众想从一个频道切换到另一个频道时，可以调用该方法，实现快速切换。</p>
   <p class="- topic/p p">成功调用该方切换频道后，本地会先收到离开原频道的回调 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onleavechannel" title="离开频道回调。"><span class="- topic/keyword keyword">onLeaveChannel</span></a>，再收到成功加入新频道的回调 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess" title="成功加入频道回调。"><span class="- topic/keyword keyword">onJoinChannelSuccess</span></a>。</p>
   <p class="- topic/p p">用户成功切换频道后，默认订阅频道内所有其他用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <span class="+ topic/keyword pr-d/apiname keyword apiname">mute</span> 方法实现。</p>
        </section>
        <section class="- topic/section section" id="api_switchchannel2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">动态秘钥。<ul class="- topic/ul ul">
      <li class="- topic/li li">安全要求不高: 将值设为 <span class="- topic/ph ph">NULL</span>。</li>
      <li class="- topic/li li">安全要求高: 将值设置为 Token。如果你已经启用了 App Certificate, 请务必使用 Token。</li>
  </ul>
      <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
 请务必确保用于生成 token 的 App ID 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 方法初始化引擎时用的是同一个 App ID，否则会造成旁路推流失败。
      </div>
  </div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">channelId</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul" id="api_switchchannel2__ul_lx4_nrc_h4b">
 <li class="- topic/li li">26 个小写英文字母 a~z</li>
 <li class="- topic/li li">26 个大写英文字母 A~Z</li>
 <li class="- topic/li li">10 个数字 0~9</li>
 <li class="- topic/li li">空格</li>
 <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
      </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">options</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道媒体设置选项。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_channelmediaoptions">ChannelMediaOptions</a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_switchchannel2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-5(ERR_NOT_INITIALIZED): 调用被拒绝。可能因为用户角色不是观众。</li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化。</li>
  <li class="- topic/li li">-102(ERR_INVALID CHANNEL_NAME): 频道名无效。请更换有效的频道名。</li>
  <li class="- topic/li li">-113(ERR_NOT_IN_CHANNEL): 用户不在频道内。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title12" id="api_setclientrole1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title12"><a href="class_irtcengine.aspx#api_setclientrole1"><span class="- topic/ph ph">setClientRole</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setclientrole1__shortdesc">设置直播场景下的用户角色。</span></p>
        <section class="- topic/section section" id="api_setclientrole1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">
      
      
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setClientRole(CLIENT_ROLE_TYPE role) = <span class="hl-number">0</span>;</pre>

  </div>
    </section>
        <section class="- topic/section section" id="api_setclientrole1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   <p class="- topic/p p" id="api_setclientrole1__desc" data-ofbid="api_setclientrole1__desc">在加入频道前和加入频道后均可调用该方法设置用户角色。</p>
   <p class="- topic/p p">如果你在加入频道后调用该方法切换用户角色，调用成功后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onclientrolechanged" title="直播场景下用户角色已切换回调。"><span class="- topic/keyword keyword">onClientRoleChanged</span></a> 回调；远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserjoined" title="远端用户（通信场景）/主播（直播场景）加入当前频道回调。"><span class="- topic/keyword keyword">onUserJoined</span></a> 或 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuseroffline" title="远端用户（通信场景）/主播（直播场景）离开当前频道回调。"><span class="- topic/keyword keyword">onUserOffline</span></a>(USER_OFFLINE_BECOME_AUDIENCE) 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法仅适用于直播场景。</div>
        </section>
        <section class="- topic/section section" id="api_setclientrole1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">role</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">直播场景里的用户角色。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_clientroletype" title="直播场景里的用户角色。"><span class="- topic/keyword keyword">CLIENT_ROLE_TYPE</span></a>。</p>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setclientrole1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。
  <ul class="- topic/ul ul">
      <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
 <li class="- topic/li li">-2(ERR_INALID_ARGUMENT): 参数无效。</li>
 <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化。</li>
  </ul>
       </li>
   </ul>
        </section></div>
<nav role="navigation" class="- topic/related-links related-links"><div class="- topic/linklist linklist relref"><strong>相关参考</strong><ul class="linklist related_link"><li class="linklist"><a class="navheader_parent_path" href="../API/class_irtcengineeventhandler.aspx#api_onclientrolechanged" title="直播场景下用户角色已切换回调。">onClientRoleChanged</a></li></ul></div></nav></article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title13" id="api_setclientrole2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title13"><a href="class_irtcengine.aspx#api_setclientrole2"><span class="- topic/ph ph">setClientRole</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setclientrole2__shortdesc">设置直播场景下的用户角色和级别。</span></p><section class="- topic/section section" id="api_setclientrole2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setClientRole(CLIENT_ROLE_TYPE role, <strong class="hl-keyword">const</strong> ClientRoleOptions&amp; options) = <span class="hl-number">0</span>;</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_setclientrole2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.2.0</dd>
       
   </dl>
   <p class="- topic/p p">在加入频道前和加入频道后均可调用该方法设置用户角色。</p>
   <div class="- topic/p p">如果你在加入频道后调用该方法成功切换用户角色，SDK 会触发以下回调：<ul class="- topic/ul ul">
       <li class="- topic/li li">本地触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onclientrolechanged" title="直播场景下用户角色已切换回调。"><span class="- topic/keyword keyword">onClientRoleChanged</span></a> 回调。</li>
       <li class="- topic/li li">远端触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserjoined" title="远端用户（通信场景）/主播（直播场景）加入当前频道回调。"><span class="- topic/keyword keyword">onUserJoined</span></a> 或 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuseroffline" title="远端用户（通信场景）/主播（直播场景）离开当前频道回调。"><span class="- topic/keyword keyword">onUserOffline</span></a> 回调。</li>
   </ul></div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法仅在频道场景为直播（<a class="- topic/xref xref" href="class_irtcengine.aspx#api_setchannelprofile" title="设置频道场景。"><span class="- topic/keyword keyword">setChannelProfile</span></a> 中 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 设为 <span class="- topic/ph ph">CHANNEL_PROFILE_LIVE_BROADCASTING</span>）时生效。</li>
       <li class="- topic/li li">该方法与 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setclientrole1" title="设置直播场景下的用户角色。"><span class="- topic/keyword keyword">setClientRole</span></a>[1/2] 的区别在于，该方法还支持设置用户级别。<ul class="- topic/ul ul" id="api_setclientrole2__diff">
 <li class="- topic/li li">用户角色（<span class="+ topic/keyword pr-d/parmname keyword parmname">role</span>）确定用户在 SDK
     层的权限，包含是否可以发送流、是否可以接收流、是否可以推流到 CDN 等。</li>
 <li class="- topic/li li">用户级别（<span class="+ topic/keyword pr-d/parmname keyword parmname">level</span>）需要与角色结合使用，确定用户在其权限范围内，可以操作和享受到的服务级别。例如对于观众，选择接收低延时还是超低延时的视频流。不同的级别会影响计费。</li>
      </ul></li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_setclientrole2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">role</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">直播场景中的用户角色。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_clientroletype" title="直播场景里的用户角色。">CLIENT_ROLE_TYPE</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">options</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户具体设置，包含用户级别。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_clientroleoptions" title="用户角色具体设置。">ClientRoleOptions</a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setclientrole2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-7(ERR_NOT_INITALIZED): SDK 尚未初始化。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title14" id="api_leavechannel">
    <h2 class="- topic/title title topictitle2" id="ariaid-title14"><a href="class_irtcengine.aspx#api_leavechannel"><span class="- topic/ph ph">leaveChannel</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_leavechannel__shortdesc">离开频道。</span></p><section class="- topic/section section" id="api_leavechannel__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> leaveChannel() = <span class="hl-number">0</span>;</pre>       
      
  </div>
        </section>
        <section class="- topic/section section" id="api_leavechannel__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">离开频道，即挂断或退出通话。该方法会把会话相关的所有资源释放掉。该方法是异步操作，调用返回时并没有真正退出频道。</p>
   <p class="- topic/p p">调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 后，必须调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">leaveChannel</span> 结束通话，否则无法开始下一次通话。</p>
   <p class="- topic/p p">不管当前是否在通话中，都可以调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">leaveChannel</span>，没有副作用。</p>
   <p class="- topic/p p">成功调用该方法离开频道后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onleavechannel" title="离开频道回调。"><span class="- topic/keyword keyword">onLeaveChannel</span></a> 回调；通信场景下的用户和直播场景下的主播离开频道后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuseroffline" title="远端用户（通信场景）/主播（直播场景）离开当前频道回调。"><span class="- topic/keyword keyword">onUserOffline</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">如果你调用了 <span class="+ topic/keyword pr-d/apiname keyword apiname">leaveChannel</span> 后立即调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_release" title="销毁 IRtcEngine 对象。"><span class="- topic/keyword keyword">release</span></a> 方法，SDK 将无法触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onLeaveChannel</span> 回调。</li>
  <li class="- topic/li li">如果你在旁路推流过程中调用了 <span class="+ topic/keyword pr-d/apiname keyword apiname">leaveChannel</span> 方法，SDK 将自动调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_removepublishstreamurl" title="删除旁路推流地址。"><span class="- topic/keyword keyword">removePublishStreamUrl</span></a> 方法。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_leavechannel__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-3(ERR_NOT_INITIALIZED): SDK 尚未初始化。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title15" id="api_renewtoken">
    <h2 class="- topic/title title topictitle2" id="ariaid-title15"><a href="class_irtcengine.aspx#api_renewtoken"><span class="- topic/ph ph">renewToken</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_renewtoken__shortdesc">更新 Token。</span></p><section class="- topic/section section" id="api_renewtoken__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> renewToken(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_renewtoken__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   该方法用于更新 Token。Token 生成后会在有效期过期后失效。在以下两种情况下，app 应重新获取 Token,
   然后调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">renewToken</span> 更新 Token，否则 SDK 无法和服务器建立连接：
   <ul class="- topic/ul ul">
       <li class="- topic/li li">发生 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_ontokenprivilegewillexpire" title="Token 服务即将过期回调。"><span class="- topic/keyword keyword">onTokenPrivilegeWillExpire</span></a> 回调时。</li>
       <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onconnectionstatechanged" title="网络连接状态已改变回调。"><span class="- topic/keyword keyword">onConnectionStateChanged</span></a> 回调报告 <span class="+ topic/keyword pr-d/apiname keyword apiname">CONNECTION_CHANGED_TOKEN_EXPIRED</span>(9) 时。</li>
   </ul>
        </section>
        <section class="- topic/section section" id="api_renewtoken__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">新的 Token。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_renewtoken__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0(ERR_OK): 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-1(ERR_FAILED): 一般性的错误（未明确归类）。</li>
  <li class="- topic/li li">-2(ERR_INVALID_ARGUMENT): 参数无效。</li>
  <li class="- topic/li li">-7(ERR_NOT_INITIALIZED): SDK 尚未初始化。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title16" id="api_getconnectionstate">
    <h2 class="- topic/title title topictitle2" id="ariaid-title16"><a href="class_irtcengine.aspx#api_getconnectionstate"><span class="- topic/ph ph">getConnectionState</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getconnectionstate__shortdesc">获取当前网络连接状态。</span></p><section class="- topic/section section" id="api_getconnectionstate__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> CONNECTION_STATE_TYPE getConnectionState() = <span class="hl-number">0</span>;</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_getconnectionstate__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法在加入频道前后都能调用。</p>
        </section>
        <section class="- topic/section section" id="api_getconnectionstate__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <p class="- topic/p p">当前网络连接的状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_connectionstatetype" title="网络连接状态。"><span class="- topic/keyword keyword">CONNECTION_STATE_TYPE</span></a>。</p>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title17" id="api_enablewebsdkinteroperability">
    <h2 class="- topic/title title topictitle2" id="ariaid-title17"><a href="class_irtcengine.aspx#api_enablewebsdkinteroperability"><span class="- topic/ph ph">enableWebSdkInteroperability</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablewebsdkinteroperability__shortdesc">打开与 Web SDK 的互通（仅在直播场景适用）。</span></p><section class="- topic/section section" id="api_enablewebsdkinteroperability__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">     
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableWebSdkInteroperability(<strong class="hl-keyword">bool</strong> enabled) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enablewebsdkinteroperability__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用:</dt>
  <dd class="- topic/dd dd">该方法从 v3.0.0 起废弃，SDK 自动开启与 Web SDK 的互通，无需调用该方法开启。</dd>
       
   </dl>
   <p class="- topic/p p">该方法打开或关闭与 Agora Web SDK 的互通。如果有用户通过 Web SDK 加入频道，请确保调用该方法，否则 Web 端用户看 Native 端的画面会是黑屏。</p>
   <p class="- topic/p p">该方法仅在直播场景下适用，通信场景下默认互通是打开的。</p>
        </section>
        <section class="- topic/section section" id="api_enablewebsdkinteroperability__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">是否打开与 Agora Web SDK 的互通：<ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/parmname keyword parmname">true</span>: 打开互通。</li>
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/parmname keyword parmname">false</span>: (默认) 关闭互通。</li>
  </ul></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enablewebsdkinteroperability__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title18" id="api_enableaudio">
    <h2 class="- topic/title title topictitle2" id="ariaid-title18"><a href="class_irtcengine.aspx#api_enableaudio"><span class="- topic/ph ph">enableAudio</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enableaudio__shortdesc">启用音频模块。</span></p><section class="- topic/section section" id="api_enableaudio__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">     
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableAudio() = <span class="hl-number">0</span>;</pre>   
  </div>
    </section>
        <section class="- topic/section section" id="api_enableaudio__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">启用音频模块（默认为开启状态）。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法设置音频模块为启用状态，在频道内和频道外均可调用。在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 后仍然有效。</li>
       <li class="- topic/li li">该方法开启整个音频模块，响应时间较慢，因此 Agora 建议使用如下方法来控制音频模块：<ul class="- topic/ul ul">
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalaudio" title="开关本地音频采集。"><span class="- topic/keyword keyword">enableLocalAudio</span></a>: 是否启动麦克风采集并创建本地音频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a>: 是否发布本地音频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteremoteaudiostream" title="取消或恢复订阅指定远端用户的音频流。"><span class="- topic/keyword keyword">muteRemoteAudioStream</span></a>: 是否接收并播放远端音频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteallremoteaudiostreams" title="取消或恢复订阅所有远端用户的音频流。"><span class="- topic/keyword keyword">muteAllRemoteAudioStreams</span></a>: 是否接收并播放所有远端音频流。</li>
       </ul></li>
   </ul></div>        
        </section>
        <section class="- topic/section section" id="api_enableaudio__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。 </li>
   </ul>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title19" id="api_disableaudio">
    <h2 class="- topic/title title topictitle2" id="ariaid-title19"><a href="class_irtcengine.aspx#api_disableaudio"><span class="- topic/ph ph">disableAudio</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_disableaudio__shortdesc">关闭音频模块。</span></p><section class="- topic/section section" id="api_disableaudio__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> disableAudio() = <span class="hl-number">0</span>;</pre>     
  </div>
        </section>
        <section class="- topic/section section" id="api_disableaudio__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
        </section>
        <section class="- topic/section section">   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法设置内部引擎为禁用状态，在频道内和频道外均可调用。 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 后仍然有效。</li>
       <li class="- topic/li li">该方法重置整个引擎，响应时间较慢，因此声网建议使用如下方法来控制音频模块：<ul class="- topic/ul ul">
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalaudio" title="开关本地音频采集。"><span class="- topic/keyword keyword">enableLocalAudio</span></a>: 是否启动麦克风采集并创建本地音频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a>: 是否发布本地音频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteremoteaudiostream" title="取消或恢复订阅指定远端用户的音频流。"><span class="- topic/keyword keyword">muteRemoteAudioStream</span></a>: 是否接收并播放远端音频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteallremoteaudiostreams" title="取消或恢复订阅所有远端用户的音频流。"><span class="- topic/keyword keyword">muteAllRemoteAudioStreams</span></a>: 是否接收并播放所有远端音频流。</li>
       </ul></li>
   </ul></div>     
        </section>
        <section class="- topic/section section" id="api_disableaudio__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。 </li>
   </ul>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title20" id="api_setaudioprofile">
    <h2 class="- topic/title title topictitle2" id="ariaid-title20"><a href="class_irtcengine.aspx#api_setaudioprofile"><span class="- topic/ph ph">setAudioProfile</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setaudioprofile__shortdesc">设置音频编码属性。</span></p><section class="- topic/section section" id="api_setaudioprofile__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setAudioProfile(AUDIO_PROFILE_TYPE profile, AUDIO_SCENARIO_TYPE scenario) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_setaudioprofile__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 之前设置好， <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 之后设置不生效。</li>
  <li class="- topic/li li">通信和直播场景下，音质（码率）会有网络自适应的调整，通过该方法设置的是一个最高码率。</li>
  <li class="- topic/li li">在有高音质需求的场景（例如音乐教学场景）中，建议将 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 设置为 <span class="- topic/ph ph">AUDIO_PROFILE_MUSIC_HIGH_QUALITY</span>(4)，<span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 设置为 <span class="- topic/ph ph">AUDIO_SCENARIO_GAME_STREAMING</span>(3)。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setaudioprofile__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">profile</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">设置采样率，码率，编码模式和声道数，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audiocodecprofiletype" title="用于旁路推流的输出音频的编解码规格，默认为 LC-AAC。"><span class="- topic/keyword keyword">AUDIO_CODEC_PROFILE_TYPE</span></a>。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">scenario</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置音频应用场景，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audioscenariotype" title="设置音频应用场景。"><span class="- topic/keyword keyword">AUDIO_SCENARIO_TYPE</span></a> 。不同的音频场景下，设备的音量类型是不同的。详见<a class="- topic/xref xref" href="https://docs.agora.io/cn/faq/system_volume" target="_blank" rel="external noopener">如何区分媒体音量和通话音量</a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setaudioprofile__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title21" id="api_sethighqualityaudioparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title21"><a href="class_irtcengine.aspx#api_sethighqualityaudioparameters"><span class="- topic/ph ph">setHighQualityAudioParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_sethighqualityaudioparameters__shortdesc">设置音频高音质选项。</span></p><section class="- topic/section section" id="api_sethighqualityaudioparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setHighQualityAudioParameters(<strong class="hl-keyword">bool</strong> fullband, <strong class="hl-keyword">bool</strong> stereo, <strong class="hl-keyword">bool</strong> fullBitrate) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_sethighqualityaudioparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法已废弃。声网不建议你使用。如果你希望设置音频高音质选项，请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 方法。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_sethighqualityaudioparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">fullband</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">全频带编解码器（48 kHz 采样率）, 不兼容 v1.7.4 以前版本</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>：启用全频带编解码器</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>：禁用全频带编解码器</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stereo</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">立体声编解码器，不兼容 v1.7.4 以前版本</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>：启用立体声编解码器</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>：禁用立体声编解码器</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">fullBitrate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">高码率模式，建议仅在纯音频模式下使用</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>：启用高码率模式</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>：禁用高码率模式</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_sethighqualityaudioparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title22" id="api_adjustrecordingsignalvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title22"><a href="class_irtcengine.aspx#api_adjustrecordingsignalvolume"><span class="- topic/ph ph">adjustRecordingSignalVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_adjustrecordingsignalvolume__shortdesc">调节音频采集信号音量。</span></p><section class="- topic/section section" id="api_adjustrecordingsignalvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> adjustRecordingSignalVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_adjustrecordingsignalvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <p class="- topic/p p">该方法在加入频道前后都能调用。</p>
   </div>
        </section>
        <section class="- topic/section section" id="api_adjustrecordingsignalvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">录音信号音量。为避免回声并提升通话质量，Agora 建议将 <span class="+ topic/keyword pr-d/parmname keyword parmname">volume</span> 值设为 [0,100]。如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">volume</span> 值需超过
 100，联系<a class="- topic/xref xref" href="https://agora-ticket.agora.io/" target="_blank" rel="external noopener">技术支持</a>:</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li">0: 静音；</li>
 <li class="- topic/li li">100: 原始音量。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_adjustrecordingsignalvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt;0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title23" id="api_adjustuserplaybacksignalvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title23"><a href="class_irtcengine.aspx#api_adjustuserplaybacksignalvolume"><span class="- topic/ph ph">adjustUserPlaybackSignalVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_adjustuserplaybacksignalvolume__shortdesc">调节本地播放的指定远端用户信号音量。</span></p><section class="- topic/section section" id="api_adjustuserplaybacksignalvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> adjustUserPlaybackSignalVolume(<strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> uid, <strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_adjustuserplaybacksignalvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.0.0</dd>
       
   </dl>
   <p class="- topic/p p">你可以在通话中调用该方法调节指定远端用户在本地播放的音量。如需调节多个用户在本地播放的音量，则需多次调用该方法。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在加入频道后，调用该方法。</li>
  <li class="- topic/li li">该方法调节的是本地播放的指定远端用户混音后的音量。</li>
       </ul>
   </div> 
        </section>
        <section class="- topic/section section" id="api_adjustuserplaybacksignalvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_adjustuserplaybacksignalvolume__volume">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
     <p class="- topic/p p">播放音量，取值范围为 [0,100]:</p>
 <ul class="- topic/ul ul">
     <li class="- topic/li li">0: 静音</li>
     <li class="- topic/li li">100: 原始音量</li>
 </ul>
  </dd>
        
   </dl>
        </section>
        <section class="- topic/section section" id="api_adjustuserplaybacksignalvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt;0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title24" id="api_adjustplaybacksignalvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title24"><a href="class_irtcengine.aspx#api_adjustplaybacksignalvolume"><span class="- topic/ph ph">adjustPlaybackSignalVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_adjustplaybacksignalvolume__shortdesc">调节本地播放的所有远端用户信号音量。</span></p><section class="- topic/section section" id="api_adjustplaybacksignalvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> adjustPlaybackSignalVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_adjustplaybacksignalvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法调节的是本地播放的所有远端用户混音后的音量。</li>
  <li class="- topic/li li">从 v2.3.2 开始，静音本地音频需同时调用 <code class="+ topic/ph pr-d/codeph ph codeph">adjustPlaybackSignalVolume</code> 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_adjustaudiomixingplayoutvolume" title="调节音乐文件本端播放音量。"><span class="- topic/keyword keyword">adjustAudioMixingPlayoutVolume</span></a> 方法，并将 <code class="+ topic/ph pr-d/codeph ph codeph">volume</code> 设置为 <code class="+ topic/ph pr-d/codeph ph codeph">0</code>。</li>
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_adjustplaybacksignalvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">
      播放音量。为避免回声并提升通话质量，Agora 建议将 <span class="+ topic/keyword pr-d/parmname keyword parmname">volume</span> 值设为 [0,100]。如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">volume</span> 值需超过 100，联系<a class="- topic/xref xref" href="https://agora-ticket.agora.io/" target="_blank" rel="external noopener">技术支持</a>:</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li">0: 静音；</li>
 <li class="- topic/li li">100: 原始音量。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_adjustplaybacksignalvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title25" id="api_enablelocalaudio">
    <h2 class="- topic/title title topictitle2" id="ariaid-title25"><a href="class_irtcengine.aspx#api_enablelocalaudio"><span class="- topic/ph ph">enableLocalAudio</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablelocalaudio__shortdesc">开关本地音频采集。</span></p><section class="- topic/section section" id="api_enablelocalaudio__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableLocalAudio(<strong class="hl-keyword">bool</strong> enabled) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enablelocalaudio__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当用户加入频道时，语音功能默认是开启的。该方法可以关闭或重新开启本地语音功能，即停止或重新开始本地音频采集。</p>
   <p class="- topic/p p">该方法不影响接收或播放远端音频流，<a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalaudio" title="开关本地音频采集。"><span class="- topic/keyword keyword">enableLocalAudio</span></a>(<span class="- topic/ph ph">false</span>) 适用于只听不发的用户场景。</p>
   <p class="- topic/p p">语音功能关闭或重新开启后，会收到回调 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlocalaudiostatechanged" title="本地音频状态发生改变回调。"><span class="- topic/keyword keyword">onLocalAudioStateChanged</span></a>， 并报告 <span class="+ topic/keyword pr-d/apiname keyword apiname">LOCAL_AUDIO_STREAM_STATE_STOPPED</span>(0) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">LOCAL_AUDIO_STREAM_STATE_RECORDING</span>(1)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法与 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a> 的区别在于：
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">enableLocalVideo</span>: 开启或关闭本地语音采集及处理。使用 <code class="+ topic/ph pr-d/codeph ph codeph">enableLocalAudio</code> 关闭或开启本地采集后，本地听远端播放会有短暂中断。</li>
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">muteLocalAudioStream</span>: 停止或继续发送本地音频流。</li>   
  </ul>
       </li>       
       <li class="- topic/li li">该该方法在加入频道前后都能调用。</li> 
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_enablelocalaudio__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 重新开启本地语音功能，即开启本地语音采集（默认）；</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 关闭本地语音功能，即停止本地语音采集。</li>
  </ul>     
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enablelocalaudio__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title26" id="api_mutelocalaudiostream">
    <h2 class="- topic/title title topictitle2" id="ariaid-title26"><a href="class_irtcengine.aspx#api_mutelocalaudiostream"><span class="- topic/ph ph">muteLocalAudioStream</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_mutelocalaudiostream__shortdesc">取消或恢复发布本地音频流。</span></p><section class="- topic/section section" id="api_mutelocalaudiostream__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> muteLocalAudioStream(<strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_mutelocalaudiostream__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">成功调用该方法后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onusermuteaudio" title="远端用户静音回调。"><span class="- topic/keyword keyword">onUserMuteAudio</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法不影响音频采集状态，因为没有禁用音频采集设备。</li>
  <li class="- topic/li li">该方法在加入频道前后都能调用。如果你在该方法后调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setchannelprofile" title="设置频道场景。"><span class="- topic/keyword keyword">setChannelProfile</span></a> 方法， SDK 会根据你设置的频道场景以及用户角色，重新设置是否取消发布本地音频。因此我们建议在 <code class="+ topic/ph pr-d/codeph ph codeph">setChannelProfile</code> 后调用该方法。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_mutelocalaudiostream__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">是否取消发布本地音频流。</p>
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 取消发布。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>:（默认）发布。</li>
  </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_mutelocalaudiostream__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title27" id="api_muteremoteaudiostream">
    <h2 class="- topic/title title topictitle2" id="ariaid-title27"><a href="class_irtcengine.aspx#api_muteremoteaudiostream"><span class="- topic/ph ph">muteRemoteAudioStream</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_muteremoteaudiostream__shortdesc">取消或恢复订阅指定远端用户的音频流。</span></p><section class="- topic/section section" id="api_muteremoteaudiostream__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> muteRemoteAudioStream(uid_t userId, <strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_muteremoteaudiostream__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">该方法的推荐设置详见《设置订阅状态》。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_muteremoteaudiostream__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定用户的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">是否取消订阅指定远端用户的音频流。</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 取消订阅。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>:（默认）订阅。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_muteremoteaudiostream__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title28" id="api_muteallremoteaudiostreams">
    <h2 class="- topic/title title topictitle2" id="ariaid-title28"><a href="class_irtcengine.aspx#api_muteallremoteaudiostreams"><span class="- topic/ph ph">muteAllRemoteAudioStreams</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_muteallremoteaudiostreams__shortdesc">取消或恢复订阅所有远端用户的音频流。</span></p><section class="- topic/section section" id="api_muteallremoteaudiostreams__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> muteAllRemoteAudioStreams(<strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_muteallremoteaudiostreams__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">自 v3.3.0 起，成功调用该方法后，本地用户会取消或恢复订阅所有远端用户的音频流，包括在调用该方法后加入频道的用户的音频流。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">该方法的推荐设置详见《设置订阅状态》。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_muteallremoteaudiostreams__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">是否取消订阅所有远端用户的音频流。</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 取消订阅。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>:（默认）订阅。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_muteallremoteaudiostreams__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title29" id="api_setdefaultmuteallremoteaudiostreams">
    <h2 class="- topic/title title topictitle2" id="ariaid-title29"><a href="class_irtcengine.aspx#api_setdefaultmuteallremoteaudiostreams"><span class="- topic/ph ph">setDefaultMuteAllRemoteAudioStreams</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setdefaultmuteallremoteaudiostreams__shortdesc">默认取消或恢复订阅远端用户的音频流。</span></p><section class="- topic/section section" id="api_setdefaultmuteallremoteaudiostreams__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setDefaultMuteAllRemoteAudioStreams(<strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setdefaultmuteallremoteaudiostreams__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法自 v3.3.0 起废弃。</dd>
       
   </dl>
   <p class="- topic/p p" id="api_setdefaultmuteallremoteaudiostreams__sequence" data-ofbid="api_setdefaultmuteallremoteaudiostreams__sequence">该方法需要在加入频道后调用。调用成功后，本地用户取消或恢复订阅调用时刻之后加入频道的远端用户。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <p class="- topic/p p">取消订阅音频流后，如果需要恢复订阅频道内的远端，可以进行如下操作：</p>
       <ul class="- topic/ul ul">
  <li class="- topic/li li">如果需要恢复订阅单个用户的音频流，调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteremoteaudiostream" title="取消或恢复订阅指定远端用户的音频流。"><span class="- topic/keyword keyword">muteRemoteAudioStream</span></a> (<span class="- topic/ph ph">false</span>)，并指定你想要订阅的远端用户 ID。</li>
  <li class="- topic/li li">如果想恢复订阅多个用户的音频流，则需要多次调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">muteRemoteAudioStream</span> (<span class="- topic/ph ph">false</span>)。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setdefaultmuteallremoteaudiostreams__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">是否默认取消订阅远端用户的音频流：</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>：默认取消订阅。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>：（默认）默认订阅。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setdefaultmuteallremoteaudiostreams__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title30" id="api_enablevideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title30"><a href="class_irtcengine.aspx#api_enablevideo"><span class="- topic/ph ph">enableVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablevideo__shortdesc">启用视频模块。</span></p><section class="- topic/section section" id="api_enablevideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableVideo() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enablevideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   该方法可以在加入频道前或者通话中调用，在加入频道前调用则自动开启视频模块；在通话中调用则由音频模式切换为视频模式。 调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablevideo" title="关闭视频模块。"><span class="- topic/keyword keyword">disableVideo</span></a> 方法可关闭视频模式。 成功调用该方法后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged" title="远端视频状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteVideoStateChanged</span></a> 回调。
        <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
   <li class="- topic/li li">该方法在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 后仍然有效。</li>
   <li class="- topic/li li">该方法响应时间较慢，因此声网建议使用如下方法来控制视频模块：<ul class="- topic/ul ul">
       <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalvideo" title="开关本地视频采集。"><span class="- topic/keyword keyword">enableLocalVideo</span></a>: 是否启动摄像头采集并创建本地视频流。</li>
       <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalvideostream" title="开关本地视频发送。"><span class="- topic/keyword keyword">muteLocalVideoStream</span></a>: 是否发布本地视频流。</li>
       <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteremotevideostream" title="取消或恢复订阅指定远端用户的视频流。"><span class="- topic/keyword keyword">muteRemoteVideoStream</span></a>: 是否接收并播放远端视频流。</li>
       <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteallremotevideostreams" title="取消或恢复订阅所有远端用户的视频流。"><span class="- topic/keyword keyword">muteAllRemoteVideoStreams</span></a>: 是否接收并播放所有远端视频流。</li>
   </ul></li>
        </ul></div>
        </section>
        <section class="- topic/section section" id="api_enablevideo__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。 </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title31" id="api_disablevideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title31"><a href="class_irtcengine.aspx#api_disablevideo"><span class="- topic/ph ph">disableVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_disablevideo__shortdesc">关闭视频模块。</span></p><section class="- topic/section section" id="api_disablevideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> disableVideo() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_disablevideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法可以在加入频道前或者通话中调用，在加入频道前调用，则自动开启纯音频模式，在通话中调用则由视频模式切换为纯音频模式。 调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 方法可开启视频模式。成功调用该方法后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged" title="远端视频状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteVideoStateChanged</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 后仍然有效。</li>
       <li class="- topic/li li">该方法响应时间较慢，因此声网建议使用如下方法来控制视频模块：<ul class="- topic/ul ul">
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalvideo" title="开关本地视频采集。"><span class="- topic/keyword keyword">enableLocalVideo</span></a>: 是否启动摄像头采集并创建本地视频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalvideostream" title="开关本地视频发送。"><span class="- topic/keyword keyword">muteLocalVideoStream</span></a>: 是否发布本地视频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteremotevideostream" title="取消或恢复订阅指定远端用户的视频流。"><span class="- topic/keyword keyword">muteRemoteVideoStream</span></a>: 是否接收并播放远端视频流。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteallremotevideostreams" title="取消或恢复订阅所有远端用户的视频流。"><span class="- topic/keyword keyword">muteAllRemoteVideoStreams</span></a>: 是否接收并播放所有远端视频流。</li>
       </ul></li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_disablevideo__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。 </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title32" id="api_setvideoprofile">
    <h2 class="- topic/title title topictitle2" id="ariaid-title32"><a href="class_irtcengine.aspx#api_setvideoprofile"><span class="- topic/ph ph">setVideoProfile</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setvideoprofile__shortdesc">设置视频编码配置。</span></p><section class="- topic/section section" id="api_setvideoprofile__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setVideoProfile(VIDEO_PROFILE_TYPE profile, <strong class="hl-keyword">bool</strong> swapWidthAndHeight) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setvideoprofile__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法自 v2.3 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvideoencoderconfiguration" title="设置视频编码属性。"><span class="- topic/keyword keyword">setVideoEncoderConfiguration</span></a> 方法。</dd>
       
   </dl>
   <p class="- topic/p p">该方法设置视频的编码属性。 该方法在加入频道前后都能调用。 如果用户加入频道后不需要重新设置视频编码属性，则 Agora 建议在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 前调用该方法，可以加快首帧出图的时间。</p>
        </section>
        <section class="- topic/section section" id="api_setvideoprofile__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">profile</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频属性。详见: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_videoprofiletype" title="视频属性。"><span class="- topic/keyword keyword">VIDEO_PROFILE_TYPE</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">swapWidthAndHeight</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">SDK 会按照你选择的视频属性 (<span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span>) 输出固定宽高的视频。该参数设置是否交换宽和高：</p>
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 交换宽和高</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 不交换宽和高（默认）</li>
  </ul>
   <p class="- topic/p p">你可以直接通过视频属性 (<span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span>) 来定义输出的视频是 <span class="+ topic/keyword pr-d/parmname keyword parmname">Landscape</span>（横屏）还是 <span class="+ topic/keyword pr-d/parmname keyword parmname">Portrait</span>（竖屏）模式，因此 声网建议你将参数设置为默认值。</p>
  </dd>
       
   </dl>
   
        </section>
        <section class="- topic/section section" id="api_setvideoprofile__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title33" id="api_setvideoencoderconfiguration">
    <h2 class="- topic/title title topictitle2" id="ariaid-title33"><a href="class_irtcengine.aspx#api_setvideoencoderconfiguration"><span class="- topic/ph ph">setVideoEncoderConfiguration</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setvideoencoderconfiguration__shortdesc">设置视频编码属性。</span></p><section class="- topic/section section" id="api_setvideoencoderconfiguration__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setVideoEncoderConfiguration(<strong class="hl-keyword">const</strong> VideoEncoderConfiguration&amp; config) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_setvideoencoderconfiguration__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">设置本地视频的编码属性。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_setvideoencoderconfiguration__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">config</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频编码参数配置。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_videoencoderconfiguration" title="视频编码器配置的属性。"><span class="- topic/keyword keyword">VideoEncoderConfiguration</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setvideoencoderconfiguration__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title34" id="api_setuplocalvideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title34"><a href="class_irtcengine.aspx#api_setuplocalvideo"><span class="- topic/ph ph">setupLocalVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setuplocalvideo__shortdesc">初始化本地视图。</span></p><section class="- topic/section section" id="api_setuplocalvideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setupLocalVideo(<strong class="hl-keyword">const</strong> VideoCanvas&amp; canvas) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_setuplocalvideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   该方法初始化本地视图并设置本地用户视频显示信息，只影响本地用户看到的视频画面，不影响本地发布视频。调用该方法绑定本地视频流的显示视窗(<span class="+ topic/keyword pr-d/parmname keyword parmname">view</span>)，并设置本地用户视图的渲染模式和镜像模式。
   <p class="- topic/p p">在 App 开发中，通常在初始化后调用该方法进行本地视频设置，然后再加入频道。退出频道后，绑定仍然有效，如果需要解除绑定，可以指定空(<span class="- topic/ph ph">NULL</span>) <span class="+ topic/keyword pr-d/parmname keyword parmname">view</span> 调用该方法。</p>
        <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
   <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
       <li class="- topic/li li">如果你希望在通话中更新本地用户视图的渲染或镜像模式，请使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalrendermode1" title="更新本地视图显示模式。"><span class="- topic/keyword keyword">setLocalRenderMode</span></a> 方法。</li>
   </ul>
        </div>
        </section>
        <section class="- topic/section section" id="api_setuplocalvideo__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">canvas</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      视频画布信息: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_videocanvas" title="VideoCanvas 类的视频显示设置。"><span class="- topic/keyword keyword">VideoCanvas</span></a>。
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setuplocalvideo__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title35" id="api_setupremotevideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title35"><a href="class_irtcengine.aspx#api_setupremotevideo"><span class="- topic/ph ph">setupRemoteVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setupremotevideo__shortdesc">初始化远端用户视图。</span></p><section class="- topic/section section"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setupRemoteVideo(<strong class="hl-keyword">const</strong> VideoCanvas&amp; canvas) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_setupremotevideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法绑定远端用户和显示视图，并设置远端用户视图在本地显示时的渲染模式和镜像模式，只影响本地用户看到的视频画面。</p>
   <p class="- topic/p p">调用该接口时需要指定远端视频的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>，一般可以在进频道前提前设置好。</p>
   <p class="- topic/p p">如果 App 不能事先知道对方的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>，可以在 App 收到 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserjoined" title="远端用户（通信场景）/主播（直播场景）加入当前频道回调。"><span class="- topic/keyword keyword">onUserJoined</span></a> 事件时设置。如果启用了视频录制功能，视频录制服务会做为一个哑客户端加入频道，因此其他客户端也会收到它的 <span class="+ topic/keyword pr-d/apiname keyword apiname">onUserJoined</span> 事件，App 不应给它绑定视图（因为它不会发送视频流）。如果 App 不能识别哑客户端，可以在 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onfirstremotevideodecoded" title="已接收到远端视频并完成解码回调。"><span class="- topic/keyword keyword">onFirstRemoteVideoDecoded</span></a> 事件时再绑定视图。 解除某个用户的绑定视图可以把 <span class="+ topic/keyword pr-d/parmname keyword parmname">view</span> 设置为空。退出频道后，SDK 会把远端用户的绑定关系清除掉。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如果你希望在通话中更新远端用户视图的渲染或镜像模式，请使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setremoterendermode2" title="更新远端视图显示模式。"><span class="- topic/keyword keyword">setRemoteRenderMode</span></a> 方法。</div>
        </section>
        <section class="- topic/section section" id="api_setupremotevideo__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">canvas</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">视频画布信息。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_videocanvas" title="VideoCanvas 类的视频显示设置。"><span class="- topic/keyword keyword">VideoCanvas</span></a>。</p>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setupremotevideo__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title36" id="api_setlocalrendermode1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title36"><a href="class_irtcengine.aspx#api_setlocalrendermode1"><span class="- topic/ph ph">setLocalRenderMode</span></a> [1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalrendermode1__shortdesc">更新本地视图显示模式。</span></p><section class="- topic/section section" id="api_setlocalrendermode1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalRenderMode(RENDER_MODE_TYPE renderMode) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalrendermode1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">初始化本地用户视图后，你可以调用该方法更新本地用户视图的渲染和镜像模式。该方法只影响本地用户看到的视频画面，不影响本地发布视频。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setuplocalvideo" title="初始化本地视图。"><span class="- topic/keyword keyword">setupLocalVideo</span></a> 方法初始化本地视图后，调用该方法。</li>
  <li class="- topic/li li">你可以在通话中多次调用该方法，多次更新本地用户视图的显示模式。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setlocalrendermode1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">renderMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">本地视图的渲染模式：<a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rendermodetype" title="视频显示模式。"><span class="- topic/keyword keyword">RENDER_MODE_TYPE</span></a>。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mirrorMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">本地视图的镜像模式：<a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_videomirrormodetype" title="镜像模式类型。"><span class="- topic/keyword keyword">VIDEO_MIRROR_MODE_TYPE</span></a>。</p>
      <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如果你使用前置摄像头，则 SDK 默认启用本地用户视图镜像模式；如果你使用后置摄像头，则 SDK 默认关闭本地视图镜像模式。</div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalrendermode1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title37" id="api_setlocalrendermode2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title37"><a href="class_irtcengine.aspx#api_setlocalrendermode2"><span class="- topic/ph ph">setLocalRenderMode</span></a> [2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalrendermode2__shortdesc">更新本地视图显示模式。</span></p><section class="- topic/section section" id="api_setlocalrendermode2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalRenderMode(RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = <span class="hl-number">0</span>;</pre>       
      
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalrendermode2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">初始化本地用户视图后，你可以调用该方法更新本地用户视图的渲染和镜像模式。该方法只影响本地用户看到的视频画面，不影响本地发布视频。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setuplocalvideo" title="初始化本地视图。"><span class="- topic/keyword keyword">setupLocalVideo</span></a> 方法初始化本地视图后，调用该方法。</li>
  <li class="- topic/li li">你可以在通话中多次调用该方法，多次更新本地用户视图的显示模式。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setlocalrendermode2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">renderMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地视图的渲染模式，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rendermodetype" title="视频显示模式。"><span class="- topic/keyword keyword">RENDER_MODE_TYPE</span></a> </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mirrorMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">本地视图的渲染模式，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_videomirrormodetype" title="镜像模式类型。"><span class="- topic/keyword keyword">VIDEO_MIRROR_MODE_TYPE</span></a>。</p>
      <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如果你使用前置摄像头，默认启动本地用户视图镜像模式；如果你使用后置摄像头，默认关闭本地视图镜像模式。</div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalrendermode2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title38" id="api_setremoterendermode1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title38"><a href="class_irtcengine.aspx#api_setremoterendermode1"><span class="- topic/ph ph">setRemoteRenderMode</span></a> [1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremoterendermode1__shortdesc">设置远端视图显示模式。</span></p><section class="- topic/section section" id="api_setremoterendermode1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setremoterendermode1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法已废弃，请使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setremoterendermode2" title="更新远端视图显示模式。"><span class="- topic/keyword keyword">setRemoteRenderMode</span></a> [2/2]。</dd>
       
   </dl>
   <p class="- topic/p p">该方法设置远端视图显示模式。App 可以多次调用此方法更改显示模式。</p>
        </section>
        <section class="- topic/section section" id="api_setremoterendermode1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">renderMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rendermodetype" title="视频显示模式。"><span class="- topic/keyword keyword">RENDER_MODE_TYPE</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremoterendermode1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title39" id="api_setremoterendermode2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title39"><a href="class_irtcengine.aspx#api_setremoterendermode2"><span class="- topic/ph ph">setRemoteRenderMode</span></a> [2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremoterendermode2__shortdesc">更新远端视图显示模式。</span></p><section class="- topic/section section" id="api_setremoterendermode2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode, VIDEO_MIRROR_MODE_TYPE mirrorMode) = <span class="hl-number">0</span>;</pre>       
      
  </div>
        </section>
        <section class="- topic/section section" id="api_setremoterendermode2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.0.0</dd>
       
   </dl>
   <p class="- topic/p p">初始化远端用户视图后，你可以调用该方法更新远端用户视图在本地显示时的渲染和镜像模式。该方法只影响本地用户看到的视频画面。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setupremotevideo" title="初始化远端用户视图。"><span class="- topic/keyword keyword">setupRemoteVideo</span></a> 方法初始化远端视图后，调用该方法。</li>
  <li class="- topic/li li">你可以在通话中多次调用该方法，多次更新远端用户视图的显示模式。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setremoterendermode2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">远端用户 ID。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">renderMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">远端用户视图的渲染模式，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rendermodetype" title="视频显示模式。"><span class="- topic/keyword keyword">RENDER_MODE_TYPE</span></a>。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mirrorMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">远端用户视图的镜像模式，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_videomirrormodetype" title="镜像模式类型。"><span class="- topic/keyword keyword">VIDEO_MIRROR_MODE_TYPE</span></a>。</p>
      <div class="- topic/note note note note_note"><span class="note__title">注：</span> 默认关闭远端用户的镜像模式。</div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremoterendermode2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title40" id="api_startpreview">
    <h2 class="- topic/title title topictitle2" id="ariaid-title40"><a href="class_irtcengine.aspx#api_startpreview"><span class="- topic/ph ph">startPreview</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startpreview__shortdesc">开启视频预览。</span></p><section class="- topic/section section" id="api_startpreview__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startPreview() = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_startpreview__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法用于在进入频道前启动本地视频预览。调用该 API 前，必须：</p>
   <ul class="- topic/ul ul">
       <li class="- topic/li li">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setuplocalvideo" title="初始化本地视图。"><span class="- topic/keyword keyword">setupLocalVideo</span></a> 设置预览窗口及属性；</li>
       <li class="- topic/li li">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 开启视频功能。</li>
   </ul>
   <p class="- topic/p p">启用了本地视频预览后，如果调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a>退出频道，本地预览依然处于启动状态，如需要关闭本地预览，需要调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_stoppreview" title="停止视频预览。"><span class="- topic/keyword keyword">stopPreview</span></a>。</p>
        </section>
        <section class="- topic/section section" id="api_startpreview__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title41" id="api_stoppreview">
    <h2 class="- topic/title title topictitle2" id="ariaid-title41"><a href="class_irtcengine.aspx#api_stoppreview"><span class="- topic/ph ph">stopPreview</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stoppreview__shortdesc">停止视频预览。</span></p><section class="- topic/section section" id="api_stoppreview__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopPreview() = <span class="hl-number">0</span>;</pre>       
        
  </div>
        </section>
        <section class="- topic/section section" id="api_stoppreview__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title42" id="api_enablelocalvideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title42"><a href="class_irtcengine.aspx#api_enablelocalvideo"><span class="- topic/ph ph">enableLocalVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablelocalvideo__shortdesc">开关本地视频采集。</span></p><section class="- topic/section section" id="api_enablelocalvideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableLocalVideo(<strong class="hl-keyword">bool</strong> enabled) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_enablelocalvideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法禁用或重新启用本地视频采集，不影响接收远端视频。</p>
   <p class="- topic/p p">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 后，本地视频即默认开启。你可以调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalvideo" title="开关本地视频采集。"><span class="- topic/keyword keyword">enableLocalVideo</span></a>(<span class="- topic/ph ph">false</span>) 关闭本地视频采集。关闭后如果想要重新开启，则可调用 <code class="+ topic/ph pr-d/codeph ph codeph">enableLocalVideo(<span class="- topic/ph ph">true</span>)</code>。</p>
   <p class="- topic/p p">成功禁用或启用本地视频采集后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuserenablelocalvideo" title="其他用户启用/关闭本地视频。"><span class="- topic/keyword keyword">onUserEnableLocalVideo</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  <li class="- topic/li li">该方法设置内部引擎为启用状态，在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 后仍然有效。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_enablelocalvideo__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">是否开启本地视频采集。</p>
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启本地视频采集和渲染 (默认)。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 关闭使用本地摄像头设备。关闭后，远端用户会接收不到本地用户的视频流；但本地用户依然可以接收远端用户的视频流。设置为 <span class="- topic/ph ph">false</span> 时，该方法不需要本地有摄像头。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enablelocalvideo__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title43" id="api_mutelocalvideostream">
    <h2 class="- topic/title title topictitle2" id="ariaid-title43"><a href="class_irtcengine.aspx#api_mutelocalvideostream"><span class="- topic/ph ph">muteLocalVideoStream</span></a> </h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_mutelocalvideostream__shortdesc">开关本地视频发送。</span></p><section class="- topic/section section" id="api_mutelocalvideostream__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> agora::rtc::IRtcEngine::muteLocalVideoStream(<strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>; </pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_mutelocalvideostream__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">成功调用该方法后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onusermutevideo" title="远端用户暂停/恢复发送视频流回调。"><span class="- topic/keyword keyword">onUserMuteVideo</span></a> 回调。 
       <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
  <ul class="- topic/ul ul" id="api_mutelocalvideostream__ul_ogk_hwc_f4b">
      <li class="- topic/li li">调用该方法时，SDK 不再发送本地视频流，但摄像头仍然处于工作状态。相比于 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalvideo" title="开关本地视频采集。"><span class="- topic/keyword keyword">enableLocalVideo</span></a>(<span class="- topic/ph ph">false</span>)
 用于控制本地视频流发送的方法，该方法响应速度更快。该方法不影响本地视频流获取，没有禁用摄像头。 </li>
      <li class="- topic/li li">该方法在加入频道前后都能调用。如果你在该方法后调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setchannelprofile" title="设置频道场景。"><span class="- topic/keyword keyword">setChannelProfile</span></a> 方法，SDK
 会根据你设置的频道场景以及用户角色，重新设置是否停止发送本地视频。因此我们建议在 <span class="+ topic/keyword pr-d/apiname keyword apiname">setChannelProfile</span> 后调用该方法。</li>
  </ul>
       </div></div>
        </section>
        <section class="- topic/section section" id="api_mutelocalvideostream__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">
 <ul class="- topic/ul ul" id="api_mutelocalvideostream__ul_xwr_mxc_f4b">
     <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 不发送本地视频流</li>
     <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 发送本地视频流（默认）</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_mutelocalvideostream__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul" id="api_mutelocalvideostream__ul_gkv_dxc_f4b">
       <li class="- topic/li li">0:  方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title44" id="api_muteremotevideostream">
    <h2 class="- topic/title title topictitle2" id="ariaid-title44"><a href="class_irtcengine.aspx#api_muteremotevideostream"><span class="- topic/ph ph">muteRemoteVideoStream</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_muteremotevideostream__shortdesc">取消或恢复订阅指定远端用户的视频流。</span></p>
        <section class="- topic/section section" id="api_muteremotevideostream__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> muteRemoteVideoStream(uid_t userId, <strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_muteremotevideostream__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
        </section>
        <section class="- topic/section section">
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">该方法的推荐设置详见《设置订阅状态》。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_muteremotevideostream__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">指定用户的用户 ID。</p>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 停止接收指定远端用户的视频流。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 允许接收指定远端用户的视频流（默认）。</li>
  </ul>
      </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_muteremotevideostream__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。 </li>
   </ul>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title45" id="api_muteallremotevideostreams">
    <h2 class="- topic/title title topictitle2" id="ariaid-title45"><a href="class_irtcengine.aspx#api_muteallremotevideostreams"><span class="- topic/ph ph">muteAllRemoteVideoStreams</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_muteallremotevideostreams__shortdesc">取消或恢复订阅所有远端用户的视频流。</span></p><section class="- topic/section section" id="api_muteallremotevideostreams__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> muteAllRemoteVideoStreams(<strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>       
      
  </div>
        </section>
        <section class="- topic/section section" id="api_muteallremotevideostreams__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">自 v3.3.0 起，成功调用该方法后，本地用户会取消或恢复订阅所有远端用户的视频流，包括在调用该方法后加入频道的用户的视频流。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">该方法的推荐设置详见《设置订阅状态》。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_muteallremotevideostreams__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">
 <ul class="- topic/ul ul">
     <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 停止接收所有远端视频流；</li>
     <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 允许接收所有远端视频流（默认）。</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_muteallremotevideostreams__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li"> &lt; 0: 方法调用失败。 </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title46" id="api_setdefaultmuteallremotevideostreams">
    <h2 class="- topic/title title topictitle2" id="ariaid-title46"><a href="class_irtcengine.aspx#api_setdefaultmuteallremotevideostreams"><span class="- topic/ph ph">setDefaultMuteAllRemoteVideoStreams</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setdefaultmuteallremotevideostreams__shortdesc">设置是否默认停止接收视频流。</span></p><section class="- topic/section section" id="api_setdefaultmuteallremotevideostreams__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setDefaultMuteAllRemoteVideoStreams(<strong class="hl-keyword">bool</strong> mute) = <span class="hl-number">0</span>;</pre>       
      
  </div>
        </section>
        <section class="- topic/section section" id="api_setdefaultmuteallremotevideostreams__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_setdefaultmuteallremotevideostreams__sequence" data-ofbid="api_setdefaultmuteallremotevideostreams__sequence">该方法在加入频道前后都可调用。如果在加入频道后调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setDefaultMuteAllRemoteVideoStreams</span>(<span class="- topic/ph ph">true</span>)，会接收不到设置后加入频道的用户的视频流。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       停止接收视频流后，如果想要恢复接收，请调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteremotevideostream" title="取消或恢复订阅指定远端用户的视频流。"><span class="- topic/keyword keyword">muteRemoteVideoStream</span></a>(<span class="- topic/ph ph">false</span>)，并指定你想要接收的远端用户 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>； 如果想恢复接收多个用户的视频流，则需要多次调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">muteRemoteVideoStream</span>。<span class="+ topic/keyword pr-d/apiname keyword apiname">setDefaultMuteAllRemoteVideoStreams</span>(<span class="- topic/ph ph">false</span>) 只能恢复接收后面加入频道的用户的视频流。
   </div>
        </section>
        <section class="- topic/section section" id="api_setdefaultmuteallremotevideostreams__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mute</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">
 <ul class="- topic/ul ul">
     <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 默认停止接收所有远端视频；</li>
     <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 默认接收所有远端视频（默认）。</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setdefaultmuteallremotevideostreams__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title47" id="api_setbeautyeffectoptions">
    <h2 class="- topic/title title topictitle2" id="ariaid-title47"><a href="class_irtcengine.aspx#api_setbeautyeffectoptions"><span class="- topic/ph ph">setBeautyEffectOptions</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setbeautyeffectoptions__shortdesc">设置美颜效果选项</span></p><section class="- topic/section section" id="api_setbeautyeffectoptions__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setBeautyEffectOptions(<strong class="hl-keyword">bool</strong> enabled, BeautyOptions options) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setbeautyeffectoptions__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.0.0</dd>
  
  
       
   </dl>
   <p class="- topic/p p">开启本地美颜功能，并设置美颜效果选项。</p>
   <p class="- topic/p p">该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 后调用。</p>
   
        </section>
        <section class="- topic/section section" id="api_setbeautyeffectoptions__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">是否开启美颜功能：<ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>:（默认）关闭。</li>
  </ul></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">options</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">美颜选项，详细定义见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_beautyoptions" title="美颜选项。"><span class="- topic/keyword keyword">BeautyOptions</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setbeautyeffectoptions__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用成功。
  </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title48" id="class_irtcengine2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title48"><a href="class_irtcengine.aspx#class_irtcengine2"><span class="- topic/ph ph">IRtcEngine2</span></a></h2>
    <p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_irtcengine2__shortdesc">继承自 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。">agora::rtc::IRtcEngine</a>。</span></p>
<article class="- topic/topic reference/reference topic reference nested2" aria-labelledby="ariaid-title49" id="api_createChannel">
    <h3 class="- topic/title title topictitle3" id="ariaid-title49"><a href="class_irtcengine.aspx#api_createChannel"><span class="- topic/ph ph">createChannel</span></a></h3>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_createChannel__shortdesc">创建并获取一个 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。">IChannel</a> 对象。</span></p><section class="- topic/section section" id="api_createChannel__prototype"><h4 class="- topic/title title sectiontitle">原型</h4>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> IChannel* createChannel(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *channelId) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_createChannel__detailed_desc"><h4 class="- topic/title title sectiontitle">详细描述</h4>
   
   <p class="- topic/p p">你可以多次调用该方法，创建多个 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。">IChannel</a> 对象，再调用各 <span class="+ topic/keyword pr-d/apiname keyword apiname">IChannel</span> 对象中的 <a href="class_ichannel.aspx#api_ichannel_joinchannel"><span class="- topic/ph ph">joinChannel</span></a> 方法，实现同时加入多个频道。</p>
   <p class="- topic/p p">加入多个频道后，你可以同时订阅各个频道的音、视频流；但是同一时间只能在一个频道发布一路音、视频流。</p>
        </section>
        <section class="- topic/section section" id="api_createChannel__parameters"><h4 class="- topic/title title sectiontitle">参数</h4>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channelId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">标识频道的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）:<ul class="- topic/ul ul">
     <li class="- topic/li li">26 个小写英文字母 a~z</li>
     <li class="- topic/li li">26 个大写英文字母 A~Z</li>
     <li class="- topic/li li">10 个数字 0~9</li>
     <li class="- topic/li li">空格</li>
     <li class="- topic/li li">"!"、"#"、"$"、"%"、"&amp;"、"("、")"、"+"、"-"、":"、";"、"&lt;"、"="、"."、"&gt;"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","</li>
 </ul></div>
      <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
 <ul class="- topic/ul ul">
     <li class="- topic/li li">参数没有默认值，请确保对参数设值。</li>
     <li class="- topic/li li">请勿将该参数设为空字符 <code class="+ topic/ph pr-d/codeph ph codeph">""</code>，否则 SDK 会返回 <code class="+ topic/ph pr-d/codeph ph codeph">ERR_REFUSED</code>(5)。</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_createChannel__return_values"><h4 class="- topic/title title sectiontitle">返回值</h4>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">方法调用成功，返回 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 对象的指针。</li>
       <li class="- topic/li li">方法调用失败，返回一个空指针 <span class="- topic/ph ph">NULL</span>。</li>
   </ul>
        </section></div>
</article></article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title50" id="api_startscreencapture">
    <h2 class="- topic/title title topictitle2" id="ariaid-title50"><a href="class_irtcengine.aspx#api_startscreencapture"><span class="- topic/ph ph">startScreenCapture</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startscreencapture__shortdesc">开始屏幕共享。</span></p><section class="- topic/section section" id="api_startscreencapture__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startScreenCapture(WindowIDType windowId, <strong class="hl-keyword">int</strong> captureFreq, <strong class="hl-keyword">const</strong> Rect* rect, <strong class="hl-keyword">int</strong> bitrate) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startscreencapture__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法从 v2.4.0 起废弃，请使用以下方法作为替代：<ul class="- topic/ul ul">
      <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_startscreencapturebydisplayid" title="通过屏幕 ID 共享屏幕。"><span class="- topic/keyword keyword">startScreenCaptureByDisplayId</span></a></li>
      <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_startscreencapturebyscreenrect" title="通过指定区域共享屏幕。"><span class="- topic/keyword keyword">startScreenCaptureByScreenRect</span></a></li>
      <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_startscreencapturebywindowid" title="通过窗口 ID 共享窗口。"><span class="- topic/keyword keyword">startScreenCaptureByWindowId</span></a></li>
  </ul></dd>
       
   </dl>
   <div class="- topic/p p">该方法共享整个屏幕、指定窗口、或指定区域。<ul class="- topic/ul ul">
       <li class="- topic/li li">共享整个屏幕：将 <span class="+ topic/keyword pr-d/parmname keyword parmname">windowId</span> 设为 0，且将 <span class="+ topic/keyword pr-d/parmname keyword parmname">rect</span> 设为 <span class="- topic/ph ph">NULL</span>。</li>
       <li class="- topic/li li">共享指定窗口：将 <span class="+ topic/keyword pr-d/parmname keyword parmname">windowId</span> 设为非 0，每个窗口都有一个非 0 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">windowId</span>。</li>
       <li class="- topic/li li">共享指定区域：将 <span class="+ topic/keyword pr-d/parmname keyword parmname">windowId</span> 设为 0，且将 <span class="+ topic/keyword pr-d/parmname keyword parmname">rect</span> 设为非 <span class="- topic/ph ph">NULL</span>。在这个情况下，你可以共享指定区域，例如你可以拖动鼠标选中要共享的区域，但这个逻辑你由你自己实现的。这里的共享指定区域指的是共享整个屏幕里的某个区域。目前暂不支持共享指定窗口里的指定区域。</li>
   </ul></div>
   <div class="- topic/note note note note_note info"><span class="note__title">注：</span> 当开启屏幕共享功能时，<span class="+ topic/keyword pr-d/parmname keyword parmname">captureFreq</span> 参数为共享屏幕的帧率，值区间为 1 到 15 fps（必填）。无论你开启的是上述哪个功能，执行成功时均返回 0，执行失败时返回错误代码。</div>
        </section>
        <section class="- topic/section section" id="api_startscreencapture__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">windowId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">共享屏幕区域。 </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">captureFreq</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">共享屏幕的帧率，必须设置，范围是 1 到 15 fps。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">屏幕共享区域，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rect" title="屏幕共享区域。"><span class="- topic/keyword keyword">Rect</span></a> 当 <span class="+ topic/keyword pr-d/parmname keyword parmname">windowId</span> 设为 0 时该参数有效；当你将 <span class="+ topic/keyword pr-d/parmname keyword parmname">rect</span> 设为 <span class="- topic/ph ph">NULL</span> 时，整个屏幕被共享。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">bitrate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">共享屏幕的码率。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startscreencapture__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title51" id="api_startscreencapturebydisplayid">
    <h2 class="- topic/title title topictitle2" id="ariaid-title51"><a href="class_irtcengine.aspx#api_startscreencapturebydisplayid"><span class="- topic/ph ph">startScreenCaptureByDisplayId</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startscreencapturebydisplayid__shortdesc">通过屏幕 ID 共享屏幕。</span></p><section class="- topic/section section" id="api_startscreencapturebydisplayid__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startScreenCaptureByDisplayId(<strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> displayId, <strong class="hl-keyword">const</strong> Rectangle&amp; regionRect, <strong class="hl-keyword">const</strong> ScreenCaptureParameters&amp; captureParams) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebydisplayid__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
   <p class="- topic/p p">共享一个屏幕或该屏幕的部分区域。用户需要在该方法中指定想要共享的屏幕 ID。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法仅适用于 macOS。</li>
       <li class="- topic/li li">该方法需要在加入频道后调用。</li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebydisplayid__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">displayId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定待共享的屏幕 ID。开发者需要通过该参数指定你要共享的那个屏幕。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">regionRect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">（可选）指定待共享区域相对于整个屏幕的位置。如不填，则表示共享整个屏幕。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rectangle" title="待共享区域相对于整个屏幕或窗口的位置，如不填，则表示共享整个屏幕或窗口。"><span class="- topic/keyword keyword">Rectangle</span></a>。如果设置的共享区域超出了屏幕的边界，则只共享屏幕视窗内的内容；如果宽或高为 0，则共享整个屏幕。</dd>
       
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">captureParams</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">屏幕共享的参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_screencaptureparameters" title="屏幕共享的参数配置。"><span class="- topic/keyword keyword">ScreenCaptureParameters</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebydisplayid__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title52" id="api_startscreencapturebyscreenrect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title52"><a href="class_irtcengine.aspx#api_startscreencapturebyscreenrect"><span class="- topic/ph ph">startScreenCaptureByScreenRect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startscreencapturebyscreenrect__shortdesc">通过指定区域共享屏幕。</span></p><section class="- topic/section section" id="api_startscreencapturebyscreenrect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startScreenCaptureByScreenRect(<strong class="hl-keyword">const</strong> Rectangle&amp; screenRect, <strong class="hl-keyword">const</strong> Rectangle&amp; regionRect, <strong class="hl-keyword">const</strong> ScreenCaptureParameters&amp; captureParams) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebyscreenrect__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
   <p class="- topic/p p">共享一个屏幕或该屏幕的部分区域。用户需要在该方法中指定想要共享的屏幕区域。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">该方法仅适用于 Windows 平台。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebyscreenrect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">screenRect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定待共享的屏幕相对于虚拟屏的位置。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">regionRect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">(可选）指定待共享区域相对于整个屏幕的位置。如不填，则表示共享整个屏幕。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rectangle" title="待共享区域相对于整个屏幕或窗口的位置，如不填，则表示共享整个屏幕或窗口。"><span class="- topic/keyword keyword">Rectangle</span></a>。如果设置的共享区域超出了屏幕的边界，则只共享屏幕内的内容；如果将 width 或 height 设为 0 ，则共享整个屏幕。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">captureParams</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">屏幕共享的编码参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_screencaptureparameters" title="屏幕共享的参数配置。"><span class="- topic/keyword keyword">ScreenCaptureParameters</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebyscreenrect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title53" id="api_startscreencapturebywindowid">
    <h2 class="- topic/title title topictitle2" id="ariaid-title53"><a href="class_irtcengine.aspx#api_startscreencapturebyscreenrect"><span class="- topic/ph ph">startScreenCaptureByScreenRect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startscreencapturebywindowid__shortdesc">通过窗口 ID 共享窗口。</span></p><section class="- topic/section section" id="api_startscreencapturebywindowid__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startScreenCaptureByWindowId(view_t windowId, <strong class="hl-keyword">const</strong> Rectangle&amp; regionRect, <strong class="hl-keyword">const</strong> ScreenCaptureParameters&amp; captureParams) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebywindowid__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
   <p class="- topic/p p">共享一个窗口或该窗口的部分区域。用户需要在该方法中指定想要共享的窗口 ID。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">该方法仅适用于 macOS 和 Windows 平台。</li>
       </ul>
   </div>
   
   <div class="- topic/p p">
       <table class="- topic/table table" id="api_startscreencapturebywindowid__table_lvk_tfs_r4b" data-ofbid="api_startscreencapturebywindowid__table_lvk_tfs_r4b"><caption></caption><colgroup><col /><col /><col /><col /></colgroup><tbody class="- topic/tbody tbody">
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0"><strong class="+ topic/ph hi-d/b ph b">系统版本</strong></td>
     <td class="- topic/entry entry colsep-0 rowsep-0"><strong class="+ topic/ph hi-d/b ph b">软件</strong></td>
     <td class="- topic/entry entry colsep-0 rowsep-0"><strong class="+ topic/ph hi-d/b ph b">软件版本</strong></td>
     <td class="- topic/entry entry colsep-0 rowsep-0"><strong class="+ topic/ph hi-d/b ph b">是否支持</strong></td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="8">win10</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">Chrome</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">76.0.3809.100</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">否</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office Word</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">18.1903.1152.0</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office Excel</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">否</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office PPT</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS Word</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">11.1.0.9145</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS Excel</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS PPT</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Media Player（系统自带）</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">全部</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="8">win8</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">Chrome</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">全部</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office Word</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">全部</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office Excel</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office PPT</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS Word</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">11.1.0.9098</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS Excel</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS PPT</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Media Player（系统自带）</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">全部</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="8">win7</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">Chrome</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">73.0.3683.103</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">否</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office Word</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">全部</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="3">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office Excel</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Office PPT</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS Word</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="2">11.1.0.9098</td>
     <td class="- topic/entry entry colsep-0 rowsep-0" rowspan="2">否</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS Excel</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">WPS PPT</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">11.1.0.9098</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">是</td>
 </tr>
 <tr class="- topic/row">
     <td class="- topic/entry entry colsep-0 rowsep-0">Media Player（系统自带）</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">全部</td>
     <td class="- topic/entry entry colsep-0 rowsep-0">否</td>
 </tr>
      </tbody></table>
   </div>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebywindowid__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">windowId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定待共享的窗口 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">regionRect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">（可选）指定待共享区域相对于整个屏幕的位置。如不填，则表示共享整个屏幕。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rectangle" title="待共享区域相对于整个屏幕或窗口的位置，如不填，则表示共享整个屏幕或窗口。"><span class="- topic/keyword keyword">Rectangle</span></a>。如果设置的共享区域超出了窗口的边界，则只共享窗口内的内容；如果宽或高为 0，则共享整个窗口。</dd>
       
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">captureParams</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">屏幕共享的参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_screencaptureparameters" title="屏幕共享的参数配置。"><span class="- topic/keyword keyword">ScreenCaptureParameters</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startscreencapturebywindowid__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title54" id="api_setscreencapturecontenthint">
    <h2 class="- topic/title title topictitle2" id="ariaid-title54"><a href="class_irtcengine.aspx#api_setscreencapturecontenthint"><span class="- topic/ph ph">setScreenCaptureContentHint</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setscreencapturecontenthint__shortdesc">设置屏幕共享内容类型</span></p><section class="- topic/section section" id="api_setscreencapturecontenthint__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setScreenCaptureContentHint(VideoContentHint contentHint) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setscreencapturecontenthint__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
   <p class="- topic/p p">Agora SDK 会根据不同的内容类型，使用不同的算法对共享效果进行优化。如果不调用该方法，SDK 会将屏幕共享的内容默认为 <span class="- topic/ph ph">CONTENT_HINT_NONE</span>，即无指定的内容类型。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在开始屏幕共享前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_setscreencapturecontenthint__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">contentHint</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">屏幕共享的内容类型。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_videocontenthint" title="屏幕共享的内容类型。"><span class="- topic/keyword keyword">VideoContentHint</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setscreencapturecontenthint__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title55" id="api_updatescreencaptureparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title55"><a href="class_irtcengine.aspx#api_updatescreencaptureparameters"><span class="- topic/ph ph">updateScreenCaptureParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_updatescreencaptureparameters__shortdesc">更新屏幕共享的参数配置。</span></p><section class="- topic/section section" id="api_updatescreencaptureparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> updateScreenCaptureParameters(<strong class="hl-keyword">const</strong> ScreenCaptureParameters&amp; captureParams) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">captureParams</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">屏幕共享的编码参数配置。默认的分辨率为 1920 x 1080，即 2073600 像素。该像素值为计费标准。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_screencaptureparameters" title="屏幕共享的参数配置。"><span class="- topic/keyword keyword">ScreenCaptureParameters</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">-3(ERR_NOT_READY): 如果当前没有共享的屏幕，会返回该错误码。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title56" id="api_updatescreencaptureregion1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title56"><a href="class_irtcengine.aspx#api_updatescreencaptureregion1"><span class="- topic/ph ph">updateScreenCaptureRegion</span></a> [1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_updatescreencaptureregion1__shortdesc">更新屏幕共享区域。</span></p><section class="- topic/section section" id="api_updatescreencaptureregion1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> updateScreenCaptureRegion(<strong class="hl-keyword">const</strong> Rectangle&amp; regionRect) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureregion1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureregion1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">regionRect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">待共享区域相对于整个屏幕或窗口的位置，如不填，则表示共享整个屏幕或窗口。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rectangle" title="待共享区域相对于整个屏幕或窗口的位置，如不填，则表示共享整个屏幕或窗口。"><span class="- topic/keyword keyword">Rectangle</span></a>。
      如果设置的共享区域超出了屏幕或窗口的边界，则只共享屏幕或窗口内的内容；如果将 width 或 height 设为 0 ，则共享整个屏幕或窗口。</dd>
       
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureregion1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">-3(ERR_NOT_READY): 如果当前没有共享的屏幕，会返回该错误码。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title57" id="api_updatescreencaptureregion2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title57"><a href="class_irtcengine.aspx#api_updatescreencaptureregion2"><span class="- topic/ph ph">updateScreenCaptureRegion</span></a> [2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_updatescreencaptureregion2__shortdesc">更新屏幕共享区域。</span></p><section class="- topic/section section" id="api_updatescreencaptureregion2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> updateScreenCaptureRegion(<strong class="hl-keyword">const</strong> Rect* rect) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureregion2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
      
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法从 v2.4.0 起废弃，请使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_updatescreencaptureregion1" title="更新屏幕共享区域。"><span class="- topic/keyword keyword">updateScreenCaptureRegion</span></a> [1/2]。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureregion2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rect</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">待共享区域相对于整个屏幕的位置，如不填，则表示共享整个屏幕。 详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rect" title="屏幕共享区域。"><span class="- topic/keyword keyword">Rect</span></a>。如果设置的共享区域超出了屏幕或窗口的边界，则只共享屏幕或窗口内的内容；如果将 width 或 height 设为 0 ，则共享整个屏幕或窗口。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatescreencaptureregion2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。
  <ul class="- topic/ul ul">
      <li class="- topic/li li">-3(ERR_NOT_READY): 如果当前没有共享的屏幕，会返回该错误码。</li>
  </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title58" id="api_stopscreencapture">
    <h2 class="- topic/title title topictitle2" id="ariaid-title58"><a href="class_irtcengine.aspx#api_stopscreencapture"><span class="- topic/ph ph">stopScreenCapture</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopscreencapture__shortdesc">停止屏幕共享。</span></p><section class="- topic/section section" id="api_stopscreencapture__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopScreenCapture() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stopscreencapture__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title59" id="api_startaudiomixing">
    <h2 class="- topic/title title topictitle2" id="ariaid-title59"><a href="class_irtcengine.aspx#api_startaudiomixing"><span class="- topic/ph ph">startAudioMixing</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startaudiomixing__shortdesc">开始播放音乐文件。</span></p><section class="- topic/section section" id="api_startaudiomixing__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startAudioMixing(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath, <strong class="hl-keyword">bool</strong> loopback, <strong class="hl-keyword">bool</strong> replace, <strong class="hl-keyword">int</strong> cycle) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startaudiomixing__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">指定本地或在线音频文件来和麦克风采集的音频流进行混音和替换。替换是指用音频文件替换音频采集设备采集的音频流。该方法可以选择是否让对方听到本地播 放的音频并指定循环播放的次数。成功调用该方法后，本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onaudiomixingstatechanged" title="本地用户的音乐文件播放状态已改变回调。"><span class="- topic/keyword keyword">onAudioMixingStateChanged</span></a> (<code class="+ topic/ph pr-d/codeph ph codeph">PLAY</code>) 回调。播放结束后， 会收到 <span class="+ topic/keyword pr-d/apiname keyword apiname">onAudioMixingStateChanged</span> (<code class="+ topic/ph pr-d/codeph ph codeph">STOPPED</code>) 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在频道内调用该方法，如果在频道外调用该方法可能会出现问题。</li>
  <li class="- topic/li li">如果本地音乐文件不存在、文件格式不支持、无法访问在线音乐文件 URL 都会返回警告码 <code class="+ topic/ph pr-d/codeph ph codeph">WARN_AUDIO_MIXING_OPEN_ERROR</code> (701)。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startaudiomixing__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定需要混音的本地或在线音频文件的绝对路径，例如：<span class="+ topic/ph sw-d/filepath ph filepath">C:/music/audio.mp4</span>。建议填写文件后缀名。若无法确定文件后缀名，可不填。
      支持的音频格式包括：3GP、ASF、ADTS、AVI、MP3、MP4、MPEG-4、SAMI 和 WAVE。 详见 <a class="- topic/xref xref" href="https://docs.microsoft.com/zh-cn/windows/win32/medfound/supported-media-formats-in-media-foundation" target="_blank" rel="external noopener">Supported Media Formats in Media Foundation</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">loopback</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 只有本地用户可以听到混音的音频；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 本地用户和远端用户都能听到混音的音频。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">replace</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 只推送指定的本地音频文件或者线上音频文件，不传输麦克风收录的音频。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 本地音频文件与来自麦克风的音频流混音。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">cycle</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">循环播放次数：
      <ul class="- topic/ul ul">
 <li class="- topic/li li">正整数: 循环播放的次数；</li>
 <li class="- topic/li li">-1: 无限循环。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startaudiomixing__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title60" id="api_stopaudiomixing">
    <h2 class="- topic/title title topictitle2" id="ariaid-title60"><a href="class_irtcengine.aspx#api_stopaudiomixing"><span class="- topic/ph ph">stopAudioMixing</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopaudiomixing__shortdesc">停止播放音乐文件。</span></p><section class="- topic/section section" id="api_stopaudiomixing__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopAudioMixing() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stopaudiomixing__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法停止播放音乐文件。请在频道内调用该方法。</p>
        </section>
        <section class="- topic/section section" id="api_stopaudiomixing__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title61" id="api_pauseaudiomixing">
    <h2 class="- topic/title title topictitle2" id="ariaid-title61"><a href="class_irtcengine.aspx#api_pauseaudiomixing"><span class="- topic/ph ph">pauseAudioMixing</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_pauseaudiomixing__shortdesc">暂停播放音乐文件。</span></p><section class="- topic/section section" id="api_pauseaudiomixing__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> pauseAudioMixing() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_pauseaudiomixing__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法暂停播放音乐文件。请在频道内调用该方法。</p>
        </section>
        <section class="- topic/section section" id="api_pauseaudiomixing__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title62" id="api_resumeaudiomixing">
    <h2 class="- topic/title title topictitle2" id="ariaid-title62"><a href="class_irtcengine.aspx#api_resumeaudiomixing"><span class="- topic/ph ph">resumeAudioMixing</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_resumeaudiomixing__shortdesc">恢复播放音乐文件。</span></p><section class="- topic/section section" id="api_resumeaudiomixing__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> resumeAudioMixing() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_resumeaudiomixing__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法恢复混音，继续播放音乐文件。请在频道内调用该方法。</p>
        </section>
        <section class="- topic/section section" id="api_resumeaudiomixing__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title63" id="api_adjustaudiomixingvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title63"><a href="class_irtcengine.aspx#api_adjustaudiomixingvolume"><span class="- topic/ph ph">adjustAudioMixingVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_adjustaudiomixingvolume__shortdesc">调节音乐文件的播放音量。</span></p><section class="- topic/section section" id="api_adjustaudiomixingvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> adjustAudioMixingVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法调节混音音乐文件在本端和远端的播放音量大小。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a> 后调用。</li>
  <li class="- topic/li li">调用该方法不影响调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_playeffect2" title="播放指定音效文件。"><span class="- topic/keyword keyword">playEffect</span></a> 播放音效文件的音量。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音乐文件音量范围为 0~100。100 （默认值）为原始文件音量。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title64" id="api_adjustaudiomixingplayoutvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title64"><a href="class_irtcengine.aspx#api_adjustaudiomixingplayoutvolume"><span class="- topic/ph ph">adjustAudioMixingPlayoutVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_adjustaudiomixingplayoutvolume__shortdesc">调节音乐文件本端播放音量。</span></p><section class="- topic/section section" id="api_adjustaudiomixingplayoutvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> adjustAudioMixingPlayoutVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingplayoutvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法调节混音音乐文件在本端的播放音量大小。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a> 后调用。
   </div>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingplayoutvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音乐文件音量范围为 0~100。100 （默认值）为原始文件音量。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingplayoutvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title65" id="api_adjustaudiomixingpublishvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title65"><a href="class_irtcengine.aspx#api_adjustaudiomixingpublishvolume"><span class="- topic/ph ph">adjustAudioMixingPublishVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_adjustaudiomixingpublishvolume__shortdesc">调节音乐文件远端播放音量。</span></p><section class="- topic/section section" id="api_adjustaudiomixingpublishvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> adjustAudioMixingPublishVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingpublishvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法调节混音音乐文件在远端的播放音量大小。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a> 后调用。
   </div>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingpublishvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音乐文件音量范围为 0~100。100 （默认值）为原始文件音量。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_adjustaudiomixingpublishvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title66" id="api_setaudiomixingpitch">
    <h2 class="- topic/title title topictitle2" id="ariaid-title66"><a href="class_irtcengine.aspx#api_setaudiomixingpitch"><span class="- topic/ph ph">setAudioMixingPitch</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setaudiomixingpitch__shortdesc">调整本地播放的音乐文件的音调。</span></p><section class="- topic/section section" id="api_setaudiomixingpitch__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setAudioMixingPitch(<strong class="hl-keyword">int</strong> pitch) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setaudiomixingpitch__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.0.1</dd>
       
   </dl>
   <p class="- topic/p p">本地人声和播放的音乐文件混音时，调用该方法可以仅调节音乐文件的音调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a> 后调用。</div>
        </section>
        <section class="- topic/section section" id="api_setaudiomixingpitch__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">pitch</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">按半音音阶调整本地播放的音乐文件的音调，默认值为 0，即不调整音调。取值范围为 [-12,12]，每相邻两个值的音高距离相差半音。取值的绝对值越大，音调升高或降低得越多。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setaudiomixingpitch__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title67" id="api_getaudiomixingplayoutvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title67"><a href="class_irtcengine.aspx#api_getaudiomixingplayoutvolume"><span class="- topic/ph ph">getAudioMixingPlayoutVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getaudiomixingplayoutvolume__shortdesc">获取音乐文件的本地播放音量。</span></p><section class="- topic/section section" id="api_getaudiomixingplayoutvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getAudioMixingPlayoutVolume() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingplayoutvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法获取混音的音乐文件本地播放音量，方便排查音量相关问题。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 请在频道内调用该方法。</div>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingplayoutvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">≥ 0: 方法调用成功则返回音量值，范围为 [0,100]。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title68" id="api_getaudiomixingpublishvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title68"><a href="class_irtcengine.aspx#api_getaudiomixingpublishvolume"><span class="- topic/ph ph">getAudioMixingPublishVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getaudiomixingpublishvolume__shortdesc">获取音乐文件的远端播放音量。</span></p><section class="- topic/section section" id="api_getaudiomixingpublishvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getAudioMixingPublishVolume() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingpublishvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该接口可以方便开发者排查音量相关问题。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 请在频道中调用该方法。</div>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingpublishvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">≥ 0: 方法调用成功则返回音量值，范围为 [0,100]。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title69" id="api_getaudiomixingduration">
    <h2 class="- topic/title title topictitle2" id="ariaid-title69"><a href="class_irtcengine.aspx#api_getaudiomixingduration"><span class="- topic/ph ph">getAudioMixingDuration</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getaudiomixingduration__shortdesc">获取音乐文件总时长。</span></p><section class="- topic/section section" id="api_getaudiomixingduration__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getAudioMixingDuration() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingduration__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法获取音乐文件总时长，单位为毫秒。请在频道内调用该方法。</p>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingduration__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">≥ 0: 方法调用成功返回音乐文件时长。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title70" id="api_getaudiomixingcurrentposition">
    <h2 class="- topic/title title topictitle2" id="ariaid-title70"><a href="class_irtcengine.aspx#api_getaudiomixingcurrentposition"><span class="- topic/ph ph">getAudioMixingCurrentPosition</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getaudiomixingcurrentposition__shortdesc">获取音乐文件的播放进度。</span></p><section class="- topic/section section" id="api_getaudiomixingcurrentposition__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getAudioMixingCurrentPosition() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingcurrentposition__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法获取当前音乐文件播放进度，单位为毫秒。请在频道内调用该方法。</p>
        </section>
        <section class="- topic/section section" id="api_getaudiomixingcurrentposition__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">≥ 0: 方法调用成功返回音乐文件播放进度。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title71" id="api_setaudiomixingposition">
    <h2 class="- topic/title title topictitle2" id="ariaid-title71"><a href="class_irtcengine.aspx#api_setaudiomixingposition"><span class="- topic/ph ph">setAudioMixingPosition</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setaudiomixingposition__shortdesc">设置音乐文件的播放位置。</span></p><section class="- topic/section section" id="api_setaudiomixingposition__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setAudioMixingPosition(<strong class="hl-keyword">int</strong> pos <em class="hl-comment">/*in ms*/</em>) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setaudiomixingposition__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法可以设置音频文件的播放位置，这样你可以根据实际情况播放文件，而非从头到尾播放整个文件。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a> 后调用。</div>
        </section>
        <section class="- topic/section section" id="api_setaudiomixingposition__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">pos</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">整数。进度条位置，单位为毫秒。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setaudiomixingposition__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title72" id="api_geteffectsvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title72"><a href="class_irtcengine.aspx#api_geteffectsvolume"><span class="- topic/ph ph">getEffectsVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_geteffectsvolume__shortdesc">获取音效文件的播放音量。</span></p><section class="- topic/section section" id="api_geteffectsvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getEffectsVolume() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_geteffectsvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">音量范围为 0~100。100 （默认值）为原始文件音量。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_playeffect2" title="播放指定音效文件。"><span class="- topic/keyword keyword">playEffect</span></a> 后调用。</div>
        </section>
        <section class="- topic/section section" id="api_geteffectsvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">音效文件的音量。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title73" id="api_seteffectsvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title73"><a href="class_irtcengine.aspx#api_seteffectsvolume"><span class="- topic/ph ph">setEffectsVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_seteffectsvolume__shortdesc">设置音效文件的播放音量。</span></p><section class="- topic/section section" id="api_seteffectsvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setEffectsVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_seteffectsvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">音量范围为 0~100。100 （默认值）为原始文件音量。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_playeffect2" title="播放指定音效文件。"><span class="- topic/keyword keyword">playEffect</span></a> 后调用。</div>
        </section>
        <section class="- topic/section section" id="api_seteffectsvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该方法设置音效的音量。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_seteffectsvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title74" id="api_setvolumeofeffect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title74"><a href="class_irtcengine.aspx#api_setvolumeofeffect"><span class="- topic/ph ph">setVolumeOfEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setvolumeofeffect__shortdesc">实时调整音效文件的播放音量。</span></p><section class="- topic/section section" id="api_setvolumeofeffect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setVolumeOfEffect(<strong class="hl-keyword">int</strong> soundId, <strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setvolumeofeffect__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_playeffect2" title="播放指定音效文件。"><span class="- topic/keyword keyword">playEffect</span></a> 后调用。</div>
        </section>
        <section class="- topic/section section" id="api_setvolumeofeffect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效的 ID。每个音效均有唯一的 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">播放音量。音量范围为 0~100。100 （默认值）为原始文件音量。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setvolumeofeffect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title75" id="api_playeffect2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title75"><a href="class_irtcengine.aspx#api_playeffect2"><span class="- topic/ph ph">playEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_playeffect2__shortdesc">播放指定音效文件。</span></p><section class="- topic/section section" id="api_playeffect2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> playEffect(<strong class="hl-keyword">int</strong> soundId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath, <strong class="hl-keyword">int</strong> loopCount, <strong class="hl-keyword">double</strong> pitch, <strong class="hl-keyword">double</strong> pan, <strong class="hl-keyword">int</strong> gain, <strong class="hl-keyword">bool</strong> publish = <strong class="hl-keyword">false</strong>) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_playeffect2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">你可以多次调用该方法，通过传入不同的音效文件的 <code class="+ topic/ph pr-d/codeph ph codeph">soundID</code> 和 <code class="+ topic/ph pr-d/codeph ph codeph">filePath</code>，同时播放多个音效文件，实现音效叠加。为获得最佳用户体验，我们建议同时播放的音效文件不要超过 3 个。在 macOS 和 Windows 上，该方法不支持同时播放多个在线音效文件。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在加入频道后调用。</div>
   
        </section>
        <section class="- topic/section section" id="api_playeffect2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效的 ID。每个音效均有唯一的 ID。
      <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如果你已通过 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_preloadeffect" title="将音效文件加载至内存。"><span class="- topic/keyword keyword">preloadEffect</span></a> 将音效加载至内存，确保这里设置的 <span class="+ topic/keyword pr-d/parmname keyword parmname">soundId</span> 与 <span class="+ topic/keyword pr-d/apiname keyword apiname">preloadEffect</span> 设置的 <span class="+ topic/keyword pr-d/parmname keyword parmname">soundId</span> 相同。</div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音效文件的绝对路径或 URL 地址，例如：<code class="+ topic/ph pr-d/codeph ph codeph">c:/music/audio.mp4</code>。建议填写文件后缀名。若无法确定文件后缀名，可不填。 支持的音频格式包括：mp3、mp4、m4a、aac、3gp、mkv 及 wav。 详见 <a class="- topic/xref xref" href="https://docs.microsoft.com/zh-cn/windows/win32/medfound/supported-media-formats-in-media-foundation" target="_blank" rel="external noopener">Supported Media Formats in Media Foundation</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">loopCount</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置音效循环播放的次数：
      <ul class="- topic/ul ul">
 <li class="- topic/li li">0: 播放音效一次；</li>
 <li class="- topic/li li">1: 播放音效两次；</li>
 <li class="- topic/li li">-1: 无限循环播放音效，直至调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_stopeffect" title="停止播放指定音效文件。"><span class="- topic/keyword keyword">stopEffect</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_stopalleffects" title="停止播放所有音效文件。"><span class="- topic/keyword keyword">stopAllEffects</span></a> 后停止。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">pitch</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置音效的音调。取值范围为 [0.5,2]。默认值为 1.0，表示不需要修改音调。取值越小，则音调越低。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">pan</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置是否改变音效的空间位置。取值范围为 [-1.0,1.0]: <ul class="- topic/ul ul">
 <li class="- topic/li li">0.0: 音效出现在正前方；</li>
 <li class="- topic/li li">1.0: 音效出现在右边；</li>
 <li class="- topic/li li">-1.0: 音效出现在左边。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">gain</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置是否改变单个音效的音量。取值范围为 [0.0,100.0]。默认值为 100.0。取值越小，则音效的音量越低。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">publish</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置是否将音效传到远端：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 音效在本地播放的同时，会发布到 Agora 云端，因此远端用户也能听到该音效；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 音效不会发布到 Agora 云端，因此只能在本地听到该音效。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_playeffect2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功</li>
       <li class="- topic/li li">&lt; 0：方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title76" id="api_stopeffect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title76"><a href="class_irtcengine.aspx#api_stopeffect"><span class="- topic/ph ph">stopEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopeffect__shortdesc">停止播放指定音效文件。</span></p><section class="- topic/section section" id="api_stopeffect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopEffect(<strong class="hl-keyword">int</strong> soundId) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stopeffect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效文件的 ID。每个音效文件均有唯一的 ID。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_stopeffect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title77" id="api_stopalleffects">
    <h2 class="- topic/title title topictitle2" id="ariaid-title77"><a href="class_irtcengine.aspx#api_stopalleffects"><span class="- topic/ph ph">stopAllEffects</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopalleffects__shortdesc">停止播放所有音效文件。</span></p><section class="- topic/section section" id="api_stopalleffects__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopAllEffects() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stopalleffects__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title78" id="api_preloadeffect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title78"><a href="class_irtcengine.aspx#api_preloadeffect"><span class="- topic/ph ph">preloadEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_preloadeffect__shortdesc">将音效文件加载至内存。</span></p><section class="- topic/section section" id="api_preloadeffect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">     
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> preloadEffect(<strong class="hl-keyword">int</strong> soundId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_preloadeffect__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法将指定音效文件预加载至内存。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法不支持在线音频文件。</div>
   <p class="- topic/p p">为保证通信畅通，请注意控制预加载音效文件的大小，并在 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span>
       前就使用该方法完成音效预加载。音频文件支持以下音频格式: mp3、aac、m4a、3gp 和 wav。</p>
        </section>
        <section class="- topic/section section" id="api_preloadeffect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效文件的 ID。每个音效文件均有唯一的 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音效文件的绝对路径。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_preloadeffect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
       <ul class="- topic/ul ul">
  <li class="- topic/li li">0: 方法调用成功</li>
  <li class="- topic/li li">&lt; 0: 方法调用失败</li>
       </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title79" id="api_unloadeffect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title79"><a href="class_irtcengine.aspx#api_unloadeffect"><span class="- topic/ph ph">unloadEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_unloadeffect__shortdesc">从内存释放某个预加载的音效文件。</span></p><section class="- topic/section section" id="api_unloadeffect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> unloadEffect(<strong class="hl-keyword">int</strong> soundId) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_unloadeffect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效文件的 ID。每个音效文件均有唯一的 ID。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_unloadeffect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title80" id="api_pauseeffect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title80"><a href="class_irtcengine.aspx#api_pauseeffect"><span class="- topic/ph ph">pauseEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_pauseeffect__shortdesc">暂停音效文件播放。</span></p><section class="- topic/section section" id="api_pauseeffect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> pauseEffect(<strong class="hl-keyword">int</strong> soundId) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_pauseeffect__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   
        </section>
        <section class="- topic/section section" id="api_pauseeffect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效文件的 ID。每个音效文件均有唯一的 ID。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_pauseeffect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title81" id="api_pausealleffects">
    <h2 class="- topic/title title topictitle2" id="ariaid-title81"><a href="class_irtcengine.aspx#api_pausealleffects"><span class="- topic/ph ph">pauseAllEffects</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_pausealleffects__shortdesc">暂停所有音效文件播放。</span></p><section class="- topic/section section" id="api_pausealleffects__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> pauseAllEffects() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_pausealleffects__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title82" id="api_resumeeffect">
    <h2 class="- topic/title title topictitle2" id="ariaid-title82"><a href="class_irtcengine.aspx#api_resumeeffect"><span class="- topic/ph ph">resumeEffect</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_resumeeffect__shortdesc">恢复播放指定音效文件。</span></p><section class="- topic/section section" id="api_resumeeffect__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> resumeEffect(<strong class="hl-keyword">int</strong> soundId) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_resumeeffect__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效文件的 ID。每个音效文件均有唯一的 ID。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_resumeeffect__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title83" id="api_resumealleffects">
    <h2 class="- topic/title title topictitle2" id="ariaid-title83"><a href="class_irtcengine.aspx#api_resumealleffects"><span class="- topic/ph ph">resumeAllEffects</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_resumealleffects__shortdesc">恢复播放所有音效文件。</span></p><section class="- topic/section section" id="api_resumealleffects__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> resumeAllEffects() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_resumealleffects__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title84" id="api_setlocalvoicechanger">
    <h2 class="- topic/title title topictitle2" id="ariaid-title84"><a href="class_irtcengine.aspx#api_setlocalvoicechanger"><span class="- topic/ph ph">setLocalVoiceChanger</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalvoicechanger__shortdesc">设置本地语音变声、美音或语聊美声效果。</span></p><section class="- topic/section section" id="api_setlocalvoicechanger__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicechanger__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法从 v3.2.0 起废弃，请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectpreset" title="设置 SDK 预设的人声音效。"><span class="- topic/keyword keyword">setAudioEffectPreset</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierpreset" title="设置 SDK 预设的美声效果。"><span class="- topic/keyword keyword">setVoiceBeautifierPreset</span></a>。</dd>
       
   </dl>
   <div class="- topic/p p">通信场景下的用户或直播场景下的主播均可调用该方法为本地语音设置以下效果。成功设置以后，频道内的所有用户均可听到声音效果。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">变声效果：枚举值以 <code class="+ topic/ph pr-d/codeph ph codeph">VOICE_CHANGER</code> 为前缀。效果包括老男人、小男孩、小女孩、猪八戒、空灵和绿巨人，通常用于语聊场景。</li>
  <li class="- topic/li li">美音效果：枚举值以 <code class="+ topic/ph pr-d/codeph ph codeph">VOICE_BEAUTY</code> 为前缀。效果包括浑厚、低沉、圆润、假音、饱满、清澈、高亢、嘹亮和空旷，通常用于语聊和唱歌场景。</li>
  <li class="- topic/li li">语聊美声效果：枚举值以 <code class="+ topic/ph pr-d/codeph ph codeph">GENERAL_BEAUTY_VOICE</code> 为前缀。效果包括磁性（男）、清新（女）和活力（女），通常用于语聊场景。该功能主要细化了男声和女声各自的特点。</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">为达到更好的声音效果，Agora 推荐在调用该方法前将 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY</span> (4) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span> (5)。</li>
  <li class="- topic/li li">该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含人声和音乐的音频数据。</li>
  <li class="- topic/li li">该方法不能与 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverbpreset" title="设置本地语音混响（含虚拟立体声效果）。"><span class="- topic/keyword keyword">setLocalVoiceReverbPreset</span></a> 方法一同使用，否则先调的方法会不生效。更多注意事项，详见进阶功能《变声与混响》。</li>
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicechanger__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">voiceChanger</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">预设本地语音变声、美音或语聊美声效果选项，默认值为 <span class="+ topic/keyword pr-d/apiname keyword apiname">VOICE_CHANGER_OFF</span> ，即原声。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_voicechangerpreset" title="预设的语音变声效果。"><span class="- topic/keyword keyword">VOICE_CHANGER_PRESET</span></a> 。设置语聊美声效果时，Agora 推荐使用 <span class="+ topic/keyword pr-d/apiname keyword apiname">GENERAL_BEAUTY_VOICE_MALE_MAGNETIC</span> 处理男声，使用 <span class="+ topic/keyword pr-d/apiname keyword apiname">GENERAL_BEAUTY_VOICE_FEMALE_FRESH</span> 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">GENERAL_BEAUTY_VOICE_FEMALE_VITALITY</span> 处理女声，否则音频可能会产生失真。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicechanger__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title85" id="api_setlocalvoicereverbpreset">
    <h2 class="- topic/title title topictitle2" id="ariaid-title85"><a href="class_irtcengine.aspx#api_setlocalvoicereverbpreset"><span class="- topic/ph ph">setLocalVoiceReverbPreset</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalvoicereverbpreset__shortdesc">设置本地语音混响（含虚拟立体声效果）。</span></p><section class="- topic/section section" id="api_setlocalvoicereverbpreset__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalVoiceReverbPreset(AUDIO_REVERB_PRESET reverbPreset) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicereverbpreset__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法从 v3.2.0 起废弃，请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectpreset" title="设置 SDK 预设的人声音效。"><span class="- topic/keyword keyword">setAudioEffectPreset</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierpreset" title="设置 SDK 预设的美声效果。"><span class="- topic/keyword keyword">setVoiceBeautifierPreset</span></a>。</dd>
       
   </dl>
   <p class="- topic/p p">通信场景下的用户或直播场景下的主播均可调用该方法设置本地语音混响。成功设置以后，频道内的所有用户均可听到声音效果。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">当使用以 <code class="+ topic/ph pr-d/codeph ph codeph">AUDIO_REVERB_FX</code> 为前缀的枚举值时，请确保在调用该方法前将 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY</span> (4) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span> (5) ，否则该方法设置无效。</li>
  <li class="- topic/li li">当使用 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_VIRTUAL_STEREO</span> 时，Agora 推荐在调用该方法前将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span> (5)。</li>
  <li class="- topic/li li">该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含人声和音乐的音频数据。</li>
  <li class="- topic/li li">该方法不能与 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicechanger" title="设置本地语音变声、美音或语聊美声效果。"><span class="- topic/keyword keyword">setLocalVoiceChanger</span></a> 方法一同使用，否则先调的方法会不生效。更多注意事项，详见进阶功能《变声与混响》。</li>
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicereverbpreset__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reverbPreset</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">本地语音混响选项，默认值为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_REVERB_OFF</span> ，即原声。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audioreverbpreset" title="预设的语音混响效果。"><span class="- topic/keyword keyword">AUDIO_REVERB_PRESET</span></a> 。</p>
      <p class="- topic/p p">为达到更好的混响效果，Agora 推荐使用以 <code class="+ topic/ph pr-d/codeph ph codeph">AUDIO_REVERB_FX</code> 为前缀的枚举值。</p></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicereverbpreset__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title86" id="api_setlocalvoicepitch">
    <h2 class="- topic/title title topictitle2" id="ariaid-title86"><a href="class_irtcengine.aspx#api_setlocalvoicepitch"><span class="- topic/ph ph">setLocalVoicePitch</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalvoicepitch__shortdesc">设置本地语音音调。</span></p><section class="- topic/section section" id="api_setlocalvoicepitch__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalVoicePitch(<strong class="hl-keyword">double</strong> pitch) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicepitch__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicepitch__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">pitch</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">语音频率可以 [0.5,2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示不需要修改音调。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicepitch__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title87" id="api_setlocalvoiceequalization">
    <h2 class="- topic/title title topictitle2" id="ariaid-title87"><a href="class_irtcengine.aspx#api_setlocalvoiceequalization"><span class="- topic/ph ph">setLocalVoiceEqualization</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalvoiceequalization__shortdesc">设置本地语音音效均衡。</span></p><section class="- topic/section section" id="api_setlocalvoiceequalization__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency, <strong class="hl-keyword">int</strong> bandGain) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoiceequalization__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoiceequalization__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">bandFrequency</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频谱子带索引。取值范围是 [0,9]，分别代表音效的 10 个频带。对应的中心频率为 [31，62，125，250，500，1k，2k，4k，8k，16k] Hz。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audioequalizationbandfrequency" title="语音音效均衡波段的中心频率。"><span class="- topic/keyword keyword">AUDIO_EQUALIZATION_BAND_FREQUENCY</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">bandGain</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">每个 band 的增益，单位是 dB，每一个值的范围是 [-15,15]。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvoiceequalization__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title88" id="api_setlocalvoicereverb">
    <h2 class="- topic/title title topictitle2" id="ariaid-title88"><a href="class_irtcengine.aspx#api_setlocalvoicereverb"><span class="- topic/ph ph">setLocalVoiceReverb</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalvoicereverb__shortdesc">设置本地音效混响。</span></p><section class="- topic/section section" id="api_setlocalvoicereverb__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, <strong class="hl-keyword">int</strong> value) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicereverb__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicereverb__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reverbKey</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">混响音效 Key。该方法共有 5 个混响音效 Key: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audioreverbtype" title="音频混响类型。"><span class="- topic/keyword keyword">AUDIO_REVERB_TYPE</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">value</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">各混响音效 Key 所对应的值。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvoicereverb__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title89" id="api_setvoicebeautifierpreset">
    <h2 class="- topic/title title topictitle2" id="ariaid-title89"><a href="class_irtcengine.aspx#api_setvoicebeautifierpreset"><span class="- topic/ph ph">setVoiceBeautifierPreset</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setvoicebeautifierpreset__shortdesc">设置 SDK 预设的美声效果。</span></p><section class="- topic/section section" id="api_setvoicebeautifierpreset__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET preset) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setvoicebeautifierpreset__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.2.0</dd>
       
   </dl>
   <p class="- topic/p p">调用该方法可以为本地发流用户设置 SDK 预设的人声美化效果。设置美声效果后，频道内所有用户都能听到该效果。根据不同的场景，你可以为用户设置不同的美声效果，各美声效果的适用场景可参考《美声与音效》。</p>
   <p class="- topic/p p">为获取更好的人声效果，Agora 推荐你在调用该方法前将 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_GAME_STREAMING</span>(3)，并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY</span>(4) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span>(5)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  <li class="- topic/li li">请勿将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_SPEECH_STANDARD</span>(1) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_IOT</span>(6)，否则该方法会调用失败。</li>
  <li class="- topic/li li">该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。</li>
  <li class="- topic/li li">调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectpreset" title="设置 SDK 预设的人声音效。"><span class="- topic/keyword keyword">setAudioEffectPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectparameters" title="设置 SDK 预设人声音效的参数。"><span class="- topic/keyword keyword">setAudioEffectParameters</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverbpreset" title="设置本地语音混响（含虚拟立体声效果）。"><span class="- topic/keyword keyword">setLocalVoiceReverbPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicechanger" title="设置本地语音变声、美音或语聊美声效果。"><span class="- topic/keyword keyword">setLocalVoiceChanger</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicepitch" title="设置本地语音音调。"><span class="- topic/keyword keyword">setLocalVoicePitch</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoiceequalization" title="设置本地语音音效均衡。"><span class="- topic/keyword keyword">setLocalVoiceEqualization</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverb" title="设置本地音效混响。"><span class="- topic/keyword keyword">setLocalVoiceReverb</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierparameters" title="设置 SDK 预设美声效果的参数。"><span class="- topic/keyword keyword">setVoiceBeautifierParameters</span></a></li>
      </ul>
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setvoicebeautifierpreset__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">preset</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">预设的美声效果选项，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_voicebeautifierpreset" title="预设的美声效果选项。"><span class="- topic/keyword keyword">VOICE_BEAUTIFIER_PRESET</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setvoicebeautifierpreset__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title90" id="api_setvoicebeautifierparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title90"><a href="class_irtcengine.aspx#api_setvoicebeautifierparameters"><span class="- topic/ph ph">setVoiceBeautifierParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setvoicebeautifierparameters__shortdesc">设置 SDK 预设美声效果的参数。</span></p><section class="- topic/section section" id="api_setvoicebeautifierparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET preset, <strong class="hl-keyword">int</strong> param1, <strong class="hl-keyword">int</strong> param2) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setvoicebeautifierparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">调用该方法可以设置歌唱美声效果的性别特征和混响效果。该方法对本地发流用户进行设置。设置后，频道内所有用户都能听到该效果。</p>
   <p class="- topic/p p">为获取更好的人声效果，Agora 推荐你在调用该方法前将 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_GAME_STREAMING</span>(3)，并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY</span>(4) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span>(5)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  <li class="- topic/li li">请勿将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_SPEECH_STANDARD</span>(1) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_IOT</span>(6)，否则该方法会不生效。</li>
  <li class="- topic/li li">该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。</li>
  <li class="- topic/li li">调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectpreset" title="设置 SDK 预设的人声音效。"><span class="- topic/keyword keyword">setAudioEffectPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectparameters" title="设置 SDK 预设人声音效的参数。"><span class="- topic/keyword keyword">setAudioEffectParameters</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierpreset" title="设置 SDK 预设的美声效果。"><span class="- topic/keyword keyword">setVoiceBeautifierPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverbpreset" title="设置本地语音混响（含虚拟立体声效果）。"><span class="- topic/keyword keyword">setLocalVoiceReverbPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicechanger" title="设置本地语音变声、美音或语聊美声效果。"><span class="- topic/keyword keyword">setLocalVoiceChanger</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicepitch" title="设置本地语音音调。"><span class="- topic/keyword keyword">setLocalVoicePitch</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoiceequalization" title="设置本地语音音效均衡。"><span class="- topic/keyword keyword">setLocalVoiceEqualization</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverb" title="设置本地音效混响。"><span class="- topic/keyword keyword">setLocalVoiceReverb</span></a></li>
      </ul>
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setvoicebeautifierparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">preset</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">SDK 预设的音效：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">SINGING_BEAUTIFIER</code>: 歌唱美声。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">param1</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">歌声的性别特征：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">1</code>: 男声。</li>
 <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">2</code>: 女声。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">param2</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">歌声的混响效果：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">1</code>: 歌声在小房间的混响效果。</li>
 <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">2</code>: 歌声在大房间的混响效果。</li>
 <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">3</code>: 歌声在大厅的混响效果。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setvoicebeautifierparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title91" id="api_setaudioeffectpreset">
    <h2 class="- topic/title title topictitle2" id="ariaid-title91"><a href="class_irtcengine.aspx#api_setaudioeffectpreset"><span class="- topic/ph ph">setAudioEffectPreset</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setaudioeffectpreset__shortdesc">设置 SDK 预设的人声音效。</span></p><section class="- topic/section section" id="api_setaudioeffectpreset__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setAudioEffectPreset(AUDIO_EFFECT_PRESET preset) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setaudioeffectpreset__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.2.0</dd>
       
   </dl>
   <p class="- topic/p p">调用该方法可以为本地发流用户设置 SDK 预设的人声音效，且不会改变原声的性别特征。设置音效后，频道内所有用户都能听到该效果。</p>
   <p class="- topic/p p">根据不同的场景，你可以为用户设置不同的音效，各音效的适用场景可参考《美声与音效》。</p>
   <p class="- topic/p p">为获取更好的人声效果，Agora 推荐你在调用该方法前将 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_GAME_STREAMING</span>(3)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  <li class="- topic/li li">请勿将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_SPEECH_STANDARD</span>(1) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_IOT</span>(6)，否则该方法会调用失败。</li>
  <li class="- topic/li li">该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。</li>
  <li class="- topic/li li">如果调用该方法并设置除 <span class="+ topic/keyword pr-d/apiname keyword apiname">ROOM_ACOUSTICS_3D_VOICE</span> 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">PITCH_CORRECTION</span> 外的枚举，请勿再调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectparameters" title="设置 SDK 预设人声音效的参数。"><span class="- topic/keyword keyword">setAudioEffectParameters</span></a>，否则该方法设置的效果会被覆盖。</li>
  <li class="- topic/li li">调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierpreset" title="设置 SDK 预设的美声效果。"><span class="- topic/keyword keyword">setVoiceBeautifierPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverbpreset" title="设置本地语音混响（含虚拟立体声效果）。"><span class="- topic/keyword keyword">setLocalVoiceReverbPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicechanger" title="设置本地语音变声、美音或语聊美声效果。"><span class="- topic/keyword keyword">setLocalVoiceChanger</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicepitch" title="设置本地语音音调。"><span class="- topic/keyword keyword">setLocalVoicePitch</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoiceequalization" title="设置本地语音音效均衡。"><span class="- topic/keyword keyword">setLocalVoiceEqualization</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverb" title="设置本地音效混响。"><span class="- topic/keyword keyword">setLocalVoiceReverb</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierparameters" title="设置 SDK 预设美声效果的参数。"><span class="- topic/keyword keyword">setVoiceBeautifierParameters</span></a></li>
      </ul>
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setaudioeffectpreset__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">preset</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">预设的音效选项，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audioeffectpreset" title="预设的音效选项。"><span class="- topic/keyword keyword">AUDIO_EFFECT_PRESET</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setaudioeffectpreset__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title92" id="api_setaudioeffectparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title92"><a href="class_irtcengine.aspx#api_setaudioeffectparameters"><span class="- topic/ph ph">setAudioEffectParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setaudioeffectparameters__shortdesc">设置 SDK 预设人声音效的参数。</span></p><section class="- topic/section section" id="api_setaudioeffectparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setAudioEffectParameters(AUDIO_EFFECT_PRESET preset, <strong class="hl-keyword">int</strong> param1, <strong class="hl-keyword">int</strong> param2) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setaudioeffectparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.2.0</dd>
       
   </dl>
   <div class="- topic/p p">调用该方法可以对本地发流用户进行如下设置：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">3D 人声音效：设置 3D 人声音效的环绕周期。</li>
  <li class="- topic/li li">电音音效：设置电音音效的基础调式和主音音高。为方便用户自行调节电音音效，Agora 推荐你将基础调式和主音音高配置选项与应用的 UI 元素绑定。</li>
       </ul>
   </div>
   <p class="- topic/p p">设置后，频道内所有用户都能听到该效果。</p>
   <p class="- topic/p p">该方法可以单独使用，也可以搭配 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectpreset" title="设置 SDK 预设的人声音效。"><span class="- topic/keyword keyword">setAudioEffectPreset</span></a> 使用。搭配使用时， 需要先调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioEffectPreset</span> 并使用 <span class="+ topic/keyword pr-d/apiname keyword apiname">ROOM_ACOUSTICS_3D_VOICE</span> 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">PITCH_CORRECTION</span> 枚举，再调用该方法使用相同的枚举。否则，该方法设置的效果会覆盖 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioEffectPreset</span> 设置的效果。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  <li class="- topic/li li">为获取更好的人声效果，Agora 推荐你在调用该方法前将 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_GAME_STREAMING</span>(3)。</li>
  <li class="- topic/li li">请勿将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_SPEECH_STANDARD</span>(1) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_IOT</span>(6)，否则该方法会调用失败。</li>
  <li class="- topic/li li">该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。</li>
  <li class="- topic/li li">调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioeffectpreset" title="设置 SDK 预设的人声音效。"><span class="- topic/keyword keyword">setAudioEffectPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierpreset" title="设置 SDK 预设的美声效果。"><span class="- topic/keyword keyword">setVoiceBeautifierPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverbpreset" title="设置本地语音混响（含虚拟立体声效果）。"><span class="- topic/keyword keyword">setLocalVoiceReverbPreset</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicechanger" title="设置本地语音变声、美音或语聊美声效果。"><span class="- topic/keyword keyword">setLocalVoiceChanger</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicepitch" title="设置本地语音音调。"><span class="- topic/keyword keyword">setLocalVoicePitch</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoiceequalization" title="设置本地语音音效均衡。"><span class="- topic/keyword keyword">setLocalVoiceEqualization</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalvoicereverb" title="设置本地音效混响。"><span class="- topic/keyword keyword">setLocalVoiceReverb</span></a></li>
 <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvoicebeautifierparameters" title="设置 SDK 预设美声效果的参数。"><span class="- topic/keyword keyword">setVoiceBeautifierParameters</span></a></li>
      </ul>
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setaudioeffectparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">preset</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">SDK 预设的音效：
      <ul class="- topic/ul ul">
 <li class="- topic/li li">3D 人声音效：<span class="+ topic/keyword pr-d/apiname keyword apiname">ROOM_ACOUSTICS_3D_VOICE</span>
     <ul class="- topic/ul ul">
<li class="- topic/li li">你需要在使用该枚举前将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置 为 <span class="- topic/xref xref"><span class="- topic/keyword keyword">AUDIO_PROFILE_MUSIC_STANDARD_STEREO</span></span>(3) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span>(5)，否则该枚举设置无效。</li>
<li class="- topic/li li">启用 3D 人声后，用户需要使用支持双声道的音频播放设备才能听到预期效果。</li>
     </ul>
 </li>
 <li class="- topic/li li">电音音效：<span class="+ topic/keyword pr-d/apiname keyword apiname">PITCH_CORRECTION</span>。为获取更好的人声效果，Agora 建议你在使用该枚举前将 <span class="+ topic/keyword pr-d/apiname keyword apiname">setAudioProfile</span> 的 <span class="+ topic/keyword pr-d/parmname keyword parmname">profile</span> 参数设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY</span>(4) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO</span>(5)。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">param1</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li">如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">preset</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">ROOM_ACOUSTICS_3D_VOICE</span> ，则 <span class="+ topic/keyword pr-d/parmname keyword parmname">param1</span> 表示 3D 人声音效的环绕周期。取值范围为 [1,60]，单位为秒。默认值为 10，表示人声会 10 秒环绕 360 度。</li>
 <li class="- topic/li li">如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">preset</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">PITCH_CORRECTION</span>，则 <span class="+ topic/keyword pr-d/parmname keyword parmname">param1</span> 表示电音音效的基础调式。可设为如下值：
     <ul class="- topic/ul ul">
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">1</code>: （默认）自然大调。</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">2</code>: 自然小调。</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">3</code>: 和风小调。</li>
     </ul>
 </li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">param2</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li">如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">preset</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">ROOM_ACOUSTICS_3D_VOICE</span>，你需要将 <span class="+ topic/keyword pr-d/parmname keyword parmname">param2</span> 设置为 <code class="+ topic/ph pr-d/codeph ph codeph">0</code>。</li>
 <li class="- topic/li li">如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">preset</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">PITCH_CORRECTION</span>，则 <span class="+ topic/keyword pr-d/parmname keyword parmname">param2</span> 表示电音音效的主音音高。可设为如下值：
     <ul class="- topic/ul ul">
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">1</code>: A</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">2</code>: A#</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">3</code>: B</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">4</code>: (Default) C</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">5</code>: C#</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">6</code>: D</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">7</code>: D#</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">8</code>: E</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">9</code>: F</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">10</code>: F#</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">11</code>: G</li>
<li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">12</code>: G#</li>
     </ul>
 </li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setaudioeffectparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title93" id="api_enablesoundpositionindication">
    <h2 class="- topic/title title topictitle2" id="ariaid-title93"><a href="class_irtcengine.aspx#api_enablesoundpositionindication"><span class="- topic/ph ph">enableSoundPositionIndication</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablesoundpositionindication__shortdesc">开启/关闭远端用户的语音立体声。</span></p><section class="- topic/section section" id="api_enablesoundpositionindication__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableSoundPositionIndication(<strong class="hl-keyword">bool</strong> enabled) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enablesoundpositionindication__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">如果想调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setRemoteVoicePosition</span> 实现听声辨位的功能，请确保在加入频道前调用该方法开启远端用户的语音立体声。</p>
        </section>
        <section class="- topic/section section" id="api_enablesoundpositionindication__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">是否开启远端用户语音立体声：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 关闭</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enablesoundpositionindication__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title94" id="api_setremotevoiceposition">
    <h2 class="- topic/title title topictitle2" id="ariaid-title94"><a href="class_irtcengine.aspx#api_setremotevoiceposition"><span class="- topic/ph ph">setRemoteVoicePosition</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremotevoiceposition__shortdesc">设置远端用户的语音位置。</span></p><section class="- topic/section section" id="api_setremotevoiceposition__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteVoicePosition(uid_t uid, <strong class="hl-keyword">double</strong> pan, <strong class="hl-keyword">double</strong> gain) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setremotevoiceposition__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">设置远端用户声音的空间位置和音量，方便本地用户听声辨位。</p>
   <p class="- topic/p p">通过调用该接口设置远端用户声音出现的位置，左右声道的声音差异会产生声音的方位感，从而判断出远端用户的实时位置。在多人在线游戏场景，如吃鸡游戏中，该方法能有效增加游戏角色的方位感，模拟真实场景。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">使用该方法需要在加入频道前调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablesoundpositionindication" title="开启/关闭远端用户的语音立体声。"><span class="- topic/keyword keyword">enableSoundPositionIndication</span></a> 开启远端用户的语音立体声。</li>
  <li class="- topic/li li">为获得最佳听觉体验，我们建议使用该方法时使用立体声外放。</li>
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setremotevoiceposition__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的 ID</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">pan</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置远端用户声音的空间位置，取值范围为 [-1.0,1.0]:
      <ul class="- topic/ul ul">
 <li class="- topic/li li">(默认）0.0: 声音出现在正前方。</li>
 <li class="- topic/li li">-1.0: 声音出现在左边。</li>
 <li class="- topic/li li">1.0: 声音出现在右边。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">gain</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置远端用户声音的音量，取值范围为 [0.0,100.0]，默认值为 100.0，表示该用户的原始音量。取值越小，则音量越低。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremotevoiceposition__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title95" id="api_setlivetranscoding">
    <h2 class="- topic/title title topictitle2" id="ariaid-title95">setLiveTranscoding</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlivetranscoding__shortdesc">设置直播推流转码。</span></p>
        <section class="- topic/section section" id="api_setlivetranscoding__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLiveTranscoding(<strong class="hl-keyword">const</strong> LiveTranscoding &amp;transcoding) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_setlivetranscoding__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法用于旁路推流的视图布局及音频设置等。调用该方法更新转码设置后本地会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_ontranscodingupdated" title="旁路推流设置已被更新回调。"><span class="- topic/keyword keyword">onTranscodingUpdated</span></a> 回调。</p>
   <div class="- topic/note note note note_note" id="api_setlivetranscoding__note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">在直播场景中，只有角色为主播的用户才能调用该方法。</li>
  <li class="- topic/li li">请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。</li>
  <li class="- topic/li li">首次调用该方法更新转码设置时，不会触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onTranscodingUpdated</span> 回调。</li>
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li">Agora 目前仅支持转码时向 CDN 推送 RTMPS 协议的媒体流。</li>
       </ul>
   </div>
   </section>
        <section class="- topic/section section" id="api_setlivetranscoding__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">transcoding</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">推流设置。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_livetranscoding" title="管理旁路推流配置的类。">LiveTranscoding</a>。</p></dd>
       
   </dl>
        </section><section class="- topic/section section" id="api_setlivetranscoding__return_values"><h3 class="- topic/title title sectiontitle">返回</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功</li>
       <li class="- topic/li li">&lt; 0：方法调用失败</li>
   </ul>
        </section></div>

</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title96" id="api_addpublishstreamurl">
    <h2 class="- topic/title title topictitle2" id="ariaid-title96"><a href="class_irtcengine.aspx#api_addpublishstreamurl"><span class="- topic/ph ph">addPublishStreamUrl</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_addpublishstreamurl__shortdesc">增加旁路推流地址。</span></p><section class="- topic/section section" id="api_addpublishstreamurl__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> addPublishStreamUrl(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *url, <strong class="hl-keyword">bool</strong> transcodingEnabled) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_addpublishstreamurl__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">调用该方法后，你可以向 CDN 推送 RTMP 或 RTMPS 协议的媒体流。SDK 会在本地触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingstatechanged" title="RTMP/RTMPS 推流状态发生改变回调。"><span class="- topic/keyword keyword">onRtmpStreamingStateChanged</span></a> 回调，报告增加旁路推流地址的状态。</p>
   <div class="- topic/note note note note_note" id="api_addpublishstreamurl__note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请确保在成功加入频道后调用该接口。</li>
  <li class="- topic/li li">请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。</li>
  <li class="- topic/li li">该方法每次只能增加一路旁路推流地址。若需推送多路流，则需多次调用该方法。</li>
  <li class="- topic/li li">在直播场景中，只有角色为主播的用户才能调用该方法。</li>
  <li class="- topic/li li">Agora 目前仅支持转码时向 CDN 推送 RTMPS 协议的媒体流。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_addpublishstreamurl__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_addpublishstreamurl__url">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">CDN 推流地址，格式为 RTMP。该字符长度不能超过 1024 字节。url 不支持中文字符等特殊字符。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">transcodingEnabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 转码（ <a class="- topic/xref xref" href="https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#%E8%BD%AC%E7%A0%81" target="_blank" rel="external noopener">转码</a> 是指在旁路推流时对音视频流进行转码处理后再推送到其他 CDN 服务器。多适用于频道内有多个主播，需要进行混流、合图的场景）。如果设为 <span class="- topic/ph ph">true</span>，需先调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlivetranscoding" title="设置直播推流转码。"><span class="- topic/keyword keyword">setLiveTranscoding</span></a> 方法。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 不转码。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_addpublishstreamurl__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code> (2): URL 为空或是长度为 0 的的字符串</li>
      <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_INITIALIZED</code> (7): 推流时未初始化引擎</li>
  </ul>
       </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title97" id="api_removepublishstreamurl">
    <h2 class="- topic/title title topictitle2" id="ariaid-title97"><a href="class_irtcengine.aspx#api_removepublishstreamurl"><span class="- topic/ph ph">removePublishStreamUrl</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_removepublishstreamurl__shortdesc">删除旁路推流地址。</span></p><section class="- topic/section section" id="api_removepublishstreamurl__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> removePublishStreamUrl(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *url) = <span class="hl-number">0</span>;</pre>       

  </div>
        </section>
        <section class="- topic/section section" id="api_removepublishstreamurl__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">调用该方法后，SDK 会在本地触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingstatechanged" title="RTMP/RTMPS 推流状态发生改变回调。"><span class="- topic/keyword keyword">onRtmpStreamingStateChanged</span></a> 回调，报告删除旁路推流地址的状态。</p>
   <div class="- topic/note note note note_note" id="api_removepublishstreamurl__note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法每次只能删除一路旁路推流地址。若需删除多路流，则需多次调用该方法。</li>
  <li class="- topic/li li">URL 不支持中文等特殊字符。</li>
  <li class="- topic/li li">在直播场景中，只有角色为主播的用户才能调用该方法。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_removepublishstreamurl__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      待删除的旁路推流地址，格式为 RTMP。该字符长度不能超过 1024 字节。
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_removepublishstreamurl__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功</li>
       <li class="- topic/li li">&lt; 0：方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title98" id="api_startchannelmediarelay">
    <h2 class="- topic/title title topictitle2" id="ariaid-title98"><a href="class_irtcengine.aspx#api_startchannelmediarelay"><span class="- topic/ph ph">startChannelMediaRelay</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startchannelmediarelay__shortdesc">开始跨频道媒体流转发。该方法可用于实现跨频道连麦等场景。</span></p><section class="- topic/section section" id="api_startchannelmediarelay__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startChannelMediaRelay(<strong class="hl-keyword">const</strong> ChannelMediaRelayConfiguration &amp;configuration) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startchannelmediarelay__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">成功调用该方法后，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onchannelmediarelaystatechanged" title="跨频道媒体流转发状态发生改变回调。"><span class="- topic/keyword keyword">onChannelMediaRelayStateChanged</span></a> 和 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onchannelmediarelayevent" title="跨频道媒体流转发事件回调。"><span class="- topic/keyword keyword">onChannelMediaRelayEvent</span></a> 回调，并在回调中报告当前的跨频道媒体流转发状态和事件。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">如果 <span class="+ topic/keyword pr-d/apiname keyword apiname">onChannelMediaRelayStateChanged</span> 回调报告 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_STATE_RUNNING</span> (2) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_OK</span> (0)，且 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onchannelmediarelayevent" title="跨频道媒体流转发事件回调。"><span class="- topic/keyword keyword">onChannelMediaRelayEvent</span></a> 回调报告 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_EVENT_PACKET_SENT_TO_DEST_CHANNEL</span> (4)， 则表示 SDK 开始在源频道和目标频道之间转发媒体流。</li>
  <li class="- topic/li li">如果 <span class="+ topic/keyword pr-d/apiname keyword apiname">onChannelMediaRelayStateChanged</span> 回调报告 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_STATE_FAILURE</span> (3)， 则表示跨频道媒体流转发出现异常。</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在成功加入频道后调用该方法。</li>
  <li class="- topic/li li">在直播场景中，只有角色为主播的用户才能调用该方法。</li>
  <li class="- topic/li li">功调用该方法后，若你想再次调用该方法，必须先调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_stopchannelmediarelay" title="停止跨频道媒体流转发。一旦停止，主播会退出所有目标频道。"><span class="- topic/keyword keyword">stopChannelMediaRelay</span></a> 方法退出当前的转发状态。</li>
  <li class="- topic/li li">跨频道媒体流转发功能需要<a class="- topic/xref xref" href="https://agora-ticket.agora.io/" target="_blank" rel="external noopener">提交工单</a>联系技术支持开通。</li>
  <li class="- topic/li li">该功能不支持 String 型 UID。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startchannelmediarelay__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">configuration</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发参数配置。详见 <span class="- topic/xref xref"><span class="- topic/keyword keyword">ChannelMediaRelayConfiguration</span></span>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startchannelmediarelay__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功</li>
       <li class="- topic/li li">&lt;0：方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title99" id="api_updatechannelmediarelay">
    <h2 class="- topic/title title topictitle2" id="ariaid-title99"><a href="class_irtcengine.aspx#api_updatechannelmediarelay"><span class="- topic/ph ph">updateChannelMediaRelay</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_updatechannelmediarelay__shortdesc">更新媒体流转发的频道。</span></p><section class="- topic/section section" id="api_updatechannelmediarelay__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> updateChannelMediaRelay(<strong class="hl-keyword">const</strong> ChannelMediaRelayConfiguration &amp;configuration) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_updatechannelmediarelay__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_updatechannelmediarelay__desc" data-ofbid="api_updatechannelmediarelay__desc">成功开始跨频道转发媒体流后，如果你希望将流转发到多个目标频道，或退出当前的转发频道，可以调用该方法。</p>
   <p class="- topic/p p">成功调用该方法后，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onchannelmediarelayevent" title="跨频道媒体流转发事件回调。"><span class="- topic/keyword keyword">onChannelMediaRelayEvent</span></a> 回调， 并在回调中报告状态码 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL</span> (7)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 请在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startchannelmediarelay" title="开始跨频道媒体流转发。该方法可用于实现跨频道连麦等场景。"><span class="- topic/keyword keyword">startChannelMediaRelay</span></a> 方法后调用该方法，更新媒体流转发的频道。</div>
        </section>
        <section class="- topic/section section" id="api_updatechannelmediarelay__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">configuration</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发参数配置。详见 <span class="- topic/xref xref"><span class="- topic/keyword keyword">ChannelMediaRelayConfiguration</span></span> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_updatechannelmediarelay__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功</li>
       <li class="- topic/li li">&lt; 0：方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title100" id="api_stopchannelmediarelay">
    <h2 class="- topic/title title topictitle2" id="ariaid-title100"><a href="class_irtcengine.aspx#api_stopchannelmediarelay"><span class="- topic/ph ph">stopChannelMediaRelay</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopchannelmediarelay__shortdesc">停止跨频道媒体流转发。一旦停止，主播会退出所有目标频道。</span></p><section class="- topic/section section" id="api_stopchannelmediarelay__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopChannelMediaRelay() = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_stopchannelmediarelay__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">成功调用该方法后，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onchannelmediarelaystatechanged" title="跨频道媒体流转发状态发生改变回调。"><span class="- topic/keyword keyword">onChannelMediaRelayStateChanged</span></a> 回调。如果报告 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_STATE_IDLE</span> (0) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_OK</span> (0)，则表示已停止转发媒体流。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       如果该方法调用不成功，SDK 会触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onChannelMediaRelayStateChanged</span> 回调，并报告状态码 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_ERROR_SERVER_NO_RESPONSE</span> (2) 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">RELAY_ERROR_SERVER_CONNECTION_LOST</span> (8)。你可以调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 方法离开频道，跨频道媒体流转发会自动停止。
   </div>
        </section>
        <section class="- topic/section section" id="api_stopchannelmediarelay__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt;0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title101" id="api_enableaudiovolumeindication">
    <h2 class="- topic/title title topictitle2" id="ariaid-title101"><a href="class_irtcengine.aspx#api_enableaudiovolumeindication"><span class="- topic/ph ph">enableAudioVolumeIndication</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enableaudiovolumeindication__shortdesc">启用用户音量提示。</span></p><section class="- topic/section section" id="api_enableaudiovolumeindication__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableAudioVolumeIndication(<strong class="hl-keyword">int</strong> interval, <strong class="hl-keyword">int</strong> smooth, <strong class="hl-keyword">bool</strong> report_vad) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enableaudiovolumeindication__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法允许 SDK 定期向 app 报告本地发流用户和瞬时音量最高的远端用户（最多 3 位）的音量相关信息。启用该方法后，只要频道内有发流用户， SDK 会在加入频道后按设置的时间间隔触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onaudiovolumeindication" title="用户音量提示回调。"><span class="- topic/keyword keyword">onAudioVolumeIndication</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_enableaudiovolumeindication__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">interval</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音量提示的时间间隔：
      <ul class="- topic/ul ul">
 <li class="- topic/li li">≤ 0: 禁用音量提示功能。</li>
 <li class="- topic/li li">&gt; 0: 返回音量提示的间隔，单位为毫秒。建议设置到大于 200 毫秒。最小不得少于 10 毫秒，否则会收不到 <span class="+ topic/keyword pr-d/apiname keyword apiname">onAudioVolumeIndication</span> 回调。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">smooth</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">平滑系数，指定音量提示的灵敏度。取值范围为 [0,10]，建议值为 3。数字越大，波动越灵敏；数字越小，波动越平滑。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">report_vad</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>：开启本地人声检测功能。开启后，<span class="+ topic/keyword pr-d/apiname keyword apiname">onAudioVolumeIndication</span> 回调的 <span class="+ topic/keyword pr-d/parmname keyword parmname">vad</span> 参数会报告是否在本地检测到人声。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>：（默认）关闭本地人声检测功能。除引擎自动进行本地人声检测的场景外，<span class="+ topic/keyword pr-d/apiname keyword apiname">onAudioVolumeIndication</span> 回调的 <span class="+ topic/keyword pr-d/parmname keyword parmname">vad</span> 参数不会报告是否在本地检测到人声。</li>
      </ul>
      
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enableaudiovolumeindication__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功</li>
       <li class="- topic/li li">&lt;0：方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title102" id="api_enablefacedetection">
    <h2 class="- topic/title title topictitle2" id="ariaid-title102"><a href="class_irtcengine.aspx#api_enablefacedetection"><span class="- topic/ph ph">enableFaceDetection</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablefacedetection__shortdesc">开启/关闭本地人脸检测。</span></p><section class="- topic/section section" id="api_enablefacedetection__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableFaceDetection(<strong class="hl-keyword">bool</strong> enable) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enablefacedetection__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.0.1</dd>
       
   </dl>
   <div class="- topic/note note note note_note info"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法仅适用于 Android 和 iOS。</div>
   <div class="- topic/p p">开启本地人脸检测后，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onfacepositionchanged" title="报告本地人脸检测结果。仅适用于 Android 和 iOS 平台。"><span class="- topic/keyword keyword">onFacePositionChanged</span></a> 回调向你报告人脸检测的信息：
   <ul class="- topic/ul ul">
       <li class="- topic/li li">摄像头采集的画面大小</li>
       <li class="- topic/li li">人脸在画面中的位置</li>
       <li class="- topic/li li">人脸距设备屏幕的距离</li>
   </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_enablefacedetection__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enable</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">是否开启人脸检测：
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>：开启人脸检测</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>：（默认）关闭人脸检测</li>
  </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enablefacedetection__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title103" id="api_setdefaultaudioroutetospeakerphone">
    <h2 class="- topic/title title topictitle2" id="ariaid-title103"><a href="class_irtcengine.aspx#api_setdefaultaudioroutetospeakerphone"><span class="- topic/ph ph">setDefaultAudioRouteToSpeakerphone</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setdefaultaudioroutetospeakerphone__shortdesc">设置默认的语音路由。</span></p><section class="- topic/section section" id="api_setdefaultaudioroutetospeakerphone__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setDefaultAudioRouteToSpeakerphone(<strong class="hl-keyword">bool</strong> defaultToSpeaker) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setdefaultaudioroutetospeakerphone__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法设置接收到的语音从听筒或扬声器出声。如果用户不调用本方法，语音默认从听筒出声。</p>
   <div class="- topic/p p">各频道场景下默认的语音路由：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">语音通话：听筒</li>
  <li class="- topic/li li">视频通话：扬声器。如果有用户在频道中使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablevideo" title="关闭视频模块。"><span class="- topic/keyword keyword">disableVideo</span></a> 、<a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalvideostream" title="开关本地视频发送。"><span class="- topic/keyword keyword">muteLocalVideoStream</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_muteallremotevideostreams" title="取消或恢复订阅所有远端用户的视频流。"><span class="- topic/keyword keyword">muteAllRemoteVideoStreams</span></a> 方法关闭视频，则语音路由会自动切换回听筒。</li>
  <li class="- topic/li li">直播：扬声器</li>
  <li class="- topic/li li">游戏语音：扬声器</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法仅适用于 Android 和 iOS 平台。</li>
  <li class="- topic/li li">在 iOS 平台上，该方法只在纯音频模式下工作，在有视频的模式下不工作。</li>
  <li class="- topic/li li">该方法需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 前设置，否则不生效。如需在加入频道后更改默认语音路由，请调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setenablespeakerphone" title="启用/关闭扬声器播放。"><span class="- topic/keyword keyword">setEnableSpeakerphone</span></a> 方法。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setdefaultaudioroutetospeakerphone__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">defaultToSpeaker</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置默认的语音路由:
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 语音路由为外放（扬声器）。如果设备连接了耳机或蓝牙，则无法切换到外放。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>:（默认）语音路由为听筒。</li>
  </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setdefaultaudioroutetospeakerphone__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title104" id="api_setenablespeakerphone">
    <h2 class="- topic/title title topictitle2" id="ariaid-title104"><a href="class_irtcengine.aspx#api_setenablespeakerphone"><span class="- topic/ph ph">setEnableSpeakerphone</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setenablespeakerphone__shortdesc">启用/关闭扬声器播放。</span></p><section class="- topic/section section" id="api_setenablespeakerphone__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setEnableSpeakerphone(<strong class="hl-keyword">bool</strong> speakerOn) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setenablespeakerphone__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法设置是否将语音路由到扬声器（外放）。</p>
   <p class="- topic/p p">该方法设置是否将语音路由设到扬声器（外放）。你可以在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setdefaultaudioroutetospeakerphone" title="设置默认的语音路由。"><span class="- topic/keyword keyword">setDefaultAudioRouteToSpeakerphone</span></a>
       方法中查看默认的语音路由。</p>
   <div class="- topic/p p">在 Android 上，<a class="- topic/xref xref" href="class_irtcengine.aspx#api_setaudioprofile" title="设置音频编码属性。"><span class="- topic/keyword keyword">setAudioProfile</span></a> 中 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 及 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setchannelprofile" title="设置频道场景。"><span class="- topic/keyword keyword">setChannelProfile</span></a> 的设置会影响 <span class="+ topic/keyword pr-d/apiname keyword apiname">setEnableSpeakerphone</span>
  的行为。<span class="+ topic/keyword pr-d/apiname keyword apiname">setEnableSpeakerphone</span> 不生效的情况如下：<ul class="- topic/ul ul">
  <li class="- topic/li li">当 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_GAME_STREAMING</span> 时，所有用户都无法切换音频播放路由。</li>
  <li class="- topic/li li">当 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_DEFAULT</span>
      或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_SHOWROOM</span>
      时，直播场景中的观众无法切换音频播放路由，且当频道中只有一个主播时，该主播也无法切换音频播放路由。</li>
  <li class="- topic/li li">当 <span class="+ topic/keyword pr-d/parmname keyword parmname">scenario</span> 为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_SCENARIO_EDUCATION</span> 时，直播场景中的观众无法切换音频播放路由。</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法仅适用于 Android 和 iOS 平台。</li>
  <li class="- topic/li li">请确保在调用此方法前已调用过 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 方法。</li>
  <li class="- topic/li li">调用该方法后，SDK 将返回 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onaudioroutechanged" title="语音路由已发生变化回调。"><span class="- topic/keyword keyword">onAudioRouteChanged</span></a> 回调提示状态已更改。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setenablespeakerphone__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">speakerOn</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置是否切换语音路由到扬声器（外放）：<ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 切换到外放。如果设备连接了耳机或蓝牙，则无法切换到外放。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 切换到听筒。如果设备连接了耳机，则语音路由走耳机。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setenablespeakerphone__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title105" id="api_isspeakerphoneenabled">
    <h2 class="- topic/title title topictitle2" id="ariaid-title105"><a href="class_irtcengine.aspx#api_isspeakerphoneenabled"><span class="- topic/ph ph">isSpeakerphoneEnabled</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_isspeakerphoneenabled__shortdesc">检查扬声器状态启用状态。</span></p><section class="- topic/section section" id="api_isspeakerphoneenabled__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">bool</strong> isSpeakerphoneEnabled() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_isspeakerphoneenabled__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
       <p class="- topic/p p">该方法检查扬声器是否已开启。</p>
        </section>
        <section class="- topic/section section" id="api_isspeakerphoneenabled__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 扬声器已开启，语音会输出到扬声器</li>
       <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 扬声器未开启，语音会输出到非扬声器（听筒，耳机等）</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title106" id="api_enableInearmonitoring">
    <h2 class="- topic/title title topictitle2" id="ariaid-title106"><a href="class_irtcengine.aspx#api_enableInearmonitoring"><span class="- topic/ph ph">enableInEarMonitoring</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enableInearmonitoring__shortdesc">开启耳返功能。</span></p><section class="- topic/section section" id="api_enableInearmonitoring__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableInEarMonitoring(<strong class="hl-keyword">bool</strong> enabled) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enableInearmonitoring__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
       <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
  <ul class="- topic/ul ul">
      <li class="- topic/li li">该方法仅适用于 Android 和 iOS 平台。</li>
      <li class="- topic/li li">用户必须使用有线耳机才能听到耳返效果。</li>
      <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  </ul>
       </div>
       <p class="- topic/p p">该方法打开或关闭耳返功能。</p>
        </section>
        <section class="- topic/section section" id="api_enableInearmonitoring__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">开启/关闭耳返功能:  <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启耳返功能</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 关闭耳返功能(默认)</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enableInearmonitoring__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title107" id="api_seiinearmonitoringvolume">
    <h2 class="- topic/title title topictitle2" id="ariaid-title107"><a href="class_irtcengine.aspx#api_seiinearmonitoringvolume"><span class="- topic/ph ph">setInEarMonitoringVolume</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_seiinearmonitoringvolume__shortdesc">设置耳返音量。</span></p><section class="- topic/section section" id="api_seiinearmonitoringvolume__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setInEarMonitoringVolume(<strong class="hl-keyword">int</strong> volume) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_seiinearmonitoringvolume__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
       <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
  <ul class="- topic/ul ul">
      <li class="- topic/li li">该方法仅适用于 Android 和 iOS 平台。</li>
      <li class="- topic/li li">用户必须使用有线耳机才能听到耳返效果。</li>
      <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  </ul>
       </div>
        </section>
        <section class="- topic/section section" id="api_seiinearmonitoringvolume__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置耳返音量，取值范围在 [0,100]。默认值为 100。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_seiinearmonitoringvolume__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title108" id="api_enabledualstreammode">
    <h2 class="- topic/title title topictitle2" id="ariaid-title108"><a href="class_irtcengine.aspx#api_enabledualstreammode"><span class="- topic/ph ph">enableDualStreamMode</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enabledualstreammode__shortdesc">开关双流模式。</span></p><section class="- topic/section section" id="api_enabledualstreammode__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableDualStreamMode(<strong class="hl-keyword">bool</strong> enabled) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enabledualstreammode__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法设置单流（默认）或者双流模式。发送端开启双流模式后，接收端可以选择接收大流还是小流。其中，大流指高分辨率、高码率的视频流，小流指低分辨率、低码率的视频流。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_enabledualstreammode__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 双流。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 单流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title109" id="api_setremotevideostreamtype">
    <h2 class="- topic/title title topictitle2" id="ariaid-title109"><a href="class_irtcengine.aspx#api_setremotevideostreamtype"><span class="- topic/ph ph">setRemoteVideoStreamType</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremotevideostreamtype__shortdesc">设置订阅的视频流类型。</span></p><section class="- topic/section section" id="api_setremotevideostreamtype__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteVideoStreamType(uid_t userId, REMOTE_VIDEO_STREAM_TYPE streamType) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_setremotevideostreamtype__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_setremotevideostreamtype__desc1" data-ofbid="api_setremotevideostreamtype__desc1">在网络条件受限的情况下，如果发送端没有调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enabledualstreammode" title="开关双流模式。"><span class="- topic/keyword keyword">enableDualStreamMode</span></a> (<span class="- topic/ph ph">false</span>) 关闭双流模式，接收端可以选择接收大流还是小流。其中，大流可以接为高分辨率高码率的视频流，小流则是低分辨率低码率的视频流。</p>
   <p class="- topic/p p" id="api_setremotevideostreamtype__desc2" data-ofbid="api_setremotevideostreamtype__desc2">正常情况下，用户默认接收大流。如需接收小流，可以调用本方法进行切换。SDK 会根据视频窗口的大小动态调整对应视频流的大小，以节约带宽和计算资源。视频小流默认的宽高比和视频大流的宽高比一致。根据当前大流的宽高比，系统会自动分配小流的分辨率、帧率及码率。</p>
   <p class="- topic/p p" id="api_setremotevideostreamtype__desc3" data-ofbid="api_setremotevideostreamtype__desc3">调用本方法的执行结果将在 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onapicallexecuted" title="API 方法已执行回调。"><span class="- topic/keyword keyword">onApiCallExecuted</span></a> 中返回。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span>  该方法需要在加入频道后调用。如果既调用了 <span class="+ topic/keyword pr-d/apiname keyword apiname">setRemoteVideoStreamType</span>，也调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setremotedefaultvideostreamtype" title="设置默认订阅的视频流类型。"><span class="- topic/keyword keyword">setRemoteDefaultVideoStreamType</span></a>，则 SDK 以 <span class="+ topic/keyword pr-d/apiname keyword apiname">setRemoteVideoStreamType</span> 中的设置为准。</div>
        </section>
        <section class="- topic/section section" id="api_setremotevideostreamtype__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">streamType</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流类型: <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STREAM_TYPE</span> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremotevideostreamtype__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title110" id="api_setremotedefaultvideostreamtype">
    <h2 class="- topic/title title topictitle2" id="ariaid-title110"><a href="class_irtcengine.aspx#api_setremotedefaultvideostreamtype"><span class="- topic/ph ph">setRemoteDefaultVideoStreamType</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremotedefaultvideostreamtype__shortdesc">设置默认订阅的视频流类型。</span></p><section class="- topic/section section" id="api_setremotedefaultvideostreamtype__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteDefaultVideoStreamType(REMOTE_VIDEO_STREAM_TYPE streamType) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setremotedefaultvideostreamtype__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_setremotedefaultvideostreamtype__desc1" data-ofbid="api_setremotedefaultvideostreamtype__desc1">在网络条件受限的情况下，如果发送端没有调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enabledualstreammode" title="开关双流模式。"><span class="- topic/keyword keyword">enableDualStreamMode</span></a> (<span class="- topic/xref xref"><span class="- topic/keyword keyword">false</span></span>)
       关闭双流模式，接收端可以选择接收大流还是小流。其中，大流可以接为高分辨率高码率的视频流，小流则是低分辨率低码率的视频流。</p>
   <p class="- topic/p p" id="api_setremotedefaultvideostreamtype__desc2" data-ofbid="api_setremotedefaultvideostreamtype__desc2">正常情况下，用户默认接收大流。如需默认接收所有用户的视频小流，可以调用本方法进行切换。SDK
       会根据视频窗口的大小动态调整对应视频流的大小，以节约带宽和计算资源。视频小流默认的宽高比和视频大流的宽高比一致。根据当前大流的宽高比，系统会自动分配小流的分辨率、帧率及码率。</p>
   <p class="- topic/p p" id="api_setremotedefaultvideostreamtype__desc3" data-ofbid="api_setremotedefaultvideostreamtype__desc3">调用本方法的执行结果将在 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onapicallexecuted" title="API 方法已执行回调。"><span class="- topic/keyword keyword">onApiCallExecuted</span></a> 中返回。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在加入频道后调用。如果既调用了 <span class="+ topic/keyword pr-d/apiname keyword apiname">setRemoteVideoStreamType</span>，也调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setremotedefaultvideostreamtype" title="设置默认订阅的视频流类型。"><span class="- topic/keyword keyword">setRemoteDefaultVideoStreamType</span></a>，则 SDK 以 <span class="+ topic/keyword pr-d/apiname keyword apiname">setRemoteVideoStreamType</span> 中的设置为准。</div>
        </section>
        <section class="- topic/section section" id="api_setremotedefaultvideostreamtype__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">streamType</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流类型: <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STREAM_TYPE</span> 。
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremotedefaultvideostreamtype__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title111" id="api_setlocalpublishfallbackoption">
    <h2 class="- topic/title title topictitle2" id="ariaid-title111"><a href="class_irtcengine.aspx#api_setlocalpublishfallbackoption"><span class="- topic/ph ph">setLocalPublishFallbackOption</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalpublishfallbackoption__shortdesc">设置弱网条件下发布的音视频流回退选项。</span></p><section class="- topic/section section" id="api_setlocalpublishfallbackoption__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalPublishFallbackOption(STREAM_FALLBACK_OPTIONS option) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalpublishfallbackoption__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">网络不理想的环境下，实时通信音视频的质量都会下降。使用该接口并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> (2) 后，SDK 会在上行弱网且音视频质量严重受影响时，自动关断视频流，从而保证或提高音频质量。同时 SDK 会持续监控网络质量，并在网络质量改善时恢复音视频流。当本地推流回退为音频流时，或由音频流恢复为音视频流时，SDK 会触发本地发布的媒体流已回退为音频流 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlocalpublishfallbacktoaudioonly" title="本地发布流已回退为音频流回调。"><span class="- topic/keyword keyword">onLocalPublishFallbackToAudioOnly</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">视频直播场景下，旁路推流的发流用户（即主播）设置 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> (2) 可能导致 CDN 观众听到的声音有所延迟。Agora 不建议主播使用视频流回退机制。</li>
  <li class="- topic/li li">该方法需要在加入频道前调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setlocalpublishfallbackoption__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">option</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地发流回退处理选项：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_DISABLED</span> (0)：（默认）上行网络较弱时，不对音视频流作回退处理，但不能保证音视频流的质量</li>
 <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> (2)：上行网络较弱时只发布音频流</li>
      </ul>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalpublishfallbackoption__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title112" id="api_setremotesubscribefallbackoption">
    <h2 class="- topic/title title topictitle2" id="ariaid-title112"><a href="class_irtcengine.aspx#api_setremotesubscribefallbackoption"><span class="- topic/ph ph">setRemoteSubscribeFallbackOption</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremotesubscribefallbackoption__shortdesc">设置弱网条件下订阅的音视频流的回退选项。</span></p><section class="- topic/section section" id="api_setremotesubscribefallbackoption__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteSubscribeFallbackOption(STREAM_FALLBACK_OPTIONS option) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setremotesubscribefallbackoption__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">默认 <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_DISABLED</span> (1)。如果你使用本方法并将
  <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> (2)，SDK
       会在下行弱网且音视频质量严重受影响时，将视频流切换为小流，或关断视频流，从而保证或提高音频质量。同时 SDK
       会持续监控网络质量，并在网络质量改善时恢复音视频流。当远端订阅流回退为音频流时，或由音频流恢复为音视频流时，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotesubscribefallbacktoaudioonly" title="远端订阅流已回退为音频流回调。"><span class="- topic/keyword keyword">onRemoteSubscribeFallbackToAudioOnly</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在加入频道前调用。</div>
        </section>
        <section class="- topic/section section" id="api_setremotesubscribefallbackoption__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">option</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTIONS</span> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremotesubscribefallbackoption__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title113" id="api_setremoteuserpriority">
    <h2 class="- topic/title title topictitle2" id="ariaid-title113"><a href="class_irtcengine.aspx#api_setremoteuserpriority"><span class="- topic/ph ph">setRemoteUserPriority</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setremoteuserpriority__shortdesc">设置远端用户流的优先级。</span></p><section class="- topic/section section" id="api_setremoteuserpriority__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRemoteUserPriority(uid_t uid, PRIORITY_TYPE userPriority) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setremoteuserpriority__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">设置远端用户的优先级。如果将某个用户的优先级设为高，那么发给这个用户的音视频流的优先级就会高于其他用户。弱网下 SDK 会优先保证高优先级用户收到的流的质量。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">目前 Agora SDK 仅允许将一名远端用户设为高优先级。</li>
  <li class="- topic/li li">该方法需要在加入频道前调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setremoteuserpriority__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">userPriority</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的需求优先级。详见: <span class="+ topic/keyword pr-d/apiname keyword apiname">PRIORITY_TYPE</span> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setremoteuserpriority__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title114" id="api_startechotest1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title114"><a href="class_irtcengine.aspx#api_startechotest1"><span class="- topic/ph ph">startEchoTest</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startechotest1__shortdesc">开始语音通话回路测试。</span></p><section class="- topic/section section" id="api_startechotest1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startEchoTest() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startechotest1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法自 v2.4.0 起废弃。</dd>
       
   </dl>
   <p class="- topic/p p">该方法启动语音通话测试，目的是测试系统的音频设备（耳麦、扬声器等）和网络连接是否正常。在测试过程中，用户先说一段话，声音会在设置的时间间隔（单位为秒）后回放出来。如果用户能正常听到自己刚才说的话，就表示系统音频设备和网络连接都是正常的。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在加入频道前调用该方法。</li>
  <li class="- topic/li li">调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">startEchoTest</span> 后必须调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_stopechotest" title="停止语音通话回路测试。"><span class="- topic/keyword keyword">stopEchoTest</span></a> 以结束测试，否则不能进行下一次回声测试，也无法加入频道。</li>
  <li class="- topic/li li">直播场景下，该方法仅能由用户角色为主播的用户调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startechotest1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title115" id="api_startechotest2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title115"><a href="class_irtcengine.aspx#api_startechotest2"><span class="- topic/ph ph">startEchoTest</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startechotest2__shortdesc">开始语音通话回路测试。</span></p><section class="- topic/section section" id="api_startechotest2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startEchoTest(<strong class="hl-keyword">int</strong> intervalInSeconds) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startechotest2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法启动语音通话测试，目的是测试系统的音频设备（耳麦、扬声器等）和网络连接是否正常。在测试过程中，用户先说一段话，声音会在设置的时间间隔（单位为秒）后回放出来。如果用户能正常听到自己刚才说的话，就表示系统音频设备和网络连接都是正常的。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请在加入频道前调用该方法。</li>
  <li class="- topic/li li">调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">startEchoTest</span> 后必须调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_stopechotest" title="停止语音通话回路测试。"><span class="- topic/keyword keyword">stopEchoTest</span></a> 以结束测试，否则不能进行下一次回声测试，也无法加入频道。</li>
  <li class="- topic/li li">直播场景下，该方法仅能由用户角色为主播的用户调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startechotest2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">intervalInSeconds</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设置返回语音通话回路测试结果的时间间隔，取值范围为 [2,10]，单位为秒，默认为 10 秒。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startechotest2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title116" id="api_stopechotest">
    <h2 class="- topic/title title topictitle2" id="ariaid-title116"><a href="class_irtcengine.aspx#api_stopechotest"><span class="- topic/ph ph">stopEchoTest</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopechotest__shortdesc">停止语音通话回路测试。</span></p><section class="- topic/section section" id="api_stopechotest__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopEchoTest() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stopechotest__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title117" id="api_enablelastmiletest">
    <h2 class="- topic/title title topictitle2" id="ariaid-title117"><a href="class_irtcengine.aspx#api_enablelastmiletest"><span class="- topic/ph ph">enableLastmileTest</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enablelastmiletest__shortdesc">启动网络测试。</span></p><section class="- topic/section section" id="api_enablelastmiletest__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableLastmileTest() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enablelastmiletest__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">该方法启用网络连接质量测试，用于检测用户目前的网络接入质量（上行网络质量）。默认该功能为关闭状态。该方法主要用于以下场景:
       <ul class="- topic/ul ul">
  <li class="- topic/li li">用户加入频道前，可以调用该方法判断和预测目前的上行网络质量是否足够好。</li>
  <li class="- topic/li li">直播场景下，当用户角色由观众切换为主播时，可以调用该方法判断和预测目前的上行网络质量是否足够好。</li>
       </ul>
   </div>
   <p class="- topic/p p">无论哪种场景，启用该方法均会消耗网络流量，影响通话质量。用户必须在收到 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlastmilequality" title="通话前网络上下行 last mile 质量报告回调。"><span class="- topic/keyword keyword">onLastmileQuality</span></a> 回调后须调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablelastmiletest" title="关闭网络测试。"><span class="- topic/keyword keyword">disableLastmileTest</span></a> 停止测试，再加入频道或切换为主播。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法请勿与 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startlastmileprobetest" title="开始通话前网络质量探测。"><span class="- topic/keyword keyword">startLastmileProbeTest</span></a> 同时使用。</li>
  <li class="- topic/li li">调用该方法后，在收到 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlastmilequality" title="通话前网络上下行 last mile 质量报告回调。"><span class="- topic/keyword keyword">onLastmileQuality</span></a> 回调前请勿调用其他方法，否则可能由于 API 操作过于频繁导致回调无法执行。</li>
  <li class="- topic/li li">在直播场景中，如果本地用户为主播，请勿加入频道后调用该方法。</li>
  <li class="- topic/li li">加入频道前调用该方法检测网络质量后，SDK 会占用一路视频的带宽，码率与 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvideoencoderconfiguration" title="设置视频编码属性。"><span class="- topic/keyword keyword">setVideoEncoderConfiguration</span></a> 中设置的码率相同。加入频道后，无论是否调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablelastmiletest" title="关闭网络测试。"><span class="- topic/keyword keyword">disableLastmileTest</span></a> ，SDK 均会自动停止带宽占用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_enablelastmiletest__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title118" id="api_disablelastmiletest">
    <h2 class="- topic/title title topictitle2" id="ariaid-title118"><a href="class_irtcengine.aspx#api_disablelastmiletest"><span class="- topic/ph ph">disableLastmileTest</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_disablelastmiletest__shortdesc">关闭网络测试。</span></p><section class="- topic/section section" id="api_disablelastmiletest__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> disableLastmileTest() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_disablelastmiletest__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title119" id="api_startlastmileprobetest">
    <h2 class="- topic/title title topictitle2" id="ariaid-title119"><a href="class_irtcengine.aspx#api_startlastmileprobetest"><span class="- topic/ph ph">startLastmileProbeTest</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startlastmileprobetest__shortdesc">开始通话前网络质量探测。</span></p><section class="- topic/section section" id="api_startlastmileprobetest__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startLastmileProbeTest(<strong class="hl-keyword">const</strong> LastmileProbeConfig&amp; config) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startlastmileprobetest__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">开始通话前网络质量探测，向用户反馈上下行网络的带宽、丢包、网络抖动和往返时延数据。</p>
   <div class="- topic/p p">启用该方法后，SDK 会依次返回如下 2 个回调：<ul class="- topic/ul ul">
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlastmilequality" title="通话前网络上下行 last mile 质量报告回调。"><span class="- topic/keyword keyword">onLastmileQuality</span></a>，视网络情况约 2
      秒内返回。该回调通过打分反馈上下行网络质量，更贴近用户的主观感受。</li>
  <li class="- topic/li li"><a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlastmileproberesult" title="通话前网络质量探测报告回调。"><span class="- topic/keyword keyword">onLastmileProbeResult</span></a>，视网络情况约 30
      秒内返回。该回调通过具体数据反馈上下行网络质量，更加客观。</li>
       </ul>
   </div>
   <div class="- topic/p p">该方法主要用于以下两种场景：<ul class="- topic/ul ul">
  <li class="- topic/li li">用户加入频道前，可以调用该方法判断和预测目前的上行网络质量是否足够好。</li>
  <li class="- topic/li li">直播场景下，当用户角色想由观众切换为主播时，可以调用该方法判断和预测目前的上行网络质量是否足够好。</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法会消耗一定的网络流量，影响通话质量，因此我们建议不要和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelastmiletest" title="启动网络测试。"><span class="- topic/keyword keyword">enableLastmileTest</span></a> 同时使用。</li>
  <li class="- topic/li li">调用该方法后，在收到 <span class="+ topic/keyword pr-d/apiname keyword apiname">onLastmileQuality</span> 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">onLastmileProbeResult</span> 回调之前请不要调用其他方法，否则可能会由于 API 操作过于频繁导致此方法无法执行。</li>
  <li class="- topic/li li">在直播场景中，如果本地用户为主播，请勿加入频道后调用该方法。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startlastmileprobetest__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">config</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">Last mile 网络探测配置，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_lastmileprobeconfig" title="Last mile 网络探测配置。"><span class="- topic/keyword keyword">LastmileProbeConfig</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startlastmileprobetest__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title120" id="api_stoplastmileprobetest">
    <h2 class="- topic/title title topictitle2" id="ariaid-title120"><a href="class_irtcengine.aspx#api_stoplastmileprobetest"><span class="- topic/ph ph">stopLastmileProbeTest</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stoplastmileprobetest__shortdesc">停止通话前网络质量探测。</span></p><section class="- topic/section section" id="api_stoplastmileprobetest__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopLastmileProbeTest() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stoplastmileprobetest__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title121" id="api_setvideosource">
    <h2 class="- topic/title title topictitle2" id="ariaid-title121"><a href="class_irtcengine.aspx#api_setvideosource"><span class="- topic/ph ph">setVideoSource</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setvideosource__shortdesc">设置自定义的视频源。</span></p><section class="- topic/section section" id="api_setvideosource__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">bool</strong> setVideoSource(IVideoSource *source) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_setvideosource__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">实时通信过程中，Agora SDK 会启动默认的视频输入设备，即内置的摄像头，采集视频。但是，如果你需要自定义视频输入设备，你可以先通过 <a class="- topic/xref xref" href="class_ivideosource.aspx#class_ivideosource" title="IVideoSource 类，可以设置自定义的视频源。"><span class="- topic/keyword keyword">IVideoSource</span></a> 类自定义视频源，再调用该方法将自定义的视频源加入到 SDK 中。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法在加入频道前后都能调用。</div>
        </section>
        <section class="- topic/section section" id="api_setvideosource__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">source</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">自定义的视频源。详细定义见 <span class="+ topic/keyword pr-d/apiname keyword apiname">IVideoSource</span>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setvideosource__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 自定义视频源添加成功。</li>
       <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 自定义视频源添加失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title122" id="api_setexternalaudiosource">
    <h2 class="- topic/title title topictitle2" id="ariaid-title122"><a href="class_irtcengine.aspx#api_setexternalaudiosource"><span class="- topic/ph ph">setExternalAudioSource</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setexternalaudiosource__shortdesc">设置外部音频采集参数。</span></p><section class="- topic/section section" id="api_setexternalaudiosource__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setExternalAudioSource(<strong class="hl-keyword">bool</strong> enabled, <strong class="hl-keyword">int</strong> sampleRate, <strong class="hl-keyword">int</strong> channels) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setexternalaudiosource__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">请在 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startpreview" title="开启视频预览。"><span class="- topic/keyword keyword">startPreview</span></a> 前调用该方法。</p>
        </section>
        <section class="- topic/section section" id="api_setexternalaudiosource__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul" id="api_setexternalaudiosource__ul_uq4_mgz_r4b">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启使用外部音频源的功能。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: （默认）关闭使用外部音频源的功能。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sampleRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">外部音频源的采样率 (Hz)，可设置为 8000，16000，32000，44100 或 48000。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channels</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">外部音频源的通道数，可设置为 1 或 2:<ul class="- topic/ul ul" id="api_setexternalaudiosource__ul_cpd_khz_r4b">
     <li class="- topic/li li">1: 单声道</li>
     <li class="- topic/li li">2: 双声道</li>
 </ul></div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setexternalaudiosource__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title123" id="api_setexternalaudiosink">
    <h2 class="- topic/title title topictitle2" id="ariaid-title123"><a href="class_irtcengine.aspx#api_setexternalaudiosink"><span class="- topic/ph ph">setExternalAudioSink</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setexternalaudiosink__shortdesc">设置外部音频渲染。</span></p><section class="- topic/section section" id="api_setexternalaudiosink__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setExternalAudioSink(<strong class="hl-keyword">bool</strong> enabled, <strong class="hl-keyword">int</strong> sampleRate, <strong class="hl-keyword">int</strong> channels) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setexternalaudiosink__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法适用于需要自行渲染音频的场景。开启外部音频渲染后，你可以通过调用 <a class="- topic/xref xref" href="class_imediaengine.aspx#api_pullaudioframe" title="拉取远端音频数据。"><span class="- topic/keyword keyword">pullAudioFrame</span></a> 方法拉取远端音频数据。 App
       可以对拉取到的原始音频数据进行处理后再渲染，获取想要的音频效果。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul" id="api_setexternalaudiosink__ul_ng3_ljz_r4b">
  <li class="- topic/li li">开启外部音频渲染后，App 会无法从 <a class="- topic/xref xref" href="class_iaudioframeobserver.aspx#api_onplaybackaudioframe" title="获得播放的声音。"><span class="- topic/keyword keyword">onPlaybackAudioFrame</span></a> 回调中获得数据。</li>
  <li class="- topic/li li">该方法需要在加入频道前调用。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setexternalaudiosink__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启外部音频渲染。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: （默认）关闭外部音频渲染。</li>
      </ul>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sampleRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">外部音频渲染的采样率 (Hz)，可设置为 16000，32000，44100 或 48000。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channels</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">外部音频渲染的通道数，可设置为 1 或 2:<ul class="- topic/ul ul" id="api_setexternalaudiosink__ul_cpd_khz_r4b">
 <li class="- topic/li li">1: 单声道</li>
 <li class="- topic/li li">2: 双声道</li>
      </ul></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setexternalaudiosink__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title124" id="api_setrecordingaudioframeparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title124"><a href="class_irtcengine.aspx#api_setrecordingaudioframeparameters"><span class="- topic/ph ph">setRecordingAudioFrameParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setrecordingaudioframeparameters__shortdesc">设置采集的音频格式。</span></p><section class="- topic/section section" id="api_setrecordingaudioframeparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setRecordingAudioFrameParameters(<strong class="hl-keyword">int</strong> sampleRate, <strong class="hl-keyword">int</strong> channel, RAW_AUDIO_FRAME_OP_MODE_TYPE mode, <strong class="hl-keyword">int</strong> samplesPerCall) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setrecordingaudioframeparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法设置 <a class="- topic/xref xref" href="class_iaudioframeobserver.aspx#api_onrecordaudioframe" title="获得采集的音频。"><span class="- topic/keyword keyword">onRecordAudioFrame</span></a> 回调的采集音频格式。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul" id="api_setrecordingaudioframeparameters__ul_t13_lnz_r4b">
  <li class="- topic/li li">该方法需要在加入频道前调用。</li>
  <li class="- topic/li li">SDK 会通过该方法中的
 <span class="+ topic/keyword pr-d/parmname keyword parmname">samplesPerCall</span>、<span class="+ topic/keyword pr-d/parmname keyword parmname">sampleRate</span> 和
 <span class="+ topic/keyword pr-d/parmname keyword parmname">channel</span> 参数计算出采样间隔，计算公式为<span class="+ topic/ph equation-d/equation-inline  eqn-inline ">采样间隔 =
 samplesPerCall/(sampleRate × channel)</span>。 请确保采样间隔不小于 0.01
      秒。SDK 会根据该采样间隔触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onRecordAudioFrame</span> 回调。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setrecordingaudioframeparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sampleRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定 <span class="+ topic/keyword pr-d/apiname keyword apiname">onRecordAudioFrame</span> 中返回数据的采样率，可设置为 8000、 16000、 32000、
      44100 或 48000。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p"><span class="+ topic/keyword pr-d/apiname keyword apiname">onRecordAudioFrame</span> 中返回数据的通道数，可设置为 1 或 2:<ul class="- topic/ul ul" id="api_setrecordingaudioframeparameters__ul_xg2_cnz_r4b">
     <li class="- topic/li li">1: 单声道</li>
     <li class="- topic/li li">2: 双声道</li>
 </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onRecordAudioFrame</span> 回调的使用模式，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rawaudioframeopmodetype" title="onRecordAudioFrame 或 onPlaybackAudioFrame 回调中返回的音频数据的使用模式。"><span class="- topic/keyword keyword">RAW_AUDIO_FRAME_OP_MODE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">samplesPerCall</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onRecordAudioFrame</span> 中返回数据的采样点数，如 RTMP/RTMPS 推流应用中通常为
      1024。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setrecordingaudioframeparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title125" id="api_setplaybackaudioframeparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title125"><a href="class_irtcengine.aspx#api_setplaybackaudioframeparameters"><span class="- topic/ph ph">setPlaybackAudioFrameParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setplaybackaudioframeparameters__shortdesc">设置播放的音频格式。</span></p><section class="- topic/section section" id="api_setplaybackaudioframeparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setPlaybackAudioFrameParameters(<strong class="hl-keyword">int</strong> sampleRate, <strong class="hl-keyword">int</strong> channel, RAW_AUDIO_FRAME_OP_MODE_TYPE mode, <strong class="hl-keyword">int</strong> samplesPerCall) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setplaybackaudioframeparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法设置 <a class="- topic/xref xref" href="class_iaudioframeobserver.aspx#api_onplaybackaudioframe" title="获得播放的声音。"><span class="- topic/keyword keyword">onPlaybackAudioFrame</span></a> 回调数据的格式。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul" id="api_setplaybackaudioframeparameters__ul_t13_lnz_r4b">
  <li class="- topic/li li">该方法需要在加入频道前调用。</li>
  <li class="- topic/li li">SDK 会通过该方法中的
 <span class="+ topic/keyword pr-d/parmname keyword parmname">samplesPerCall</span>、<span class="+ topic/keyword pr-d/parmname keyword parmname">sampleRate</span> 和
 <span class="+ topic/keyword pr-d/parmname keyword parmname">channel</span> 参数计算出采样间隔，计算公式为<span class="+ topic/ph equation-d/equation-inline  eqn-inline ">采样间隔 =
 samplesPerCall/(sampleRate × channel)</span>。 请确保采样间隔不小于 0.01
      秒。SDK 会根据该采样间隔触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onPlaybackAudioFrame</span> 回调。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setplaybackaudioframeparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sampleRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onPlaybackAudioFrame</span> 中返回数据的采样率，可设置为 8000、 16000、 32000、
      44100 或 48000。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p"><span class="+ topic/keyword pr-d/apiname keyword apiname">onPlaybackAudioFrame</span> 中返回数据的通道数，可设置为 1 或 2:<ul class="- topic/ul ul" id="api_setplaybackaudioframeparameters__ul_xg2_cnz_r4b">
     <li class="- topic/li li">1: 单声道</li>
     <li class="- topic/li li">2: 双声道</li>
 </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onPlaybackAudioFrame</span> 回调的使用模式，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rawaudioframeopmodetype" title="onRecordAudioFrame 或 onPlaybackAudioFrame 回调中返回的音频数据的使用模式。"><span class="- topic/keyword keyword">RAW_AUDIO_FRAME_OP_MODE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">samplesPerCall</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onPlaybackAudioFrame</span> 中返回数据的采样点数，如 RTMP/RTMPS 推流应用中通常为
      1024。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setplaybackaudioframeparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title126" id="api_setmixedaudioframeparameters">
    <h2 class="- topic/title title topictitle2" id="ariaid-title126"><a href="class_irtcengine.aspx#api_setmixedaudioframeparameters"><span class="- topic/ph ph">setMixedAudioFrameParameters</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setmixedaudioframeparameters__shortdesc">设置录制和播放声音混音后的数据格式。</span></p><section class="- topic/section section" id="api_setmixedaudioframeparameters__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setMixedAudioFrameParameters(<strong class="hl-keyword">int</strong> sampleRate, <strong class="hl-keyword">int</strong> samplesPerCall) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setmixedaudioframeparameters__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法设置 <a class="- topic/xref xref" href="class_iaudioframeobserver.aspx#api_onmixedaudioframe" title="获取采集和播放语音混音后的数据。"><span class="- topic/keyword keyword">onMixedAudioFrame</span></a> 回调数据的格式。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul" id="api_setmixedaudioframeparameters__ul_t13_lnz_r4b">
  <li class="- topic/li li">该方法需要在加入频道前调用。</li>
  <li class="- topic/li li">SDK 会通过该方法中的
 <span class="+ topic/keyword pr-d/parmname keyword parmname">samplesPerCall</span>、<span class="+ topic/keyword pr-d/parmname keyword parmname">sampleRate</span> 和
 <span class="+ topic/keyword pr-d/parmname keyword parmname">channel</span> 参数计算出采样间隔，计算公式为<span class="+ topic/ph equation-d/equation-inline  eqn-inline ">采样间隔 =
 samplesPerCall/(sampleRate × channel)</span>。 请确保采样间隔不小于 0.01
      秒。SDK 会根据该采样间隔触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onMixedAudioFrame</span> 回调。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setmixedaudioframeparameters__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sampleRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onMixedAudioFrame</span> 中返回数据的采样率，可设置为 8000、 16000、 32000、
      44100 或 48000。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">samplesPerCall</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">onMixedAudioFrame</span> 中返回数据的采样点数，如 RTMP/RTMPS 推流应用中通常为
      1024。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setmixedaudioframeparameters__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title127" id="api_registermediametadataobserver">
    <h2 class="- topic/title title topictitle2" id="ariaid-title127"><a href="class_irtcengine.aspx#api_registermediametadataobserver"><span class="- topic/ph ph">registerMediaMetadataObserver</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_registermediametadataobserver__shortdesc">注册媒体 metadata 观测器用于接收或发送 metadata。</span></p><section class="- topic/section section" id="api_registermediametadataobserver__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> registerMediaMetadataObserver(IMetadataObserver *observer, IMetadataObserver::METADATA_TYPE type) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_registermediametadataobserver__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.1</dd>
       
   </dl>
   <div class="- topic/p p">
       <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
  <ul class="- topic/ul ul" id="api_registermediametadataobserver__ul_bmd_btz_r4b">
      <li class="- topic/li li">请在 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 前调用该方法。</li>
      <li class="- topic/li li">该方法仅适用于直播场景。</li>
  </ul>
       </div>
   </div>
        </section>
        <section class="- topic/section section" id="api_registermediametadataobserver__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">observer</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      指向已注册的 metadata 观测器的指针。详见 <a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_imetadataobserver" title="Metadata 观测器。"><span class="- topic/keyword keyword">IMetadataObserver</span></a>。
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">type</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户希望在观测器中使用的 METADATA 类型 。目前仅支持 <span class="+ topic/keyword pr-d/apiname keyword apiname">VIDEO_METADATA</span> 。详见 <a class="- topic/xref xref" href="class_imetadataobserver.aspx#enum_metadatatype" title="观测器的 Metadata 类型。当前仅支持视频类型的 Metadata 。"><span class="- topic/keyword keyword">METADATA_TYPE</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_registermediametadataobserver__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0：方法调用成功。</li>
       <li class="- topic/li li">&lt; 0：方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title128" id="api_addvideowatermark1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title128"><a href="class_irtcengine.aspx#api_addvideowatermark1"><span class="- topic/ph ph">addVideoWatermark</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_addvideowatermark1__shortdesc">添加本地视频水印。</span></p><section class="- topic/section section" id="api_addvideowatermark1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> addVideoWatermark(<strong class="hl-keyword">const</strong> RtcImage&amp; watermark) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_addvideowatermark1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法已废弃，请使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_addvideowatermark2" title="添加本地视频水印。"><span class="- topic/keyword keyword">addVideoWatermark</span></a> 作为替代。</dd>
       
   </dl>
   <p class="- topic/p p">该方法将一张 PNG
       图片作为水印添加到本地发布的直播视频流上，同一直播频道中的观众，旁路推流观众，甚至采集设备都能看到或采集到该水印图片。如果你仅仅希望在旁路直播推流中添加水印，请参考
  <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlivetranscoding" title="设置直播推流转码。"><span class="- topic/keyword keyword">setLiveTranscoding</span></a> 中描述的用法。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">在本地直播和旁路推流中，URL 的定义不同。本地直播中，URL 指本地直播视频上图片的本地绝对/相对路径；旁路推流中，URL 指旁路推流视频上图片的地址。</li>
  <li class="- topic/li li">待添加图片的源文件格式必须是 PNG。如果待添加的 PNG 图片的尺寸与你该方法中设置的尺寸不一致，SDK 会对 PNG 图片进行裁剪，以与设置相符。</li>
  <li class="- topic/li li">声网当前只支持在直播视频流中添加一个水印，后添加的水印会替换掉之前添加的水印。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_addvideowatermark1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">watermark</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">待添加在本地直播推流中的水印图片： <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rtcimage" title="图像属性。"><span class="- topic/keyword keyword">RtcImage</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_addvideowatermark1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title129" id="api_addvideowatermark2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title129"><a href="class_irtcengine.aspx#api_addvideowatermark2"><span class="- topic/ph ph">addVideoWatermark</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_addvideowatermark2__shortdesc">添加本地视频水印。</span></p><section class="- topic/section section" id="api_addvideowatermark2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> addVideoWatermark(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* watermarkUrl, <strong class="hl-keyword">const</strong> WatermarkOptions&amp; options) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_addvideowatermark2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法将一张 PNG 图片作为水印添加到本地发布的直播视频流上，同一直播频道中的观众、旁路直播观众和采集设备都能看到或采集到该水印图片。Agora 当前只支持在直播视频流中添加一个水印，后添加的水印会替换掉之前添加的水印。</p>
   <div class="- topic/p p">水印坐标和 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvideoencoderconfiguration" title="设置视频编码属性。"><span class="- topic/keyword keyword">setVideoEncoderConfiguration</span></a> 方法中的设置有依赖关系：<ul class="- topic/ul ul">
  <li class="- topic/li li">如果视频编码方向（<span class="+ topic/keyword pr-d/apiname keyword apiname">ORIENTATION_MODE</span>）
      固定为横屏或自适应模式下的横屏，那么水印使用横屏坐标。</li>
  <li class="- topic/li li">如果视频编码方向（<span class="+ topic/keyword pr-d/apiname keyword apiname">ORIENTATION_MODE</span>）
      固定为竖屏或自适应模式下的竖屏，那么水印使用竖屏坐标。</li>
  <li class="- topic/li li">设置水印坐标时，水印的图像区域不能超出 <span class="+ topic/keyword pr-d/apiname keyword apiname">setVideoEncoderConfiguration</span>
      方法中设置的视频尺寸，否则超出部分将被裁剪。</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">你需要在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 方法之后再调用本方法。</li>
  <li class="- topic/li li">如果你只是在旁路直播（推流到 CDN）中添加水印，你可以使用本方法或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlivetranscoding" title="设置直播推流转码。"><span class="- topic/keyword keyword">setLiveTranscoding</span></a> 方法设置水印。</li>
  <li class="- topic/li li">待添加水印图片必须是 PNG 格式。本方法支持所有像素格式的 PNG 图片：RGBA、RGB、Palette、Gray 和 Alpha_gray。</li>
  <li class="- topic/li li">如果待添加的 PNG 图片的尺寸与你在本方法中设置的尺寸不一致，SDK 会对 PNG 图片进行缩放或裁剪，以与设置相符。</li>
  <li class="- topic/li li">如果你已经使用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startpreview" title="开启视频预览。"><span class="- topic/keyword keyword">startPreview</span></a> 方法开启本地视频预览，那么本方法的 <code class="+ topic/ph pr-d/codeph ph codeph">visibleInPreview</code> 可设置水印在预览时是否可见。</li>
  <li class="- topic/li li">如果你已设置本地视频为镜像模式，那么此处的本地水印也为镜像。为避免本地用户看本地视频时的水印也被镜像，Agora 建议你不要对本地视频同时使用镜像和水印功能，请在应用层实现本地水印功能。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_addvideowatermark2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">watermarkUrl</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">待添加的水印图片的本地路径。本方法支持从本地绝对/相对路径添加水印图片。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">options</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">待添加的水印图片的设置选项，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_watermarkoptions" title="待添加的水印图片的设置选项。"><span class="- topic/keyword keyword">WatermarkOptions</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_addvideowatermark2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title130" id="api_clearvideowatermarks">
    <h2 class="- topic/title title topictitle2" id="ariaid-title130"><a href="class_irtcengine.aspx#api_clearvideowatermarks"><span class="- topic/ph ph">clearVideoWatermarks</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_clearvideowatermarks__shortdesc">删除已添加的视频水印。</span></p><section class="- topic/section section" id="api_clearvideowatermarks__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> clearVideoWatermarks() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_clearvideowatermarks__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title131" id="api_enableencryption">
    <h2 class="- topic/title title topictitle2" id="ariaid-title131"><a href="class_irtcengine.aspx#api_enableencryption"><span class="- topic/ph ph">enableEncryption</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enableencryption__shortdesc">开启或关闭内置加密。</span></p><section class="- topic/section section" id="api_enableencryption__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableEncryption(<strong class="hl-keyword">bool</strong> enabled, <strong class="hl-keyword">const</strong> EncryptionConfig&amp; config) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enableencryption__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
   <p class="- topic/p p">在安全要求较高的场景下，Agora 建议你在加入频道前，调用本方法开启内置加密。</p>
   <p class="- topic/p p">同一频道内所有用户必须使用相同的加密模式和密钥。一旦所有用户都离开频道，该频道的加密密钥会自动清除。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">如果开启了内置加密，则不能使用 RTMP/RTMPS 推流功能。</li>
  <li class="- topic/li li">Agora 支持 4 种加密模式。除 <code class="+ topic/ph pr-d/codeph ph codeph">SM4_128_ECB</code> 模式外，其他加密模式都需要在集成 Android 或 iOS SDK 时，额外添加加密库文件。详见《媒体流加密》。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_enableencryption__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">是否开启内置加密：
 <ul class="- topic/ul ul">
     <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启</li>
     <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 关闭</li>
 </ul>
      </div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">config</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">配置内置加密模式和密钥。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_encryptionconfig" title="配置内置加密模式和密钥。"><span class="- topic/keyword keyword">EncryptionConfig</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enableencryption__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败 <ul class="- topic/ul ul">
      <li class="- topic/li li">-2(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code>): 调用了无效的参数。需重新指定参数。</li>
      <li class="- topic/li li">-4(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_SUPPORTED</code>):
 设置的加密模式不正确或加载外部加密库失败。需检查枚举值是否正确或重新加载外部加密库。</li>
      <li class="- topic/li li">-7(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_INITIALIZED</code>): SDK 尚未初始化。需在调用 API 之前已创建 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象并完成初始化。</li>
  </ul>
       </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title132" id="api_setencryptionmode">
    <h2 class="- topic/title title topictitle2" id="ariaid-title132"><a href="class_irtcengine.aspx#api_setencryptionmode"><span class="- topic/ph ph">setEncryptionMode</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setencryptionmode__shortdesc">启用内置的加密方案。</span></p><section class="- topic/section section" id="api_setencryptionmode__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setEncryptionMode(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* encryptionMode) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setencryptionmode__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法自 v3.1.0 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enableencryption" title="开启或关闭内置加密。"><span class="- topic/keyword keyword">enableEncryption</span></a> 方法。</dd>
       
   </dl>
   <p class="- topic/p p" id="api_setencryptionmode__desc" data-ofbid="api_setencryptionmode__desc">Agora Video SDK 支持内置加密方案，默认支持 AES-128-XTS。如需采用其他加密方案，可以调用本方法。同一频道内的所有用户必须设置相同的加密方式和 <span class="+ topic/keyword pr-d/parmname keyword parmname">secret</span> 才能进行通话。关于这几种加密方式的区别，请参考 AES 加密算法的相关资料。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span>  在调用本方法前，请先调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setencryptionsecret" title="启用内置加密，并设置数据加密密码。"><span class="- topic/keyword keyword">setEncryptionSecret</span></a>
       启用内置加密功能。</div>
        </section>
        <section class="- topic/section section" id="api_setencryptionmode__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">encryptionMode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">加密模式：<ul class="- topic/ul ul">
     <li class="- topic/li li">"<code class="+ topic/ph pr-d/codeph ph codeph">aes-128-xts</code>": 128 位 AES 加密，XTS 模式；</li>
     <li class="- topic/li li">"<code class="+ topic/ph pr-d/codeph ph codeph">aes-128-ecb</code>": 128 位 AES 加密，ECB 模式；</li>
     <li class="- topic/li li">"<code class="+ topic/ph pr-d/codeph ph codeph">aes-256-xts</code>": 256 位 AES 加密，XTS 模式；</li>
     <li class="- topic/li li">"": 设置为空字符串时，默认使用加密方式 "<code class="+ topic/ph pr-d/codeph ph codeph">aes-128-xts</code>"。</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setencryptionmode__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title133" id="api_setencryptionsecret">
    <h2 class="- topic/title title topictitle2" id="ariaid-title133"><a href="class_irtcengine.aspx#api_setencryptionsecret"><span class="- topic/ph ph">setEncryptionSecret</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setencryptionsecret__shortdesc">启用内置加密，并设置数据加密密码。</span></p><section class="- topic/section section" id="api_setencryptionsecret__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setEncryptionSecret(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* secret) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setencryptionsecret__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法自 v3.1.0 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enableencryption" title="开启或关闭内置加密。"><span class="- topic/keyword keyword">enableEncryption</span></a> 方法。</dd>
       
   </dl>
   <p class="- topic/p p" id="api_setencryptionsecret__desc" data-ofbid="api_setencryptionsecret__desc">在加入频道之前，App 需调用该方法指定 <span class="+ topic/keyword pr-d/parmname keyword parmname">secret</span> 来启用内置的加密功能，同一频道内的所有用户应设置相同的 <span class="+ topic/keyword pr-d/parmname keyword parmname">secret</span>。当用户离开频道时，该频道的 <span class="+ topic/keyword pr-d/parmname keyword parmname">secret</span> 会自动清除。如果未指定 <span class="+ topic/keyword pr-d/parmname keyword parmname">secret</span> 或将 <span class="+ topic/keyword pr-d/parmname keyword parmname">secret</span> 设置为空，则无法激活加密功能。</p>
   <div class="- topic/note note note note_note" id="api_setencryptionsecret__note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请不要在旁路推流时调用此方法。</li>
  <li class="- topic/li li">为保证最佳传输效果，请确保加密后的数据大小不超过原始数据大小 + 16 字节。16 字节是 AES 通用加密模式下最大填充块大小。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_setencryptionsecret__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">secret</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">加密密码。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setencryptionsecret__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title134" id="api_registerpacketobserver">
    <h2 class="- topic/title title topictitle2" id="ariaid-title134"><a href="class_irtcengine.aspx#api_registerpacketobserver"><span class="- topic/ph ph">registerPacketObserver</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_registerpacketobserver__shortdesc">注册数据包观测器。</span></p><section class="- topic/section section" id="api_registerpacketobserver__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> registerPacketObserver(IPacketObserver* observer) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_registerpacketobserver__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法注册数据包观测器 (Packet Observer)。在 Agora SDK 发送/接收（语音、视频）网络包时，会回调 <a class="- topic/xref xref" href="class_ipacketobserver.aspx#class_ipacketobserver" title="IPacketObserver 定义。"><span class="- topic/keyword keyword">IPacketObserver</span></a> 定义的接口，App 可用此接口对数据做处理，例如加解密。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">处理后发送到网络的包大小不应超过 1200 字节，否则有可能发送失败。</li>
  <li class="- topic/li li">若需调用此方法，需确保接收端和发送端都调用此方法，否则会出现未定义行为（例如音频无声或视频黑屏）。</li>
  <li class="- topic/li li">若在直播场景下使用 CDN 推流、录制或储存，Agora 不建议调用此方法。</li>
  <li class="- topic/li li">你需要在加入频道前调用该方法。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_registerpacketobserver__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">observer</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ipacketobserver.aspx#class_ipacketobserver" title="IPacketObserver 定义。"><span class="- topic/keyword keyword">IPacketObserver</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_registerpacketobserver__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title135" id="api_startaudiorecording1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title135"><a href="class_irtcengine.aspx#api_startaudiorecording1"><span class="- topic/ph ph">startAudioRecording</span></a> [1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startaudiorecording1__shortdesc">开始客户端录音。</span></p><section class="- topic/section section" id="api_startaudiorecording1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startAudioRecording(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath, AUDIO_RECORDING_QUALITY_TYPE quality) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_startaudiorecording1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法从 v2.9.1 起废弃，其默认录音采样率为 32 kHz，不可修改。请改用新的 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiorecording2" title="开始客户端录音。"><span class="- topic/keyword keyword">startAudioRecording</span></a> 方法。</dd>
       
   </dl>
   <div class="- topic/p p">Agora SDK 支持通话过程中在客户端进行录音。该方法录制频道内所有用户的音频，并生成一个包含所有用户声音的录音文件，录音文件格式可以为:
       <ul class="- topic/ul ul">
  <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">.wav</code>: 文件大，音质保真度高；</li>
  <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">.aac</code>: 文件小，有一定的音质保真度损失。</li>
       </ul>
   </div>
   <p class="- topic/p p">请确保 App 里指定的目录存在且可写。该接口需在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 之后调用。如果调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 时还在录音，录音会自动停止。</p>
        </section>
        <section class="- topic/section section" id="api_startaudiorecording1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">录音文件的本地保存路径，由用户自行指定，需精确到文件名及格式，例如：<code class="+ topic/ph pr-d/codeph ph codeph">/dir1/dir2/dir3/audio.aac</code>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">quality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_RECORDING_QUALITY_TYPE</span> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startaudiorecording1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title136" id="api_startaudiorecording2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title136"><a href="class_irtcengine.aspx#api_startaudiorecording2"><span class="- topic/ph ph">startAudioRecording</span></a> [2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_startaudiorecording2__shortdesc">开始客户端录音。</span></p><section class="- topic/section section" id="api_startaudiorecording2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> startAudioRecording(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath, <strong class="hl-keyword">int</strong> sampleRate, AUDIO_RECORDING_QUALITY_TYPE quality) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_startaudiorecording2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">Agora SDK 支持通话过程中在客户端进行录音。调用该方法后，你可以录制频道内所有用户的音频，并得到一个包含所有用户声音的录音文件。录音文件格式可以为:
  <ul class="- topic/ul ul">
      <li class="- topic/li li">.wav: 文件大，音质保真度较高。</li>
      <li class="- topic/li li">.aac: 文件小，音质保真度较低。</li>
  </ul>
       </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">请确保你在该方法中指定的路径存在并且可写。</li>
  <li class="- topic/li li">该接口需在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 之后调用。如果调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 时还在录音，录音会自动停止。</li>
  <li class="- topic/li li">为保证录音效果，当 <span class="+ topic/keyword pr-d/parmname keyword parmname">sampleRate</span> 设为 44.1 kHz 或 48 kHz 时，建议将 <span class="+ topic/keyword pr-d/parmname keyword parmname">quality</span> 设为 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_RECORDING_QUALITY_MEDIUM</span> 或 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_RECORDING_QUALITY_HIGH</span> 。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_startaudiorecording2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">录音文件在本地保存的绝对路径，由用户自行指定，需精确到文件名及格式，例如：<code class="+ topic/ph pr-d/codeph ph codeph">c:/music/audio.aac</code>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">sampleRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">录音采样率（Hz），可以设为以下值：
 <ul class="- topic/ul ul">
     <li class="- topic/li li">16000</li>
     <li class="- topic/li li">32000（默认）</li>
     <li class="- topic/li li">44100</li>
     <li class="- topic/li li">48000</li>
 </ul>
      </div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">quality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">录音音质。详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">AUDIO_RECORDING_QUALITY_TYPE</span> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_startaudiorecording2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title137" id="api_stopaudiorecording">
    <h2 class="- topic/title title topictitle2" id="ariaid-title137"><a href="class_irtcengine.aspx#api_stopaudiorecording"><span class="- topic/ph ph">stopAudioRecording</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_stopaudiorecording__shortdesc">停止客户端录音。</span></p><section class="- topic/section section" id="api_stopaudiorecording__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> stopAudioRecording() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_stopaudiorecording__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">停止录音。该接口需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 之前调用，不然会在调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">leaveChannel</span> 时自动停止。</p>
        </section>
        <section class="- topic/section section" id="api_stopaudiorecording__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title138" id="api_addinjectstreamurl">
    <h2 class="- topic/title title topictitle2" id="ariaid-title138"><a href="class_irtcengine.aspx#api_addinjectstreamurl"><span class="- topic/ph ph">addInjectStreamUrl</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_addinjectstreamurl__shortdesc">输入在线媒体流。</span></p><section class="- topic/section section" id="api_addinjectstreamurl__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> addInjectStreamUrl(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* url, <strong class="hl-keyword">const</strong> InjectStreamConfig&amp; config) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_addinjectstreamurl__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note warning" id="api_addinjectstreamurl__streamurl"><span class="note__title">注：</span> 
       客户端输入在线媒体流功能即将停服。如果你尚未集成该功能，Agora 建议你不要使用。详见<a class="- topic/xref xref" href="https://docs.agora.io/cn/Interactive%20Broadcast/rtc_sunset" target="_blank" rel="external noopener">部分服务下架计划</a>。
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
  <ul class="- topic/ul ul">
      <li class="- topic/li li">请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。</li>
      <li class="- topic/li li">该方法适用于 Native SDK v2.4.1 及之后的版本。</li>
      <li class="- topic/li li">在直播场景中，只有角色为主播的用户才能调用该方法。</li>
      <li class="- topic/li li">频道内同一时间只允许输入一个在线媒体流。</li>
      <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  </ul>
       </div>
   <p class="- topic/p p">该方法将正在播放的音视频作为音视频源导入到正在进行的直播中。可主要应用于赛事直播、多人看视频互动等直播场景。调用该方法后，SDK 会在本地触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onStreamInjectedStatus</span> 回调，报告输入在线媒体流的状态；成功输入媒体流后，该音视频流会出现在频道中，频道内所有用户都会收到 <span class="+ topic/keyword pr-d/apiname keyword apiname">onUserJoined</span> 回调，其中 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span> 为 666。该音视频流会出现在频道中。</p>
        </section>
        <section class="- topic/section section" id="api_addinjectstreamurl__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">添加到直播中的视频流 URL 地址。支持 RTMP、HLS、HTTP-FLV 协议传输。<ul class="- topic/ul ul">
     <li class="- topic/li li">支持的音频编码格式：AAC；</li>
     <li class="- topic/li li">支持的视频编码格式：H.264(AVC)。</li>
 </ul>
      </div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">config</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">所添加的视频流属性定义，详见: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_injectstreamconfig" title="InjectStreamConfig 定义。"><span class="- topic/keyword keyword">InjectStreamConfig</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_addinjectstreamurl__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败 <ul class="- topic/ul ul">
      <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code> (2): 输入的 URL
 为空。请重新调用该方法，并确认输入的媒体流的 URL 有效。</li>
      <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_READY</code> (3): 用户没有加入频道。</li>
      <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_SUPPORTED</code> (4): 频道非直播场景。请调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setchannelprofile" title="设置频道场景。"><span class="- topic/keyword keyword">setChannelProfile</span></a> 并将频道设置为直播场景再调用该方法。</li>
      <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_INITIALIZED</code> (7): 引擎没有初始化。请确认调用该方法前已创建 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象并完成初始化。</li>
  </ul>
       </li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title139" id="api_removeinjectstreamurl">
    <h2 class="- topic/title title topictitle2" id="ariaid-title139"><a href="class_irtcengine.aspx#api_removeinjectstreamurl"><span class="- topic/ph ph">removeInjectStreamUrl</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_removeinjectstreamurl__shortdesc">删除导入的外部媒体流。</span></p><section class="- topic/section section" id="api_removeinjectstreamurl__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> removeInjectStreamUrl(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* url) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_removeinjectstreamurl__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
       <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
       客户端输入在线媒体流功能即将停服。如果你尚未集成该功能，Agora 建议你不要使用。详见<a class="- topic/xref xref" href="https://docs.agora.io/cn/Interactive%20Broadcast/rtc_sunset" target="_blank" rel="external noopener">部分服务下架计划</a>。
   </div>
       <p class="- topic/p p"> 成功删除外部视频源 URL 地址后会触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onUserOffline</span>
  回调，<span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span> 为 666。</p>
        </section>
        <section class="- topic/section section" id="api_removeinjectstreamurl__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">已导入、待删除的外部视频源 URL 地址。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_removeinjectstreamurl__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title140" id="api_switchcamera">
    <h2 class="- topic/title title topictitle2" id="ariaid-title140"><a href="class_irtcengine.aspx#api_switchcamera"><span class="- topic/ph ph">switchCamera</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_switchcamera__shortdesc">切换前置/后置摄像头。</span></p><section class="- topic/section section" id="api_switchcamera__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> switchCamera() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_switchcamera__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法需要在相机启动（如通过调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startpreview" title="开启视频预览。"><span class="- topic/keyword keyword">startPreview</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 实现）后调用。</p>
   <div class="- topic/p p"><div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法只适用于移动端。</div></div>
        </section>
        <section class="- topic/section section" id="api_switchcamera__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title141" id="api_createdatastream1">
    <h2 class="- topic/title title topictitle2" id="ariaid-title141"><a href="class_irtcengine.aspx#api_createdatastream1"><span class="- topic/ph ph">createDataStream</span></a>[1/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_createdatastream1__shortdesc">创建数据流。</span></p><section class="- topic/section section" id="api_createdatastream1__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> createDataStream(<strong class="hl-keyword">int</strong>* streamId, <strong class="hl-keyword">bool</strong> reliable, <strong class="hl-keyword">bool</strong> ordered) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_createdatastream1__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该方法从 v3.3.0 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_createdatastream2" title="创建数据流。"><span class="- topic/keyword keyword">createDataStream</span></a>[2/2]。</dd>
       
   </dl>
   <p class="- topic/p p" id="api_createdatastream1__desc" data-ofbid="api_createdatastream1__desc">该方法用于创建数据流。RtcEngine 生命周期内，每个用户最多只能创建 5 个数据流。频道内数据通道最多允许数据延迟 5 秒，若超过 5 秒接收方尚未收到数据流，则数据通道会向 App 报错。</p>
   <div class="- topic/note note note note_note" id="api_createdatastream1__note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">该方法需要在加入频道后调用。</li>
  <li class="- topic/li li"><span class="+ topic/keyword pr-d/parmname keyword parmname">reliable</span> 和 <span class="+ topic/keyword pr-d/parmname keyword parmname">ordered</span> 需要同时为 <span class="- topic/ph ph">true</span> 或 <span class="- topic/ph ph">false</span>。不可以一个设为 
  <span class="- topic/ph ph">true</span> 另一个设为 <span class="- topic/ph ph">false</span>。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_createdatastream1__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_createdatastream1__streamId">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">输出参数，数据流 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reliable</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">该数据流是否可靠：<ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 接收方 5 秒内会收到发送方所发送的数据，否则会收到 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onstreammessageerror" title="接收对方数据流消息发生错误的回调。"><span class="- topic/keyword keyword">onStreamMessageError</span></a> 回调并获得相应报错信息。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 接收方不保证收到，就算数据丢失也不会报错。</li>
  </ul></div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_createdatastream1__ordered">ordered</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">该数据流是否有序：<ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 接收方会按照发送方发送的顺序收到数据包。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 接收方不保证按照发送方发送的顺序收到数据包。</li>
  </ul></div></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_createdatastream1__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <div class="- topic/p p"><ul class="- topic/ul ul">
       
       <li class="- topic/li li">0: 创建数据流成功。</li>
       <li class="- topic/li li">&lt; 0: 创建数据流失败。你可以参考 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a>
      进行问题排查。</li>
   </ul></div>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title142" id="api_createdatastream2">
    <h2 class="- topic/title title topictitle2" id="ariaid-title142"><a href="class_irtcengine.aspx#api_createdatastream2"><span class="- topic/ph ph">createDataStream</span></a>[2/2]</h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_createdatastream2__shortdesc">创建数据流。</span></p><section class="- topic/section section" id="api_createdatastream2__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> createDataStream(<strong class="hl-keyword">int</strong>* streamId, DataStreamConfig&amp; config) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_createdatastream2__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0。用于取代 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_createdatastream1" title="创建数据流。"><span class="- topic/keyword keyword">createDataStream</span></a>[1/2]。</dd>
       
   </dl>
   <p class="- topic/p p" id="api_createdatastream2__desc" data-ofbid="api_createdatastream2__desc">该方法用于创建数据流。每个用户在每个频道中最多只能创建 5 个数据流。</p>
   <p class="- topic/p p" id="api_createdatastream2__diff" data-ofbid="api_createdatastream2__diff">相比 <span class="+ topic/keyword pr-d/apiname keyword apiname">createDataStream</span>[1/2]，该方法不支持数据可靠。接收方会丢弃超出发送时间 5 秒后的数据包。</p>
        </section>
        <section class="- topic/section section" id="api_createdatastream2__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_createdatastream2__streamId">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">输出参数，数据流 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_createdatastream2__config">config</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">数据流设置。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_datastreamconfig" title="数据流设置。"><span class="- topic/keyword keyword">DataStreamConfig</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_createdatastream2__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 创建数据流成功。</li>
       
       <li class="- topic/li li">&lt; 0：方法调用失败。你可以参考 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a> 进行问题排查。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title143" id="api_sendstreammessage">
    <h2 class="- topic/title title topictitle2" id="ariaid-title143"><a href="class_irtcengine.aspx#api_sendstreammessage"><span class="- topic/ph ph">sendStreamMessage</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_sendstreammessage__shortdesc">发送数据流。</span></p><section class="- topic/section section" id="api_sendstreammessage__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> sendStreamMessage(<strong class="hl-keyword">int</strong> streamId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* data, size_t length) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_sendstreammessage__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_sendstreammessage__desc" data-ofbid="api_sendstreammessage__desc">该方法发送数据流消息到频道内所有用户。SDK 对该方法的实现进行了如下限制：频道内每秒最多能发送 30 个包，且每个包最大为 1 KB。
       每个客户端每秒最多能发送 6 KB 数据。频道内每人最多能同时有 5 个数据通道。</p>
   <p class="- topic/p p">成功调用该方法后，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onstreammessage" title="接收到对方数据流消息的回调。"><span class="- topic/keyword keyword">onStreamMessage</span></a> 回调，远端用户可以在该回调中获取接收到的流消息；
       若调用失败，远端会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onstreammessageerror" title="接收对方数据流消息发生错误的回调。"><span class="- topic/keyword keyword">onStreamMessageError</span></a> 回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">请确保在调用该方法前，已调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_createdatastream2" title="创建数据流。"><span class="- topic/keyword keyword">createDataStream</span></a> 创建了数据通道。</li>
       <li class="- topic/li li">直播场景下，该方法仅适用于主播用户。</li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_sendstreammessage__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">数据流 ID。可以通过 <span class="+ topic/keyword pr-d/apiname keyword apiname">createDataStream</span> 获取。</dd>
       
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">data</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">自定义数据。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">length</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">数据长度。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_sendstreammessage__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title144" id="api_enableloopbackrecording">
    <h2 class="- topic/title title topictitle2" id="ariaid-title144"><a href="class_irtcengine.aspx#api_enableloopbackrecording"><span class="- topic/ph ph">enableLoopbackRecording</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enableloopbackrecording__shortdesc">开启声卡采集。</span></p><section class="- topic/section section" id="api_enableloopbackrecording__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableLoopbackRecording(<strong class="hl-keyword">bool</strong> enabled, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* deviceName = NULL) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enableloopbackrecording__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">启用声卡采集功能后，声卡播放的声音会被合到本地音频流中，从而可以发送到远端。</p>
   <div class="- topic/p p">
       <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
  <ul class="- topic/ul ul" id="api_enableloopbackrecording__ul_pjq_swq_t4b">
      <li class="- topic/li li">该方法仅适用于 macOS 和 Windows 平台。</li>
      
      <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
  </ul>
       </div>
   </div>
        </section>
        <section class="- topic/section section" id="api_enableloopbackrecording__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>     
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">是否开启声卡采集:<ul class="- topic/ul ul" id="api_enableloopbackrecording__ul_qjq_swq_t4b">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 开启声卡采集。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>:（默认）关闭声卡采集。</li>
      </ul></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceName</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">声卡的设备名。默认设为 <span class="- topic/ph ph">NULL</span>，即使用当前声卡采集。 如果用户使用虚拟声卡，如 "Soundflower"，可以将虚拟声卡名称
      "Soundflower" 作为参数，SDK 会找到对应的虚拟声卡设备，并开始采集。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title145" id="api_setaudiosessionoperationrestriction">
    <h2 class="- topic/title title topictitle2" id="ariaid-title145"><a href="class_irtcengine.aspx#api_setaudiosessionoperationrestriction"><span class="- topic/ph ph">setAudioSessionOperationRestriction</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setaudiosessionoperationrestriction__shortdesc">设置 SDK 对 Audio Session 的控制权限。</span></p><section class="- topic/section section" id="api_setaudiosessionoperationrestriction__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setAudioSessionOperationRestriction(AUDIO_SESSION_OPERATION_RESTRICTION restriction) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_setaudiosessionoperationrestriction__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法可以在任意时候调用。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法仅适用于 iOS 平台。</li>
       <li class="- topic/li li">该方法限制 Agora SDK 对 Audio Session 的操作权限。在默认情况下，SDK 和 App 对 Audio Session 都有控制权，但某些场景下，app 会希望
  限制 Agora SDK 对 Audio Session 的控制权限，而使用其他应用或第三方组件对 Audio Session 进行操控。调用该方法可以实现该功能。</li>
       <li class="- topic/li li">一旦调用该方法限制了 Agora SDK 对 Audio Session 的控制权限， SDK 将无法对 Audio Session 进行相关设置，而需要用户自己或第三方组件进行维护。</li>
       <li class="- topic/li li">该方法在加入频道前后都能调用。</li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_setaudiosessionoperationrestriction__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">restriction</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">Agora SDK 对 Audio Session 的控制权限，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audiosessionoperationrestriction" title="SDK 对 Audio Session 的控制权限。"><span class="- topic/keyword keyword">AUDIO_SESSION_OPERATION_RESTRICTION</span></a>。该参数为 Bit Mask，每个 Bit 对应一个权限。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setaudiosessionoperationrestriction__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title146" id="api_setlocalvideomirrormode">
    <h2 class="- topic/title title topictitle2" id="ariaid-title146"><a href="class_irtcengine.aspx#api_setlocalvideomirrormode"><span class="- topic/ph ph">setLocalVideoMirrorMode</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlocalvideomirrormode__shortdesc">设置本地视频镜像。</span></p><section class="- topic/section section" id="api_setlocalvideomirrormode__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLocalVideoMirrorMode(VIDEO_MIRROR_MODE_TYPE mirrorMode) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlocalvideomirrormode__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用:</dt>
  <dd class="- topic/dd dd">从 v3.0.0 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setuplocalvideo" title="初始化本地视图。"><span class="- topic/keyword keyword">setupLocalVideo</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalrendermode2" title="更新本地视图显示模式。"><span class="- topic/keyword keyword">setLocalRenderMode</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvideomirrormode__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">mode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地视频镜像模式。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_videomirrormodetype" title="镜像模式类型。"><span class="- topic/keyword keyword">VIDEO_MIRROR_MODE_TYPE</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlocalvideomirrormode__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title147" id="api_setcameracapturerconfiguration">
    <h2 class="- topic/title title topictitle2" id="ariaid-title147"><a href="class_irtcengine.aspx#api_setcameracapturerconfiguration"><span class="- topic/ph ph">setCameraCapturerConfiguration</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setcameracapturerconfiguration__shortdesc">设置摄像头采集配置。</span></p><section class="- topic/section section" id="api_setcameracapturerconfiguration__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setCameraCapturerConfiguration(<strong class="hl-keyword">const</strong> CameraCapturerConfiguration&amp; config) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setcameracapturerconfiguration__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">一般的视频通话或直播中，默认由 SDK 自动控制摄像头的输出参数。在如下特殊场景中，默认的参数通常无法满足需求，或可能引起设备性能问题，我们推荐调用该方法设置摄像头的采集偏好:<ul class="- topic/ul ul">
       <li class="- topic/li li">使用原始音视频数据自采集接口时，如果 SDK 输出的分辨率和帧率高于 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setvideoencoderconfiguration" title="设置视频编码属性。"><span class="- topic/keyword keyword">setVideoEncoderConfiguration</span></a> 中指定的参数，在后续处理视频帧的时候，
  比如美颜功能时，会需要更高的 CPU 及内存，容易导致性能问题。在这种情况下，我们推荐将摄像头采集偏好设置为 <span class="- topic/ph ph">CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE</span>(1)，
  避免性能问题。</li>
       <li class="- topic/li li">如果没有本地预览功能或者对预览质量没有要求，我们推荐将采集偏好设置为 <span class="- topic/ph ph">CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE</span>(1)，以优化 CPU 和内存的资源分配。</li>
       <li class="- topic/li li">如果用户希望本地预览视频比实际编码发送的视频清晰，可以将采集偏好设置为 <span class="- topic/ph ph">CAPTURER_OUTPUT_PREFERENCE_PREVIEW</span>(2)。</li>
       <li class="- topic/li li">如果用户需要自定义本地采集的视频宽高，请将采集偏好设为 <span class="- topic/ph ph">CAPTURER_OUTPUT_PREFERENCE_MANUAL</span>(3)。</li>
   </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 请在启动摄像头之前调用该方法，如 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_joinchannel" title="加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a>、<a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 或者 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalvideo" title="开关本地视频采集。"><span class="- topic/keyword keyword">enableLocalVideo</span></a> 之前。</div>
        </section>
        <section class="- topic/section section" id="api_setcameracapturerconfiguration__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">config</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">摄像头采集配置，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_cameracapturerconfiguration" title="摄像头采集配置。"><span class="- topic/keyword keyword">CameraCapturerConfiguration</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setcameracapturerconfiguration__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title148" id="api_setlogfile">
    <h2 class="- topic/title title topictitle2" id="ariaid-title148"><a href="class_irtcengine.aspx#api_setlogfile"><span class="- topic/ph ph">setLogFile</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlogfile__shortdesc">设置 Agora SDK 输出的日志文件。</span></p><section class="- topic/section section" id="api_setlogfile__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
     <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLogFile(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath) = <span class="hl-number">0</span>;</pre>   
 </div>
        </section>
        <section class="- topic/section section" id="api_setlogfile__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用:</dt>
  <dd class="- topic/dd dd">该方法从 v3.3.0 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 中的 <span class="+ topic/keyword pr-d/parmname keyword parmname">mLogConfig</span> 参数设置日志文件路径。</dd>
       
   </dl>
   <p class="- topic/p p">默认情况下，SDK 会生成 agorasdk.log、agorasdk_1.log、agorasdk_2.log、agorasdk_3.log、agorasdk_4.log 这 5 个日志文件。
       每个文件的默认大小为 1024 KB。日志文件为 UTF-8 编码。最新的日志永远写在 agorasdk.log 中。agorasdk.log 写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，
       然后将 agorasdk.log 重命名为该文件，并建立新的 agorasdk.log 写入最新的日志。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如需调用本方法，请在初始化 <a class="- topic/xref xref" href="class_irtcengine.aspx#class_rtcengine" title="Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。"><span class="- topic/keyword keyword">IRtcEngine</span></a> 对象后立即调用，否则可能造成输出日志不完整。</div>
        </section>
        <section class="- topic/section section" id="api_setlogfile__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">日志文件的完整路径。默认路径为
 </p><code class="+ topic/ph pr-d/codeph ph codeph">C:\Users\&lt;user_name&gt;\AppData\Local\Agora\&lt;process_name&gt;\agorasdk.log</code><p class="- topic/p p">。请确保指定的目录存在而且可写。你可通过该参数修改日志文件名。</p></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlogfile__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title149" id="api_setlogfilter">
    <h2 class="- topic/title title topictitle2" id="ariaid-title149"><a href="class_irtcengine.aspx#api_setlogfilter"><span class="- topic/ph ph">setLogFilter</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlogfilter__shortdesc">设置日志输出等级。</span></p><section class="- topic/section section" id="api_setlogfilter__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLogFilter(<strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> filter) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlogfilter__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 中的 <span class="+ topic/keyword pr-d/parmname keyword parmname">logConfig</span>。</dd>
       
   </dl>
   <p class="- topic/p p">该方法设置 Agora SDK 的输出日志输出等级。不同的输出等级可以单独或组合使用。日志级别顺序依次为 OFF、CRITICAL、ERROR、WARNING、INFO 和 DEBUG。
       选择一个级别，你就可以看到在该级别之前所有级别的日志信息。</p>
   <p class="- topic/p p">例如，你选择 WARNING 级别，就可以看到在 CRITICAL、ERROR 和 WARNING 级别上的所有日志信息。</p>
        </section>
        <section class="- topic/section section" id="api_setlogfilter__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filter</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">日志过滤等级。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_logfiltertype" title="日志过滤等级。"><span class="- topic/keyword keyword">LOG_FILTER_TYPE</span></a>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlogfilter__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title150" id="api_setlogfilesize">
    <h2 class="- topic/title title topictitle2" id="ariaid-title150"><a href="class_irtcengine.aspx#api_setlogfilesize"><span class="- topic/ph ph">setLogFileSize</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setlogfilesize__shortdesc">设置 Agora SDK 输出的单个日志文件大小。</span></p><section class="- topic/section section" id="api_setlogfilesize__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setLogFileSize(<strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> fileSizeInKBytes) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setlogfilesize__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0。请改用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_initialize" title="初始化 Agora SDK 服务。"><span class="- topic/keyword keyword">initialize</span></a> 中的 <span class="+ topic/keyword pr-d/parmname keyword parmname">logConfig</span>。</dd>
       
   </dl>
   <p class="- topic/p p">默认情况下，SDK 会生成 agorasdk.log、agorasdk_1.log、agorasdk_2.log、agorasdk_3.log、agorasdk_4.log 这 5 个日志文件。 
       每个文件的默认大小为 1024 KB。日志文件为 UTF-8 编码。最新的日志永远写在 agorasdk.log 中。agorasdk.log 写满后，SDK 会从 1-4 中删除修改时间最早的一个
       文件， 然后将 agorasdk.log 重命名为该文件，并建立新的 agorasdk.log 写入最新的日志。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 如果想要设置日志文件的大小，则需要在 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlogfile" title="设置 Agora SDK 输出的日志文件。"><span class="- topic/keyword keyword">setLogFile</span></a> 前调用该方法，否则日志会被清空。</div>
        </section>
        <section class="- topic/section section" id="api_setlogfilesize__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">fileSizeInKBytes</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">单个日志文件的大小，单位为 KB。默认值为 1024 KB。如果你将 fileSizeInKByte 设为 1024 KB，SDK 会最多输出 5 MB 的日志文件。
      如果你将 <span class="+ topic/keyword pr-d/parmname keyword parmname">fileSizeInKByte</span> 设为小于 1024 KB，单个日志文件最大仍为 1024 KB。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setlogfilesize__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title151" id="api_uploadlogfile">
    <h2 class="- topic/title title topictitle2" id="ariaid-title151"><a href="class_irtcengine.aspx#api_uploadlogfile"><span class="- topic/ph ph">uploadLogFile</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_uploadlogfile__shortdesc">上传所有本地的 SDK 日志文件。</span></p><section class="- topic/section section" id="api_uploadlogfile__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> uploadLogFile(agora::util::AString&amp; requestId) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_uploadlogfile__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">将客户端的所有日志文件上传至 Agora 服务器。成功调用该方法后，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuploadlogresult" title="报告日志文件上传结果。"><span class="- topic/keyword keyword">onUploadLogFile</span></a> 回调报告日志文件是否成功上传至 Agora 服务器。</p>
   <div class="- topic/p p"><div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法每分钟的调用次数不得超过 1 次，超出后会报错误码 <code class="+ topic/ph pr-d/codeph ph codeph">ERR_TOO_OFTEN</code>(12)</div>。</div>
   
   <p class="- topic/p p">为了方便排查问题，Agora 推荐你将 <span class="+ topic/keyword pr-d/apiname keyword apiname">uploadLogFile</span> 方法与应用的 UI 元素绑定，在出现质量问题时提示用户上传日志。</p>
        </section>
        <section class="- topic/section section" id="api_uploadlogfile__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">requestId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">请求 ID。该请求 ID 与 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onuploadlogresult" title="报告日志文件上传结果。"><span class="- topic/keyword keyword">onUploadLogFile</span></a> 回调中的 <span class="+ topic/keyword pr-d/parmname keyword parmname">requestId</span> 一致。
  你可以通过 <span class="+ topic/keyword pr-d/parmname keyword parmname">requestId</span> 将特定的上传和回调对应起来。</p></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_uploadlogfile__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-12(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_TOO_OFTEN</code>): 调用频率超出限制。</li>
       </ul></li>
   </ul>
   
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title152" id="api_getcallid">
    <h2 class="- topic/title title topictitle2" id="ariaid-title152"><a href="class_irtcengine.aspx#api_getcallid"><span class="- topic/ph ph">getCallId</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getcallid__shortdesc">获取通话 ID。</span></p><section class="- topic/section section" id="api_getcallid__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getCallId(agora::util::AString&amp; callId) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getcallid__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">客户端在每次加入频道后会生成一个对应的 <span class="+ topic/keyword pr-d/parmname keyword parmname">callId</span>，标识该客户端的此次通话。有些方法，如 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_rate" title="给通话评分。"><span class="- topic/keyword keyword">rate</span></a>、<a class="- topic/xref xref" href="class_irtcengine.aspx#api_complain" title="投诉通话质量。"><span class="- topic/keyword keyword">complain</span></a> 等，
   需要在通话结束后调用，向 SDK 提交反馈。这些方法中需要填入指定的 <span class="+ topic/keyword pr-d/parmname keyword parmname">callId</span> 参数。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在加入频道后调用。</div>
        </section>
        <section class="- topic/section section" id="api_getcallid__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
       <dl class="+ topic/dl pr-d/parml dl parml">
  
      <dt class="+ topic/dt pr-d/pt dt pt dlterm">callId</dt>
      <dd class="+ topic/dd pr-d/pd dd pd">输出参数，当前的通话 ID。</dd>
  
       </dl>
        </section>
        <section class="- topic/section section" id="api_getcallid__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title153" id="api_rate">
    <h2 class="- topic/title title topictitle2" id="ariaid-title153"><a href="class_irtcengine.aspx#api_rate"><span class="- topic/ph ph">rate</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_rate__shortdesc">给通话评分。</span></p><section class="- topic/section section" id="api_rate__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> rate(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* callId, <strong class="hl-keyword">int</strong> rating, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* description) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_rate__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 该方法需要在用户离开频道后调用。</div>
        </section>
        <section class="- topic/section section" id="api_rate__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">callId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">通话 ID。你可以通过调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_getcallid" title="获取通话 ID。"><span class="- topic/keyword keyword">getCallId</span></a> 获取该参数。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rating</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">给通话的评分，最低 1 分，最高 5 分，如超过这个范围，SDK 会返回 -2(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code>) 错误。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">description</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">（非必选项）给通话的描述。长度应小于 800 字节。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_rate__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-2(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code>)。</li>
  <li class="- topic/li li">-3(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_READY()</code>)。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title154" id="api_complain">
    <h2 class="- topic/title title topictitle2" id="ariaid-title154"><a href="class_irtcengine.aspx#api_complain"><span class="- topic/ph ph">complain</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_complain__shortdesc">投诉通话质量。</span></p><section class="- topic/section section" id="api_complain__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> complain(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* callId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* description) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_complain__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法允许用户就通话质量进行投诉。需要在离开频道后调用。</p>
        </section>
        <section class="- topic/section section" id="api_complain__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">callId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">通话 ID。你可以通过调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_getcallid" title="获取通话 ID。"><span class="- topic/keyword keyword">getCallId</span></a> 获取该参数。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">description</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">（非必选项）给通话的描述。长度应小于 800 字节。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_complain__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-2(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code>)。</li>
  <li class="- topic/li li">-3(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_READY</code>)。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title155" id="api_getversion">
    <h2 class="- topic/title title topictitle2" id="ariaid-title155"><a href="class_irtcengine.aspx#api_getversion"><span class="- topic/ph ph">getVersion</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getversion__shortdesc">获取 SDK 版本。</span></p><section class="- topic/section section" id="api_getversion__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* getVersion(<strong class="hl-keyword">int</strong>* build) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getversion__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">build</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">SDK 的编译号。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_getversion__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <p class="- topic/p p">当前的 SDK 版本号。格式为字符串，如 3.3.0。</p>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title156" id="api_geterrordescription">
    <h2 class="- topic/title title topictitle2" id="ariaid-title156"><a href="class_irtcengine.aspx#api_geterrordescription"><span class="- topic/ph ph">getErrorDescription</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_geterrordescription__shortdesc">获取警告或错误描述。</span></p><section class="- topic/section section" id="api_geterrordescription__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* getErrorDescription(<strong class="hl-keyword">int</strong> code) = <span class="hl-number">0</span>;</pre>  
  </div>
        </section>
        <section class="- topic/section section" id="api_geterrordescription__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">SDK 报告的错误码或警告码。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_geterrordescription__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <p class="- topic/p p">具体的错误或警告描述。你可以参考 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a> 进行问题排查。</p>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title157" id="api_queryinterface">
    <h2 class="- topic/title title topictitle2" id="ariaid-title157"><span class="- topic/ph ph">queryInterface</span></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_queryinterface__shortdesc">获取指定接口类的指针。</span></p><section class="- topic/section section" id="api_queryinterface__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">      
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> queryInterface(INTERFACE_ID_TYPE iid, <strong class="hl-keyword">void</strong>** inter) = <span class="hl-number">0</span>;</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_queryinterface__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">iid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">想要获取的接口类 ID。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_interfaceidtype" title="接口类。"><span class="- topic/keyword keyword">INTERFACE_ID_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">inter</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">输出参数。指定接口的对象指针。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_queryinterface__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title158" id="api_setcloudproxy">
    <h2 class="- topic/title title topictitle2" id="ariaid-title158"><a href="class_irtcengine.aspx#api_setcloudproxy"><span class="- topic/ph ph">setCloudProxy</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_setcloudproxy__shortdesc">设置 Agora 云代理服务。</span></p><section class="- topic/section section" id="api_setcloudproxy__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> setCloudProxy(CLOUD_PROXY_TYPE proxyType) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_setcloudproxy__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">当用户防火墙限制 IP 和端口号时，你需要参考《使用云代理》开放相应 IP 和端口号，然后调用该方法开启云代理，并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">proxyType</span> 设为 <span class="- topic/ph ph">UDP_PROXY</span>(1)，
   即使用 UDP 协议的云代理。</p>
   <p class="- topic/p p">成功连接云代理后，SDK 会触发 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onconnectionstatechanged" title="网络连接状态已改变回调。"><span class="- topic/keyword keyword">onConnectionStateChanged</span></a>(<span class="- topic/ph ph">CONNECTION_STATE_CONNECTING</span>, <span class="- topic/ph ph">CONNECTION_CHANGED_SETTING_PROXY_SERVER</span>) 回调。</p>
   <p class="- topic/p p">如果你想关闭已设置的云代理，请调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setCloudProxy</span>(NONE_PROXY)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">Agora 推荐你在频道外调用该方法。</li>
       <li class="- topic/li li">使用 UDP 协议的云代理时，推流到 CDN 和跨频道媒体流转发功能不可用。</li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_setcloudproxy__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">proxyType</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">云代理类型，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_cloudproxytype" title="云代理类型。"><span class="- topic/keyword keyword">CLOUD_PROXY_TYPE</span></a>。该参数为必填参数，如果你不赋值，SDK 会报错。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_setcloudproxy__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。<ul class="- topic/ul ul">
  <li class="- topic/li li">-2(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code>): 传入的参数无效。</li>
  <li class="- topic/li li">-7(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_NOT_INITIALIZED</code>): SDK 尚未初始化。</li>
       </ul></li></ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title159" id="api_enabledeeplearningdenoise">
    <h2 class="- topic/title title topictitle2" id="ariaid-title159"><a href="class_irtcengine.aspx#api_enabledeeplearningdenoise"><span class="- topic/ph ph">enableDeepLearningDenoise</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_enabledeeplearningdenoise__shortdesc">开启或关闭 AI 降噪模式。</span></p><section class="- topic/section section" id="api_enabledeeplearningdenoise__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> enableDeepLearningDenoise(<strong class="hl-keyword">bool</strong> enable) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_enabledeeplearningdenoise__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <div class="- topic/p p">SDK 默认开启传统降噪模式，以消除大部分平稳噪声。如果你还需要消除非平稳噪声，Agora 推荐你按如下步骤开启 AI 降噪模式：
   <ol class="- topic/ol ol">
       <li class="- topic/li li">将 libs 文件夹中的动态库集成到项目中。<ul class="- topic/ul ul">
  
  
  
  <li class="- topic/li li">Windows: <code class="+ topic/ph pr-d/codeph ph codeph">libagora_ai_denoise_extension.dll</code></li>
       </ul></li>
       <li class="- topic/li li">调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">enableDeepLearningDenoise</span>(<span class="- topic/ph ph">true</span>)。</li>
   </ol></div>
   <div class="- topic/p p">AI 降噪模式对设备性能有要求。只有在设备性能良好的情况下，SDK 才会成功开启 AI 降噪模式。如下设备经测试支持开启 AI 降噪模式:<ul class="- topic/ul ul">
       <li class="- topic/li li">iPhone 6S</li>
       <li class="- topic/li li">MacBook Pro 2015</li>
       <li class="- topic/li li">iPad Pro 第五代</li>
       <li class="- topic/li li">iPad mini 第五代</li>
       <li class="- topic/li li">iPad Air 第三代</li>
   </ul></div>
   <p class="- topic/p p">成功开启 AI 降噪模式后，如果 SDK 检测到当前设备的性能不足，SDK 会自动关闭 AI 降噪模式，并开启传统降噪模式。</p>
   <p class="- topic/p p">在频道内，如果你调用了 <span class="+ topic/keyword pr-d/apiname keyword apiname">enableDeepLearningDenoise</span>(<span class="- topic/ph ph">true</span>) 或 SDK 自动关闭了 AI 降噪模式，当你需要重新开启 AI 降噪模式时， 你需要先调用
   <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a>，再调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">enableDeepLearning</span>(<span class="- topic/ph ph">true</span>)。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> <ul class="- topic/ul ul">
       <li class="- topic/li li">该方法需要动态加载动态库，所以 Agora 推荐在加入频道前调用该方法。</li>
       <li class="- topic/li li">该方法对人声的处理效果最佳。Agora 不推荐调用该方法处理含音乐的音频数据。</li>
   </ul></div>
        </section>
        <section class="- topic/section section" id="api_enabledeeplearningdenoise__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">是否开启 AI 降噪模式:<ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>:（默认）开启。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 关闭。</li>
  </ul></div></dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_enabledeeplearningdenoise__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt; 0: 方法调用失败。
       <ul class="- topic/ul ul">
  <li class="- topic/li li">-157(<code class="+ topic/ph pr-d/codeph ph codeph">ERR_MODULE_NOT_FOUND</code>): 未集成用于 AI 降噪的动态库。</li>
       </ul></li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title160" id="api_sendcustomreportmessage">
    <h2 class="- topic/title title topictitle2" id="ariaid-title160"><a href="class_irtcengine.aspx#api_sendcustomreportmessage"><span class="- topic/ph ph">sendCustomReportMessage</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_sendcustomreportmessage__shortdesc">声网提供自定义数据上报和分析服务。</span></p><section class="- topic/section section" id="api_sendcustomreportmessage__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">      
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> sendCustomReportMessage(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *id, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* category, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* event, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* label, <strong class="hl-keyword">int</strong> value) = <span class="hl-number">0</span>;</pre>      
  </div>
        </section>
        <section class="- topic/section section" id="api_sendcustomreportmessage__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
   <p class="- topic/p p">该服务当前处于免费内测期。内测期提供的能力为 6 秒内最多上报 10 条数据，每条自定义数据不能超过 256 字节，每个字符串不能超过 100 字节。
       如需试用该服务，请联系 <a class="- topic/xref xref" href="mailto:sales@agora.io" target="_blank" rel="external noopener">sales@agora.io</a> 开通并商定自定义数据格式。</p>
        </section>
    </div>
</article></article></article></main></div>
      
      
      
      
  </div>
  
      <nav role="navigation" id="wh_topic_toc" aria-label="On this page" class="col-lg-2 d-none d-lg-block navbar d-print-none"> 
 <div class=" wh_topic_toc "><div class="wh_topic_label">在本页上</div><ul><li class="topic-item"><a href="#api_joinchannelwithuseraccount1" data-tocid="api_joinchannelwithuseraccount1"><a href="class_irtcengine.aspx#api_joinchannelwithuseraccount1"><span class="- topic/ph ph">joinChannelWithUserAccount</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount1__prototype" data-tocid="api_joinchannelwithuseraccount1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount1__detailed_desc" data-tocid="api_joinchannelwithuseraccount1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount1__parameters" data-tocid="api_joinchannelwithuseraccount1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount1__return_values" data-tocid="api_joinchannelwithuseraccount1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_joinchannelwithuseraccount2" data-tocid="api_joinchannelwithuseraccount2"><a href="class_irtcengine.aspx#api_joinchannelwithuseraccount2"><span class="- topic/ph ph">joinChannelWithUserAccount</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount2__prototype" data-tocid="api_joinchannelwithuseraccount2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount2__detailed_desc" data-tocid="api_joinchannelwithuseraccount2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannelwithuseraccount2__parameters" data-tocid="api_joinchannelwithuseraccount2__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_createagorartcengine" data-tocid="api_createagorartcengine">createAgoraRtcEngine</a><ul><li class="section-item"><div class="section-title"><a href="#api_createagorartcengine__prototype" data-tocid="api_createagorartcengine__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createagorartcengine__detailed_desc" data-tocid="api_createagorartcengine__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createagorartcengine__return_values" data-tocid="api_createagorartcengine__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_initialize" data-tocid="api_initialize"><a href="class_irtcengine.aspx#api_initialize"><span class="- topic/ph ph">initialize</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_initialize__prototype" data-tocid="api_initialize__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_initialize__detailed_desc" data-tocid="api_initialize__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_initialize__parameters" data-tocid="api_initialize__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_initialize__return_values" data-tocid="api_initialize__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_release" data-tocid="api_release"><a href="class_irtcengine.aspx#api_release"><span class="- topic/ph ph">release</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_release__prototype" data-tocid="api_release__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_release__detailed_desc" data-tocid="api_release__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_release__parameters" data-tocid="api_release__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_setchannelprofile" data-tocid="api_setchannelprofile"><a href="class_irtcengine.aspx#api_setchannelprofile"><span class="- topic/ph ph">setChannelProfile</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setchannelprofile__prototype" data-tocid="api_setchannelprofile__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setchannelprofile__detailed_desc" data-tocid="api_setchannelprofile__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setchannelprofile__parameters" data-tocid="api_setchannelprofile__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setchannelprofile__return_values" data-tocid="api_setchannelprofile__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_joinchannel" data-tocid="api_joinchannel"><a href="class_irtcengine.aspx#api_joinchannel"><span class="- topic/ph ph">joinChannel</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_joinchannel__prototype" data-tocid="api_joinchannel__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannel__detailed_desc" data-tocid="api_joinchannel__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannel__parameters" data-tocid="api_joinchannel__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannel__return_values" data-tocid="api_joinchannel__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_joinchannel2" data-tocid="api_joinchannel2"><a href="class_irtcengine.aspx#api_joinchannel2"><span class="- topic/ph ph">joinChannel</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_joinchannel2__prototype" data-tocid="api_joinchannel2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannel2__detailed_desc" data-tocid="api_joinchannel2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannel2__parameters" data-tocid="api_joinchannel2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_joinchannel2__return_values" data-tocid="api_joinchannel2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_switchchannel1" data-tocid="api_switchchannel1"><a href="class_irtcengine.aspx#api_switchchannel1"><span class="- topic/ph ph">switchChannel</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_switchchannel1__prototype" data-tocid="api_switchchannel1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchchannel1__detailed_desc" data-tocid="api_switchchannel1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchchannel1__parameters" data-tocid="api_switchchannel1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchchannel1__return_values" data-tocid="api_switchchannel1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_switchchannel2" data-tocid="api_switchchannel2"><a href="class_irtcengine.aspx#api_switchchannel2"><span class="- topic/ph ph">switchChannel</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_switchchannel2__prototype" data-tocid="api_switchchannel2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchchannel2__detailed_desc" data-tocid="api_switchchannel2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchchannel2__parameters" data-tocid="api_switchchannel2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchchannel2__return_values" data-tocid="api_switchchannel2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setclientrole1" data-tocid="api_setclientrole1"><a href="class_irtcengine.aspx#api_setclientrole1"><span class="- topic/ph ph">setClientRole</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_setclientrole1__prototype" data-tocid="api_setclientrole1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setclientrole1__detailed_desc" data-tocid="api_setclientrole1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setclientrole1__parameters" data-tocid="api_setclientrole1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setclientrole1__return_values" data-tocid="api_setclientrole1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setclientrole2" data-tocid="api_setclientrole2"><a href="class_irtcengine.aspx#api_setclientrole2"><span class="- topic/ph ph">setClientRole</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_setclientrole2__prototype" data-tocid="api_setclientrole2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setclientrole2__detailed_desc" data-tocid="api_setclientrole2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setclientrole2__parameters" data-tocid="api_setclientrole2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setclientrole2__return_values" data-tocid="api_setclientrole2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_leavechannel" data-tocid="api_leavechannel"><a href="class_irtcengine.aspx#api_leavechannel"><span class="- topic/ph ph">leaveChannel</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_leavechannel__prototype" data-tocid="api_leavechannel__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_leavechannel__detailed_desc" data-tocid="api_leavechannel__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_leavechannel__return_values" data-tocid="api_leavechannel__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_renewtoken" data-tocid="api_renewtoken"><a href="class_irtcengine.aspx#api_renewtoken"><span class="- topic/ph ph">renewToken</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_renewtoken__prototype" data-tocid="api_renewtoken__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_renewtoken__detailed_desc" data-tocid="api_renewtoken__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_renewtoken__parameters" data-tocid="api_renewtoken__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_renewtoken__return_values" data-tocid="api_renewtoken__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getconnectionstate" data-tocid="api_getconnectionstate"><a href="class_irtcengine.aspx#api_getconnectionstate"><span class="- topic/ph ph">getConnectionState</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getconnectionstate__prototype" data-tocid="api_getconnectionstate__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getconnectionstate__detailed_desc" data-tocid="api_getconnectionstate__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getconnectionstate__return_values" data-tocid="api_getconnectionstate__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablewebsdkinteroperability" data-tocid="api_enablewebsdkinteroperability"><a href="class_irtcengine.aspx#api_enablewebsdkinteroperability"><span class="- topic/ph ph">enableWebSdkInteroperability</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablewebsdkinteroperability__prototype" data-tocid="api_enablewebsdkinteroperability__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablewebsdkinteroperability__detailed_desc" data-tocid="api_enablewebsdkinteroperability__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablewebsdkinteroperability__parameters" data-tocid="api_enablewebsdkinteroperability__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablewebsdkinteroperability__return_values" data-tocid="api_enablewebsdkinteroperability__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enableaudio" data-tocid="api_enableaudio"><a href="class_irtcengine.aspx#api_enableaudio"><span class="- topic/ph ph">enableAudio</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enableaudio__prototype" data-tocid="api_enableaudio__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableaudio__detailed_desc" data-tocid="api_enableaudio__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableaudio__return_values" data-tocid="api_enableaudio__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_disableaudio" data-tocid="api_disableaudio"><a href="class_irtcengine.aspx#api_disableaudio"><span class="- topic/ph ph">disableAudio</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_disableaudio__prototype" data-tocid="api_disableaudio__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_disableaudio__detailed_desc" data-tocid="api_disableaudio__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_disableaudio__return_values" data-tocid="api_disableaudio__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setaudioprofile" data-tocid="api_setaudioprofile"><a href="class_irtcengine.aspx#api_setaudioprofile"><span class="- topic/ph ph">setAudioProfile</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setaudioprofile__prototype" data-tocid="api_setaudioprofile__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioprofile__detailed_desc" data-tocid="api_setaudioprofile__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioprofile__parameters" data-tocid="api_setaudioprofile__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioprofile__return_values" data-tocid="api_setaudioprofile__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_sethighqualityaudioparameters" data-tocid="api_sethighqualityaudioparameters"><a href="class_irtcengine.aspx#api_sethighqualityaudioparameters"><span class="- topic/ph ph">setHighQualityAudioParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_sethighqualityaudioparameters__prototype" data-tocid="api_sethighqualityaudioparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sethighqualityaudioparameters__detailed_desc" data-tocid="api_sethighqualityaudioparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sethighqualityaudioparameters__parameters" data-tocid="api_sethighqualityaudioparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sethighqualityaudioparameters__return_values" data-tocid="api_sethighqualityaudioparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_adjustrecordingsignalvolume" data-tocid="api_adjustrecordingsignalvolume"><a href="class_irtcengine.aspx#api_adjustrecordingsignalvolume"><span class="- topic/ph ph">adjustRecordingSignalVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_adjustrecordingsignalvolume__prototype" data-tocid="api_adjustrecordingsignalvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustrecordingsignalvolume__detailed_desc" data-tocid="api_adjustrecordingsignalvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustrecordingsignalvolume__parameters" data-tocid="api_adjustrecordingsignalvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustrecordingsignalvolume__return_values" data-tocid="api_adjustrecordingsignalvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_adjustuserplaybacksignalvolume" data-tocid="api_adjustuserplaybacksignalvolume"><a href="class_irtcengine.aspx#api_adjustuserplaybacksignalvolume"><span class="- topic/ph ph">adjustUserPlaybackSignalVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_adjustuserplaybacksignalvolume__prototype" data-tocid="api_adjustuserplaybacksignalvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustuserplaybacksignalvolume__detailed_desc" data-tocid="api_adjustuserplaybacksignalvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustuserplaybacksignalvolume__parameters" data-tocid="api_adjustuserplaybacksignalvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustuserplaybacksignalvolume__return_values" data-tocid="api_adjustuserplaybacksignalvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_adjustplaybacksignalvolume" data-tocid="api_adjustplaybacksignalvolume"><a href="class_irtcengine.aspx#api_adjustplaybacksignalvolume"><span class="- topic/ph ph">adjustPlaybackSignalVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_adjustplaybacksignalvolume__prototype" data-tocid="api_adjustplaybacksignalvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustplaybacksignalvolume__detailed_desc" data-tocid="api_adjustplaybacksignalvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustplaybacksignalvolume__parameters" data-tocid="api_adjustplaybacksignalvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustplaybacksignalvolume__return_values" data-tocid="api_adjustplaybacksignalvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablelocalaudio" data-tocid="api_enablelocalaudio"><a href="class_irtcengine.aspx#api_enablelocalaudio"><span class="- topic/ph ph">enableLocalAudio</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablelocalaudio__prototype" data-tocid="api_enablelocalaudio__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelocalaudio__detailed_desc" data-tocid="api_enablelocalaudio__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelocalaudio__parameters" data-tocid="api_enablelocalaudio__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelocalaudio__return_values" data-tocid="api_enablelocalaudio__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_mutelocalaudiostream" data-tocid="api_mutelocalaudiostream"><a href="class_irtcengine.aspx#api_mutelocalaudiostream"><span class="- topic/ph ph">muteLocalAudioStream</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_mutelocalaudiostream__prototype" data-tocid="api_mutelocalaudiostream__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_mutelocalaudiostream__detailed_desc" data-tocid="api_mutelocalaudiostream__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_mutelocalaudiostream__parameters" data-tocid="api_mutelocalaudiostream__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_mutelocalaudiostream__return_values" data-tocid="api_mutelocalaudiostream__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_muteremoteaudiostream" data-tocid="api_muteremoteaudiostream"><a href="class_irtcengine.aspx#api_muteremoteaudiostream"><span class="- topic/ph ph">muteRemoteAudioStream</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_muteremoteaudiostream__prototype" data-tocid="api_muteremoteaudiostream__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteremoteaudiostream__detailed_desc" data-tocid="api_muteremoteaudiostream__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteremoteaudiostream__parameters" data-tocid="api_muteremoteaudiostream__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteremoteaudiostream__return_values" data-tocid="api_muteremoteaudiostream__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_muteallremoteaudiostreams" data-tocid="api_muteallremoteaudiostreams"><a href="class_irtcengine.aspx#api_muteallremoteaudiostreams"><span class="- topic/ph ph">muteAllRemoteAudioStreams</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_muteallremoteaudiostreams__prototype" data-tocid="api_muteallremoteaudiostreams__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteallremoteaudiostreams__detailed_desc" data-tocid="api_muteallremoteaudiostreams__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteallremoteaudiostreams__parameters" data-tocid="api_muteallremoteaudiostreams__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteallremoteaudiostreams__return_values" data-tocid="api_muteallremoteaudiostreams__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setdefaultmuteallremoteaudiostreams" data-tocid="api_setdefaultmuteallremoteaudiostreams"><a href="class_irtcengine.aspx#api_setdefaultmuteallremoteaudiostreams"><span class="- topic/ph ph">setDefaultMuteAllRemoteAudioStreams</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremoteaudiostreams__prototype" data-tocid="api_setdefaultmuteallremoteaudiostreams__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremoteaudiostreams__detailed_desc" data-tocid="api_setdefaultmuteallremoteaudiostreams__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremoteaudiostreams__parameters" data-tocid="api_setdefaultmuteallremoteaudiostreams__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremoteaudiostreams__return_values" data-tocid="api_setdefaultmuteallremoteaudiostreams__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablevideo" data-tocid="api_enablevideo"><a href="class_irtcengine.aspx#api_enablevideo"><span class="- topic/ph ph">enableVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablevideo__prototype" data-tocid="api_enablevideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablevideo__detailed_desc" data-tocid="api_enablevideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablevideo__return_values" data-tocid="api_enablevideo__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_disablevideo" data-tocid="api_disablevideo"><a href="class_irtcengine.aspx#api_disablevideo"><span class="- topic/ph ph">disableVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_disablevideo__prototype" data-tocid="api_disablevideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_disablevideo__detailed_desc" data-tocid="api_disablevideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_disablevideo__return_values" data-tocid="api_disablevideo__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setvideoprofile" data-tocid="api_setvideoprofile"><a href="class_irtcengine.aspx#api_setvideoprofile"><span class="- topic/ph ph">setVideoProfile</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setvideoprofile__prototype" data-tocid="api_setvideoprofile__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideoprofile__detailed_desc" data-tocid="api_setvideoprofile__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideoprofile__parameters" data-tocid="api_setvideoprofile__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideoprofile__return_values" data-tocid="api_setvideoprofile__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setvideoencoderconfiguration" data-tocid="api_setvideoencoderconfiguration"><a href="class_irtcengine.aspx#api_setvideoencoderconfiguration"><span class="- topic/ph ph">setVideoEncoderConfiguration</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setvideoencoderconfiguration__prototype" data-tocid="api_setvideoencoderconfiguration__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideoencoderconfiguration__detailed_desc" data-tocid="api_setvideoencoderconfiguration__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideoencoderconfiguration__parameters" data-tocid="api_setvideoencoderconfiguration__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideoencoderconfiguration__return_values" data-tocid="api_setvideoencoderconfiguration__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setuplocalvideo" data-tocid="api_setuplocalvideo"><a href="class_irtcengine.aspx#api_setuplocalvideo"><span class="- topic/ph ph">setupLocalVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setuplocalvideo__prototype" data-tocid="api_setuplocalvideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setuplocalvideo__detailed_desc" data-tocid="api_setuplocalvideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setuplocalvideo__parameters" data-tocid="api_setuplocalvideo__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setuplocalvideo__return_values" data-tocid="api_setuplocalvideo__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setupremotevideo" data-tocid="api_setupremotevideo"><a href="class_irtcengine.aspx#api_setupremotevideo"><span class="- topic/ph ph">setupRemoteVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setupremotevideo__detailed_desc" data-tocid="api_setupremotevideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setupremotevideo__parameters" data-tocid="api_setupremotevideo__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setupremotevideo__return_values" data-tocid="api_setupremotevideo__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalrendermode1" data-tocid="api_setlocalrendermode1"><a href="class_irtcengine.aspx#api_setlocalrendermode1"><span class="- topic/ph ph">setLocalRenderMode</span></a> [1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode1__prototype" data-tocid="api_setlocalrendermode1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode1__detailed_desc" data-tocid="api_setlocalrendermode1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode1__parameters" data-tocid="api_setlocalrendermode1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode1__return_values" data-tocid="api_setlocalrendermode1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalrendermode2" data-tocid="api_setlocalrendermode2"><a href="class_irtcengine.aspx#api_setlocalrendermode2"><span class="- topic/ph ph">setLocalRenderMode</span></a> [2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode2__prototype" data-tocid="api_setlocalrendermode2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode2__detailed_desc" data-tocid="api_setlocalrendermode2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode2__parameters" data-tocid="api_setlocalrendermode2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalrendermode2__return_values" data-tocid="api_setlocalrendermode2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setremoterendermode1" data-tocid="api_setremoterendermode1"><a href="class_irtcengine.aspx#api_setremoterendermode1"><span class="- topic/ph ph">setRemoteRenderMode</span></a> [1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode1__prototype" data-tocid="api_setremoterendermode1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode1__detailed_desc" data-tocid="api_setremoterendermode1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode1__parameters" data-tocid="api_setremoterendermode1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode1__return_values" data-tocid="api_setremoterendermode1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setremoterendermode2" data-tocid="api_setremoterendermode2"><a href="class_irtcengine.aspx#api_setremoterendermode2"><span class="- topic/ph ph">setRemoteRenderMode</span></a> [2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode2__prototype" data-tocid="api_setremoterendermode2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode2__detailed_desc" data-tocid="api_setremoterendermode2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode2__parameters" data-tocid="api_setremoterendermode2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoterendermode2__return_values" data-tocid="api_setremoterendermode2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startpreview" data-tocid="api_startpreview"><a href="class_irtcengine.aspx#api_startpreview"><span class="- topic/ph ph">startPreview</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startpreview__prototype" data-tocid="api_startpreview__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startpreview__detailed_desc" data-tocid="api_startpreview__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startpreview__return_values" data-tocid="api_startpreview__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stoppreview" data-tocid="api_stoppreview"><a href="class_irtcengine.aspx#api_stoppreview"><span class="- topic/ph ph">stopPreview</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stoppreview__prototype" data-tocid="api_stoppreview__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stoppreview__return_values" data-tocid="api_stoppreview__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablelocalvideo" data-tocid="api_enablelocalvideo"><a href="class_irtcengine.aspx#api_enablelocalvideo"><span class="- topic/ph ph">enableLocalVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablelocalvideo__prototype" data-tocid="api_enablelocalvideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelocalvideo__detailed_desc" data-tocid="api_enablelocalvideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelocalvideo__parameters" data-tocid="api_enablelocalvideo__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelocalvideo__return_values" data-tocid="api_enablelocalvideo__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_mutelocalvideostream" data-tocid="api_mutelocalvideostream"><a href="class_irtcengine.aspx#api_mutelocalvideostream"><span class="- topic/ph ph">muteLocalVideoStream</span></a> </a><ul><li class="section-item"><div class="section-title"><a href="#api_mutelocalvideostream__prototype" data-tocid="api_mutelocalvideostream__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_mutelocalvideostream__detailed_desc" data-tocid="api_mutelocalvideostream__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_mutelocalvideostream__parameters" data-tocid="api_mutelocalvideostream__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_mutelocalvideostream__return_values" data-tocid="api_mutelocalvideostream__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_muteremotevideostream" data-tocid="api_muteremotevideostream"><a href="class_irtcengine.aspx#api_muteremotevideostream"><span class="- topic/ph ph">muteRemoteVideoStream</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_muteremotevideostream__prototype" data-tocid="api_muteremotevideostream__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteremotevideostream__detailed_desc" data-tocid="api_muteremotevideostream__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteremotevideostream__parameters" data-tocid="api_muteremotevideostream__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteremotevideostream__return_values" data-tocid="api_muteremotevideostream__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_muteallremotevideostreams" data-tocid="api_muteallremotevideostreams"><a href="class_irtcengine.aspx#api_muteallremotevideostreams"><span class="- topic/ph ph">muteAllRemoteVideoStreams</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_muteallremotevideostreams__prototype" data-tocid="api_muteallremotevideostreams__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteallremotevideostreams__detailed_desc" data-tocid="api_muteallremotevideostreams__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteallremotevideostreams__parameters" data-tocid="api_muteallremotevideostreams__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_muteallremotevideostreams__return_values" data-tocid="api_muteallremotevideostreams__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setdefaultmuteallremotevideostreams" data-tocid="api_setdefaultmuteallremotevideostreams"><a href="class_irtcengine.aspx#api_setdefaultmuteallremotevideostreams"><span class="- topic/ph ph">setDefaultMuteAllRemoteVideoStreams</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremotevideostreams__prototype" data-tocid="api_setdefaultmuteallremotevideostreams__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremotevideostreams__detailed_desc" data-tocid="api_setdefaultmuteallremotevideostreams__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremotevideostreams__parameters" data-tocid="api_setdefaultmuteallremotevideostreams__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultmuteallremotevideostreams__return_values" data-tocid="api_setdefaultmuteallremotevideostreams__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setbeautyeffectoptions" data-tocid="api_setbeautyeffectoptions"><a href="class_irtcengine.aspx#api_setbeautyeffectoptions"><span class="- topic/ph ph">setBeautyEffectOptions</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setbeautyeffectoptions__prototype" data-tocid="api_setbeautyeffectoptions__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setbeautyeffectoptions__detailed_desc" data-tocid="api_setbeautyeffectoptions__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setbeautyeffectoptions__parameters" data-tocid="api_setbeautyeffectoptions__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setbeautyeffectoptions__return_values" data-tocid="api_setbeautyeffectoptions__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#class_irtcengine2" data-tocid="class_irtcengine2"><a href="class_irtcengine.aspx#class_irtcengine2"><span class="- topic/ph ph">IRtcEngine2</span></a></a><ul><li class="topic-item"><a href="#api_createChannel" data-tocid="api_createChannel"><a href="class_irtcengine.aspx#api_createChannel"><span class="- topic/ph ph">createChannel</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_createChannel__prototype" data-tocid="api_createChannel__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createChannel__detailed_desc" data-tocid="api_createChannel__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createChannel__parameters" data-tocid="api_createChannel__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createChannel__return_values" data-tocid="api_createChannel__return_values">返回值</a></div></li></ul></li></ul></li><li class="topic-item"><a href="#api_startscreencapture" data-tocid="api_startscreencapture"><a href="class_irtcengine.aspx#api_startscreencapture"><span class="- topic/ph ph">startScreenCapture</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startscreencapture__prototype" data-tocid="api_startscreencapture__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapture__detailed_desc" data-tocid="api_startscreencapture__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapture__parameters" data-tocid="api_startscreencapture__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapture__return_values" data-tocid="api_startscreencapture__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startscreencapturebydisplayid" data-tocid="api_startscreencapturebydisplayid"><a href="class_irtcengine.aspx#api_startscreencapturebydisplayid"><span class="- topic/ph ph">startScreenCaptureByDisplayId</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebydisplayid__prototype" data-tocid="api_startscreencapturebydisplayid__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebydisplayid__detailed_desc" data-tocid="api_startscreencapturebydisplayid__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebydisplayid__parameters" data-tocid="api_startscreencapturebydisplayid__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebydisplayid__return_values" data-tocid="api_startscreencapturebydisplayid__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startscreencapturebyscreenrect" data-tocid="api_startscreencapturebyscreenrect"><a href="class_irtcengine.aspx#api_startscreencapturebyscreenrect"><span class="- topic/ph ph">startScreenCaptureByScreenRect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebyscreenrect__prototype" data-tocid="api_startscreencapturebyscreenrect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebyscreenrect__detailed_desc" data-tocid="api_startscreencapturebyscreenrect__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebyscreenrect__parameters" data-tocid="api_startscreencapturebyscreenrect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebyscreenrect__return_values" data-tocid="api_startscreencapturebyscreenrect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startscreencapturebywindowid" data-tocid="api_startscreencapturebywindowid"><a href="class_irtcengine.aspx#api_startscreencapturebyscreenrect"><span class="- topic/ph ph">startScreenCaptureByScreenRect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebywindowid__prototype" data-tocid="api_startscreencapturebywindowid__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebywindowid__detailed_desc" data-tocid="api_startscreencapturebywindowid__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebywindowid__parameters" data-tocid="api_startscreencapturebywindowid__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startscreencapturebywindowid__return_values" data-tocid="api_startscreencapturebywindowid__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setscreencapturecontenthint" data-tocid="api_setscreencapturecontenthint"><a href="class_irtcengine.aspx#api_setscreencapturecontenthint"><span class="- topic/ph ph">setScreenCaptureContentHint</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setscreencapturecontenthint__prototype" data-tocid="api_setscreencapturecontenthint__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setscreencapturecontenthint__detailed_desc" data-tocid="api_setscreencapturecontenthint__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setscreencapturecontenthint__parameters" data-tocid="api_setscreencapturecontenthint__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setscreencapturecontenthint__return_values" data-tocid="api_setscreencapturecontenthint__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_updatescreencaptureparameters" data-tocid="api_updatescreencaptureparameters"><a href="class_irtcengine.aspx#api_updatescreencaptureparameters"><span class="- topic/ph ph">updateScreenCaptureParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureparameters__prototype" data-tocid="api_updatescreencaptureparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureparameters__detailed_desc" data-tocid="api_updatescreencaptureparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureparameters__parameters" data-tocid="api_updatescreencaptureparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureparameters__return_values" data-tocid="api_updatescreencaptureparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_updatescreencaptureregion1" data-tocid="api_updatescreencaptureregion1"><a href="class_irtcengine.aspx#api_updatescreencaptureregion1"><span class="- topic/ph ph">updateScreenCaptureRegion</span></a> [1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion1__prototype" data-tocid="api_updatescreencaptureregion1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion1__detailed_desc" data-tocid="api_updatescreencaptureregion1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion1__parameters" data-tocid="api_updatescreencaptureregion1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion1__return_values" data-tocid="api_updatescreencaptureregion1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_updatescreencaptureregion2" data-tocid="api_updatescreencaptureregion2"><a href="class_irtcengine.aspx#api_updatescreencaptureregion2"><span class="- topic/ph ph">updateScreenCaptureRegion</span></a> [2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion2__prototype" data-tocid="api_updatescreencaptureregion2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion2__detailed_desc" data-tocid="api_updatescreencaptureregion2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion2__parameters" data-tocid="api_updatescreencaptureregion2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatescreencaptureregion2__return_values" data-tocid="api_updatescreencaptureregion2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopscreencapture" data-tocid="api_stopscreencapture"><a href="class_irtcengine.aspx#api_stopscreencapture"><span class="- topic/ph ph">stopScreenCapture</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopscreencapture__prototype" data-tocid="api_stopscreencapture__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopscreencapture__return_values" data-tocid="api_stopscreencapture__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startaudiomixing" data-tocid="api_startaudiomixing"><a href="class_irtcengine.aspx#api_startaudiomixing"><span class="- topic/ph ph">startAudioMixing</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startaudiomixing__prototype" data-tocid="api_startaudiomixing__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiomixing__detailed_desc" data-tocid="api_startaudiomixing__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiomixing__parameters" data-tocid="api_startaudiomixing__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiomixing__return_values" data-tocid="api_startaudiomixing__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopaudiomixing" data-tocid="api_stopaudiomixing"><a href="class_irtcengine.aspx#api_stopaudiomixing"><span class="- topic/ph ph">stopAudioMixing</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopaudiomixing__prototype" data-tocid="api_stopaudiomixing__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopaudiomixing__detailed_desc" data-tocid="api_stopaudiomixing__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopaudiomixing__return_values" data-tocid="api_stopaudiomixing__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_pauseaudiomixing" data-tocid="api_pauseaudiomixing"><a href="class_irtcengine.aspx#api_pauseaudiomixing"><span class="- topic/ph ph">pauseAudioMixing</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_pauseaudiomixing__prototype" data-tocid="api_pauseaudiomixing__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_pauseaudiomixing__detailed_desc" data-tocid="api_pauseaudiomixing__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_pauseaudiomixing__return_values" data-tocid="api_pauseaudiomixing__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_resumeaudiomixing" data-tocid="api_resumeaudiomixing"><a href="class_irtcengine.aspx#api_resumeaudiomixing"><span class="- topic/ph ph">resumeAudioMixing</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_resumeaudiomixing__prototype" data-tocid="api_resumeaudiomixing__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_resumeaudiomixing__detailed_desc" data-tocid="api_resumeaudiomixing__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_resumeaudiomixing__return_values" data-tocid="api_resumeaudiomixing__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_adjustaudiomixingvolume" data-tocid="api_adjustaudiomixingvolume"><a href="class_irtcengine.aspx#api_adjustaudiomixingvolume"><span class="- topic/ph ph">adjustAudioMixingVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingvolume__prototype" data-tocid="api_adjustaudiomixingvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingvolume__detailed_desc" data-tocid="api_adjustaudiomixingvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingvolume__parameters" data-tocid="api_adjustaudiomixingvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingvolume__return_values" data-tocid="api_adjustaudiomixingvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_adjustaudiomixingplayoutvolume" data-tocid="api_adjustaudiomixingplayoutvolume"><a href="class_irtcengine.aspx#api_adjustaudiomixingplayoutvolume"><span class="- topic/ph ph">adjustAudioMixingPlayoutVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingplayoutvolume__prototype" data-tocid="api_adjustaudiomixingplayoutvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingplayoutvolume__detailed_desc" data-tocid="api_adjustaudiomixingplayoutvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingplayoutvolume__parameters" data-tocid="api_adjustaudiomixingplayoutvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingplayoutvolume__return_values" data-tocid="api_adjustaudiomixingplayoutvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_adjustaudiomixingpublishvolume" data-tocid="api_adjustaudiomixingpublishvolume"><a href="class_irtcengine.aspx#api_adjustaudiomixingpublishvolume"><span class="- topic/ph ph">adjustAudioMixingPublishVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingpublishvolume__prototype" data-tocid="api_adjustaudiomixingpublishvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingpublishvolume__detailed_desc" data-tocid="api_adjustaudiomixingpublishvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingpublishvolume__parameters" data-tocid="api_adjustaudiomixingpublishvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_adjustaudiomixingpublishvolume__return_values" data-tocid="api_adjustaudiomixingpublishvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setaudiomixingpitch" data-tocid="api_setaudiomixingpitch"><a href="class_irtcengine.aspx#api_setaudiomixingpitch"><span class="- topic/ph ph">setAudioMixingPitch</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingpitch__prototype" data-tocid="api_setaudiomixingpitch__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingpitch__detailed_desc" data-tocid="api_setaudiomixingpitch__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingpitch__parameters" data-tocid="api_setaudiomixingpitch__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingpitch__return_values" data-tocid="api_setaudiomixingpitch__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getaudiomixingplayoutvolume" data-tocid="api_getaudiomixingplayoutvolume"><a href="class_irtcengine.aspx#api_getaudiomixingplayoutvolume"><span class="- topic/ph ph">getAudioMixingPlayoutVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingplayoutvolume__prototype" data-tocid="api_getaudiomixingplayoutvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingplayoutvolume__detailed_desc" data-tocid="api_getaudiomixingplayoutvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingplayoutvolume__return_values" data-tocid="api_getaudiomixingplayoutvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getaudiomixingpublishvolume" data-tocid="api_getaudiomixingpublishvolume"><a href="class_irtcengine.aspx#api_getaudiomixingpublishvolume"><span class="- topic/ph ph">getAudioMixingPublishVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingpublishvolume__prototype" data-tocid="api_getaudiomixingpublishvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingpublishvolume__detailed_desc" data-tocid="api_getaudiomixingpublishvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingpublishvolume__return_values" data-tocid="api_getaudiomixingpublishvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getaudiomixingduration" data-tocid="api_getaudiomixingduration"><a href="class_irtcengine.aspx#api_getaudiomixingduration"><span class="- topic/ph ph">getAudioMixingDuration</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingduration__prototype" data-tocid="api_getaudiomixingduration__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingduration__detailed_desc" data-tocid="api_getaudiomixingduration__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingduration__return_values" data-tocid="api_getaudiomixingduration__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getaudiomixingcurrentposition" data-tocid="api_getaudiomixingcurrentposition"><a href="class_irtcengine.aspx#api_getaudiomixingcurrentposition"><span class="- topic/ph ph">getAudioMixingCurrentPosition</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingcurrentposition__prototype" data-tocid="api_getaudiomixingcurrentposition__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingcurrentposition__detailed_desc" data-tocid="api_getaudiomixingcurrentposition__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getaudiomixingcurrentposition__return_values" data-tocid="api_getaudiomixingcurrentposition__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setaudiomixingposition" data-tocid="api_setaudiomixingposition"><a href="class_irtcengine.aspx#api_setaudiomixingposition"><span class="- topic/ph ph">setAudioMixingPosition</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingposition__prototype" data-tocid="api_setaudiomixingposition__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingposition__detailed_desc" data-tocid="api_setaudiomixingposition__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingposition__parameters" data-tocid="api_setaudiomixingposition__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiomixingposition__return_values" data-tocid="api_setaudiomixingposition__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_geteffectsvolume" data-tocid="api_geteffectsvolume"><a href="class_irtcengine.aspx#api_geteffectsvolume"><span class="- topic/ph ph">getEffectsVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_geteffectsvolume__prototype" data-tocid="api_geteffectsvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_geteffectsvolume__detailed_desc" data-tocid="api_geteffectsvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_geteffectsvolume__return_values" data-tocid="api_geteffectsvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_seteffectsvolume" data-tocid="api_seteffectsvolume"><a href="class_irtcengine.aspx#api_seteffectsvolume"><span class="- topic/ph ph">setEffectsVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_seteffectsvolume__prototype" data-tocid="api_seteffectsvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_seteffectsvolume__detailed_desc" data-tocid="api_seteffectsvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_seteffectsvolume__parameters" data-tocid="api_seteffectsvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_seteffectsvolume__return_values" data-tocid="api_seteffectsvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setvolumeofeffect" data-tocid="api_setvolumeofeffect"><a href="class_irtcengine.aspx#api_setvolumeofeffect"><span class="- topic/ph ph">setVolumeOfEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setvolumeofeffect__prototype" data-tocid="api_setvolumeofeffect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvolumeofeffect__detailed_desc" data-tocid="api_setvolumeofeffect__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvolumeofeffect__parameters" data-tocid="api_setvolumeofeffect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvolumeofeffect__return_values" data-tocid="api_setvolumeofeffect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_playeffect2" data-tocid="api_playeffect2"><a href="class_irtcengine.aspx#api_playeffect2"><span class="- topic/ph ph">playEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_playeffect2__prototype" data-tocid="api_playeffect2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_playeffect2__detailed_desc" data-tocid="api_playeffect2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_playeffect2__parameters" data-tocid="api_playeffect2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_playeffect2__return_values" data-tocid="api_playeffect2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopeffect" data-tocid="api_stopeffect"><a href="class_irtcengine.aspx#api_stopeffect"><span class="- topic/ph ph">stopEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopeffect__prototype" data-tocid="api_stopeffect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopeffect__parameters" data-tocid="api_stopeffect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopeffect__return_values" data-tocid="api_stopeffect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopalleffects" data-tocid="api_stopalleffects"><a href="class_irtcengine.aspx#api_stopalleffects"><span class="- topic/ph ph">stopAllEffects</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopalleffects__prototype" data-tocid="api_stopalleffects__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopalleffects__return_values" data-tocid="api_stopalleffects__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_preloadeffect" data-tocid="api_preloadeffect"><a href="class_irtcengine.aspx#api_preloadeffect"><span class="- topic/ph ph">preloadEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_preloadeffect__prototype" data-tocid="api_preloadeffect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_preloadeffect__detailed_desc" data-tocid="api_preloadeffect__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_preloadeffect__parameters" data-tocid="api_preloadeffect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_preloadeffect__return_values" data-tocid="api_preloadeffect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_unloadeffect" data-tocid="api_unloadeffect"><a href="class_irtcengine.aspx#api_unloadeffect"><span class="- topic/ph ph">unloadEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_unloadeffect__prototype" data-tocid="api_unloadeffect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_unloadeffect__parameters" data-tocid="api_unloadeffect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_unloadeffect__return_values" data-tocid="api_unloadeffect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_pauseeffect" data-tocid="api_pauseeffect"><a href="class_irtcengine.aspx#api_pauseeffect"><span class="- topic/ph ph">pauseEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_pauseeffect__prototype" data-tocid="api_pauseeffect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_pauseeffect__detailed_desc" data-tocid="api_pauseeffect__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_pauseeffect__parameters" data-tocid="api_pauseeffect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_pauseeffect__return_values" data-tocid="api_pauseeffect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_pausealleffects" data-tocid="api_pausealleffects"><a href="class_irtcengine.aspx#api_pausealleffects"><span class="- topic/ph ph">pauseAllEffects</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_pausealleffects__prototype" data-tocid="api_pausealleffects__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_pausealleffects__return_values" data-tocid="api_pausealleffects__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_resumeeffect" data-tocid="api_resumeeffect"><a href="class_irtcengine.aspx#api_resumeeffect"><span class="- topic/ph ph">resumeEffect</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_resumeeffect__prototype" data-tocid="api_resumeeffect__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_resumeeffect__parameters" data-tocid="api_resumeeffect__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_resumeeffect__return_values" data-tocid="api_resumeeffect__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_resumealleffects" data-tocid="api_resumealleffects"><a href="class_irtcengine.aspx#api_resumealleffects"><span class="- topic/ph ph">resumeAllEffects</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_resumealleffects__prototype" data-tocid="api_resumealleffects__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_resumealleffects__return_values" data-tocid="api_resumealleffects__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalvoicechanger" data-tocid="api_setlocalvoicechanger"><a href="class_irtcengine.aspx#api_setlocalvoicechanger"><span class="- topic/ph ph">setLocalVoiceChanger</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicechanger__prototype" data-tocid="api_setlocalvoicechanger__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicechanger__detailed_desc" data-tocid="api_setlocalvoicechanger__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicechanger__parameters" data-tocid="api_setlocalvoicechanger__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicechanger__return_values" data-tocid="api_setlocalvoicechanger__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalvoicereverbpreset" data-tocid="api_setlocalvoicereverbpreset"><a href="class_irtcengine.aspx#api_setlocalvoicereverbpreset"><span class="- topic/ph ph">setLocalVoiceReverbPreset</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverbpreset__prototype" data-tocid="api_setlocalvoicereverbpreset__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverbpreset__detailed_desc" data-tocid="api_setlocalvoicereverbpreset__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverbpreset__parameters" data-tocid="api_setlocalvoicereverbpreset__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverbpreset__return_values" data-tocid="api_setlocalvoicereverbpreset__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalvoicepitch" data-tocid="api_setlocalvoicepitch"><a href="class_irtcengine.aspx#api_setlocalvoicepitch"><span class="- topic/ph ph">setLocalVoicePitch</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicepitch__prototype" data-tocid="api_setlocalvoicepitch__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicepitch__detailed_desc" data-tocid="api_setlocalvoicepitch__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicepitch__parameters" data-tocid="api_setlocalvoicepitch__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicepitch__return_values" data-tocid="api_setlocalvoicepitch__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalvoiceequalization" data-tocid="api_setlocalvoiceequalization"><a href="class_irtcengine.aspx#api_setlocalvoiceequalization"><span class="- topic/ph ph">setLocalVoiceEqualization</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalvoiceequalization__prototype" data-tocid="api_setlocalvoiceequalization__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoiceequalization__detailed_desc" data-tocid="api_setlocalvoiceequalization__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoiceequalization__parameters" data-tocid="api_setlocalvoiceequalization__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoiceequalization__return_values" data-tocid="api_setlocalvoiceequalization__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalvoicereverb" data-tocid="api_setlocalvoicereverb"><a href="class_irtcengine.aspx#api_setlocalvoicereverb"><span class="- topic/ph ph">setLocalVoiceReverb</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverb__prototype" data-tocid="api_setlocalvoicereverb__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverb__detailed_desc" data-tocid="api_setlocalvoicereverb__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverb__parameters" data-tocid="api_setlocalvoicereverb__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvoicereverb__return_values" data-tocid="api_setlocalvoicereverb__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setvoicebeautifierpreset" data-tocid="api_setvoicebeautifierpreset"><a href="class_irtcengine.aspx#api_setvoicebeautifierpreset"><span class="- topic/ph ph">setVoiceBeautifierPreset</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierpreset__prototype" data-tocid="api_setvoicebeautifierpreset__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierpreset__detailed_desc" data-tocid="api_setvoicebeautifierpreset__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierpreset__parameters" data-tocid="api_setvoicebeautifierpreset__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierpreset__return_values" data-tocid="api_setvoicebeautifierpreset__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setvoicebeautifierparameters" data-tocid="api_setvoicebeautifierparameters"><a href="class_irtcengine.aspx#api_setvoicebeautifierparameters"><span class="- topic/ph ph">setVoiceBeautifierParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierparameters__prototype" data-tocid="api_setvoicebeautifierparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierparameters__detailed_desc" data-tocid="api_setvoicebeautifierparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierparameters__parameters" data-tocid="api_setvoicebeautifierparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvoicebeautifierparameters__return_values" data-tocid="api_setvoicebeautifierparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setaudioeffectpreset" data-tocid="api_setaudioeffectpreset"><a href="class_irtcengine.aspx#api_setaudioeffectpreset"><span class="- topic/ph ph">setAudioEffectPreset</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectpreset__prototype" data-tocid="api_setaudioeffectpreset__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectpreset__detailed_desc" data-tocid="api_setaudioeffectpreset__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectpreset__parameters" data-tocid="api_setaudioeffectpreset__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectpreset__return_values" data-tocid="api_setaudioeffectpreset__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setaudioeffectparameters" data-tocid="api_setaudioeffectparameters"><a href="class_irtcengine.aspx#api_setaudioeffectparameters"><span class="- topic/ph ph">setAudioEffectParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectparameters__prototype" data-tocid="api_setaudioeffectparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectparameters__detailed_desc" data-tocid="api_setaudioeffectparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectparameters__parameters" data-tocid="api_setaudioeffectparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudioeffectparameters__return_values" data-tocid="api_setaudioeffectparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablesoundpositionindication" data-tocid="api_enablesoundpositionindication"><a href="class_irtcengine.aspx#api_enablesoundpositionindication"><span class="- topic/ph ph">enableSoundPositionIndication</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablesoundpositionindication__prototype" data-tocid="api_enablesoundpositionindication__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablesoundpositionindication__detailed_desc" data-tocid="api_enablesoundpositionindication__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablesoundpositionindication__parameters" data-tocid="api_enablesoundpositionindication__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablesoundpositionindication__return_values" data-tocid="api_enablesoundpositionindication__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setremotevoiceposition" data-tocid="api_setremotevoiceposition"><a href="class_irtcengine.aspx#api_setremotevoiceposition"><span class="- topic/ph ph">setRemoteVoicePosition</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setremotevoiceposition__prototype" data-tocid="api_setremotevoiceposition__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotevoiceposition__detailed_desc" data-tocid="api_setremotevoiceposition__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotevoiceposition__parameters" data-tocid="api_setremotevoiceposition__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotevoiceposition__return_values" data-tocid="api_setremotevoiceposition__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlivetranscoding" data-tocid="api_setlivetranscoding">setLiveTranscoding</a><ul><li class="section-item"><div class="section-title"><a href="#api_setlivetranscoding__prototype" data-tocid="api_setlivetranscoding__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlivetranscoding__detailed_desc" data-tocid="api_setlivetranscoding__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlivetranscoding__parameters" data-tocid="api_setlivetranscoding__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlivetranscoding__return_values" data-tocid="api_setlivetranscoding__return_values">返回</a></div></li></ul></li><li class="topic-item"><a href="#api_addpublishstreamurl" data-tocid="api_addpublishstreamurl"><a href="class_irtcengine.aspx#api_addpublishstreamurl"><span class="- topic/ph ph">addPublishStreamUrl</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_addpublishstreamurl__prototype" data-tocid="api_addpublishstreamurl__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addpublishstreamurl__detailed_desc" data-tocid="api_addpublishstreamurl__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addpublishstreamurl__parameters" data-tocid="api_addpublishstreamurl__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addpublishstreamurl__return_values" data-tocid="api_addpublishstreamurl__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_removepublishstreamurl" data-tocid="api_removepublishstreamurl"><a href="class_irtcengine.aspx#api_removepublishstreamurl"><span class="- topic/ph ph">removePublishStreamUrl</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_removepublishstreamurl__prototype" data-tocid="api_removepublishstreamurl__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_removepublishstreamurl__detailed_desc" data-tocid="api_removepublishstreamurl__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_removepublishstreamurl__parameters" data-tocid="api_removepublishstreamurl__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_removepublishstreamurl__return_values" data-tocid="api_removepublishstreamurl__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startchannelmediarelay" data-tocid="api_startchannelmediarelay"><a href="class_irtcengine.aspx#api_startchannelmediarelay"><span class="- topic/ph ph">startChannelMediaRelay</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startchannelmediarelay__prototype" data-tocid="api_startchannelmediarelay__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startchannelmediarelay__detailed_desc" data-tocid="api_startchannelmediarelay__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startchannelmediarelay__parameters" data-tocid="api_startchannelmediarelay__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startchannelmediarelay__return_values" data-tocid="api_startchannelmediarelay__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_updatechannelmediarelay" data-tocid="api_updatechannelmediarelay"><a href="class_irtcengine.aspx#api_updatechannelmediarelay"><span class="- topic/ph ph">updateChannelMediaRelay</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_updatechannelmediarelay__prototype" data-tocid="api_updatechannelmediarelay__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatechannelmediarelay__detailed_desc" data-tocid="api_updatechannelmediarelay__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatechannelmediarelay__parameters" data-tocid="api_updatechannelmediarelay__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_updatechannelmediarelay__return_values" data-tocid="api_updatechannelmediarelay__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopchannelmediarelay" data-tocid="api_stopchannelmediarelay"><a href="class_irtcengine.aspx#api_stopchannelmediarelay"><span class="- topic/ph ph">stopChannelMediaRelay</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopchannelmediarelay__prototype" data-tocid="api_stopchannelmediarelay__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopchannelmediarelay__detailed_desc" data-tocid="api_stopchannelmediarelay__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopchannelmediarelay__return_values" data-tocid="api_stopchannelmediarelay__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enableaudiovolumeindication" data-tocid="api_enableaudiovolumeindication"><a href="class_irtcengine.aspx#api_enableaudiovolumeindication"><span class="- topic/ph ph">enableAudioVolumeIndication</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enableaudiovolumeindication__prototype" data-tocid="api_enableaudiovolumeindication__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableaudiovolumeindication__detailed_desc" data-tocid="api_enableaudiovolumeindication__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableaudiovolumeindication__parameters" data-tocid="api_enableaudiovolumeindication__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableaudiovolumeindication__return_values" data-tocid="api_enableaudiovolumeindication__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablefacedetection" data-tocid="api_enablefacedetection"><a href="class_irtcengine.aspx#api_enablefacedetection"><span class="- topic/ph ph">enableFaceDetection</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablefacedetection__prototype" data-tocid="api_enablefacedetection__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablefacedetection__detailed_desc" data-tocid="api_enablefacedetection__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablefacedetection__parameters" data-tocid="api_enablefacedetection__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablefacedetection__return_values" data-tocid="api_enablefacedetection__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setdefaultaudioroutetospeakerphone" data-tocid="api_setdefaultaudioroutetospeakerphone"><a href="class_irtcengine.aspx#api_setdefaultaudioroutetospeakerphone"><span class="- topic/ph ph">setDefaultAudioRouteToSpeakerphone</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setdefaultaudioroutetospeakerphone__prototype" data-tocid="api_setdefaultaudioroutetospeakerphone__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultaudioroutetospeakerphone__detailed_desc" data-tocid="api_setdefaultaudioroutetospeakerphone__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultaudioroutetospeakerphone__parameters" data-tocid="api_setdefaultaudioroutetospeakerphone__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setdefaultaudioroutetospeakerphone__return_values" data-tocid="api_setdefaultaudioroutetospeakerphone__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setenablespeakerphone" data-tocid="api_setenablespeakerphone"><a href="class_irtcengine.aspx#api_setenablespeakerphone"><span class="- topic/ph ph">setEnableSpeakerphone</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setenablespeakerphone__prototype" data-tocid="api_setenablespeakerphone__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setenablespeakerphone__detailed_desc" data-tocid="api_setenablespeakerphone__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setenablespeakerphone__parameters" data-tocid="api_setenablespeakerphone__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setenablespeakerphone__return_values" data-tocid="api_setenablespeakerphone__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_isspeakerphoneenabled" data-tocid="api_isspeakerphoneenabled"><a href="class_irtcengine.aspx#api_isspeakerphoneenabled"><span class="- topic/ph ph">isSpeakerphoneEnabled</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_isspeakerphoneenabled__prototype" data-tocid="api_isspeakerphoneenabled__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_isspeakerphoneenabled__detailed_desc" data-tocid="api_isspeakerphoneenabled__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_isspeakerphoneenabled__return_values" data-tocid="api_isspeakerphoneenabled__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enableInearmonitoring" data-tocid="api_enableInearmonitoring"><a href="class_irtcengine.aspx#api_enableInearmonitoring"><span class="- topic/ph ph">enableInEarMonitoring</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enableInearmonitoring__prototype" data-tocid="api_enableInearmonitoring__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableInearmonitoring__detailed_desc" data-tocid="api_enableInearmonitoring__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableInearmonitoring__parameters" data-tocid="api_enableInearmonitoring__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableInearmonitoring__return_values" data-tocid="api_enableInearmonitoring__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_seiinearmonitoringvolume" data-tocid="api_seiinearmonitoringvolume"><a href="class_irtcengine.aspx#api_seiinearmonitoringvolume"><span class="- topic/ph ph">setInEarMonitoringVolume</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_seiinearmonitoringvolume__prototype" data-tocid="api_seiinearmonitoringvolume__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_seiinearmonitoringvolume__detailed_desc" data-tocid="api_seiinearmonitoringvolume__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_seiinearmonitoringvolume__parameters" data-tocid="api_seiinearmonitoringvolume__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_seiinearmonitoringvolume__return_values" data-tocid="api_seiinearmonitoringvolume__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enabledualstreammode" data-tocid="api_enabledualstreammode"><a href="class_irtcengine.aspx#api_enabledualstreammode"><span class="- topic/ph ph">enableDualStreamMode</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enabledualstreammode__prototype" data-tocid="api_enabledualstreammode__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enabledualstreammode__detailed_desc" data-tocid="api_enabledualstreammode__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enabledualstreammode__parameters" data-tocid="api_enabledualstreammode__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_setremotevideostreamtype" data-tocid="api_setremotevideostreamtype"><a href="class_irtcengine.aspx#api_setremotevideostreamtype"><span class="- topic/ph ph">setRemoteVideoStreamType</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setremotevideostreamtype__prototype" data-tocid="api_setremotevideostreamtype__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotevideostreamtype__detailed_desc" data-tocid="api_setremotevideostreamtype__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotevideostreamtype__parameters" data-tocid="api_setremotevideostreamtype__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotevideostreamtype__return_values" data-tocid="api_setremotevideostreamtype__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setremotedefaultvideostreamtype" data-tocid="api_setremotedefaultvideostreamtype"><a href="class_irtcengine.aspx#api_setremotedefaultvideostreamtype"><span class="- topic/ph ph">setRemoteDefaultVideoStreamType</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setremotedefaultvideostreamtype__prototype" data-tocid="api_setremotedefaultvideostreamtype__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotedefaultvideostreamtype__detailed_desc" data-tocid="api_setremotedefaultvideostreamtype__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotedefaultvideostreamtype__parameters" data-tocid="api_setremotedefaultvideostreamtype__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotedefaultvideostreamtype__return_values" data-tocid="api_setremotedefaultvideostreamtype__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalpublishfallbackoption" data-tocid="api_setlocalpublishfallbackoption"><a href="class_irtcengine.aspx#api_setlocalpublishfallbackoption"><span class="- topic/ph ph">setLocalPublishFallbackOption</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalpublishfallbackoption__prototype" data-tocid="api_setlocalpublishfallbackoption__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalpublishfallbackoption__detailed_desc" data-tocid="api_setlocalpublishfallbackoption__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalpublishfallbackoption__parameters" data-tocid="api_setlocalpublishfallbackoption__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalpublishfallbackoption__return_values" data-tocid="api_setlocalpublishfallbackoption__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setremotesubscribefallbackoption" data-tocid="api_setremotesubscribefallbackoption"><a href="class_irtcengine.aspx#api_setremotesubscribefallbackoption"><span class="- topic/ph ph">setRemoteSubscribeFallbackOption</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setremotesubscribefallbackoption__prototype" data-tocid="api_setremotesubscribefallbackoption__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotesubscribefallbackoption__detailed_desc" data-tocid="api_setremotesubscribefallbackoption__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotesubscribefallbackoption__parameters" data-tocid="api_setremotesubscribefallbackoption__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremotesubscribefallbackoption__return_values" data-tocid="api_setremotesubscribefallbackoption__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setremoteuserpriority" data-tocid="api_setremoteuserpriority"><a href="class_irtcengine.aspx#api_setremoteuserpriority"><span class="- topic/ph ph">setRemoteUserPriority</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setremoteuserpriority__prototype" data-tocid="api_setremoteuserpriority__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoteuserpriority__detailed_desc" data-tocid="api_setremoteuserpriority__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoteuserpriority__parameters" data-tocid="api_setremoteuserpriority__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setremoteuserpriority__return_values" data-tocid="api_setremoteuserpriority__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startechotest1" data-tocid="api_startechotest1"><a href="class_irtcengine.aspx#api_startechotest1"><span class="- topic/ph ph">startEchoTest</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_startechotest1__prototype" data-tocid="api_startechotest1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startechotest1__detailed_desc" data-tocid="api_startechotest1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startechotest1__return_values" data-tocid="api_startechotest1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startechotest2" data-tocid="api_startechotest2"><a href="class_irtcengine.aspx#api_startechotest2"><span class="- topic/ph ph">startEchoTest</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_startechotest2__prototype" data-tocid="api_startechotest2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startechotest2__detailed_desc" data-tocid="api_startechotest2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startechotest2__parameters" data-tocid="api_startechotest2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startechotest2__return_values" data-tocid="api_startechotest2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopechotest" data-tocid="api_stopechotest"><a href="class_irtcengine.aspx#api_stopechotest"><span class="- topic/ph ph">stopEchoTest</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopechotest__prototype" data-tocid="api_stopechotest__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopechotest__return_values" data-tocid="api_stopechotest__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enablelastmiletest" data-tocid="api_enablelastmiletest"><a href="class_irtcengine.aspx#api_enablelastmiletest"><span class="- topic/ph ph">enableLastmileTest</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enablelastmiletest__prototype" data-tocid="api_enablelastmiletest__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelastmiletest__detailed_desc" data-tocid="api_enablelastmiletest__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enablelastmiletest__return_values" data-tocid="api_enablelastmiletest__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_disablelastmiletest" data-tocid="api_disablelastmiletest"><a href="class_irtcengine.aspx#api_disablelastmiletest"><span class="- topic/ph ph">disableLastmileTest</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_disablelastmiletest__prototype" data-tocid="api_disablelastmiletest__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_disablelastmiletest__return_values" data-tocid="api_disablelastmiletest__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startlastmileprobetest" data-tocid="api_startlastmileprobetest"><a href="class_irtcengine.aspx#api_startlastmileprobetest"><span class="- topic/ph ph">startLastmileProbeTest</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_startlastmileprobetest__prototype" data-tocid="api_startlastmileprobetest__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startlastmileprobetest__detailed_desc" data-tocid="api_startlastmileprobetest__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startlastmileprobetest__parameters" data-tocid="api_startlastmileprobetest__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startlastmileprobetest__return_values" data-tocid="api_startlastmileprobetest__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stoplastmileprobetest" data-tocid="api_stoplastmileprobetest"><a href="class_irtcengine.aspx#api_stoplastmileprobetest"><span class="- topic/ph ph">stopLastmileProbeTest</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stoplastmileprobetest__prototype" data-tocid="api_stoplastmileprobetest__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stoplastmileprobetest__return_values" data-tocid="api_stoplastmileprobetest__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setvideosource" data-tocid="api_setvideosource"><a href="class_irtcengine.aspx#api_setvideosource"><span class="- topic/ph ph">setVideoSource</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setvideosource__prototype" data-tocid="api_setvideosource__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideosource__detailed_desc" data-tocid="api_setvideosource__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideosource__parameters" data-tocid="api_setvideosource__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setvideosource__return_values" data-tocid="api_setvideosource__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setexternalaudiosource" data-tocid="api_setexternalaudiosource"><a href="class_irtcengine.aspx#api_setexternalaudiosource"><span class="- topic/ph ph">setExternalAudioSource</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosource__prototype" data-tocid="api_setexternalaudiosource__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosource__detailed_desc" data-tocid="api_setexternalaudiosource__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosource__parameters" data-tocid="api_setexternalaudiosource__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosource__return_values" data-tocid="api_setexternalaudiosource__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setexternalaudiosink" data-tocid="api_setexternalaudiosink"><a href="class_irtcengine.aspx#api_setexternalaudiosink"><span class="- topic/ph ph">setExternalAudioSink</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosink__prototype" data-tocid="api_setexternalaudiosink__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosink__detailed_desc" data-tocid="api_setexternalaudiosink__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosink__parameters" data-tocid="api_setexternalaudiosink__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setexternalaudiosink__return_values" data-tocid="api_setexternalaudiosink__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setrecordingaudioframeparameters" data-tocid="api_setrecordingaudioframeparameters"><a href="class_irtcengine.aspx#api_setrecordingaudioframeparameters"><span class="- topic/ph ph">setRecordingAudioFrameParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setrecordingaudioframeparameters__prototype" data-tocid="api_setrecordingaudioframeparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setrecordingaudioframeparameters__detailed_desc" data-tocid="api_setrecordingaudioframeparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setrecordingaudioframeparameters__parameters" data-tocid="api_setrecordingaudioframeparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setrecordingaudioframeparameters__return_values" data-tocid="api_setrecordingaudioframeparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setplaybackaudioframeparameters" data-tocid="api_setplaybackaudioframeparameters"><a href="class_irtcengine.aspx#api_setplaybackaudioframeparameters"><span class="- topic/ph ph">setPlaybackAudioFrameParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setplaybackaudioframeparameters__prototype" data-tocid="api_setplaybackaudioframeparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setplaybackaudioframeparameters__detailed_desc" data-tocid="api_setplaybackaudioframeparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setplaybackaudioframeparameters__parameters" data-tocid="api_setplaybackaudioframeparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setplaybackaudioframeparameters__return_values" data-tocid="api_setplaybackaudioframeparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setmixedaudioframeparameters" data-tocid="api_setmixedaudioframeparameters"><a href="class_irtcengine.aspx#api_setmixedaudioframeparameters"><span class="- topic/ph ph">setMixedAudioFrameParameters</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setmixedaudioframeparameters__prototype" data-tocid="api_setmixedaudioframeparameters__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setmixedaudioframeparameters__detailed_desc" data-tocid="api_setmixedaudioframeparameters__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setmixedaudioframeparameters__parameters" data-tocid="api_setmixedaudioframeparameters__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setmixedaudioframeparameters__return_values" data-tocid="api_setmixedaudioframeparameters__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_registermediametadataobserver" data-tocid="api_registermediametadataobserver"><a href="class_irtcengine.aspx#api_registermediametadataobserver"><span class="- topic/ph ph">registerMediaMetadataObserver</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_registermediametadataobserver__prototype" data-tocid="api_registermediametadataobserver__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registermediametadataobserver__detailed_desc" data-tocid="api_registermediametadataobserver__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registermediametadataobserver__parameters" data-tocid="api_registermediametadataobserver__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registermediametadataobserver__return_values" data-tocid="api_registermediametadataobserver__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_addvideowatermark1" data-tocid="api_addvideowatermark1"><a href="class_irtcengine.aspx#api_addvideowatermark1"><span class="- topic/ph ph">addVideoWatermark</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark1__prototype" data-tocid="api_addvideowatermark1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark1__detailed_desc" data-tocid="api_addvideowatermark1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark1__parameters" data-tocid="api_addvideowatermark1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark1__return_values" data-tocid="api_addvideowatermark1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_addvideowatermark2" data-tocid="api_addvideowatermark2"><a href="class_irtcengine.aspx#api_addvideowatermark2"><span class="- topic/ph ph">addVideoWatermark</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark2__prototype" data-tocid="api_addvideowatermark2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark2__detailed_desc" data-tocid="api_addvideowatermark2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark2__parameters" data-tocid="api_addvideowatermark2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addvideowatermark2__return_values" data-tocid="api_addvideowatermark2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_clearvideowatermarks" data-tocid="api_clearvideowatermarks"><a href="class_irtcengine.aspx#api_clearvideowatermarks"><span class="- topic/ph ph">clearVideoWatermarks</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_clearvideowatermarks__prototype" data-tocid="api_clearvideowatermarks__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_clearvideowatermarks__return_values" data-tocid="api_clearvideowatermarks__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enableencryption" data-tocid="api_enableencryption"><a href="class_irtcengine.aspx#api_enableencryption"><span class="- topic/ph ph">enableEncryption</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enableencryption__prototype" data-tocid="api_enableencryption__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableencryption__detailed_desc" data-tocid="api_enableencryption__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableencryption__parameters" data-tocid="api_enableencryption__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableencryption__return_values" data-tocid="api_enableencryption__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setencryptionmode" data-tocid="api_setencryptionmode"><a href="class_irtcengine.aspx#api_setencryptionmode"><span class="- topic/ph ph">setEncryptionMode</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setencryptionmode__prototype" data-tocid="api_setencryptionmode__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setencryptionmode__detailed_desc" data-tocid="api_setencryptionmode__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setencryptionmode__parameters" data-tocid="api_setencryptionmode__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setencryptionmode__return_values" data-tocid="api_setencryptionmode__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setencryptionsecret" data-tocid="api_setencryptionsecret"><a href="class_irtcengine.aspx#api_setencryptionsecret"><span class="- topic/ph ph">setEncryptionSecret</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setencryptionsecret__prototype" data-tocid="api_setencryptionsecret__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setencryptionsecret__detailed_desc" data-tocid="api_setencryptionsecret__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setencryptionsecret__parameters" data-tocid="api_setencryptionsecret__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setencryptionsecret__return_values" data-tocid="api_setencryptionsecret__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_registerpacketobserver" data-tocid="api_registerpacketobserver"><a href="class_irtcengine.aspx#api_registerpacketobserver"><span class="- topic/ph ph">registerPacketObserver</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_registerpacketobserver__prototype" data-tocid="api_registerpacketobserver__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registerpacketobserver__detailed_desc" data-tocid="api_registerpacketobserver__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registerpacketobserver__parameters" data-tocid="api_registerpacketobserver__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registerpacketobserver__return_values" data-tocid="api_registerpacketobserver__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startaudiorecording1" data-tocid="api_startaudiorecording1"><a href="class_irtcengine.aspx#api_startaudiorecording1"><span class="- topic/ph ph">startAudioRecording</span></a> [1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording1__prototype" data-tocid="api_startaudiorecording1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording1__detailed_desc" data-tocid="api_startaudiorecording1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording1__parameters" data-tocid="api_startaudiorecording1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording1__return_values" data-tocid="api_startaudiorecording1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_startaudiorecording2" data-tocid="api_startaudiorecording2"><a href="class_irtcengine.aspx#api_startaudiorecording2"><span class="- topic/ph ph">startAudioRecording</span></a> [2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording2__prototype" data-tocid="api_startaudiorecording2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording2__detailed_desc" data-tocid="api_startaudiorecording2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording2__parameters" data-tocid="api_startaudiorecording2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_startaudiorecording2__return_values" data-tocid="api_startaudiorecording2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_stopaudiorecording" data-tocid="api_stopaudiorecording"><a href="class_irtcengine.aspx#api_stopaudiorecording"><span class="- topic/ph ph">stopAudioRecording</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_stopaudiorecording__prototype" data-tocid="api_stopaudiorecording__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopaudiorecording__detailed_desc" data-tocid="api_stopaudiorecording__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_stopaudiorecording__return_values" data-tocid="api_stopaudiorecording__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_addinjectstreamurl" data-tocid="api_addinjectstreamurl"><a href="class_irtcengine.aspx#api_addinjectstreamurl"><span class="- topic/ph ph">addInjectStreamUrl</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_addinjectstreamurl__prototype" data-tocid="api_addinjectstreamurl__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addinjectstreamurl__detailed_desc" data-tocid="api_addinjectstreamurl__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addinjectstreamurl__parameters" data-tocid="api_addinjectstreamurl__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_addinjectstreamurl__return_values" data-tocid="api_addinjectstreamurl__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_removeinjectstreamurl" data-tocid="api_removeinjectstreamurl"><a href="class_irtcengine.aspx#api_removeinjectstreamurl"><span class="- topic/ph ph">removeInjectStreamUrl</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_removeinjectstreamurl__prototype" data-tocid="api_removeinjectstreamurl__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_removeinjectstreamurl__detailed_desc" data-tocid="api_removeinjectstreamurl__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_removeinjectstreamurl__parameters" data-tocid="api_removeinjectstreamurl__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_removeinjectstreamurl__return_values" data-tocid="api_removeinjectstreamurl__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_switchcamera" data-tocid="api_switchcamera"><a href="class_irtcengine.aspx#api_switchcamera"><span class="- topic/ph ph">switchCamera</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_switchcamera__prototype" data-tocid="api_switchcamera__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchcamera__detailed_desc" data-tocid="api_switchcamera__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_switchcamera__return_values" data-tocid="api_switchcamera__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_createdatastream1" data-tocid="api_createdatastream1"><a href="class_irtcengine.aspx#api_createdatastream1"><span class="- topic/ph ph">createDataStream</span></a>[1/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_createdatastream1__prototype" data-tocid="api_createdatastream1__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createdatastream1__detailed_desc" data-tocid="api_createdatastream1__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createdatastream1__parameters" data-tocid="api_createdatastream1__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createdatastream1__return_values" data-tocid="api_createdatastream1__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_createdatastream2" data-tocid="api_createdatastream2"><a href="class_irtcengine.aspx#api_createdatastream2"><span class="- topic/ph ph">createDataStream</span></a>[2/2]</a><ul><li class="section-item"><div class="section-title"><a href="#api_createdatastream2__prototype" data-tocid="api_createdatastream2__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createdatastream2__detailed_desc" data-tocid="api_createdatastream2__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createdatastream2__parameters" data-tocid="api_createdatastream2__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_createdatastream2__return_values" data-tocid="api_createdatastream2__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_sendstreammessage" data-tocid="api_sendstreammessage"><a href="class_irtcengine.aspx#api_sendstreammessage"><span class="- topic/ph ph">sendStreamMessage</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_sendstreammessage__prototype" data-tocid="api_sendstreammessage__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sendstreammessage__detailed_desc" data-tocid="api_sendstreammessage__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sendstreammessage__parameters" data-tocid="api_sendstreammessage__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sendstreammessage__return_values" data-tocid="api_sendstreammessage__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enableloopbackrecording" data-tocid="api_enableloopbackrecording"><a href="class_irtcengine.aspx#api_enableloopbackrecording"><span class="- topic/ph ph">enableLoopbackRecording</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enableloopbackrecording__prototype" data-tocid="api_enableloopbackrecording__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableloopbackrecording__detailed_desc" data-tocid="api_enableloopbackrecording__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enableloopbackrecording__parameters" data-tocid="api_enableloopbackrecording__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_setaudiosessionoperationrestriction" data-tocid="api_setaudiosessionoperationrestriction"><a href="class_irtcengine.aspx#api_setaudiosessionoperationrestriction"><span class="- topic/ph ph">setAudioSessionOperationRestriction</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setaudiosessionoperationrestriction__prototype" data-tocid="api_setaudiosessionoperationrestriction__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiosessionoperationrestriction__detailed_desc" data-tocid="api_setaudiosessionoperationrestriction__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiosessionoperationrestriction__parameters" data-tocid="api_setaudiosessionoperationrestriction__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setaudiosessionoperationrestriction__return_values" data-tocid="api_setaudiosessionoperationrestriction__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlocalvideomirrormode" data-tocid="api_setlocalvideomirrormode"><a href="class_irtcengine.aspx#api_setlocalvideomirrormode"><span class="- topic/ph ph">setLocalVideoMirrorMode</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlocalvideomirrormode__prototype" data-tocid="api_setlocalvideomirrormode__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvideomirrormode__detailed_desc" data-tocid="api_setlocalvideomirrormode__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvideomirrormode__parameters" data-tocid="api_setlocalvideomirrormode__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlocalvideomirrormode__return_values" data-tocid="api_setlocalvideomirrormode__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setcameracapturerconfiguration" data-tocid="api_setcameracapturerconfiguration"><a href="class_irtcengine.aspx#api_setcameracapturerconfiguration"><span class="- topic/ph ph">setCameraCapturerConfiguration</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setcameracapturerconfiguration__prototype" data-tocid="api_setcameracapturerconfiguration__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setcameracapturerconfiguration__detailed_desc" data-tocid="api_setcameracapturerconfiguration__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setcameracapturerconfiguration__parameters" data-tocid="api_setcameracapturerconfiguration__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setcameracapturerconfiguration__return_values" data-tocid="api_setcameracapturerconfiguration__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlogfile" data-tocid="api_setlogfile"><a href="class_irtcengine.aspx#api_setlogfile"><span class="- topic/ph ph">setLogFile</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlogfile__prototype" data-tocid="api_setlogfile__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfile__detailed_desc" data-tocid="api_setlogfile__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfile__parameters" data-tocid="api_setlogfile__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfile__return_values" data-tocid="api_setlogfile__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlogfilter" data-tocid="api_setlogfilter"><a href="class_irtcengine.aspx#api_setlogfilter"><span class="- topic/ph ph">setLogFilter</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlogfilter__prototype" data-tocid="api_setlogfilter__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfilter__detailed_desc" data-tocid="api_setlogfilter__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfilter__parameters" data-tocid="api_setlogfilter__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfilter__return_values" data-tocid="api_setlogfilter__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setlogfilesize" data-tocid="api_setlogfilesize"><a href="class_irtcengine.aspx#api_setlogfilesize"><span class="- topic/ph ph">setLogFileSize</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setlogfilesize__prototype" data-tocid="api_setlogfilesize__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfilesize__detailed_desc" data-tocid="api_setlogfilesize__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfilesize__parameters" data-tocid="api_setlogfilesize__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setlogfilesize__return_values" data-tocid="api_setlogfilesize__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_uploadlogfile" data-tocid="api_uploadlogfile"><a href="class_irtcengine.aspx#api_uploadlogfile"><span class="- topic/ph ph">uploadLogFile</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_uploadlogfile__prototype" data-tocid="api_uploadlogfile__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_uploadlogfile__detailed_desc" data-tocid="api_uploadlogfile__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_uploadlogfile__parameters" data-tocid="api_uploadlogfile__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_uploadlogfile__return_values" data-tocid="api_uploadlogfile__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getcallid" data-tocid="api_getcallid"><a href="class_irtcengine.aspx#api_getcallid"><span class="- topic/ph ph">getCallId</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getcallid__prototype" data-tocid="api_getcallid__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getcallid__detailed_desc" data-tocid="api_getcallid__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getcallid__parameters" data-tocid="api_getcallid__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getcallid__return_values" data-tocid="api_getcallid__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_rate" data-tocid="api_rate"><a href="class_irtcengine.aspx#api_rate"><span class="- topic/ph ph">rate</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_rate__prototype" data-tocid="api_rate__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_rate__detailed_desc" data-tocid="api_rate__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_rate__parameters" data-tocid="api_rate__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_rate__return_values" data-tocid="api_rate__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_complain" data-tocid="api_complain"><a href="class_irtcengine.aspx#api_complain"><span class="- topic/ph ph">complain</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_complain__prototype" data-tocid="api_complain__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_complain__detailed_desc" data-tocid="api_complain__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_complain__parameters" data-tocid="api_complain__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_complain__return_values" data-tocid="api_complain__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_getversion" data-tocid="api_getversion"><a href="class_irtcengine.aspx#api_getversion"><span class="- topic/ph ph">getVersion</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getversion__prototype" data-tocid="api_getversion__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getversion__parameters" data-tocid="api_getversion__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getversion__return_values" data-tocid="api_getversion__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_geterrordescription" data-tocid="api_geterrordescription"><a href="class_irtcengine.aspx#api_geterrordescription"><span class="- topic/ph ph">getErrorDescription</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_geterrordescription__prototype" data-tocid="api_geterrordescription__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_geterrordescription__parameters" data-tocid="api_geterrordescription__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_geterrordescription__return_values" data-tocid="api_geterrordescription__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_queryinterface" data-tocid="api_queryinterface"><span class="- topic/ph ph">queryInterface</span></a><ul><li class="section-item"><div class="section-title"><a href="#api_queryinterface__prototype" data-tocid="api_queryinterface__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_queryinterface__parameters" data-tocid="api_queryinterface__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_queryinterface__return_values" data-tocid="api_queryinterface__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_setcloudproxy" data-tocid="api_setcloudproxy"><a href="class_irtcengine.aspx#api_setcloudproxy"><span class="- topic/ph ph">setCloudProxy</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_setcloudproxy__prototype" data-tocid="api_setcloudproxy__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setcloudproxy__detailed_desc" data-tocid="api_setcloudproxy__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setcloudproxy__parameters" data-tocid="api_setcloudproxy__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_setcloudproxy__return_values" data-tocid="api_setcloudproxy__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_enabledeeplearningdenoise" data-tocid="api_enabledeeplearningdenoise"><a href="class_irtcengine.aspx#api_enabledeeplearningdenoise"><span class="- topic/ph ph">enableDeepLearningDenoise</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_enabledeeplearningdenoise__prototype" data-tocid="api_enabledeeplearningdenoise__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enabledeeplearningdenoise__detailed_desc" data-tocid="api_enabledeeplearningdenoise__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enabledeeplearningdenoise__parameters" data-tocid="api_enabledeeplearningdenoise__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_enabledeeplearningdenoise__return_values" data-tocid="api_enabledeeplearningdenoise__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_sendcustomreportmessage" data-tocid="api_sendcustomreportmessage"><a href="class_irtcengine.aspx#api_sendcustomreportmessage"><span class="- topic/ph ph">sendCustomReportMessage</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_sendcustomreportmessage__prototype" data-tocid="api_sendcustomreportmessage__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_sendcustomreportmessage__detailed_desc" data-tocid="api_sendcustomreportmessage__detailed_desc">详细描述</a></div></li></ul></li></ul></div>
      </nav>
  
       </div>
   </div>
        </div> 
        <footer class="navbar navbar-default wh_footer" whc:version="23.0">
  <div class=" footer-container mx-auto ">
    
   Generated by <a class="oxyFooter" href="http://www.oxygenxml.com/xml_webhelp.html" target="_blank">
   &lt;oXygen/&gt; XML WebHelp
   </a>
        
  </div>
</footer>
        
        <div id="go2top" class="d-print-none">
   <span class="oxy-icon oxy-icon-up"></span>
        </div>
        
        <!-- The modal container for images -->
        <div id="modal_img_large" class="modal">
   <span class="close oxy-icon oxy-icon-remove"></span>
   <!-- Modal Content (The Image) -->
   <img class="modal-content" id="modal-img" alt="" />
   <!-- Modal Caption (Image Text) -->
   <div id="caption"></div>
        </div>
        
        
    </body>
</html>