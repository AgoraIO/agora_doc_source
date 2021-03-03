
<!DOCTYPE html
  SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:whc="http://www.oxygenxml.com/webhelp/components" xml:lang="zh-cn" lang="zh-cn" whc:version="22.0">
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta charset="UTF-8" /><meta name="copyright" content="(C) 版权 2021" /><meta name="DC.rights.owner" content="(C) 版权 2021" /><meta name="DC.type" content="reference" /><meta name="description" content="IRtcEngineEventHandler 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK 的事件通知。" /><meta name="DC.subject" content="IRtcEngineEventHandler, onConnectionStateChanged, onJoinChannelSuccess, onRejoinChannelSuccess, onLeaveChannel, onClientRoleChanged, onUserJoined, onUserOffline, onNetworkTypeChanged, onConnectionInterrupted, onConnectionLost, onConnectionBanned, onTokenPrivilegeWillExpire, onRequestToken, onLocalAudioStateChanged, onFirstLocalAudioFrame, onLocalVideoStateChanged, onVideoStopped, onFirstLocalAudioFramePublished, onFirstLocalVideoFramePublished, onFirstLocalVideoFrame, onAudioPublishStateChanged, onVideoPublishStateChanged, onRemoteAudioStateChanged, onRemoteVideoStateChanged, onFirstRemoteAudioFrame, onFirstRemoteAudioDecoded, onFirstRemoteVideoFrame, onFirstRemoteVideoDecoded, onAudioSubscribeStateChanged, onVideoSubscribeStateChanged, onUserMuteAudio, onUserMuteVideo, onUserEnableVideo, onUserEnableLocalVideo, onVideoSizeChanged, onRtcStats, onNetworkQuality, onLocalAudioStats, onLocalVideoStats, onRemoteAudioStats, onRemoteAudioTransportStats, onRemoteVideoStats, onRemoteVideoTransportStats, onAudioQuality, onAudioMixingStateChanged, onAudioMixingFinished, onAudioEffectFinished, onRtmpStreamingStateChanged, onRtmpStreamingEvent, onTranscodingUpdated, onStreamPublished, onStreamUnpublished, onChannelMediaRelayStateChanged, onChannelMediaRelayEvent, onAudioVolumeIndication, onActiveSpeaker, onFacePositionChanged, onAudioRouteChanged, onLocalPublishFallbackToAudioOnly, onRemoteSubscribeFallbackToAudioOnly, onLastmileQuality, onLastmileProbeResult, onStreamInjectedStatus, onCameraFocusAreaChanged, onCameraExposureAreaChanged, onCameraReady, onAudioDeviceStateChanged, onAudioDeviceVolumeChanged, onVideoDeviceStateChanged, onStreamMessage, onStreamMessageError, onUploadLogFile, onWarning, onError, onApiCallExecuted, onMediaEngineLoadSuccess, onMediaEngineStartCallSuccess" /><meta name="keywords" content="IRtcEngineEventHandler, onConnectionStateChanged, onJoinChannelSuccess, onRejoinChannelSuccess, onLeaveChannel, onClientRoleChanged, onUserJoined, onUserOffline, onNetworkTypeChanged, onConnectionInterrupted, onConnectionLost, onConnectionBanned, onTokenPrivilegeWillExpire, onRequestToken, onLocalAudioStateChanged, onFirstLocalAudioFrame, onLocalVideoStateChanged, onVideoStopped, onFirstLocalAudioFramePublished, onFirstLocalVideoFramePublished, onFirstLocalVideoFrame, onAudioPublishStateChanged, onVideoPublishStateChanged, onRemoteAudioStateChanged, onRemoteVideoStateChanged, onFirstRemoteAudioFrame, onFirstRemoteAudioDecoded, onFirstRemoteVideoFrame, onFirstRemoteVideoDecoded, onAudioSubscribeStateChanged, onVideoSubscribeStateChanged, onUserMuteAudio, onUserMuteVideo, onUserEnableVideo, onUserEnableLocalVideo, onVideoSizeChanged, onRtcStats, onNetworkQuality, onLocalAudioStats, onLocalVideoStats, onRemoteAudioStats, onRemoteAudioTransportStats, onRemoteVideoStats, onRemoteVideoTransportStats, onAudioQuality, onAudioMixingStateChanged, onAudioMixingFinished, onAudioEffectFinished, onRtmpStreamingStateChanged, onRtmpStreamingEvent, onTranscodingUpdated, onStreamPublished, onStreamUnpublished, onChannelMediaRelayStateChanged, onChannelMediaRelayEvent, onAudioVolumeIndication, onActiveSpeaker, onFacePositionChanged, onAudioRouteChanged, onLocalPublishFallbackToAudioOnly, onRemoteSubscribeFallbackToAudioOnly, onLastmileQuality, onLastmileProbeResult, onStreamInjectedStatus, onCameraFocusAreaChanged, onCameraExposureAreaChanged, onCameraReady, onAudioDeviceStateChanged, onAudioDeviceVolumeChanged, onVideoDeviceStateChanged, onStreamMessage, onStreamMessageError, onUploadLogFile, onWarning, onError, onApiCallExecuted, onMediaEngineLoadSuccess, onMediaEngineStartCallSuccess" /><meta name="indexterms" content="onConnectionStateChanged, onJoinChannelSuccess, onRejoinChannelSuccess, onLeaveChannel, onUserOffline, onNetworkTypeChanged, onConnectionInterrupted, onConnectionLost, onConnectionBanned, onTokenPrivilegeWillExpire, onRequestToken, onLocalAudioStateChanged, onFirstLocalAudioFrame, onLocalVideoStateChanged, onVideoStopped, onFirstLocalAudioFramePublished, onFirstLocalVideoFramePublished, onFirstLocalVideoFrame, onAudioPublishStateChanged, onVideoPublishStateChanged, onRemoteAudioStateChanged, onRemoteVideoStateChanged, onFirstRemoteAudioFrame, onFirstRemoteAudioDecoded, onFirstRemoteVideoFrame, onFirstRemoteVideoDecoded, onAudioSubscribeStateChanged, onVideoSubscribeStateChanged, onUserMuteAudio, onUserMuteVideo, onUserEnableVideo, onUserEnableLocalVideo, onVideoSizeChanged, onRtcStats, onNetworkQuality, onLocalAudioStats, onLocalVideoStats, onRemoteAudioStats, onRemoteAudioTransportStats, onRemoteVideoStats, onRemoteVideoTransportStats, onAudioQuality, onAudioMixingStateChanged, onAudioMixingFinished, onAudioEffectFinished, onRtmpStreamingStateChanged, onRtmpStreamingEvent, onTranscodingUpdated, onStreamPublished, onStreamUnpublished, onChannelMediaRelayStateChanged, onChannelMediaRelayEvent, onAudioVolumeIndication, onActiveSpeaker, onFacePositionChanged, onAudioRouteChanged, onLocalPublishFallbackToAudioOnly, onRemoteSubscribeFallbackToAudioOnly, onLastmileQuality, onLastmileProbeResult, onStreamInjectedStatus, onCameraFocusAreaChanged, onCameraExposureAreaChanged, onCameraReady, onAudioDeviceStateChanged, onAudioDeviceVolumeChanged, onVideoDeviceStateChanged, onStreamMessage, onStreamMessageError, onUploadLogFile, onWarning, onError, onApiCallExecuted, onMediaEngineLoadSuccess, onMediaEngineStartCallSuccess" /><meta name="DC.format" content="HTML5" /><meta name="DC.identifier" content="class_rtcengineeventhandler" />        
      <title>IRtcEngineEventHandler</title><!--  Generated with Oxygen version 23.0, build number 2020121702.  --><meta name="wh-path2root" content="../" /><meta name="wh-toc-id" content="class_rtcengineeventhandler-d4991e17857" /><meta name="wh-source-relpath" content="API/class_irtcengineeventhandler.dita" /><meta name="wh-out-relpath" content="API/class_irtcengineeventhandler.aspx" />
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
  <div data-tooltip-position="bottom" class=" wh_breadcrumb "><ol xmlns:html="http://www.w3.org/1999/xhtml" class="d-print-none"><li><span class="home"><a href="../index.aspx"><span>主页</span></a></span></li><li><span class="topicref"><span class="title"><a href="../API/rtc_api_overview.aspx">C++ API Reference for All Platforms</a></span></span></li><li class="active"><span class="topicref" data-id="class_rtcengineeventhandler"><span class="title"><a href="../API/class_irtcengineeventhandler.aspx#class_rtcengineeventhandler"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengineeventhandler.html#class_rtcengineeventhandler"><span class="ph">IRtcEngineEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IRtcEngineEventHandler</span> 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK的事件通知。</span></p></span></span></span></li></ol></div>

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
 <div class=" wh_publication_toc " data-tooltip-position="right"><ul role="tree" aria-label="Table of Contents"><span class="expand-button-action-labels"><span id="button-expand-action" aria-label="Expand"></span><span id="button-collapse-action" aria-label="Collapse"></span><span id="button-pending-action" aria-label="Pending"></span></span><li role="treeitem" aria-expanded="true"><span data-tocid="tocId-d4991e13735" class="topicref" data-state="expanded"><span role="button" tabindex="0" aria-labelledby="button-collapse-action tocId-d4991e13735-link" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="tocId-d4991e13735-link">C++ API Reference for All Platforms</a></span></span><ul role="group" class="navbar-nav nav-list"><li role="treeitem"><span data-tocid="api-title-d4991e13736" class="topicref" data-id="api-title" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="api-title-d4991e13736-link">API Overview</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">声网通过全球部署的虚拟网络，提供可以灵活搭配的 API 组合，提供质量可靠的实时音视频通信。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_rtcengine-d4991e13748" class="topicref" data-id="class_rtcengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengine.aspx#class_rtcengine" id="class_rtcengine-d4991e13748-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengine.html#class_rtcengine"><span class="ph">IRtcEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichannel-d4991e15906" class="topicref" data-id="class_ichannel" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichannel.aspx#class_ichannel" id="class_ichannel-d4991e15906-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichannel.html#class_ichannel"><span class="ph">IChannel</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">调用 <a href="../API/class_irtcengine.html#api_createChannel" class="xref"><span class="keyword">createChannel</span></a> 创建一个 <span class="keyword apiname">IChannel</span> 对象。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichanneleventhandler-d4991e16473" class="topicref" data-id="class_ichanneleventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichanneleventhandler.aspx#class_ichanneleventhandler" id="class_ichanneleventhandler-d4991e16473-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichanneleventhandler.html#class_ichanneleventhandler"><span class="ph">IChannelEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IChannelEventHandler</span> 接口类用于 SDK 向 app 发送 <a href="../API/class_ichannel.html#class_ichannel" class="xref"><span class="keyword">IChannel</span></a> 频道的回调事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imediaengine-d4991e16949" class="topicref" data-id="class_imediaengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imediaengine.aspx#class_imediaengine" id="class_imediaengine-d4991e16949-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imediaengine.html#class_imediaengine"><span class="ph">IMediaEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IMediaEngine</span> 类。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ipacketobserver-d4991e17061" class="topicref" data-id="class_ipacketobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ipacketobserver.aspx#class_ipacketobserver" id="class_ipacketobserver-d4991e17061-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ipacketobserver.html#class_ipacketobserver"><span class="ph">IPacketObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IPacketObserver 定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicemanager-d4991e17126" class="topicref" data-id="class_iaudiodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicemanager.aspx#class_iaudiodevicemanager" id="class_iaudiodevicemanager-d4991e17126-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicemanager.html#class_iaudiodevicemanager"><span class="ph">IAudioDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">音频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicecollection-d4991e17443" class="topicref" data-id="class_iaudiodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicecollection.aspx#class_iaudiodevicecollection" id="class_iaudiodevicecollection-d4991e17443-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicecollection.html#class_iaudiodevicecollection"><span class="ph">IAudioDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IAudioDeviceCollection 类。你可以通过该接口类获取音频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideosource-d4991e17560" class="topicref" data-id="class_ivideosource" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideosource.aspx#class_ivideosource" id="class_ivideosource-d4991e17560-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideosource.html#class_ivideosource"><span class="ph">IVideoSource</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoSource 类，可以设置自定义的视频源。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeconsumer-d4991e17664" class="topicref" data-id="class_ivideoframeconsumer" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeconsumer.aspx#class_ivideoframeconsumer" id="class_ivideoframeconsumer-d4991e17664-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeconsumer.html#class_ivideoframeconsumer"><span class="ph">IVideoFrameConsumer</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IVideoFrameConsumer</span> 类，用于让 SDK 接收你采集的视频帧。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicemanager-d4991e17692" class="topicref" data-id="class_ivideodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicemanager.aspx#class_ivideodevicemanager" id="class_ivideodevicemanager-d4991e17692-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicemanager.html#class_ivideodevicemanager"><span class="ph">IVideoDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicecollection-d4991e17788" class="topicref" data-id="class_ivideodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicecollection.aspx#class_ivideodevicecollection" id="class_ivideodevicecollection-d4991e17788-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicecollection.html#class_ivideodevicecollection"><span class="ph">IVideoDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoDeviceCollection 类。你可以通过该接口类获取视频设备相关的信息。</span></p></span></span></span></li><li role="treeitem" class="active"><span data-tocid="class_rtcengineeventhandler-d4991e17857" class="topicref" data-id="class_rtcengineeventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengineeventhandler.aspx#class_rtcengineeventhandler" id="class_rtcengineeventhandler-d4991e17857-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengineeventhandler.html#class_rtcengineeventhandler"><span class="ph">IRtcEngineEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IRtcEngineEventHandler</span> 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK的事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudioframeobserver-d4991e18897" class="topicref" data-id="class_iaudioframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudioframeobserver.aspx#class_iaudioframeobserver" id="class_iaudioframeobserver-d4991e18897-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudioframeobserver.html#class_iaudioframeobserver"><span class="ph">IAudioFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">语音观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeobserver-d4991e19014" class="topicref" data-id="class_ivideoframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeobserver.aspx#class_ivideoframeobserver" id="class_ivideoframeobserver-d4991e19014-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeobserver.html#class_ivideoframeobserver"><span class="ph">IVideoFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imetadataobserver-d4991e19199" class="topicref" data-id="class_imetadataobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imetadataobserver.aspx#class_imetadataobserver" id="class_imetadataobserver-d4991e19199-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imetadataobserver.html#class_imetadataobserver"><span class="ph">IMetadataObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Metadata 观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="datatype-d4991e19289" class="topicref" data-id="datatype" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_data_type.aspx#datatype" id="datatype-d4991e19289-link">类型定义</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">本页列出 <span class="ph">Windows</span> API 所有的类型定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="错误码和警告码-d4991e20757" class="topicref" data-id="错误码和警告码" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/error_rtc.aspx" id="错误码和警告码-d4991e20757-link">错误码和警告码</a></span></span></li></ul></li></ul></div>
      </nav>
  
  
  <div class="col-lg-7 col-md-9 col-sm-12" id="wh_topic_body">
      <div class=" wh_topic_content body "><main role="main"><article role="article" aria-labelledby="ariaid-title1"><article class="nested0" aria-labelledby="ariaid-title1" id="class_rtcengineeventhandler">
    <h1 class="- topic/title title topictitle1" id="ariaid-title1"><a href="class_irtcengineeventhandler.aspx#class_rtcengineeventhandler"><span class="- topic/ph ph">IRtcEngineEventHandler</span></a></h1>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_rtcengineeventhandler__shortdesc"><span class="+ topic/keyword pr-d/apiname keyword apiname">IRtcEngineEventHandler</span> 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK
        的事件通知。</span></p><section class="- topic/section section"><p class="- topic/p p">接口类的所有方法都有缺省（空）实现， app 可以根据需要只继承关心的事件。在回调方法中，app 不应该做耗时或者调用可能会引起阻塞的 API（如
   sendMessage），否则可能影响 SDK 的运行。</p></section></div>
<article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title2" id="api_onconnectionstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title2"><a href="class_irtcengineeventhandler.aspx#api_onconnectionstatechanged"><span class="- topic/ph ph">onConnectionStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onconnectionstatechanged__shortdesc">网络连接状态已改变回调。</span></p><section class="- topic/section section" id="api_onconnectionstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onConnectionStateChanged(
      CONNECTION_STATE_TYPE state, CONNECTION_CHANGED_REASON_TYPE reason) {
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)reason;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onconnectionstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.3.2</dd>
       
   </dl>
   <p class="- topic/p p" id="api_onconnectionstatechanged__desc" data-ofbid="api_onconnectionstatechanged__desc">该回调在网络连接状态发生改变的时候触发，并告知用户当前的网络连接状态和引起网络状态改变的原因。</p>
        </section>
        <section class="- topic/section section" id="api_onconnectionstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onconnectionstatechanged__state">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前网络连接状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_connectionstatetype" title="网络连接状态。"><span class="- topic/keyword keyword">CONNECTION_STATE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onconnectionstatechanged__reason">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">引起当前网络连接状态改变的原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_connectionchangedreasontype" title="网络连接状态发生变化的原因。"><span class="- topic/keyword keyword">CONNECTION_CHANGED_REASON_TYPE</span></a>。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title3" id="api_onjoinchannelsuccess">
    <h2 class="- topic/title title topictitle2" id="ariaid-title3"><a href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess"><span class="- topic/ph ph">onJoinChannelSuccess</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onjoinchannelsuccess__shortdesc">成功加入频道回调。</span></p><section class="- topic/section section" id="api_onjoinchannelsuccess__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onJoinChannelSuccess(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channel, uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)channel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onjoinchannelsuccess__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_onjoinchannelsuccess__desc" data-ofbid="api_onjoinchannelsuccess__desc">该回调方法表示该客户端成功加入了指定的频道。</p>
        </section>
        <section class="- topic/section section" id="api_onjoinchannelsuccess__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道名。该参数基于调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span>加入频道时指定的频道名分配。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。该参数基于调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 加入频道时指定的用户 ID 分配；如果加入频道时未指定用户 ID，则 Agora 服务器会自动分配一个 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 开始到发生此事件过去的时间（毫秒）。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title4" id="api_onrejoinchannelsuccess">
    <h2 class="- topic/title title topictitle2" id="ariaid-title4"><a href="class_irtcengineeventhandler.aspx#api_onrejoinchannelsuccess"><span class="- topic/ph ph">onRejoinChannelSuccess</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onrejoinchannelsuccess__shortdesc">成功重新加入频道回调。</span></p><section class="- topic/section section" id="api_onrejoinchannelsuccess__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRejoinChannelSuccess(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channel, uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)channel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onrejoinchannelsuccess__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">有时候由于网络原因，客户端可能会和服务器失去连接，SDK 会进行自动重连，自动重连成功后触发此回调方法。</p>
        </section>
        <section class="- topic/section section" id="api_onrejoinchannelsuccess__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道名。该参数基于调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span>加入频道时指定的频道名分配。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrejoinchannelsuccess__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。该参数基于调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 加入频道时指定的用户 ID 分配；如果加入频道时未指定用户 ID，则 Agora 服务器会自动分配一个 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrejoinchannelsuccess__elapsed">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地开始重连到发生此事件过去的时间（毫秒）。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title5" id="api_onleavechannel">
    <h2 class="- topic/title title topictitle2" id="ariaid-title5"><a href="class_irtcengineeventhandler.aspx#api_onleavechannel"><span class="- topic/ph ph">onLeaveChannel</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onleavechannel__shortdesc">离开频道回调。</span></p><section class="- topic/section section" id="api_onleavechannel__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLeaveChannel(<strong class="hl-keyword">const</strong> RtcStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_onleavechannel__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">App 调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 方法时，SDK 提示 App 离开频道成功。在该回调方法中，App 可以得到此次通话的总通话时长、SDK 收发数据的流量等信息。App 通过该回调获取通话时长以及 SDK 接收到或发送的数据统计信息。</p>
        </section>
        <section class="- topic/section section" id="api_onleavechannel__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onleavechannel__stats">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">通话的统计数据: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rtcstats" title="通话相关的统计信息。"><span class="- topic/keyword keyword">RtcStats</span></a>。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title6" id="api_onclientrolechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title6"><a href="class_irtcengineeventhandler.aspx#api_onclientrolechanged"><span class="- topic/ph ph">onClientRoleChanged</span></a></h2>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onclientrolechanged__shortdesc">直播场景下用户角色已切换回调。</span></p>
        <section class="- topic/section section" id="api_onclientrolechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">
      
      
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onClientRoleChanged(CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole) {
    }</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_onclientrolechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p" id="api_onclientrolechanged__desc" data-ofbid="api_onclientrolechanged__desc">直播场景下，当用户切换角色时会触发此回调，即主播切换为观众时，或观众切换为主播时。</p>
   <p class="- topic/p p">该回调是由本地用户在加入频道后调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setclientrole1" title="设置直播场景下的用户角色。"><span class="- topic/keyword keyword">setClientRole</span></a> 改变用户角色触发的。</p>
        </section>
    <section class="- topic/section section" id="api_onclientrolechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
        
        <dl class="+ topic/dl pr-d/parml dl parml">
   
       <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onclientrolechanged__oldRole">oldRole</dt>
       <dd class="+ topic/dd pr-d/pd dd pd">切换前的角色: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_clientroletype" title="直播场景里的用户角色。"><span class="- topic/keyword keyword">CLIENT_ROLE_TYPE</span></a>。</dd>
   
   
       <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onclientrolechanged__newRole">newRole</dt>
       <dd class="+ topic/dd pr-d/pd dd pd">切换后的角色: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_clientroletype" title="直播场景里的用户角色。"><span class="- topic/keyword keyword">CLIENT_ROLE_TYPE</span></a>。</dd>
   
        </dl>
    </section>
    </div>
<nav role="navigation" class="- topic/related-links related-links"><div class="- topic/linklist linklist relref"><strong>相关参考</strong><ul class="linklist related_link"><li class="linklist"><a class="navheader_parent_path" href="../API/class_irtcengine.aspx#api_setclientrole1" title="设置直播场景下的用户角色。">setClientRole[1/2]</a></li></ul></div></nav></article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title7" id="api_onuserjoined">
    <h2 class="- topic/title title topictitle2" id="ariaid-title7"><a href="class_irtcengineeventhandler.aspx#api_onuserjoined"><span class="- topic/ph ph">onUserJoined</span></a></h2>
        
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onuserjoined__shortdesc">远端用户（通信场景）/主播（直播场景）加入当前频道回调。</span></p>
   <section class="- topic/section section" id="api_onuserjoined__prototype">
  <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock"><code>virtual void onUserJoined(uid_t uid, int elapsed) {
        (void)uid;
        (void)elapsed;
    }</code></pre>
  </div>
   </section>
   <section class="- topic/section section" id="api_onuserjoined__detailed_desc">
  <ul class="- topic/ul ul" id="api_onuserjoined__detailed_desc_scene">
   <li class="- topic/li li">通信场景下，该回调提示有远端用户加入了频道，并返回新加入用户的
  ID；如果加入之前，已经有其他用户在频道中了，新加入的用户也会收到这些已有用户加入频道的回调。</li>
   <li class="- topic/li li">直播场景下，该回调提示有主播加入了频道，并返回该主播的用户 ID。如果在加入之前，已经有主播在频道中了，新加入的用户也会收到已有主播加入频道的回调。Agora
  建议连麦主播不超过 17 人。</li>
        </ul>
  <p class="- topic/p p">该回调在如下情况下会被触发：</p>
  <ul class="- topic/ul ul">
   <li class="- topic/li li">远端用户/主播调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法加入频道。</li>
   <li class="- topic/li li">远端用户加入频道后调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setClientRole</span> 将用户角色改变为主播。</li>
   <li class="- topic/li li">远端用户/主播网络中断后重新加入频道。</li>
   <li class="- topic/li li">主播通过调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">addInjectStreamUrl</span> 方法成功输入在线媒体流。</li>
        </ul>
      <div class="- topic/note note note note_note" id="api_onuserjoined__note"><span class="note__title">注：</span> 
     <p class="- topic/p p">直播场景下，</p>
     <ul class="- topic/ul ul">
    <li class="- topic/li li">主播间能相互收到新主播加入频道的回调，并能获得该主播的 uid。</li>
    <li class="- topic/li li">观众也能收到新主播加入频道的回调，并能获得该主播的 uid。</li>
    <li class="- topic/li li">当 Web 端加入直播频道时，只要 Web 端有推流，SDK 会默认该 Web 端为主播，并触发该回调。</li>
     </ul>
      </div>
   </section>
   <section class="- topic/section section" id="api_onuserjoined__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
  
  <dl class="+ topic/dl pr-d/parml dl parml">
 
<dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onuserjoined__uid">uid</dt>
<dd class="+ topic/dd pr-d/pd dd pd">新加入频道的远端用户/主播 ID。</dd>
 
 
<dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
<dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 到该回调触发的延迟（毫秒)。</dd>
 
  </dl>
   </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title8" id="api_onuseroffline">
    <h2 class="- topic/title title topictitle2" id="ariaid-title8"><a href="class_irtcengineeventhandler.aspx#api_onuseroffline"><span class="- topic/ph ph">onUserOffline</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onuseroffline__shortdesc">远端用户（通信场景）/主播（直播场景）离开当前频道回调。</span></p><section class="- topic/section section" id="api_onuseroffline__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)reason;
    }</pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_onuseroffline__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">提示有远端用户/主播离开了频道（或掉线）。用户离开频道有两个原因，即正常离开和超时掉线：<ul class="- topic/ul ul">
  <li class="- topic/li li">正常离开的时候，远端用户/主播会发送类似“再见”的消息。接收此消息后，判断用户离开频道。</li>
  <li class="- topic/li li">超时掉线的依据是，在一定时间内（通信场景为 20
      秒，直播场景稍有延时），用户没有收到对方的任何数据包，则判定为对方掉线。在网络较差的情况下，有可能会误报。我们建议使用 Agora 实时消息 SDK
      来做可靠的掉线检测。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onuseroffline__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onuseroffline__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">离线用户或主播的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onuseroffline__reason">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">离线原因: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_userofflinereasontype" title="用户离线原因。"><span class="- topic/keyword keyword">USER_OFFLINE_REASON_TYPE</span></a>。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title9" id="api_onnetworktypechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title9"><a href="class_irtcengineeventhandler.aspx#api_onnetworktypechanged"><span class="- topic/ph ph">onNetworkTypeChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onnetworktypechanged__shortdesc">本地网络类型发生改变回调。</span></p><section class="- topic/section section" id="api_onnetworktypechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onNetworkTypeChanged(NETWORK_TYPE type) {
        (<strong class="hl-keyword">void</strong>)type;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onnetworktypechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.1</dd>
       
   </dl>
   <p class="- topic/p p">本地网络连接类型发生改变时，SDK 会触发该回调，并在回调中明确当前的网络连接类型。 你可以通过该回调获取正在使用的网络类型；当连接中断时，该回调能辨别引起中断的原因是网络切换还是网络条件不好。</p>
        </section>
        <section class="- topic/section section" id="api_onnetworktypechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">type</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地网络连接类型。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_networktype" title="网络连接类型。"><span class="- topic/keyword keyword">NETWORK_TYPE</span></a></dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title10" id="api_onconnectioninterrupted">
    <h2 class="- topic/title title topictitle2" id="ariaid-title10"><a href="class_irtcengineeventhandler.aspx#api_onconnectioninterrupted"><span class="- topic/ph ph">onConnectionInterrupted</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onconnectioninterrupted__shortdesc">网络连接中断回调。</span></p><section class="- topic/section section" id="api_onconnectioninterrupted__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onConnectionInterrupted() {}</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onconnectioninterrupted__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用:</dt>
  <dd class="- topic/dd dd">该方法从 v2.3.2 起废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onconnectionstatechanged" title="网络连接状态已改变回调。"><span class="- topic/keyword keyword">onConnectionStateChanged</span></a> 回调。</dd>
       
   </dl>
   <div class="- topic/p p">SDK 在和服务器建立连接后，失去了网络连接超过 4 秒，会触发该回调。在触发事件后，SDK 会主动重连服务器，所以该事件可以用于 UI 提示。该回调与 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onconnectionlost" title="网络连接中断，且 SDK 无法在 10 秒内连接服务器回调。"><span class="- topic/keyword keyword">onConnectionLost</span></a> 的区别是：
   <ul class="- topic/ul ul">
       <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">onConnectionInterrupted</span> 回调一定是发生在成功加入频道后，且 SDK 刚失去和服务器连接超过 4 秒时触发。</li>
       <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">onConnectionLost</span> 回调是无论是否成功加入频道，只要 10 秒内和服务器无法建立连接都会触发。</li>
   </ul>
   如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，SDK 会停止尝试重连。</div>
        </section>
        </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title11" id="api_onconnectionlost">
    <h2 class="- topic/title title topictitle2" id="ariaid-title11"><a href="class_irtcengineeventhandler.aspx#api_onconnectionlost"><span class="- topic/ph ph">onConnectionLost</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onconnectionlost__shortdesc">网络连接中断，且 SDK 无法在 10 秒内连接服务器回调。</span></p><section class="- topic/section section" id="api_onconnectionlost__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onConnectionLost() {}</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onconnectionlost__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">SDK 在调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 后，无论是否加入成功，只要 10 秒和服务器无法连接就会触发该回调。</p>
        </section>
        </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title12" id="api_onconnectionbanned">
    <h2 class="- topic/title title topictitle2" id="ariaid-title12"><a href="class_irtcengineeventhandler.aspx#api_onconnectionbanned"><span class="- topic/ph ph">onConnectionBanned</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onconnectionbanned__shortdesc">网络连接已被服务器禁止回调。</span></p><section class="- topic/section section" id="api_onconnectionbanned__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onConnectionBanned() {}</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onconnectionbanned__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用: </dt>
  <dd class="- topic/dd dd">该方法从 v2.3.2 起废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onconnectionstatechanged" title="网络连接状态已改变回调。"><span class="- topic/keyword keyword">onConnectionStateChanged</span></a>。</dd>
       
   </dl>
   <p class="- topic/p p">当你被服务端禁掉连接的权限时，会触发该回调。</p>
        </section>
        </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title13" id="api_ontokenprivilegewillexpire">
    <h2 class="- topic/title title topictitle2" id="ariaid-title13"><a href="class_irtcengineeventhandler.aspx#api_ontokenprivilegewillexpire"><span class="- topic/ph ph">onTokenPrivilegeWillExpire</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ontokenprivilegewillexpire__shortdesc">Token 服务即将过期回调。</span></p><section class="- topic/section section" id="api_ontokenprivilegewillexpire__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onTokenPrivilegeWillExpire(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token) {
        (<strong class="hl-keyword">void</strong>)token;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ontokenprivilegewillexpire__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">在调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 时如果指定了 Token，由于 Token 具有一定的时效性，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发该回调，提醒 App 更新 Token。</p>
   <p class="- topic/p p">当收到该回调时，你需要重新在服务端生成新的 Token，然后调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_renewtoken" title="更新 Token。"><span class="- topic/keyword keyword">renewToken</span></a> 将新生成的 Token 传给 SDK。</p>
        </section>
        <section class="- topic/section section" id="api_ontokenprivilegewillexpire__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_ontokenprivilegewillexpire__token">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">即将服务失效的 Token。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title14" id="api_onrequesttoken">
    <h2 class="- topic/title title topictitle2" id="ariaid-title14"><a href="class_irtcengineeventhandler.aspx#api_onrequesttoken"><span class="- topic/ph ph">onRequestToken</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onrequesttoken__shortdesc">Token 过期回调</span></p><section class="- topic/section section" id="api_onrequesttoken__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRequestToken() {
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onrequesttoken__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">在调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 时如果指定了 Token，由于 Token 具有一定的时效性，在通话过程中如果 Token 已失效，SDK 会触发该回调，提醒 App 更新 Token。</p>
   <p class="- topic/p p">当收到该回调时，你需要重新在服务端生成新的 Token，然后调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_renewtoken" title="更新 Token。"><span class="- topic/keyword keyword">renewToken</span></a> 将新生成的 Token 传给 SDK。</p>
        </section>
        </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title15" id="api_onlocalaudiostatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title15"><a href="class_irtcengineeventhandler.aspx#api_onlocalaudiostatechanged"><span class="- topic/ph ph">onLocalAudioStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlocalaudiostatechanged__shortdesc">本地音频状态发生改变回调。</span></p><section class="- topic/section section" id="api_onlocalaudiostatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLocalAudioStateChanged(LOCAL_AUDIO_STREAM_STATE state, LOCAL_AUDIO_STREAM_ERROR error) {
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)error;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlocalaudiostatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">本地音频的状态发生改变时（包括本地麦克风采集状态和音频编码状态）， SDK 会触发该回调报告当前的本地音频状态。在本地音频出现故障时， 该回调可以帮助你了解当前音频的状态以及出现故障的原因，方便你排查问题。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       当状态为 <span class="+ topic/keyword pr-d/apiname keyword apiname">LOCAL_AUDIO_STREAM_STATE_FAILED</span> (3) 时， 你可以在 <span class="+ topic/keyword pr-d/parmname keyword parmname">error</span> 参数中查看返回的错误信息。
   </div>
        </section>
        <section class="- topic/section section" id="api_onlocalaudiostatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的本地音频状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_localaudiostreamstate" title="本地音频状态。"><span class="- topic/keyword keyword">LOCAL_AUDIO_STREAM_STATE</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">error</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地音频出错原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_localaudiostreamerror" title="本地音频出错原因。"><span class="- topic/keyword keyword">LOCAL_AUDIO_STREAM_ERROR</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title16" id="api_onfirstlocalaudioframe">
    <h2 class="- topic/title title topictitle2" id="ariaid-title16"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalaudioframe"><span class="- topic/ph ph">onFirstLocalAudioFrame</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstlocalaudioframe__shortdesc">已发送本地音频首帧回调。</span></p><section class="- topic/section section" id="api_onfirstlocalaudioframe__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstLocalAudioFrame(<strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalaudioframe__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该回调自 v3.1.0 废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onfirstlocalaudioframepublished" title="已发布本地音频首帧回调。"><span class="- topic/keyword keyword">onFirstLocalAudioFramePublished</span></a> 回调。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalaudioframe__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法直至该回调被触发的时间。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title17" id="api_onlocalvideostatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title17"><a href="class_irtcengineeventhandler.aspx#api_onlocalvideostatechanged"><span class="- topic/ph ph">onLocalVideoStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlocalvideostatechanged__shortdesc">本地视频状态发生改变回调。</span></p><section class="- topic/section section" id="api_onlocalvideostatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE localVideoState, LOCAL_VIDEO_STREAM_ERROR error) {
        (<strong class="hl-keyword">void</strong>)localVideoState;
        (<strong class="hl-keyword">void</strong>)error;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlocalvideostatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">本地视频的状态发生改变时，SDK 会触发该回调返回当前的本地视频状态。你可以通过该回调了解当前视频的状态以及出现故障的原因，方便排查问题。</p>
   <div class="- topic/p p">SDK 会在如下情况触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onLocalVideoStateChanged</span><code class="+ topic/ph pr-d/codeph ph codeph">(LOCAL_VIDEO_STREAM_STATE_FAILED，LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE)</code> 回调：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">应用退到后台，系统回收摄像头。</li>
  <li class="- topic/li li">摄像头正常启动，但连续 4 秒都没有输出采集的视频。</li>
       </ul>
   </div>
   <p class="- topic/p p">摄像头输出采集的视频帧时，如果连续 15 帧中，所有视频帧都一样，SDK 触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onLocalVideoStateChanged</span><code class="+ topic/ph pr-d/codeph ph codeph">(LOCAL_VIDEO_STREAM_STATE_CAPTURING，LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE)</code> 回调。 注意：帧重复检测仅针对分辨率大于 200 × 200，帧率大于等于 10 fps，码率小于 20 Kbps 的视频帧。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       对某些机型而言，当本地视频采集设备正在使用中时，SDK 不会在本地视频状态发生改变时触发该回调，你需要自行做超时判断。
   </div>
        </section>
        <section class="- topic/section section" id="api_onlocalvideostatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">localVideoState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地视频状态，详见: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_localvideostreamstate" title="本地视频状态。"><span class="- topic/keyword keyword">LOCAL_VIDEO_STREAM_STATE</span></a> </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">error</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地视频出错原因，详见: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_localvideostreamerror" title="本地视频出错原因。"><span class="- topic/keyword keyword">LOCAL_VIDEO_STREAM_ERROR</span></a> </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title18" id="api_onvideostopped">
    <h2 class="- topic/title title topictitle2" id="ariaid-title18"><a href="class_irtcengineeventhandler.aspx#api_onvideostopped"><span class="- topic/ph ph">onVideoStopped</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onvideostopped__shortdesc">视频功能已停止回调。</span></p><section class="- topic/section section" id="api_onvideostopped__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoStopped() {}</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onvideostopped__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">从 v2.4.1 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlocalvideostatechanged" title="本地视频状态发生改变回调。"><span class="- topic/keyword keyword">onLocalVideoStateChanged</span></a> 回调中的 <span class="+ topic/keyword pr-d/apiname keyword apiname">LOCAL_VIDEO_STREAM_STATE_STOPPED</span>(0)。</dd>
       
   </dl>
   <p class="- topic/p p">提示视频功能已停止。 App 如需在停止视频后对 <span class="+ topic/keyword pr-d/parmname keyword parmname">view</span> 做其他处理（比如显示其他画面），可以在这个回调中进行。</p>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title19" id="api_onfirstlocalaudioframepublished">
    <h2 class="- topic/title title topictitle2" id="ariaid-title19"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalaudioframepublished"><span class="- topic/ph ph">onFirstLocalAudioFramePublished</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstlocalaudioframepublished__shortdesc">已发布本地音频首帧回调。</span></p><section class="- topic/section section" id="api_onfirstlocalaudioframepublished__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstLocalAudioFramePublished(<strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalaudioframepublished__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
   <div class="- topic/p p">SDK 会在以下三种时机触发该回调：
   <ul class="- topic/ul ul">
       <li class="- topic/li li">开启本地音频的情况下，调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 成功加入频道后。</li>
       <li class="- topic/li li">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a>(<span class="- topic/ph ph">true</span>)，再调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">muteLocalAudioStream</span>(<span class="- topic/ph ph">false</span>) 后。</li>
       <li class="- topic/li li">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disableaudio" title="关闭音频模块。"><span class="- topic/keyword keyword">disableAudio</span></a>，再调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enableaudio" title="启用音频模块。"><span class="- topic/keyword keyword">enableAudio</span></a> 后。</li>
   </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalaudioframepublished__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法到触发该回调的时间间隔（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title20" id="api_onfirstlocalvideoframepublished">
    <h2 class="- topic/title title topictitle2" id="ariaid-title20"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalvideoframepublished"><span class="- topic/ph ph">onFirstLocalVideoFramePublished</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstlocalvideoframepublished__shortdesc">已发布本地视频首帧回调。</span></p><section class="- topic/section section" id="api_onfirstlocalvideoframepublished__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstLocalVideoFramePublished(<strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalvideoframepublished__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
   <div class="- topic/p p">SDK 会在以下三种时机触发该回调：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">开启本地视频的情况下，调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 成功加入频道后。</li>
  <li class="- topic/li li">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalvideostream" title="开关本地视频发送。"><span class="- topic/keyword keyword">muteLocalVideoStream</span></a>(<span class="- topic/ph ph">true</span>)，再调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">muteLocalVideoStream</span>(<span class="- topic/ph ph">false</span>) 后。</li>
  <li class="- topic/li li">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablevideo" title="关闭视频模块。"><span class="- topic/keyword keyword">disableVideo</span></a>，再调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 后。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalvideoframepublished__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法到触发该回调的时间间隔（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title21" id="api_onfirstlocalvideoframe">
    <h2 class="- topic/title title topictitle2" id="ariaid-title21"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalvideoframe"><span class="- topic/ph ph">onFirstLocalVideoFrame</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstlocalvideoframe__shortdesc">已显示本地视频首帧回调。</span></p><section class="- topic/section section" id="api_onfirstlocalvideoframe__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstLocalVideoFrame(<strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalvideoframe__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">本地视频首帧显示在本地视图上时，SDK 会触发此回调。</p>
        </section>
        <section class="- topic/section section" id="api_onfirstlocalvideoframe__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地渲染视频的宽 (px) 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地渲染视频的高 (px)。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 到发生此事件过去的时间（毫秒）。如果在 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 前调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startpreview" title="开启视频预览。"><span class="- topic/keyword keyword">startPreview</span></a>，则是从 <span class="+ topic/keyword pr-d/apiname keyword apiname">startPreview</span> 到发生此事件过去的时间。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title22" id="api_onaudiopublishstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title22"><a href="class_irtcengineeventhandler.aspx#api_onaudiopublishstatechanged"><span class="- topic/ph ph">onAudioPublishStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiopublishstatechanged__shortdesc">音频发布状态改变回调。</span></p><section class="- topic/section section" id="api_onaudiopublishstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioPublishStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)channel;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiopublishstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onaudiopublishstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道名。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiopublishstatechanged__oldState">oldState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">之前的发布状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_streampublishstate" title="发布状态。"><span class="- topic/keyword keyword">STREAM_PUBLISH_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiopublishstatechanged__newState">newState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的发布状态，详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_PUBLISH_STATE</span>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiopublishstatechanged__elapseSinceLastState">elapseSinceLastState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">两次状态变化时间间隔（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title23" id="api_onvideopublishstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title23"><a href="class_irtcengineeventhandler.aspx#api_onvideopublishstatechanged"><span class="- topic/ph ph">onVideoPublishStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onvideopublishstatechanged__shortdesc">视频发布状态改变回调。</span></p>
        <section class="- topic/section section" id="api_onvideopublishstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoPublishStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)channel;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
    </section>
        <section class="- topic/section section" id="api_onvideopublishstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onvideopublishstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道名。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">oldState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">之前的发布状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_streampublishstate" title="发布状态。"><span class="- topic/keyword keyword">STREAM_PUBLISH_STATE</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">newState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的发布状态，详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_PUBLISH_STATE</span></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapseSinceLastState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">两次状态变化时间间隔（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title24" id="api_onremoteaudiostatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title24"><a href="class_irtcengineeventhandler.aspx#api_onremoteaudiostatechanged"><span class="- topic/ph ph">onRemoteAudioStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremoteaudiostatechanged__shortdesc">远端音频流状态发生改变回调。</span></p><section class="- topic/section section" id="api_onremoteaudiostatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteAudioStateChanged(uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)reason;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremoteaudiostatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">远端用户/主播音频状态发生改变时，SDK 会触发该回调向本地用户报告当前的远端音频流状态。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调不生效。
   </div>
        </section>
        <section class="- topic/section section" id="api_onremoteaudiostatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremoteaudiostatechanged__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生音频状态改变的远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremoteaudiostatechanged__state">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端音频流状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remoteaudiostate" title="远端音频流状态。"><span class="- topic/keyword keyword">REMOTE_AUDIO_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremoteaudiostatechanged__reason">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端音频流状态改变的具体原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remoteaudiostatereason" title="远端音频流状态切换原因。"><span class="- topic/keyword keyword">REMOTE_AUDIO_STATE_REASON</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法到发生本事件经历的时间，单位为 ms。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title25" id="api_onremotevideostatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title25"><a href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged"><span class="- topic/ph ph">onRemoteVideoStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremotevideostatechanged__shortdesc">远端视频状态发生改变回调。</span></p><section class="- topic/section section" id="api_onremotevideostatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteVideoStateChanged(uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)reason;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremotevideostatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调不生效。</div>
        </section>
        <section class="- topic/section section" id="api_onremotevideostatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremotevideostatechanged__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生视频状态改变的远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremotevideostatechanged__state">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频流状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remotevideostate" title="远端视频流状态。"><span class="- topic/keyword keyword">REMOTE_VIDEO_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremotevideostatechanged__reason">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频流状态改变的具体原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remotevideostatereason" title="远端视频流状态切换原因。"><span class="- topic/keyword keyword">REMOTE_VIDEO_STATE_REASON</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法到发生本事件经历的时间，单位为 ms。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title26" id="api_onfirstremoteaudioframe">
    <h2 class="- topic/title title topictitle2" id="ariaid-title26"><a href="class_irtcengineeventhandler.aspx#api_onfirstremoteaudioframe"><span class="- topic/ph ph">onFirstRemoteAudioFrame</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstremoteaudioframe__shortdesc">已接收远端音频首帧回调。</span></p><section class="- topic/section section" id="api_onfirstremoteaudioframe__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstRemoteAudioFrame(uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstremoteaudioframe__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">从 v3.0.0，该回调已废弃。请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremoteaudiostatechanged" title="远端音频流状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteAudioStateChanged</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onfirstremoteaudioframe__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发送音频帧的远端用户的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 方法直至该回调被触发的时间。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title27" id="api_onfirstremoteaudiodecoded">
    <h2 class="- topic/title title topictitle2" id="ariaid-title27"><a href="class_irtcengineeventhandler.aspx#api_onfirstremoteaudiodecoded"><span class="- topic/ph ph">onFirstRemoteAudioDecoded</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstremoteaudiodecoded__shortdesc">已解码远端音频首帧的回调。</span></p><section class="- topic/section section" id="api_onfirstremoteaudiodecoded__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstRemoteAudioDecoded(uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstremoteaudiodecoded__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">从 v3.0.0。该回调已废弃。请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremoteaudiostatechanged" title="远端音频流状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteAudioStateChanged</span></a> 。</dd>
       
   </dl>
   <div class="- topic/p p">SDK 完成远端音频首帧解码，并发送给音频模块用以播放时，会触发此回调。有两种情况：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">远端用户首次上线后发送音频</li>
  <li class="- topic/li li">远端用户音频离线再上线发送音频。音频离线指本地在 15 秒内没有收到音频包，可能有如下原因：
      <ul class="- topic/ul ul">
 <li class="- topic/li li">远端用户离开频道</li>
 <li class="- topic/li li">远端用户掉线</li>
 <li class="- topic/li li">远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a> 方法停止发送音频流</li>
 <li class="- topic/li li">远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disableaudio" title="关闭音频模块。"><span class="- topic/keyword keyword">disableAudio</span></a> 方法关闭音频</li>
      </ul>
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onfirstremoteaudiodecoded__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户 ID 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 直至该回调触发的延迟，单位为毫秒。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title28" id="api_onfirstremotevideoframe">
    <h2 class="- topic/title title topictitle2" id="ariaid-title28"><a href="class_irtcengineeventhandler.aspx#api_onfirstremotevideoframe"><span class="- topic/ph ph">onFirstRemoteVideoFrame</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstremotevideoframe__shortdesc">已显示首帧远端视频回调。</span></p><section class="- topic/section section" id="api_onfirstremotevideoframe__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstRemoteVideoFrame(uid_t uid, <strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstremotevideoframe__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">第一帧远端视频显示在视图上时，触发此调用。 App 可在此调用中获知出图时间（<span class="+ topic/keyword pr-d/parmname keyword parmname">elapsed</span>）。</p>
        </section>
        <section class="- topic/section section" id="api_onfirstremotevideoframe__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，指定是哪个用户的视频流。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流宽（px）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流高（px）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 到发生此事件过去的时间（毫秒)。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title29" id="api_onfirstremotevideodecoded">
    <h2 class="- topic/title title topictitle2" id="ariaid-title29"><a href="class_irtcengineeventhandler.aspx#api_onfirstremotevideodecoded"><span class="- topic/ph ph">onFirstRemoteVideoDecoded</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfirstremotevideodecoded__shortdesc">已接收到远端视频并完成解码回调。</span></p><section class="- topic/section section" id="api_onfirstremotevideodecoded__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFirstRemoteVideoDecoded(uid_t uid, <strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }     </pre>
  </div>
        </section>
        <section class="- topic/section section" id="api_onfirstremotevideodecoded__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">自 v2.9.0 起废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged" title="远端视频状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteVideoStateChanged</span></a> 回调中的：
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_STARTING</span> (1)。</li>
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_DECODING</span> (2)。</li>
  </ul>
  </dd>
       
   </dl>
   <p class="- topic/p p">引擎收到第一帧远端视频流并解码成功时，触发此回调。</p>
   <div class="- topic/p p">App 可在此回调中设置该用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">view</span>。有两种情况：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">远端用户首次上线后发送视频。</li>
  <li class="- topic/li li">远端用户视频离线再上线后发送视频。出现这种中断的可能原因包括：
      <ul class="- topic/ul ul">
 <li class="- topic/li li">远端用户离开频道。</li>
 <li class="- topic/li li">远端用户掉线。</li>
 <li class="- topic/li li">远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalvideostream" title="开关本地视频发送。"><span class="- topic/keyword keyword">muteLocalVideoStream</span></a> 方法停止发送本地视频流。</li>
 <li class="- topic/li li">远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablevideo" title="关闭视频模块。"><span class="- topic/keyword keyword">disableVideo</span></a> 方法关闭视频模块。</li>
      </ul>
  </li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onfirstremotevideodecoded__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，指定是哪个用户的视频流。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流宽（px）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流高（px）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 开始到该回调触发的延迟（毫秒)。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title30" id="api_onaudiosubscribestatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title30"><a href="class_irtcengineeventhandler.aspx#api_onaudiosubscribestatechanged"><span class="- topic/ph ph">onAudioSubscribeStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiosubscribestatechanged__shortdesc">音频订阅状态发生改变回调。</span></p><section class="- topic/section section" id="api_onaudiosubscribestatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioSubscribeStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)channel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiosubscribestatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onaudiosubscribestatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道名。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiosubscribestatechanged__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiosubscribestatechanged__oldState">oldState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">之前的订阅状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_streamsubscribestate" title="订阅状态。"><span class="- topic/keyword keyword">STREAM_SUBSCRIBE_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiosubscribestatechanged__newState">newState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的订阅状态，详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_SUBSCRIBE_STATE</span>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onaudiosubscribestatechanged__elapseSinceLastState">elapseSinceLastState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">两次状态变化时间间隔（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title31" id="api_onvideosubscribestatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title31"><a href="class_irtcengineeventhandler.aspx#api_onvideosubscribestatechanged"><span class="- topic/ph ph">onVideoSubscribeStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onvideosubscribestatechanged__shortdesc">视频订阅状态发生改变回调。</span></p><section class="- topic/section section" id="api_onvideosubscribestatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoSubscribeStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* channel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)channel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onvideosubscribestatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onvideosubscribestatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">channel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">频道名。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">oldState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">之前的订阅状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_streamsubscribestate" title="订阅状态。"><span class="- topic/keyword keyword">STREAM_SUBSCRIBE_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">newState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的订阅状态，详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_SUBSCRIBE_STATE</span>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapseSinceLastState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">两次状态变化时间间隔（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title32" id="api_onusermuteaudio">
    <h2 class="- topic/title title topictitle2" id="ariaid-title32"><a href="class_irtcengineeventhandler.aspx#api_onusermuteaudio"><span class="- topic/ph ph">onUserMuteAudio</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onusermuteaudio__shortdesc">远端用户静音回调。</span></p><section class="- topic/section section" id="api_onusermuteaudio__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserMuteAudio(uid_t uid, <strong class="hl-keyword">bool</strong> muted) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)muted;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onusermuteaudio__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">自 v3.0.0 该回调已废弃。请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremoteaudiostatechanged" title="远端音频流状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteAudioStateChanged</span></a>。</dd>
       
   </dl>
   <p class="- topic/p p">提示有远端用户已将其音频流静音（或取消静音）。</p>
   <p class="- topic/p p">该回调是由远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a> 方法关闭或开启音频发送触发的。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调不生效。</div>
        </section>
        <section class="- topic/section section" id="api_onusermuteaudio__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">muted</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该用户是否静音：
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 该用户已将音频静音；</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 该用户取消了音频静音。</li>
  </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title33" id="api_onusermutevideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title33"><a href="class_irtcengineeventhandler.aspx#api_onusermutevideo"><span class="- topic/ph ph">onUserMuteVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onusermutevideo__shortdesc">远端用户暂停/恢复发送视频流回调。</span></p><section class="- topic/section section" id="api_onusermutevideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserMuteVideo(uid_t uid, <strong class="hl-keyword">bool</strong> muted) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)muted;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onusermutevideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd"> 该回调已废弃。你也可以使用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged" title="远端视频状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteVideoStateChanged</span></a> 回调的：
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_STOPPED</span> (0) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED</span> (5) 。</li>
      <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_DECODING</span> (2) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED</span> (6)。</li>
  </ul>
  </dd>
       
   </dl>
   <p class="- topic/p p">该回调是由远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalvideostream" title="开关本地视频发送。"><span class="- topic/keyword keyword">muteLocalVideoStream</span></a> 方法关闭或开启视频发送触发的。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调不生效。</div>
        </section>
        <section class="- topic/section section" id="api_onusermutevideo__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">muted</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该用户是否暂停发送其视频流
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 该用户已暂停发送其视频流；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 该用户已恢复发送其视频流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title34" id="api_onuserenablevideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title34"><a href="class_irtcengineeventhandler.aspx#api_onuserenablevideo"><span class="- topic/ph ph">onUserEnableVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onuserenablevideo__shortdesc">远端用户开关本地视频采集回调。</span></p><section class="- topic/section section" id="api_onuserenablevideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserEnableVideo(uid_t uid, <strong class="hl-keyword">bool</strong> enabled) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)enabled;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onuserenablevideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">从 v2.9.0。该回调已被废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged" title="远端视频状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteVideoStateChanged</span></a> 回调的：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_STOPPED</span> (0) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED</span> (5) 。</li>
 <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_DECODING</span> (2) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED</span> (6)。</li>
      </ul>
  </dd>
       
   </dl>
   <p class="- topic/p p">提示有远端用户开关了本地视频采集。关闭视频功能是指该用户只能进行语音通话，不能显示、发送自己的视频，也不能接收、显示别人的视频。</p>
   <p class="- topic/p p">该回调是由远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablevideo" title="启用视频模块。"><span class="- topic/keyword keyword">enableVideo</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_disablevideo" title="关闭视频模块。"><span class="- topic/keyword keyword">disableVideo</span></a> 方法开启或关闭视频模块触发的。</p>
        </section>
        <section class="- topic/section section" id="api_onuserenablevideo__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，提示是哪个用户的视频流。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 该用户已启用了视频功能。启用后，该用户可以进行视频通话或直播。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 该用户已关闭了视频功能。关闭后，该用户只能进行语音通话或直播，不能显示、发送自己的视频，也不能接收、显示别人的视频。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title35" id="api_onuserenablelocalvideo">
    <h2 class="- topic/title title topictitle2" id="ariaid-title35"><a href="class_irtcengineeventhandler.aspx#api_onuserenablelocalvideo"><span class="- topic/ph ph">onUserEnableLocalVideo</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onuserenablelocalvideo__shortdesc">其他用户启用/关闭本地视频。</span></p><section class="- topic/section section" id="api_onuserenablelocalvideo__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserEnableLocalVideo(uid_t uid, <strong class="hl-keyword">bool</strong> enabled) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)enabled;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onuserenablelocalvideo__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">从 v2.9.0。该回调已被废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged" title="远端视频状态发生改变回调。"><span class="- topic/keyword keyword">onRemoteVideoStateChanged</span></a> 回调的：
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_STOPPED</span> (0) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED</span> (5) 。</li>
 <li class="- topic/li li"><span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_DECODING</span> (2) 和 <span class="+ topic/keyword pr-d/apiname keyword apiname">REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED</span> (6)。</li>
      </ul>
  </dd>
       
   </dl>
   <p class="- topic/p p">提示有其他用户启用/关闭了本地视频功能。关闭视频功能是指该用户只能进行语音通话，不能显示、发送自己的视频，也不能接收、显示别人的视频。</p>
   <p class="- topic/p p">该回调是由远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelocalvideo" title="开关本地视频采集。"><span class="- topic/keyword keyword">enableLocalVideo</span></a> 方法开启或关闭视频采集触发的。</p>
        </section>
        <section class="- topic/section section" id="api_onuserenablelocalvideo__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，提示是哪个用户的视频流。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">enabled</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 该用户已启用视频功能。启用后，其他用户可以接收到该用户的视频流。</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 该用户已关闭视频功能。关闭后，该用户仍然可以接收其他用户的视频流，但其他用户接收不到该用户的视频流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title36" id="api_onvideosizechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title36"><a href="class_irtcengineeventhandler.aspx#api_onvideosizechanged"><span class="- topic/ph ph">onVideoSizeChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onvideosizechanged__shortdesc">本地或远端视频大小和旋转信息发生改变回调。</span></p><section class="- topic/section section" id="api_onvideosizechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoSizeChanged(uid_t uid, <strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height, <strong class="hl-keyword">int</strong> rotation) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
        (<strong class="hl-keyword">void</strong>)rotation;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onvideosizechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onvideosizechanged__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">图像尺寸和旋转信息发生变化的用户的用户 ID（本地用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span> 为 0）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onvideosizechanged__width">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流的宽度（像素）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onvideosizechanged__height">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流的高度（像素）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onvideosizechanged__rotation">rotation</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">旋转信息 [0,360)。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title37" id="api_onrtcstats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title37"><a href="class_irtcengineeventhandler.aspx#api_onrtcstats"><span class="- topic/ph ph">onRtcStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onrtcstats__shortdesc">当前通话统计信息回调。</span></p><section class="- topic/section section" id="api_onrtcstats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRtcStats(<strong class="hl-keyword">const</strong> RtcStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onrtcstats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">SDK 定期向 App 报告当前通话的统计信息，每两秒触发一次。</p>
        </section>
        <section class="- topic/section section" id="api_onrtcstats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrtcstats__param">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">RTC 引擎统计数据，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rtcstats" title="通话相关的统计信息。"><span class="- topic/keyword keyword">RtcStats</span></a> 。</p>
  </dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title38" id="api_onnetworkquality">
    <h2 class="- topic/title title topictitle2" id="ariaid-title38"><a href="class_irtcengineeventhandler.aspx#api_onnetworkquality"><span class="- topic/ph ph">onNetworkQuality</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onnetworkquality__shortdesc">通话中每个用户的网络上下行 last mile 质量报告回调。</span></p>
        <section class="- topic/section section" id="api_onnetworkquality__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onNetworkQuality(uid_t uid, <strong class="hl-keyword">int</strong> txQuality, <strong class="hl-keyword">int</strong> rxQuality) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)txQuality;
        (<strong class="hl-keyword">void</strong>)rxQuality;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onnetworkquality__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述每个用户在通话中的 last mile 网络状态，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。</p>
   <p class="- topic/p p">该回调每 2 秒触发一次。如果远端有多个用户，该回调每 2 秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_onnetworkquality__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onnetworkquality__uid"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。表示该回调报告的是持有该 ID 的用户的网络质量。当 <span class="- topic/ph ph">uid</span> 为 0
      时，返回的是本地用户的网络质量。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onnetworkquality__txQuality">txQuality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该用户的上行网络质量，基于发送码率、上行丢包率、平均往返时延和网络抖动计算。该值代表当前的上行网络质量，帮助判断是否可以支持当前设置的视频编码属性。假设上行码率是
      1000 Kbps，那么支持直播场景下 640 × 480 的分辨率、15 fps 的帧率没有问题，但是支持 1280 × 720
      的分辨率就会有困难。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_qualitytype" title="网络质量。"><span class="- topic/keyword keyword">QUALITY_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onnetworkquality__rxQuality">rxQuality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该用户的下行网络质量，基于下行网络的丢包率、平均往返延时和网络抖动计算。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_qualitytype" title="网络质量。"><span class="- topic/keyword keyword">QUALITY_TYPE</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title39" id="api_onlocalaudiostats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title39"><a href="class_irtcengineeventhandler.aspx#api_onlocalaudiostats"><span class="- topic/ph ph">onLocalAudioStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlocalaudiostats__shortdesc">通话中本地音频流的统计信息回调。</span></p><section class="- topic/section section" id="api_onlocalaudiostats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLocalAudioStats(<strong class="hl-keyword">const</strong> LocalAudioStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlocalaudiostats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述本地设备发送音频流的统计信息。SDK 每 2 秒触发该回调一次。</p>
        </section>
        <section class="- topic/section section" id="api_onlocalaudiostats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地音频统计数据。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_localaudiostats" title="本地音频统计数据。"><span class="- topic/keyword keyword">LocalAudioStats</span></a>。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title40" id="api_onlocalvideostats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title40"><a href="class_irtcengineeventhandler.aspx#api_onlocalvideostats"><span class="- topic/ph ph">onLocalVideoStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlocalvideostats__shortdesc">本地视频流统计信息回调。</span></p><section class="- topic/section section" id="api_onlocalvideostats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLocalVideoStats(<strong class="hl-keyword">const</strong> LocalVideoStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlocalvideostats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3><p class="- topic/p p">该回调描述本地设备发送视频流的统计信息，每 2 秒触发一次。</p></section>
        <section class="- topic/section section" id="api_onlocalvideostats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">本地视频流统计信息。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_localvideostats" title="本地视频流统计信息。"><span class="- topic/keyword keyword">LocalVideoStats</span></a>。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title41" id="api_onremoteaudiostats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title41"><a href="class_irtcengineeventhandler.aspx#api_onremoteaudiostats"><span class="- topic/ph ph">onRemoteAudioStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremoteaudiostats__shortdesc">通话中远端音频流的统计信息回调。用于取代 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onaudioquality" title="远端声音质量回调。"><span class="- topic/keyword keyword">onAudioQuality</span></a> 回调。</span></p><section class="- topic/section section" id="api_onremoteaudiostats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteAudioStats(<strong class="hl-keyword">const</strong> RemoteAudioStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremoteaudiostats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述远端用户在通话中端到端的音频流统计信息。该回调函数针对每个发送音频流的远端用户/主播每 2 秒触发一次。如果远端有多个用户/主播发送音频流，该回调每 2
       秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_onremoteaudiostats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremoteaudiostats__stats">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的远端音频统计数据，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_remoteaudiostats" title="远端用户的音频统计数据。"><span class="- topic/keyword keyword">RemoteAudioStats</span></a>。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title42" id="api_onremoteaudiotransportstats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title42"><a href="class_irtcengineeventhandler.aspx#api_onremoteaudiotransportstats"><span class="- topic/ph ph">onRemoteAudioTransportStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremoteaudiotransportstats__shortdesc">通话中远端音频流传输的统计信息回调。</span></p><section class="- topic/section section" id="api_onremoteaudiotransportstats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteAudioTransportStats(
        uid_t uid, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> delay, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> lost,
        <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> rxKBitRate) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)delay;
        (<strong class="hl-keyword">void</strong>)lost;
        (<strong class="hl-keyword">void</strong>)rxKBitRate;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremoteaudiotransportstats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">
       <dl class="- topic/dl dl deprecated">
  
      <dt class="- topic/dt dt dlterm">弃用：</dt>
      <dd class="- topic/dd dd">该回调已被废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremoteaudiostats" title="通话中远端音频流的统计信息回调。用于取代 onAudioQuality 回调。"><span class="- topic/keyword keyword">onRemoteAudioStats</span></a>。</dd>
  
       </dl>
   </div>
   <p class="- topic/p p">该回调描述远端用户通话中端到端的网络统计信息，通过音频包计算，用客观的数据，如丢包、 网络延迟等，展示当前网络状态。</p>
   <p class="- topic/p p">通话中，当用户收到远端用户/主播发送的音频数据包后 ，会每 2 秒触发一次该回调。</p>
        </section>
        <section class="- topic/section section" id="api_onremoteaudiotransportstats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，指定是哪个用户/主播的音频包。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">delay</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音频包从发送端到接收端的延时（毫秒）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">lost</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音频包从发送端到接收端的丢包率 (%)。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rxKBitrate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端音频包的接收码率（Kbps）。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title43" id="api_onremotevideostats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title43"><a href="class_irtcengineeventhandler.aspx#api_onremotevideostats"><span class="- topic/ph ph">onRemoteVideoStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremotevideostats__shortdesc">通话中远端视频流的统计信息回调。</span></p><section class="- topic/section section" id="api_onremotevideostats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteVideoStats(<strong class="hl-keyword">const</strong> RemoteVideoStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremotevideostats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述远端用户在通话中端到端的视频流统计信息， 针对每个远端用户/主播每 2 秒触发一次。如果远端同时存在多个用户/主播， 该回调每 2 秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_onremotevideostats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremotevideostats__stats">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频统计数据。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_remotevideostats" title="远端视频流的统计信息。"><span class="- topic/keyword keyword">RemoteVideoStats</span></a>。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title44" id="api_onremotevideotransportstats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title44"><a href="class_irtcengineeventhandler.aspx#api_onremotevideotransportstats"><span class="- topic/ph ph">onRemoteVideoTransportStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremotevideotransportstats__shortdesc">通话中远端视频流传输的统计信息回调。</span></p>
        <section class="- topic/section section" id="api_onremotevideotransportstats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteVideoTransportStats(
        uid_t uid, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> delay, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> lost,
        <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> rxKBitRate) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)delay;
        (<strong class="hl-keyword">void</strong>)lost;
        (<strong class="hl-keyword">void</strong>)rxKBitRate;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremotevideotransportstats__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">该回调已被废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremotevideostats" title="通话中远端视频流的统计信息回调。"><span class="- topic/keyword keyword">onRemoteVideoStats</span></a>。</dd>
       
   </dl>
   <p class="- topic/p p">该回调描述远端用户通话中端到端的网络统计信息，通过视频包计算，用客观的数据，如丢包、 网络延迟等，展示当前网络状态。</p>
   <p class="- topic/p p">通话中，当用户收到远端用户/主播发送的视频数据包后，会每 2 秒触发一次该回调。</p>
        </section>
        <section class="- topic/section section" id="api_onremotevideotransportstats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，指定是哪个用户/主播的视频包。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">delay</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频包从发送端到接收端的延时（毫秒）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">lost</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频包从发送端到接收端的丢包率 (%)。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rxKBitRate</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频包的接收码率（Kbps）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title45" id="api_onaudioquality">
    <h2 class="- topic/title title topictitle2" id="ariaid-title45"><a href="class_irtcengineeventhandler.aspx#api_onaudioquality"><span class="- topic/ph ph">onAudioQuality</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudioquality__shortdesc">远端声音质量回调。</span></p>
        <section class="- topic/section section" id="api_onaudioquality__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioQuality(uid_t uid, <strong class="hl-keyword">int</strong> quality, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> delay, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">short</strong> lost) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)quality;
        (<strong class="hl-keyword">void</strong>)delay;
        (<strong class="hl-keyword">void</strong>)lost;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudioquality__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">
       <dl class="- topic/dl dl deprecated">
  
      <dt class="- topic/dt dt dlterm">弃用：</dt>
      <dd class="- topic/dd dd">该方法自 v2.3.2 起废弃。请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onremoteaudiostats" title="通话中远端音频流的统计信息回调。用于取代 onAudioQuality 回调。"><span class="- topic/keyword keyword">onRemoteAudioStats</span></a> 方法。</dd>
  
       </dl>
   </div>
   <p class="- topic/p p">该回调描述远端用户在通话中的音频质量，针对每个远端用户/主播每 2 秒触发一次。如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_onaudioquality__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID，指定是谁发的音频流。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">quality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">语音质量，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_qualitytype" title="网络质量。"><span class="- topic/keyword keyword">QUALITY_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">delay</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音频包从发送端到接收端的延迟（毫秒）。包括声音采样前处理、网络传输、网络抖动缓冲引起的延迟。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">lost</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音频包从发送端到接收端的丢包率 (%)。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title46" id="api_onaudiomixingstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title46"><a href="class_irtcengineeventhandler.aspx#api_onaudiomixingstatechanged"><span class="- topic/ph ph">onAudioMixingStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiomixingstatechanged__shortdesc">本地用户的音乐文件播放状态已改变回调。</span></p><section class="- topic/section section" id="api_onaudiomixingstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioMixingStateChanged(AUDIO_MIXING_STATE_TYPE state, AUDIO_MIXING_ERROR_TYPE errorCode){
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiomixingstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.4.0</dd>
       
   </dl>
   <p class="- topic/p p">该回调在音乐文件播放状态发生改变时触发，并报告当前的播放状态和错误码。</p>
   <p class="- topic/p p">如果本地音乐文件不存在、文件格式不支持或无法访问在线音乐文件 URL，SDK 会返回警告码 <span class="+ topic/keyword pr-d/apiname keyword apiname">WARN_AUDIO_MIXING_OPEN_ERROR</span>(701)。</p>
        </section>
        <section class="- topic/section section" id="api_onaudiomixingstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音乐文件播放状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audiomixingstatetype" title="音乐文件播放状态。"><span class="- topic/keyword keyword">AUDIO_MIXING_STATE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">errorCode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">错误码，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audiomixingerrortype" title="混音音乐文件错误码。"><span class="- topic/keyword keyword">AUDIO_MIXING_ERROR_TYPE</span></a>。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title47" id="api_onaudiomixingfinished">
    <h2 class="- topic/title title topictitle2" id="ariaid-title47"><a href="class_irtcengineeventhandler.aspx#api_onaudiomixingfinished"><span class="- topic/ph ph">onAudioMixingFinished</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiomixingfinished__shortdesc">本地音乐文件播放已结束回调。</span></p><section class="- topic/section section" id="api_onaudiomixingfinished__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioMixingFinished() {
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiomixingfinished__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">自 v2.4.0 起废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onaudiomixingstatechanged" title="本地用户的音乐文件播放状态已改变回调。"><span class="- topic/keyword keyword">onAudioMixingStateChanged</span></a>。</dd>
       
   </dl>
   <p class="- topic/p p">当调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a> 播放本地音乐文件结束后，会触发该回调。如果调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">startAudioMixing</span> 失败，会在 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onerror" title="发生错误回调。"><span class="- topic/keyword keyword">onError</span></a> 回调里，返回错误码
       <span class="+ topic/keyword pr-d/parmname keyword parmname">WARN_AUDIO_MIXING_OPEN_ERROR</span>。</p>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title48" id="api_onaudioeffectfinished">
    <h2 class="- topic/title title topictitle2" id="ariaid-title48"><a href="class_irtcengineeventhandler.aspx#api_onaudioeffectfinished"><span class="- topic/ph ph">onAudioEffectFinished</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudioeffectfinished__shortdesc">本地音效文件播放已结束回调。</span></p>
        <section class="- topic/section section" id="api_onaudioeffectfinished__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
   
   <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioEffectFinished(<strong class="hl-keyword">int</strong> soundId) {
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudioeffectfinished__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当播放音效结束后，会触发该回调。</p>
        </section>
        <section class="- topic/section section" id="api_onaudioeffectfinished__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">soundId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">指定音效的 ID。每个音效均有唯一的 ID。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title49" id="api_onrtmpstreamingstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title49"><a href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingstatechanged"><span class="- topic/ph ph">onRtmpStreamingStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onrtmpstreamingstatechanged__shortdesc">RTMP/RTMPS 推流状态发生改变回调。</span></p><section class="- topic/section section" id="api_onrtmpstreamingstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRtmpStreamingStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *url, RTMP_STREAM_PUBLISH_STATE state, RTMP_STREAM_PUBLISH_ERROR errCode) {
        (<strong class="hl-keyword">void</strong>) url;
        (<strong class="hl-keyword">void</strong>) state;
        (<strong class="hl-keyword">void</strong>) errCode;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onrtmpstreamingstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调返回本地用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_addpublishstreamurl" title="增加旁路推流地址。"><span class="- topic/keyword keyword">addPublishStreamUrl</span></a> 或 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_removepublishstreamurl" title="删除旁路推流地址。"><span class="- topic/keyword keyword">removePublishStreamUrl</span></a> 方法的结果。 RTMP/RTMPS 推流状态发生改变时，SDK
       会触发该回调，并在回调中明确状态发生改变的 URL
       地址及当前推流状态。该回调方便推流用户了解当前的推流状态；推流出错时，你可以通过返回的错误码了解出错的原因，方便排查问题。</p>
        </section>
        <section class="- topic/section section" id="api_onrtmpstreamingstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrtmpstreamingstatechanged__url">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">推流状态发生改变的 URL 地址。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrtmpstreamingstatechanged__state">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的推流状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rtmpstreampublishstate" title="推流状态。"><span class="- topic/keyword keyword">RTMP_STREAM_PUBLISH_STATE</span></a> 。当推流状态为 <span class="+ topic/keyword pr-d/apiname keyword apiname">RTMP_STREAM_PUBLISH_STATE_FAILURE</span> (4) 时，你可以在 <span class="+ topic/keyword pr-d/parmname keyword parmname">errorCode</span> 参数中查看返回的错误信息。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrtmpstreamingstatechanged__errCode">errCode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">推流错误信息，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rtmpstreampublisherror" title="推流错误信息。"><span class="- topic/keyword keyword">RTMP_STREAM_PUBLISH_ERROR</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title50" id="api_onrtmpstreamingevent">
    <h2 class="- topic/title title topictitle2" id="ariaid-title50"><a href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingevent"><span class="- topic/ph ph">onRtmpStreamingEvent</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onrtmpstreamingevent__shortdesc">RTMP/RTMPS 推流事件回调。</span></p><section class="- topic/section section" id="api_onrtmpstreamingevent__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRtmpStreamingEvent(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* url, RTMP_STREAMING_EVENT eventCode) {
      (<strong class="hl-keyword">void</strong>) url;
      (<strong class="hl-keyword">void</strong>) eventCode;
  }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onrtmpstreamingevent__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onrtmpstreamingevent__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrtmpstreamingevent__url">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">RTMP/RTMPS 推流 URL。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onrtmpstreamingevent__eventCode">eventCode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">RTMP/RTMPS 推流事件码。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rtmpstreamingevent" title="RTMP/RTMPS 推流时发生的事件。"><span class="- topic/keyword keyword">RTMP_STREAMING_EVENT</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title51" id="api_ontranscodingupdated">
    <h2 class="- topic/title title topictitle2" id="ariaid-title51"><a href="class_irtcengineeventhandler.aspx#api_ontranscodingupdated"><span class="- topic/ph ph">onTranscodingUpdated</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ontranscodingupdated__shortdesc">旁路推流设置已被更新回调。</span></p><section class="- topic/section section" id="api_ontranscodingupdated__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onTranscodingUpdated() {
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ontranscodingupdated__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p"><a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlivetranscoding" title="设置直播推流转码。"><span class="- topic/keyword keyword">setLiveTranscoding</span></a> 方法中的直播参数 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_livetranscoding" title="管理旁路推流配置的类。"><span class="- topic/keyword keyword">LiveTranscoding</span></a> 更新时，<span class="+ topic/keyword pr-d/apiname keyword apiname">onTranscodingUpdated</span> 回调会被触发并向主播报告更新信息。</p>
   <div class="- topic/note note note note_note" id="api_ontranscodingupdated__note"><span class="note__title">注：</span> 首次调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setLiveTranscoding</span> 方法设置转码参数 <span class="+ topic/keyword pr-d/apiname keyword apiname">LiveTranscoding</span> 时，不会触发此回调。</div>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title52" id="api_onstreampublished">
    <h2 class="- topic/title title topictitle2" id="ariaid-title52"><a href="class_irtcengineeventhandler.aspx#api_onstreampublished"><span class="- topic/ph ph">onStreamPublished</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onstreampublished__shortdesc">旁路推流已开启回调。</span></p><section class="- topic/section section" id="api_onstreampublished__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamPublished(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *url, <strong class="hl-keyword">int</strong> error) {
        (<strong class="hl-keyword">void</strong>)url;
        (<strong class="hl-keyword">void</strong>)error;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onstreampublished__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
    
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">v3.0.0</dd>
       
   </dl>
   <p class="- topic/p p">此方法已废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingstatechanged" title="RTMP/RTMPS 推流状态发生改变回调。"><span class="- topic/keyword keyword">onRtmpStreamingStateChanged</span></a>。</p>
   <p class="- topic/p p">该回调用于通知主播推流状态。</p>
        </section>
        <section class="- topic/section section" id="api_onstreampublished__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">主播推流的 URL 地址。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">error</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p"><code class="+ topic/ph pr-d/codeph ph codeph">ERROR_CODE_TYPE</code> 。<ul class="- topic/ul ul">
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_OK</code> (0): 推流成功。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_FAILED</code> (1): 推流失败。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code> (2): 参数错误。如果你在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_addpublishstreamurl" title="增加旁路推流地址。"><span class="- topic/keyword keyword">addPublishStreamUrl</span></a> 前没有调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlivetranscoding" title="设置直播推流转码。"><span class="- topic/keyword keyword">setLiveTranscoding</span></a> 配置 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_livetranscoding" title="管理旁路推流配置的类。"><span class="- topic/keyword keyword">LiveTranscoding</span></a> ，SDK 会回调
    <code class="+ topic/ph pr-d/codeph ph codeph">ERR_INVALID_ARGUMENT</code>。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_TIMEDOUT</code> (10): 推流超时未成功。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_ALREADY_IN_USE</code> (19): 推流地址已推流。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_ABORTED</code> (20): SDK 与推流服务器断开连接。推流中断。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_RESOURCE_LIMITED</code> (22): 后台没有足够资源推流。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH</code> (130):
推流已加密不能推流。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_PUBLISH_STREAM_CDN_ERROR</code> (151)</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_PUBLISH_STREAM_NUM_REACH_LIMIT</code> (152)</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_PUBLISH_STREAM_NOT_AUTHORIZED</code> (153)</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_PUBLISH_STREAM_INTERNAL_SERVER_ERROR</code>
(154)</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">ERR_PUBLISH_STREAM_FORMAT_NOT_SUPPORTED</code>
(156)</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title53" id="api_onstreamunpublished">
    <h2 class="- topic/title title topictitle2" id="ariaid-title53"><a href="class_irtcengineeventhandler.aspx#api_onstreamunpublished"><span class="- topic/ph ph">onStreamUnpublished</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onstreamunpublished__shortdesc">旁路推流已停止回调。</span></p><section class="- topic/section section" id="api_onstreamunpublished__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamUnpublished(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *url) {
        (<strong class="hl-keyword">void</strong>)url;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onstreamunpublished__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl deprecated">
       
  <dt class="- topic/dt dt dlterm">弃用：</dt>
  <dd class="- topic/dd dd">v3.0.0</dd>
       
   </dl>
   <p class="- topic/p p">此方法已废弃，请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingstatechanged" title="RTMP/RTMPS 推流状态发生改变回调。"><span class="- topic/keyword keyword">onRtmpStreamingStateChanged</span></a>。</p>
   <p class="- topic/p p">回调用于通知主播停止推流成功。</p>
        </section>
        <section class="- topic/section section" id="api_onstreamunpublished__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">被删除的 RTMP/RTMPS 推流地址。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title54" id="api_onchannelmediarelaystatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title54"><a href="class_irtcengineeventhandler.aspx#api_onchannelmediarelaystatechanged"><span class="- topic/ph ph">onChannelMediaRelayStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onchannelmediarelaystatechanged__shortdesc">跨频道媒体流转发状态发生改变回调。</span></p><section class="- topic/section section" id="api_onchannelmediarelaystatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onChannelMediaRelayStateChanged(CHANNEL_MEDIA_RELAY_STATE state,CHANNEL_MEDIA_RELAY_ERROR code) {
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onchannelmediarelaystatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当跨频道媒体流转发状态发生改变时，SDK 会触发该回调，并报告当前的转发状态以及相关的错误信息。</p>
        </section>
        <section class="- topic/section section" id="api_onchannelmediarelaystatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onchannelmediarelaystatechanged__state">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelmediarelaystate" title="跨频道媒体流转发状态码。"><span class="- topic/keyword keyword">CHANNEL_MEDIA_RELAY_STATE</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onchannelmediarelaystatechanged__code">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发出错的错误码。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelmediarelayerror" title="跨频道媒体流转发出错的错误码。"><span class="- topic/keyword keyword">CHANNEL_MEDIA_RELAY_ERROR</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title55" id="api_onchannelmediarelayevent">
    <h2 class="- topic/title title topictitle2" id="ariaid-title55"><a href="class_irtcengineeventhandler.aspx#api_onchannelmediarelayevent"><span class="- topic/ph ph">onChannelMediaRelayEvent</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onchannelmediarelayevent__shortdesc">跨频道媒体流转发事件回调。</span></p><section class="- topic/section section" id="api_onchannelmediarelayevent__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onChannelMediaRelayEvent(CHANNEL_MEDIA_RELAY_EVENT code) {
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onchannelmediarelayevent__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调报告跨频道媒体流转发过程中发生的事件。</p>
        </section>
        <section class="- topic/section section" id="api_onchannelmediarelayevent__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onchannelmediarelayevent__code">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发事件码。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelmediarelayevent" title="跨频道媒体流转发事件码。"><span class="- topic/keyword keyword">CHANNEL_MEDIA_RELAY_EVENT</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title56" id="api_onaudiovolumeindication">
    <h2 class="- topic/title title topictitle2" id="ariaid-title56"><a href="class_irtcengineeventhandler.aspx#api_onaudiovolumeindication"><span class="- topic/ph ph">onAudioVolumeIndication</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiovolumeindication__shortdesc">用户音量提示回调。</span></p><section class="- topic/section section" id="api_onaudiovolumeindication__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioVolumeIndication(<strong class="hl-keyword">const</strong> AudioVolumeInfo* speakers, <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> speakerNumber, <strong class="hl-keyword">int</strong> totalVolume) {
        (<strong class="hl-keyword">void</strong>)speakers;
        (<strong class="hl-keyword">void</strong>)speakerNumber;
        (<strong class="hl-keyword">void</strong>)totalVolume;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiovolumeindication__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调默认禁用，你可以通过 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enableaudiovolumeindication" title="启用用户音量提示。"><span class="- topic/keyword keyword">enableAudioVolumeIndication</span></a> 开启。 开启后，只要频道内有发流用户，SDK 会在加入频道后按 <span class="+ topic/keyword pr-d/apiname keyword apiname">enableAudioVolumeIndication</span> 中设置的时间间隔触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onAudioVolumeIndication</span> 回调。每次会触发两个 <span class="+ topic/keyword pr-d/apiname keyword apiname">onAudioVolumeIndication</span> 回调，一个报告本地发流用户的音量相关信息，另一个报告 瞬时音量最高的远端用户（最多 3 位）的音量相关信息。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       启用该功能后，如果有用户将自己静音（调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_mutelocalaudiostream" title="取消或恢复发布本地音频流。"><span class="- topic/keyword keyword">muteLocalAudioStream</span></a>），SDK 行为会受如下影响：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">本地用户静音后，SDK 立即停止报告本地用户的音量提示回调。</li>
  <li class="- topic/li li">远端说话者静音后 20 秒，远端的音量提示回调中将不再包含该用户；如果远端所有用户都将自己静音，20 秒后 SDK 不再报告远端用户的音量提示回调。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onaudiovolumeindication__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">speakers</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户音量信息，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_audiovolumeinfo" title="用户音量信息。"><span class="- topic/keyword keyword">AudioVolumeInfo</span></a> 数组。如果 <span class="+ topic/keyword pr-d/parmname keyword parmname">speakers</span> 为空，则表示远端用户不发流或没有远端用户。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">speakerNumber</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">用户数量。
 <ul class="- topic/ul ul">
     <li class="- topic/li li">在本地用户的回调中，只要本地用户在发流，<span class="+ topic/keyword pr-d/parmname keyword parmname">speakerNumber</span> 始终为 1。</li>
     <li class="- topic/li li">在远端用户的回调中，<span class="+ topic/keyword pr-d/parmname keyword parmname">speakerNumber</span> 取值范围为 [0,3]。如果远端发流用户数量大于 3，则此回调中 <span class="+ topic/keyword pr-d/parmname keyword parmname">speakerNumber</span> 值为 3。</li>
 </ul>
      </div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">totalVolume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">混音后的总音量，取值范围为 [0,255]。
 <ul class="- topic/ul ul">
     <li class="- topic/li li">在本地用户的回调中，<span class="+ topic/keyword pr-d/parmname keyword parmname">totalVolume</span> 为本地发流用户的音量。</li>
     <li class="- topic/li li">在远端用户的回调中，<span class="+ topic/keyword pr-d/parmname keyword parmname">totalVolume</span> 为瞬时音量最高的远端用户（最多 3 位）混音后的总音量。 如果用户调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startaudiomixing" title="开始播放音乐文件。"><span class="- topic/keyword keyword">startAudioMixing</span></a>，则 <span class="+ topic/keyword pr-d/parmname keyword parmname">totalVolume</span> 为音乐文件和用户声音的总音量。</li>
 </ul>
      </div>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title57" id="api_onactivespeaker">
    <h2 class="- topic/title title topictitle2" id="ariaid-title57"><a href="class_irtcengineeventhandler.aspx#api_onactivespeaker"><span class="- topic/ph ph">onActiveSpeaker</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onactivespeaker__shortdesc">监测到最活跃用户回调。</span></p><section class="- topic/section section" id="api_onactivespeaker__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onActiveSpeaker(uid_t uid) {
        (<strong class="hl-keyword">void</strong>)uid;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onactivespeaker__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">成功调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enableaudiovolumeindication" title="启用用户音量提示。"><span class="- topic/keyword keyword">enableAudioVolumeIndication</span></a> 后，SDK 会持续监测音量最大的远端用户，并统计该用户被判断为音量最大者的次数。当前时间段内，该次数累积最多的远端用户为最活跃的用户。</p>
   <div class="- topic/p p">当频道内用户数量大于或等于 2 且有活跃用户时，SDK 会触发该回调并报告最活跃用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>。<ul class="- topic/ul ul">
  <li class="- topic/li li">如果最活跃用户一直是同一位用户，则 SDK 不会再次触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onActiveSpeaker</span> 回调。</li>
  <li class="- topic/li li">如果最活跃用户有变化，则 SDK 会再次触发该回调并报告新的最活跃用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onactivespeaker__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onactivespeaker__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端最活跃用户的 ID。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title58" id="api_onfacepositionchanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title58"><a href="class_irtcengineeventhandler.aspx#api_onfacepositionchanged"><span class="- topic/ph ph">onFacePositionChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onfacepositionchanged__shortdesc">报告本地人脸检测结果。仅适用于 Android 和 iOS 平台。</span></p><section class="- topic/section section" id="api_onfacepositionchanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onFacePositionChanged(<strong class="hl-keyword">int</strong> imageWidth, <strong class="hl-keyword">int</strong> imageHeight, Rectangle* vecRectangle, <strong class="hl-keyword">int</strong>* vecDistance, <strong class="hl-keyword">int</strong> numFaces){
       (<strong class="hl-keyword">void</strong>)imageWidth;
       (<strong class="hl-keyword">void</strong>)imageHeight;
       (<strong class="hl-keyword">void</strong>)vecRectangle;
       (<strong class="hl-keyword">void</strong>)vecDistance;
        (<strong class="hl-keyword">void</strong>)numFaces;
    }
<span class="hl-directive">#endif</span></pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onfacepositionchanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.0.1</dd>
       
   </dl>
   <div class="- topic/p p">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablefacedetection" title="开启/关闭本地人脸检测。"><span class="- topic/keyword keyword">enableFaceDetection</span></a>(<span class="- topic/ph ph">true</span>) 开启本地人脸检测后，你可以通过该回调实时获取以下人脸检测的信息：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">摄像头采集的画面大小</li>
  <li class="- topic/li li">人脸在画面中的位置</li>
  <li class="- topic/li li">人脸距设备屏幕的距离</li>
       </ul>
   </div>
   <p class="- topic/p p">其中，人脸距设备屏幕的距离由 SDK 通过摄像头采集的画面大小和人脸在画面中的位置拟合计算得出。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li">当检测到摄像头前没有人脸时，该回调触发频率会降低，以节省设备耗能。</li>
  <li class="- topic/li li">当人脸距离设备屏幕过近时，SDK 不会触发该回调。</li>
  <li class="- topic/li li">Android 平台上，人脸距设备屏幕的距离（<span class="+ topic/keyword pr-d/parmname keyword parmname">distance</span>）值有一定误差，请不要用它进行精确计算。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_onfacepositionchanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">imageWidth</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">摄像头采集画面的宽度 (px)。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">imageHeight</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">摄像头采集画面的高度 (px)。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">vecRectangle</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">检测到的人脸信息：
 <ul class="- topic/ul ul">
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">x</code>：人脸在画面中的 x 坐标 (px)。以摄像头采集画面的左上角为原点，x
坐标为人脸左上角相对于原点的横向位移。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">y</code>：人脸在画面中的 y 坐标 (px)。以摄像头采集画面的左上角为原点，y
坐标为人脸左上角相对原点的纵向位移。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">width</code>：人脸在画面中的宽度 (px)。</li>
     <li class="- topic/li li"><code class="+ topic/ph pr-d/codeph ph codeph">height</code>：人脸在画面中的高度 (px)。</li>
 </ul>
      </div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">vecDistance</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">人脸距设备屏幕的距离 (cm)。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">numFaces</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">检测的人脸数量。如果为 0，则表示没有检测到人脸。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title59" id="api_onaudioroutechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title59"><a href="class_irtcengineeventhandler.aspx#api_onaudioroutechanged"><span class="- topic/ph ph">onAudioRouteChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudioroutechanged__shortdesc">语音路由已发生变化回调。</span></p><section class="- topic/section section" id="api_onaudioroutechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioRouteChanged(AUDIO_ROUTE_TYPE routing) {
        (<strong class="hl-keyword">void</strong>)routing;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudioroutechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当语音路由发生变化时，SDK 会触发此回调。</p>
        </section>
        <section class="- topic/section section" id="api_onaudioroutechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">routing</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的语音路由。详见：<a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_audioroutetype" title="语音路由。"><span class="- topic/keyword keyword">AUDIO_ROUTE_TYPE</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title60" id="api_onlocalpublishfallbacktoaudioonly">
    <h2 class="- topic/title title topictitle2" id="ariaid-title60"><a href="class_irtcengineeventhandler.aspx#api_onlocalpublishfallbacktoaudioonly"><span class="- topic/ph ph">onLocalPublishFallbackToAudioOnly</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlocalpublishfallbacktoaudioonly__shortdesc">本地发布流已回退为音频流回调。</span></p><section class="- topic/section section" id="api_onlocalpublishfallbacktoaudioonly__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLocalPublishFallbackToAudioOnly(<strong class="hl-keyword">bool</strong> isFallbackOrRecover) {
        (<strong class="hl-keyword">void</strong>)isFallbackOrRecover;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlocalpublishfallbacktoaudioonly__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">如果你调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalpublishfallbackoption" title="设置弱网条件下发布的音视频流回退选项。"><span class="- topic/keyword keyword">setLocalPublishFallbackOption</span></a> 接口并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> ，当上行网络环境不理想、本地发布的媒体流回退为音频流时，或当上行网络改善、媒体流恢复为音视频流时，会触发该回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span>  如果本地发流已回退为音频流，远端的 App 上会收到 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onusermutevideo" title="远端用户暂停/恢复发送视频流回调。"><span class="- topic/keyword keyword">onUserMuteVideo</span></a>
       的回调事件。</div>
        </section>
        <section class="- topic/section section" id="api_onlocalpublishfallbacktoaudioonly__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onlocalpublishfallbacktoaudioonly__isFallbackOrRecover">isFallbackOrRecover</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 由于网络环境不理想，本地发布的媒体流已回退为音频流；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 由于网络环境改善，发布的音频流已恢复为音视频流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title61" id="api_onremotesubscribefallbacktoaudioonly">
    <h2 class="- topic/title title topictitle2" id="ariaid-title61"><a href="class_irtcengineeventhandler.aspx#api_onremotesubscribefallbacktoaudioonly"><span class="- topic/ph ph">onRemoteSubscribeFallbackToAudioOnly</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onremotesubscribefallbacktoaudioonly__shortdesc">远端订阅流已回退为音频流回调。</span></p><section class="- topic/section section" id="api_onremotesubscribefallbacktoaudioonly__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteSubscribeFallbackToAudioOnly(uid_t uid, <strong class="hl-keyword">bool</strong> isFallbackOrRecover) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)isFallbackOrRecover;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onremotesubscribefallbacktoaudioonly__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">如果你调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setremotesubscribefallbackoption" title="设置弱网条件下订阅的音视频流的回退选项。"><span class="- topic/keyword keyword">setRemoteSubscribeFallbackOption</span></a> 接口并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> ，当下行网络环境不理想、仅接收远端音频流时，或当下行网络改善、恢复订阅音视频流时，会触发该回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span>  远端订阅流因弱网环境不能同时满足音视频而回退为小流时，你可以使用 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_remotevideostats" title="远端视频流的统计信息。"><span class="- topic/keyword keyword">RemoteVideoStats</span></a> 来监控远端视频大小流的切换。</div>
        </section>
        <section class="- topic/section section" id="api_onremotesubscribefallbacktoaudioonly__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremotesubscribefallbacktoaudioonly__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onremotesubscribefallbacktoaudioonly__isFallbackOrRecover">isFallbackOrRecover</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 由于网络环境不理想，远端订阅流已回退为音频流；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 由于网络环境改善，订阅的音频流已恢复为音视频流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title62" id="api_onlastmilequality">
    <h2 class="- topic/title title topictitle2" id="ariaid-title62"><a href="class_irtcengineeventhandler.aspx#api_onlastmilequality"><span class="- topic/ph ph">onLastmileQuality</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlastmilequality__shortdesc">通话前网络上下行 last mile 质量报告回调。</span></p><section class="- topic/section section" id="api_onlastmilequality__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLastmileQuality(<strong class="hl-keyword">int</strong> quality) {
        (<strong class="hl-keyword">void</strong>)quality;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlastmilequality__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述本地用户在加入频道前的 last mile 网络探测的结果，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。</p>
   <p class="- topic/p p">在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enablelastmiletest" title="启动网络测试。"><span class="- topic/keyword keyword">enableLastmileTest</span></a> 之后，该回调函数每 2 秒触发一次。如果远端有多个用户/主播，该回调每 2 秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_onlastmilequality__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">quality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">网络上下行质量，基于上下行网络的丢包率和抖动计算，探测结果主要反映上行网络的状态。详见: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_qualitytype" title="网络质量。"><span class="- topic/keyword keyword">QUALITY_TYPE</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title63" id="api_onlastmileproberesult">
    <h2 class="- topic/title title topictitle2" id="ariaid-title63"><a href="class_irtcengineeventhandler.aspx#api_onlastmileproberesult"><span class="- topic/ph ph">onLastmileProbeResult</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onlastmileproberesult__shortdesc">通话前网络质量探测报告回调。</span></p><section class="- topic/section section" id="api_onlastmileproberesult__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLastmileProbeResult(<strong class="hl-keyword">const</strong> LastmileProbeResult&amp; result) {
        (<strong class="hl-keyword">void</strong>)result;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onlastmileproberesult__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">通话前网络上下行 Last mile 质量探测报告回调。在调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_startlastmileprobetest" title="开始通话前网络质量探测。"><span class="- topic/keyword keyword">startLastmileProbeTest</span></a> 之后，SDK 会在约 30 秒内返回该回调。</p>
        </section>
        <section class="- topic/section section" id="api_onlastmileproberesult__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">result</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">上下行 Last mile 质量探测结果。 详见: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_lastmileproberesult" title="上行或下行 Last mile 网络质量探测结果。"><span class="- topic/keyword keyword">LastmileProbeResult</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title64" id="api_onstreaminjectedstatus">
    <h2 class="- topic/title title topictitle2" id="ariaid-title64"><a href="class_irtcengineeventhandler.aspx#api_onstreaminjectedstatus"><span class="- topic/ph ph">onStreamInjectedStatus</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onstreaminjectedstatus__shortdesc">输入在线媒体流状态回调。</span></p><section class="- topic/section section" id="api_onstreaminjectedstatus__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamInjectedStatus(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* url, uid_t uid, <strong class="hl-keyword">int</strong> status) {
        (<strong class="hl-keyword">void</strong>)url;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)status;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onstreaminjectedstatus__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
       <div class="- topic/note note note note_note warning"><span class="note__title">注：</span> 
       客户端输入在线媒体流功能即将停服。如果你尚未集成该功能，Agora 建议你不要使用。详见<a class="- topic/xref xref" href="https://docs.agora.io/cn/Interactive%20Broadcast/rtc_sunset" target="_blank" rel="external noopener">部分服务下架计划</a>。
   </div>
        </section>
        <section class="- topic/section section" id="api_onstreaminjectedstatus__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreaminjectedstatus__url">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">在线媒体流的地址。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreaminjectedstatus__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreaminjectedstatus__status">status</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">输入的在线媒体流状态: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_injectstreamstatus" title="导入的外部视频源状态。"><span class="- topic/keyword keyword">INJECT_STREAM_STATUS</span></a> 。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onstreaminjectedstatus__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title65" id="api_oncamerafocusareachanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title65"><a href="class_irtcengineeventhandler.aspx#api_oncamerafocusareachanged"><span class="- topic/ph ph">onCameraFocusAreaChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_oncamerafocusareachanged__shortdesc">相机对焦区域已改变回调。</span></p><section class="- topic/section section" id="api_oncamerafocusareachanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onCameraFocusAreaChanged(<strong class="hl-keyword">int</strong> x, <strong class="hl-keyword">int</strong> y, <strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height) {
        (<strong class="hl-keyword">void</strong>)x;
        (<strong class="hl-keyword">void</strong>)y;
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_oncamerafocusareachanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调表示相机的对焦区域发生了改变。 该回调是由本地用户调用 <a class="- topic/xref xref" href="api_setcamerafocuspositioninpreview.aspx" title="设置手动对焦位置，并触发对焦。"><span class="- topic/keyword keyword">setCameraFocusPositionInPreview</span></a> 方法改变对焦位置触发的。</p>
   <div class="- topic/p p"><div class="- topic/note note note note_note"><span class="note__title">注：</span> 该回调只适用于移动端。</div></div>
        </section>
        <section class="- topic/section section" id="api_oncamerafocusareachanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">x</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的对焦区域的 x 坐标。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">y</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的对焦区域的 y 坐标。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的对焦区域的宽度。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的对焦区域的高度。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title66" id="api_oncameraexposureareachanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title66"><a href="class_irtcengineeventhandler.aspx#api_oncameraexposureareachanged"><span class="- topic/ph ph">onCameraExposureAreaChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_oncameraexposureareachanged__shortdesc">摄像头曝光区域已改变回调。</span></p><section class="- topic/section section" id="api_oncameraexposureareachanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onCameraExposureAreaChanged(<strong class="hl-keyword">int</strong> x, <strong class="hl-keyword">int</strong> y, <strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height) {
        (<strong class="hl-keyword">void</strong>)x;
        (<strong class="hl-keyword">void</strong>)y;
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_oncameraexposureareachanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调是由本地用户调用 <a class="- topic/xref xref" href="api_setcameraexposureposition.aspx" title="设置手动曝光位置。"><span class="- topic/keyword keyword">setCameraExposurePosition</span></a> 方法改变曝光位置触发的。</p>
   <div class="- topic/p p"><div class="- topic/note note note note_note"><span class="note__title">注：</span> 该回调只适用于移动端。</div></div>
        </section>
        <section class="- topic/section section" id="api_oncameraexposureareachanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">x</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的曝光区域的 x 坐标。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">y</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的曝光区域的 y 坐标。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的曝光区域的宽度。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生改变的曝光区域的高度。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title67" id="api_oncameraready">
    <h2 class="- topic/title title topictitle2" id="ariaid-title67"><a href="class_irtcengineeventhandler.aspx#api_oncameraready"><span class="- topic/ph ph">onCameraReady</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_oncameraready__shortdesc">摄像头就绪回调。</span></p><section class="- topic/section section" id="api_oncameraready__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onCameraReady() {}</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_oncameraready__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">弃用:</dt>
  <dd class="- topic/dd dd"><p class="- topic/p p">该回调已废弃。请改用 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onlocalvideostatechanged" title="本地视频状态发生改变回调。"><span class="- topic/keyword keyword">onLocalVideoStateChanged</span></a> 中的 <span class="- topic/ph ph">LOCAL_VIDEO_STREAM_STATE_CAPTURING</span>(1)</p>。</dd>
       
   </dl>
   <p class="- topic/p p">该回调提示已成功打开摄像头，可以开始捕获视频。</p>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title68" id="api_onaudiodevicestatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title68"><a href="class_irtcengineeventhandler.aspx#api_onaudiodevicestatechanged"><span class="- topic/ph ph">onAudioDeviceStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiodevicestatechanged__shortdesc">音频设备变化回调。</span></p><section class="- topic/section section" id="api_onaudiodevicestatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioDeviceStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* deviceId, <strong class="hl-keyword">int</strong> deviceType, <strong class="hl-keyword">int</strong> deviceState) {
        (<strong class="hl-keyword">void</strong>)deviceId;
        (<strong class="hl-keyword">void</strong>)deviceType;
        (<strong class="hl-keyword">void</strong>)deviceState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiodevicestatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该方法提示系统音频设备状态发生改变，比如耳机被拔出。</p>
        </section>
        <section class="- topic/section section" id="api_onaudiodevicestatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceType</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备类型定义。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_mediadevicetype" title="设备类型。"><span class="- topic/keyword keyword">MEDIA_DEVICE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备状态定义。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_mediadevicestatetype" title="设备状态。"><span class="- topic/keyword keyword">MEDIA_DEVICE_STATE_TYPE</span></a>。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title69" id="api_onaudiodevicevolumechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title69"><a href="class_irtcengineeventhandler.aspx#api_onaudiodevicevolumechanged"><span class="- topic/ph ph">onAudioDeviceVolumeChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onaudiodevicevolumechanged__shortdesc">回放、音频采集设备或 App 的音量发生改变。</span></p><section class="- topic/section section" id="api_onaudiodevicevolumechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioDeviceVolumeChanged(MEDIA_DEVICE_TYPE deviceType, <strong class="hl-keyword">int</strong> volume, <strong class="hl-keyword">bool</strong> muted) {
        (<strong class="hl-keyword">void</strong>)deviceType;
        (<strong class="hl-keyword">void</strong>)volume;
        (<strong class="hl-keyword">void</strong>)muted;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onaudiodevicevolumechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceType</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备类型定义。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_mediadevicetype" title="设备类型。"><span class="- topic/keyword keyword">MEDIA_DEVICE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">volume</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">音量。范围为 [0,255]。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">muted</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">音频设备是否为静音状态：
  <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 音频设备已静音。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 音频设备未被静音。</li>
  </ul></div></dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title70" id="api_onvideodevicestatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title70"><a href="class_irtcengineeventhandler.aspx#api_onvideodevicestatechanged"><span class="- topic/ph ph">onVideoDeviceStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onvideodevicestatechanged__shortdesc">视频设备变化回调。</span></p><section class="- topic/section section" id="api_onvideodevicestatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoDeviceStateChanged(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* deviceId, <strong class="hl-keyword">int</strong> deviceType, <strong class="hl-keyword">int</strong> deviceState) {
        (<strong class="hl-keyword">void</strong>)deviceId;
        (<strong class="hl-keyword">void</strong>)deviceType;
        (<strong class="hl-keyword">void</strong>)deviceState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onvideodevicestatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调提示系统视频设备状态发生改变，比如被拔出或移除。如果设备已使用外接摄像头采集，外接摄像头被拔开后，视频会中断。</p>
        </section>
        <section class="- topic/section section" id="api_onvideodevicestatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceType</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备类型。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_mediadevicetype" title="设备类型。"><span class="- topic/keyword keyword">MEDIA_DEVICE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">deviceState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">设备状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_mediadevicestatetype" title="设备状态。"><span class="- topic/keyword keyword">MEDIA_DEVICE_STATE_TYPE</span></a>。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title71" id="api_onstreammessage">
    <h2 class="- topic/title title topictitle2" id="ariaid-title71"><a href="class_irtcengineeventhandler.aspx#api_onstreammessage"><span class="- topic/ph ph">onStreamMessage</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onstreammessage__shortdesc">接收到对方数据流消息的回调。</span></p><section class="- topic/section section" id="api_onstreammessage__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamMessage(uid_t uid, <strong class="hl-keyword">int</strong> streamId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* data, size_t length) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)streamId;
        (<strong class="hl-keyword">void</strong>)data;
        (<strong class="hl-keyword">void</strong>)length;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onstreammessage__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调表示本地用户收到了远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_sendstreammessage" title="发送数据流。"><span class="- topic/keyword keyword">sendStreamMessage</span></a> 方法发送的流消息。</p>
        </section>
        <section class="- topic/section section" id="api_onstreammessage__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessage__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发送消息的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessage__streamId">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的消息的 Stream ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessage__data">data</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的数据。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessage__length">length</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的数据长度。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title72" id="api_onstreammessageerror">
    <h2 class="- topic/title title topictitle2" id="ariaid-title72"><a href="class_irtcengineeventhandler.aspx#api_onstreammessageerror"><span class="- topic/ph ph">onStreamMessageError</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onstreammessageerror__shortdesc">接收对方数据流消息发生错误的回调。</span></p><section class="- topic/section section" id="api_onstreammessageerror__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamMessageError(uid_t uid, <strong class="hl-keyword">int</strong> streamId, <strong class="hl-keyword">int</strong> code, <strong class="hl-keyword">int</strong> missed, <strong class="hl-keyword">int</strong> cached) {
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)streamId;
        (<strong class="hl-keyword">void</strong>)code;
        (<strong class="hl-keyword">void</strong>)missed;
        (<strong class="hl-keyword">void</strong>)cached;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onstreammessageerror__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调表示本地用户未收到远端用户调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_sendstreammessage" title="发送数据流。"><span class="- topic/keyword keyword">sendStreamMessage</span></a> 方法发送的流消息。</p>
        </section>
        <section class="- topic/section section" id="api_onstreammessageerror__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessageerror__uid">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发送消息的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessageerror__streamId">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的消息的 Stream ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessageerror__code">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生错误的错误码。详见 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessageerror__missed">missed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">丢失的消息数量。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_onstreammessageerror__cached">cached</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">数据流中断时，后面缓存的消息数量。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title73" id="api_onuploadlogresult">
    <h2 class="- topic/title title topictitle2" id="ariaid-title73"><a href="class_irtcengineeventhandler.aspx#api_onuploadlogresult"><span class="- topic/ph ph">onUploadLogFile</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onuploadlogresult__shortdesc">报告日志文件上传结果。</span></p><section class="- topic/section section" id="api_onuploadlogresult__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUploadLogResult(<strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* requestId, <strong class="hl-keyword">bool</strong> success, UPLOAD_ERROR_REASON reason) {
 (<strong class="hl-keyword">void</strong>)requestId;
 (<strong class="hl-keyword">void</strong>)success;
 (<strong class="hl-keyword">void</strong>)reason;
 }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onuploadlogresult__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
   <p class="- topic/p p">调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_uploadlogfile" title="上传所有本地的 SDK 日志文件。"><span class="- topic/keyword keyword">uploadLogFile</span></a> 后，SDK 会触发该回调报告日志文件上传的结果。如果上传失败，请参考 <span class="+ topic/keyword pr-d/parmname keyword parmname">reason</span> 排查问题。</p>
        </section>
        <section class="- topic/section section" id="api_onuploadlogresult__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">requestId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">请求 ID。该请求 ID 与 <a href="class_irtcengine.aspx#api_uploadlogfile"><span class="- topic/ph ph">uploadLogFile</span></a> 中返回的 <span class="+ topic/keyword pr-d/parmname keyword parmname">requestId</span> 一致。你可以通过 <span class="+ topic/keyword pr-d/parmname keyword parmname">requestId</span> 将
  特定的上传和回调对应起来。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">success</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><div class="- topic/p p">是否成功上传日志文件: <ul class="- topic/ul ul">
      <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 日志文件上传成功。</li>
      <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 日志文件上传失败。失败的原因详见 <span class="+ topic/keyword pr-d/parmname keyword parmname">reason</span> 参数。</li>
  </ul></div></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">日志文件上传失败的原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_uploaderrorreason" title="日志文件上传失败的原因。"><span class="- topic/keyword keyword">UPLOAD_ERROR_REASON</span></a>。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title74" id="api_onwarning">
    <h2 class="- topic/title title topictitle2" id="ariaid-title74"><a href="class_irtcengineeventhandler.aspx#api_onwarning"><span class="- topic/ph ph">onWarning</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onwarning__shortdesc">发生警告回调。</span></p><section class="- topic/section section" id="api_onwarning__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onWarning(<strong class="hl-keyword">int</strong> warn, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* msg) {
        (<strong class="hl-keyword">void</strong>)warn;
        (<strong class="hl-keyword">void</strong>)msg;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onwarning__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调方法表示 SDK 运行时出现了（网络或媒体相关的）警告。通常情况下，SDK 上报的警告信息 App 可以忽略，SDK 会自动恢复。比如和服务器失去连接时，SDK
       可能会上报 <span class="+ topic/keyword pr-d/parmname keyword parmname">WARN_OPEN_CHANNEL_TIMEOUT</span> 警告，同时自动尝试重连。</p>
        </section>
        <section class="- topic/section section" id="api_onwarning__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">warn</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">警告代码，详见 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">msg</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">警告描述。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title75" id="api_onerror">
    <h2 class="- topic/title title topictitle2" id="ariaid-title75"><a href="class_irtcengineeventhandler.aspx#api_onerror"><span class="- topic/ph ph">onError</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onerror__shortdesc">发生错误回调。</span></p><section class="- topic/section section" id="api_onerror__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onError(<strong class="hl-keyword">int</strong> err, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* msg) {
        (<strong class="hl-keyword">void</strong>)err;
        (<strong class="hl-keyword">void</strong>)msg;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onerror__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调方法表示 SDK 运行时出现了（网络或媒体相关的）错误。通常情况下，SDK 上报的错误意味着 SDK 无法自动恢复，需要 App 干预或提示用户。
       比如启动通话失败时，SDK 会上报 <span class="+ topic/keyword pr-d/parmname keyword parmname">ERR_START_CALL</span> 错误。App 可以提示用户启动通话失败，并调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 退出频道。</p>
        </section>
        <section class="- topic/section section" id="api_onerror__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">err</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">错误代码，详见 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">msg</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">错误描述。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title76" id="api_onapicallexecuted">
    <h2 class="- topic/title title topictitle2" id="ariaid-title76"><a href="class_irtcengineeventhandler.aspx#api_onapicallexecuted"><span class="- topic/ph ph">onApiCallExecuted</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onapicallexecuted__shortdesc">API 方法已执行回调。</span></p><section class="- topic/section section" id="api_onapicallexecuted__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onApiCallExecuted(<strong class="hl-keyword">int</strong> err, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* api, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* result) {
        (<strong class="hl-keyword">void</strong>)err;
        (<strong class="hl-keyword">void</strong>)api;
        (<strong class="hl-keyword">void</strong>)result;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onapicallexecuted__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">err</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当方法调用失败时 SDK 返回的错误码。如果方法调用失败，会返回错误码。详细的错误信息及排查方法请参考 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a>。
  如果该方法调用成功，SDK 会返回 0。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">api</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">SDK 执行的 API 方法。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">result</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">SDK 调用 API 的结果。</dd>
       
   </dl>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title77" id="api_onmediaengineloadsuccess">
    <h2 class="- topic/title title topictitle2" id="ariaid-title77"><a href="class_irtcengineeventhandler.aspx#api_onmediaengineloadsuccess"><span class="- topic/ph ph">onMediaEngineLoadSuccess</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onmediaengineloadsuccess__shortdesc">媒体引擎成功加载的回调。</span></p><section class="- topic/section section" id="api_onmediaengineloadsuccess__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onMediaEngineLoadSuccess() {}</pre>   
  </div>
        </section>
</div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title78" id="api_onmediaenginestartcallsuccess">
    <h2 class="- topic/title title topictitle2" id="ariaid-title78"><a href="class_irtcengineeventhandler.aspx#api_onmediaenginestartcallsuccess"><span class="- topic/ph ph">onMediaEngineStartCallSuccess</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onmediaenginestartcallsuccess__shortdesc">媒体引擎成功启动的回调。</span></p><section class="- topic/section section" id="api_onmediaenginestartcallsuccess__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onMediaEngineStartCallSuccess() {}</pre>   
  </div>
        </section>
</div>
</article></article></article></main></div>
      
      
      
      
  </div>
  
      <nav role="navigation" id="wh_topic_toc" aria-label="On this page" class="col-lg-2 d-none d-lg-block navbar d-print-none"> 
 <div class=" wh_topic_toc "><div class="wh_topic_label">在本页上</div><ul><li class="topic-item"><a href="#api_onconnectionstatechanged" data-tocid="api_onconnectionstatechanged"><a href="class_irtcengineeventhandler.aspx#api_onconnectionstatechanged"><span class="- topic/ph ph">onConnectionStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onconnectionstatechanged__prototype" data-tocid="api_onconnectionstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onconnectionstatechanged__detailed_desc" data-tocid="api_onconnectionstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onconnectionstatechanged__parameters" data-tocid="api_onconnectionstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onjoinchannelsuccess" data-tocid="api_onjoinchannelsuccess"><a href="class_irtcengineeventhandler.aspx#api_onjoinchannelsuccess"><span class="- topic/ph ph">onJoinChannelSuccess</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onjoinchannelsuccess__prototype" data-tocid="api_onjoinchannelsuccess__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onjoinchannelsuccess__detailed_desc" data-tocid="api_onjoinchannelsuccess__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onjoinchannelsuccess__parameters" data-tocid="api_onjoinchannelsuccess__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onrejoinchannelsuccess" data-tocid="api_onrejoinchannelsuccess"><a href="class_irtcengineeventhandler.aspx#api_onrejoinchannelsuccess"><span class="- topic/ph ph">onRejoinChannelSuccess</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onrejoinchannelsuccess__prototype" data-tocid="api_onrejoinchannelsuccess__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrejoinchannelsuccess__detailed_desc" data-tocid="api_onrejoinchannelsuccess__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrejoinchannelsuccess__parameters" data-tocid="api_onrejoinchannelsuccess__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onleavechannel" data-tocid="api_onleavechannel"><a href="class_irtcengineeventhandler.aspx#api_onleavechannel"><span class="- topic/ph ph">onLeaveChannel</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onleavechannel__prototype" data-tocid="api_onleavechannel__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onleavechannel__detailed_desc" data-tocid="api_onleavechannel__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onleavechannel__parameters" data-tocid="api_onleavechannel__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onclientrolechanged" data-tocid="api_onclientrolechanged"><a href="class_irtcengineeventhandler.aspx#api_onclientrolechanged"><span class="- topic/ph ph">onClientRoleChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onclientrolechanged__prototype" data-tocid="api_onclientrolechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onclientrolechanged__detailed_desc" data-tocid="api_onclientrolechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onclientrolechanged__parameters" data-tocid="api_onclientrolechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onuserjoined" data-tocid="api_onuserjoined"><a href="class_irtcengineeventhandler.aspx#api_onuserjoined"><span class="- topic/ph ph">onUserJoined</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onuserjoined__parameters" data-tocid="api_onuserjoined__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onuseroffline" data-tocid="api_onuseroffline"><a href="class_irtcengineeventhandler.aspx#api_onuseroffline"><span class="- topic/ph ph">onUserOffline</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onuseroffline__prototype" data-tocid="api_onuseroffline__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuseroffline__detailed_desc" data-tocid="api_onuseroffline__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuseroffline__parameters" data-tocid="api_onuseroffline__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onnetworktypechanged" data-tocid="api_onnetworktypechanged"><a href="class_irtcengineeventhandler.aspx#api_onnetworktypechanged"><span class="- topic/ph ph">onNetworkTypeChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onnetworktypechanged__prototype" data-tocid="api_onnetworktypechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onnetworktypechanged__detailed_desc" data-tocid="api_onnetworktypechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onnetworktypechanged__parameters" data-tocid="api_onnetworktypechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onconnectioninterrupted" data-tocid="api_onconnectioninterrupted"><a href="class_irtcengineeventhandler.aspx#api_onconnectioninterrupted"><span class="- topic/ph ph">onConnectionInterrupted</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onconnectioninterrupted__prototype" data-tocid="api_onconnectioninterrupted__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onconnectioninterrupted__detailed_desc" data-tocid="api_onconnectioninterrupted__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onconnectionlost" data-tocid="api_onconnectionlost"><a href="class_irtcengineeventhandler.aspx#api_onconnectionlost"><span class="- topic/ph ph">onConnectionLost</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onconnectionlost__prototype" data-tocid="api_onconnectionlost__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onconnectionlost__detailed_desc" data-tocid="api_onconnectionlost__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onconnectionbanned" data-tocid="api_onconnectionbanned"><a href="class_irtcengineeventhandler.aspx#api_onconnectionbanned"><span class="- topic/ph ph">onConnectionBanned</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onconnectionbanned__prototype" data-tocid="api_onconnectionbanned__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onconnectionbanned__detailed_desc" data-tocid="api_onconnectionbanned__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_ontokenprivilegewillexpire" data-tocid="api_ontokenprivilegewillexpire"><a href="class_irtcengineeventhandler.aspx#api_ontokenprivilegewillexpire"><span class="- topic/ph ph">onTokenPrivilegeWillExpire</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ontokenprivilegewillexpire__prototype" data-tocid="api_ontokenprivilegewillexpire__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ontokenprivilegewillexpire__detailed_desc" data-tocid="api_ontokenprivilegewillexpire__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ontokenprivilegewillexpire__parameters" data-tocid="api_ontokenprivilegewillexpire__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onrequesttoken" data-tocid="api_onrequesttoken"><a href="class_irtcengineeventhandler.aspx#api_onrequesttoken"><span class="- topic/ph ph">onRequestToken</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onrequesttoken__prototype" data-tocid="api_onrequesttoken__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrequesttoken__detailed_desc" data-tocid="api_onrequesttoken__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onlocalaudiostatechanged" data-tocid="api_onlocalaudiostatechanged"><a href="class_irtcengineeventhandler.aspx#api_onlocalaudiostatechanged"><span class="- topic/ph ph">onLocalAudioStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlocalaudiostatechanged__prototype" data-tocid="api_onlocalaudiostatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalaudiostatechanged__detailed_desc" data-tocid="api_onlocalaudiostatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalaudiostatechanged__parameters" data-tocid="api_onlocalaudiostatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstlocalaudioframe" data-tocid="api_onfirstlocalaudioframe"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalaudioframe"><span class="- topic/ph ph">onFirstLocalAudioFrame</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalaudioframe__prototype" data-tocid="api_onfirstlocalaudioframe__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalaudioframe__detailed_desc" data-tocid="api_onfirstlocalaudioframe__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalaudioframe__parameters" data-tocid="api_onfirstlocalaudioframe__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onlocalvideostatechanged" data-tocid="api_onlocalvideostatechanged"><a href="class_irtcengineeventhandler.aspx#api_onlocalvideostatechanged"><span class="- topic/ph ph">onLocalVideoStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlocalvideostatechanged__prototype" data-tocid="api_onlocalvideostatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalvideostatechanged__detailed_desc" data-tocid="api_onlocalvideostatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalvideostatechanged__parameters" data-tocid="api_onlocalvideostatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onvideostopped" data-tocid="api_onvideostopped"><a href="class_irtcengineeventhandler.aspx#api_onvideostopped"><span class="- topic/ph ph">onVideoStopped</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onvideostopped__prototype" data-tocid="api_onvideostopped__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideostopped__detailed_desc" data-tocid="api_onvideostopped__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstlocalaudioframepublished" data-tocid="api_onfirstlocalaudioframepublished"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalaudioframepublished"><span class="- topic/ph ph">onFirstLocalAudioFramePublished</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalaudioframepublished__prototype" data-tocid="api_onfirstlocalaudioframepublished__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalaudioframepublished__detailed_desc" data-tocid="api_onfirstlocalaudioframepublished__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalaudioframepublished__parameters" data-tocid="api_onfirstlocalaudioframepublished__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstlocalvideoframepublished" data-tocid="api_onfirstlocalvideoframepublished"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalvideoframepublished"><span class="- topic/ph ph">onFirstLocalVideoFramePublished</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalvideoframepublished__prototype" data-tocid="api_onfirstlocalvideoframepublished__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalvideoframepublished__detailed_desc" data-tocid="api_onfirstlocalvideoframepublished__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalvideoframepublished__parameters" data-tocid="api_onfirstlocalvideoframepublished__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstlocalvideoframe" data-tocid="api_onfirstlocalvideoframe"><a href="class_irtcengineeventhandler.aspx#api_onfirstlocalvideoframe"><span class="- topic/ph ph">onFirstLocalVideoFrame</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalvideoframe__prototype" data-tocid="api_onfirstlocalvideoframe__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalvideoframe__detailed_desc" data-tocid="api_onfirstlocalvideoframe__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstlocalvideoframe__parameters" data-tocid="api_onfirstlocalvideoframe__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiopublishstatechanged" data-tocid="api_onaudiopublishstatechanged"><a href="class_irtcengineeventhandler.aspx#api_onaudiopublishstatechanged"><span class="- topic/ph ph">onAudioPublishStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiopublishstatechanged__prototype" data-tocid="api_onaudiopublishstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiopublishstatechanged__detailed_desc" data-tocid="api_onaudiopublishstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiopublishstatechanged__parameters" data-tocid="api_onaudiopublishstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onvideopublishstatechanged" data-tocid="api_onvideopublishstatechanged"><a href="class_irtcengineeventhandler.aspx#api_onvideopublishstatechanged"><span class="- topic/ph ph">onVideoPublishStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onvideopublishstatechanged__prototype" data-tocid="api_onvideopublishstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideopublishstatechanged__detailed_desc" data-tocid="api_onvideopublishstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideopublishstatechanged__parameters" data-tocid="api_onvideopublishstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremoteaudiostatechanged" data-tocid="api_onremoteaudiostatechanged"><a href="class_irtcengineeventhandler.aspx#api_onremoteaudiostatechanged"><span class="- topic/ph ph">onRemoteAudioStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiostatechanged__prototype" data-tocid="api_onremoteaudiostatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiostatechanged__detailed_desc" data-tocid="api_onremoteaudiostatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiostatechanged__parameters" data-tocid="api_onremoteaudiostatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremotevideostatechanged" data-tocid="api_onremotevideostatechanged"><a href="class_irtcengineeventhandler.aspx#api_onremotevideostatechanged"><span class="- topic/ph ph">onRemoteVideoStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremotevideostatechanged__prototype" data-tocid="api_onremotevideostatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotevideostatechanged__detailed_desc" data-tocid="api_onremotevideostatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotevideostatechanged__parameters" data-tocid="api_onremotevideostatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstremoteaudioframe" data-tocid="api_onfirstremoteaudioframe"><a href="class_irtcengineeventhandler.aspx#api_onfirstremoteaudioframe"><span class="- topic/ph ph">onFirstRemoteAudioFrame</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstremoteaudioframe__prototype" data-tocid="api_onfirstremoteaudioframe__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremoteaudioframe__detailed_desc" data-tocid="api_onfirstremoteaudioframe__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremoteaudioframe__parameters" data-tocid="api_onfirstremoteaudioframe__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstremoteaudiodecoded" data-tocid="api_onfirstremoteaudiodecoded"><a href="class_irtcengineeventhandler.aspx#api_onfirstremoteaudiodecoded"><span class="- topic/ph ph">onFirstRemoteAudioDecoded</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstremoteaudiodecoded__prototype" data-tocid="api_onfirstremoteaudiodecoded__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremoteaudiodecoded__detailed_desc" data-tocid="api_onfirstremoteaudiodecoded__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremoteaudiodecoded__parameters" data-tocid="api_onfirstremoteaudiodecoded__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstremotevideoframe" data-tocid="api_onfirstremotevideoframe"><a href="class_irtcengineeventhandler.aspx#api_onfirstremotevideoframe"><span class="- topic/ph ph">onFirstRemoteVideoFrame</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstremotevideoframe__prototype" data-tocid="api_onfirstremotevideoframe__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremotevideoframe__detailed_desc" data-tocid="api_onfirstremotevideoframe__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremotevideoframe__parameters" data-tocid="api_onfirstremotevideoframe__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfirstremotevideodecoded" data-tocid="api_onfirstremotevideodecoded"><a href="class_irtcengineeventhandler.aspx#api_onfirstremotevideodecoded"><span class="- topic/ph ph">onFirstRemoteVideoDecoded</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfirstremotevideodecoded__prototype" data-tocid="api_onfirstremotevideodecoded__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremotevideodecoded__detailed_desc" data-tocid="api_onfirstremotevideodecoded__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfirstremotevideodecoded__parameters" data-tocid="api_onfirstremotevideodecoded__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiosubscribestatechanged" data-tocid="api_onaudiosubscribestatechanged"><a href="class_irtcengineeventhandler.aspx#api_onaudiosubscribestatechanged"><span class="- topic/ph ph">onAudioSubscribeStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiosubscribestatechanged__prototype" data-tocid="api_onaudiosubscribestatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiosubscribestatechanged__detailed_desc" data-tocid="api_onaudiosubscribestatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiosubscribestatechanged__parameters" data-tocid="api_onaudiosubscribestatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onvideosubscribestatechanged" data-tocid="api_onvideosubscribestatechanged"><a href="class_irtcengineeventhandler.aspx#api_onvideosubscribestatechanged"><span class="- topic/ph ph">onVideoSubscribeStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onvideosubscribestatechanged__prototype" data-tocid="api_onvideosubscribestatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideosubscribestatechanged__detailed_desc" data-tocid="api_onvideosubscribestatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideosubscribestatechanged__parameters" data-tocid="api_onvideosubscribestatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onusermuteaudio" data-tocid="api_onusermuteaudio"><a href="class_irtcengineeventhandler.aspx#api_onusermuteaudio"><span class="- topic/ph ph">onUserMuteAudio</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onusermuteaudio__prototype" data-tocid="api_onusermuteaudio__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onusermuteaudio__detailed_desc" data-tocid="api_onusermuteaudio__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onusermuteaudio__parameters" data-tocid="api_onusermuteaudio__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onusermutevideo" data-tocid="api_onusermutevideo"><a href="class_irtcengineeventhandler.aspx#api_onusermutevideo"><span class="- topic/ph ph">onUserMuteVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onusermutevideo__prototype" data-tocid="api_onusermutevideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onusermutevideo__detailed_desc" data-tocid="api_onusermutevideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onusermutevideo__parameters" data-tocid="api_onusermutevideo__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onuserenablevideo" data-tocid="api_onuserenablevideo"><a href="class_irtcengineeventhandler.aspx#api_onuserenablevideo"><span class="- topic/ph ph">onUserEnableVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onuserenablevideo__prototype" data-tocid="api_onuserenablevideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuserenablevideo__detailed_desc" data-tocid="api_onuserenablevideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuserenablevideo__parameters" data-tocid="api_onuserenablevideo__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onuserenablelocalvideo" data-tocid="api_onuserenablelocalvideo"><a href="class_irtcengineeventhandler.aspx#api_onuserenablelocalvideo"><span class="- topic/ph ph">onUserEnableLocalVideo</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onuserenablelocalvideo__prototype" data-tocid="api_onuserenablelocalvideo__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuserenablelocalvideo__detailed_desc" data-tocid="api_onuserenablelocalvideo__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuserenablelocalvideo__parameters" data-tocid="api_onuserenablelocalvideo__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onvideosizechanged" data-tocid="api_onvideosizechanged"><a href="class_irtcengineeventhandler.aspx#api_onvideosizechanged"><span class="- topic/ph ph">onVideoSizeChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onvideosizechanged__prototype" data-tocid="api_onvideosizechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideosizechanged__parameters" data-tocid="api_onvideosizechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onrtcstats" data-tocid="api_onrtcstats"><a href="class_irtcengineeventhandler.aspx#api_onrtcstats"><span class="- topic/ph ph">onRtcStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onrtcstats__prototype" data-tocid="api_onrtcstats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrtcstats__detailed_desc" data-tocid="api_onrtcstats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrtcstats__parameters" data-tocid="api_onrtcstats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onnetworkquality" data-tocid="api_onnetworkquality"><a href="class_irtcengineeventhandler.aspx#api_onnetworkquality"><span class="- topic/ph ph">onNetworkQuality</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onnetworkquality__prototype" data-tocid="api_onnetworkquality__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onnetworkquality__detailed_desc" data-tocid="api_onnetworkquality__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onnetworkquality__parameters" data-tocid="api_onnetworkquality__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onlocalaudiostats" data-tocid="api_onlocalaudiostats"><a href="class_irtcengineeventhandler.aspx#api_onlocalaudiostats"><span class="- topic/ph ph">onLocalAudioStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlocalaudiostats__prototype" data-tocid="api_onlocalaudiostats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalaudiostats__detailed_desc" data-tocid="api_onlocalaudiostats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalaudiostats__parameters" data-tocid="api_onlocalaudiostats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onlocalvideostats" data-tocid="api_onlocalvideostats"><a href="class_irtcengineeventhandler.aspx#api_onlocalvideostats"><span class="- topic/ph ph">onLocalVideoStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlocalvideostats__prototype" data-tocid="api_onlocalvideostats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalvideostats__detailed_desc" data-tocid="api_onlocalvideostats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalvideostats__parameters" data-tocid="api_onlocalvideostats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremoteaudiostats" data-tocid="api_onremoteaudiostats"><a href="class_irtcengineeventhandler.aspx#api_onremoteaudiostats"><span class="- topic/ph ph">onRemoteAudioStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiostats__prototype" data-tocid="api_onremoteaudiostats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiostats__detailed_desc" data-tocid="api_onremoteaudiostats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiostats__parameters" data-tocid="api_onremoteaudiostats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremoteaudiotransportstats" data-tocid="api_onremoteaudiotransportstats"><a href="class_irtcengineeventhandler.aspx#api_onremoteaudiotransportstats"><span class="- topic/ph ph">onRemoteAudioTransportStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiotransportstats__prototype" data-tocid="api_onremoteaudiotransportstats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiotransportstats__detailed_desc" data-tocid="api_onremoteaudiotransportstats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremoteaudiotransportstats__parameters" data-tocid="api_onremoteaudiotransportstats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremotevideostats" data-tocid="api_onremotevideostats"><a href="class_irtcengineeventhandler.aspx#api_onremotevideostats"><span class="- topic/ph ph">onRemoteVideoStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremotevideostats__prototype" data-tocid="api_onremotevideostats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotevideostats__detailed_desc" data-tocid="api_onremotevideostats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotevideostats__parameters" data-tocid="api_onremotevideostats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremotevideotransportstats" data-tocid="api_onremotevideotransportstats"><a href="class_irtcengineeventhandler.aspx#api_onremotevideotransportstats"><span class="- topic/ph ph">onRemoteVideoTransportStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremotevideotransportstats__prototype" data-tocid="api_onremotevideotransportstats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotevideotransportstats__detailed_desc" data-tocid="api_onremotevideotransportstats__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotevideotransportstats__parameters" data-tocid="api_onremotevideotransportstats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudioquality" data-tocid="api_onaudioquality"><a href="class_irtcengineeventhandler.aspx#api_onaudioquality"><span class="- topic/ph ph">onAudioQuality</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudioquality__prototype" data-tocid="api_onaudioquality__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudioquality__detailed_desc" data-tocid="api_onaudioquality__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudioquality__parameters" data-tocid="api_onaudioquality__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiomixingstatechanged" data-tocid="api_onaudiomixingstatechanged"><a href="class_irtcengineeventhandler.aspx#api_onaudiomixingstatechanged"><span class="- topic/ph ph">onAudioMixingStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiomixingstatechanged__prototype" data-tocid="api_onaudiomixingstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiomixingstatechanged__detailed_desc" data-tocid="api_onaudiomixingstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiomixingstatechanged__parameters" data-tocid="api_onaudiomixingstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiomixingfinished" data-tocid="api_onaudiomixingfinished"><a href="class_irtcengineeventhandler.aspx#api_onaudiomixingfinished"><span class="- topic/ph ph">onAudioMixingFinished</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiomixingfinished__prototype" data-tocid="api_onaudiomixingfinished__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiomixingfinished__detailed_desc" data-tocid="api_onaudiomixingfinished__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudioeffectfinished" data-tocid="api_onaudioeffectfinished"><a href="class_irtcengineeventhandler.aspx#api_onaudioeffectfinished"><span class="- topic/ph ph">onAudioEffectFinished</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudioeffectfinished__prototype" data-tocid="api_onaudioeffectfinished__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudioeffectfinished__detailed_desc" data-tocid="api_onaudioeffectfinished__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudioeffectfinished__parameters" data-tocid="api_onaudioeffectfinished__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onrtmpstreamingstatechanged" data-tocid="api_onrtmpstreamingstatechanged"><a href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingstatechanged"><span class="- topic/ph ph">onRtmpStreamingStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onrtmpstreamingstatechanged__prototype" data-tocid="api_onrtmpstreamingstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrtmpstreamingstatechanged__detailed_desc" data-tocid="api_onrtmpstreamingstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrtmpstreamingstatechanged__parameters" data-tocid="api_onrtmpstreamingstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onrtmpstreamingevent" data-tocid="api_onrtmpstreamingevent"><a href="class_irtcengineeventhandler.aspx#api_onrtmpstreamingevent"><span class="- topic/ph ph">onRtmpStreamingEvent</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onrtmpstreamingevent__prototype" data-tocid="api_onrtmpstreamingevent__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrtmpstreamingevent__detailed_desc" data-tocid="api_onrtmpstreamingevent__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onrtmpstreamingevent__parameters" data-tocid="api_onrtmpstreamingevent__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ontranscodingupdated" data-tocid="api_ontranscodingupdated"><a href="class_irtcengineeventhandler.aspx#api_ontranscodingupdated"><span class="- topic/ph ph">onTranscodingUpdated</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ontranscodingupdated__prototype" data-tocid="api_ontranscodingupdated__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ontranscodingupdated__detailed_desc" data-tocid="api_ontranscodingupdated__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onstreampublished" data-tocid="api_onstreampublished"><a href="class_irtcengineeventhandler.aspx#api_onstreampublished"><span class="- topic/ph ph">onStreamPublished</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onstreampublished__prototype" data-tocid="api_onstreampublished__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreampublished__detailed_desc" data-tocid="api_onstreampublished__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreampublished__parameters" data-tocid="api_onstreampublished__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onstreamunpublished" data-tocid="api_onstreamunpublished"><a href="class_irtcengineeventhandler.aspx#api_onstreamunpublished"><span class="- topic/ph ph">onStreamUnpublished</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onstreamunpublished__prototype" data-tocid="api_onstreamunpublished__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreamunpublished__detailed_desc" data-tocid="api_onstreamunpublished__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreamunpublished__parameters" data-tocid="api_onstreamunpublished__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onchannelmediarelaystatechanged" data-tocid="api_onchannelmediarelaystatechanged"><a href="class_irtcengineeventhandler.aspx#api_onchannelmediarelaystatechanged"><span class="- topic/ph ph">onChannelMediaRelayStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onchannelmediarelaystatechanged__prototype" data-tocid="api_onchannelmediarelaystatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onchannelmediarelaystatechanged__detailed_desc" data-tocid="api_onchannelmediarelaystatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onchannelmediarelaystatechanged__parameters" data-tocid="api_onchannelmediarelaystatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onchannelmediarelayevent" data-tocid="api_onchannelmediarelayevent"><a href="class_irtcengineeventhandler.aspx#api_onchannelmediarelayevent"><span class="- topic/ph ph">onChannelMediaRelayEvent</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onchannelmediarelayevent__prototype" data-tocid="api_onchannelmediarelayevent__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onchannelmediarelayevent__detailed_desc" data-tocid="api_onchannelmediarelayevent__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onchannelmediarelayevent__parameters" data-tocid="api_onchannelmediarelayevent__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiovolumeindication" data-tocid="api_onaudiovolumeindication"><a href="class_irtcengineeventhandler.aspx#api_onaudiovolumeindication"><span class="- topic/ph ph">onAudioVolumeIndication</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiovolumeindication__prototype" data-tocid="api_onaudiovolumeindication__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiovolumeindication__detailed_desc" data-tocid="api_onaudiovolumeindication__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiovolumeindication__parameters" data-tocid="api_onaudiovolumeindication__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onactivespeaker" data-tocid="api_onactivespeaker"><a href="class_irtcengineeventhandler.aspx#api_onactivespeaker"><span class="- topic/ph ph">onActiveSpeaker</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onactivespeaker__prototype" data-tocid="api_onactivespeaker__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onactivespeaker__detailed_desc" data-tocid="api_onactivespeaker__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onactivespeaker__parameters" data-tocid="api_onactivespeaker__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onfacepositionchanged" data-tocid="api_onfacepositionchanged"><a href="class_irtcengineeventhandler.aspx#api_onfacepositionchanged"><span class="- topic/ph ph">onFacePositionChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onfacepositionchanged__prototype" data-tocid="api_onfacepositionchanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfacepositionchanged__detailed_desc" data-tocid="api_onfacepositionchanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onfacepositionchanged__parameters" data-tocid="api_onfacepositionchanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudioroutechanged" data-tocid="api_onaudioroutechanged"><a href="class_irtcengineeventhandler.aspx#api_onaudioroutechanged"><span class="- topic/ph ph">onAudioRouteChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudioroutechanged__prototype" data-tocid="api_onaudioroutechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudioroutechanged__detailed_desc" data-tocid="api_onaudioroutechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudioroutechanged__parameters" data-tocid="api_onaudioroutechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onlocalpublishfallbacktoaudioonly" data-tocid="api_onlocalpublishfallbacktoaudioonly"><a href="class_irtcengineeventhandler.aspx#api_onlocalpublishfallbacktoaudioonly"><span class="- topic/ph ph">onLocalPublishFallbackToAudioOnly</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlocalpublishfallbacktoaudioonly__prototype" data-tocid="api_onlocalpublishfallbacktoaudioonly__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalpublishfallbacktoaudioonly__detailed_desc" data-tocid="api_onlocalpublishfallbacktoaudioonly__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlocalpublishfallbacktoaudioonly__parameters" data-tocid="api_onlocalpublishfallbacktoaudioonly__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onremotesubscribefallbacktoaudioonly" data-tocid="api_onremotesubscribefallbacktoaudioonly"><a href="class_irtcengineeventhandler.aspx#api_onremotesubscribefallbacktoaudioonly"><span class="- topic/ph ph">onRemoteSubscribeFallbackToAudioOnly</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onremotesubscribefallbacktoaudioonly__prototype" data-tocid="api_onremotesubscribefallbacktoaudioonly__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotesubscribefallbacktoaudioonly__detailed_desc" data-tocid="api_onremotesubscribefallbacktoaudioonly__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onremotesubscribefallbacktoaudioonly__parameters" data-tocid="api_onremotesubscribefallbacktoaudioonly__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onlastmilequality" data-tocid="api_onlastmilequality"><a href="class_irtcengineeventhandler.aspx#api_onlastmilequality"><span class="- topic/ph ph">onLastmileQuality</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlastmilequality__prototype" data-tocid="api_onlastmilequality__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlastmilequality__detailed_desc" data-tocid="api_onlastmilequality__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlastmilequality__parameters" data-tocid="api_onlastmilequality__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onlastmileproberesult" data-tocid="api_onlastmileproberesult"><a href="class_irtcengineeventhandler.aspx#api_onlastmileproberesult"><span class="- topic/ph ph">onLastmileProbeResult</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onlastmileproberesult__prototype" data-tocid="api_onlastmileproberesult__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlastmileproberesult__detailed_desc" data-tocid="api_onlastmileproberesult__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onlastmileproberesult__parameters" data-tocid="api_onlastmileproberesult__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onstreaminjectedstatus" data-tocid="api_onstreaminjectedstatus"><a href="class_irtcengineeventhandler.aspx#api_onstreaminjectedstatus"><span class="- topic/ph ph">onStreamInjectedStatus</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onstreaminjectedstatus__prototype" data-tocid="api_onstreaminjectedstatus__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreaminjectedstatus__detailed_desc" data-tocid="api_onstreaminjectedstatus__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreaminjectedstatus__parameters" data-tocid="api_onstreaminjectedstatus__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreaminjectedstatus__return_values" data-tocid="api_onstreaminjectedstatus__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_oncamerafocusareachanged" data-tocid="api_oncamerafocusareachanged"><a href="class_irtcengineeventhandler.aspx#api_oncamerafocusareachanged"><span class="- topic/ph ph">onCameraFocusAreaChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_oncamerafocusareachanged__prototype" data-tocid="api_oncamerafocusareachanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_oncamerafocusareachanged__detailed_desc" data-tocid="api_oncamerafocusareachanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_oncamerafocusareachanged__parameters" data-tocid="api_oncamerafocusareachanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_oncameraexposureareachanged" data-tocid="api_oncameraexposureareachanged"><a href="class_irtcengineeventhandler.aspx#api_oncameraexposureareachanged"><span class="- topic/ph ph">onCameraExposureAreaChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_oncameraexposureareachanged__prototype" data-tocid="api_oncameraexposureareachanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_oncameraexposureareachanged__detailed_desc" data-tocid="api_oncameraexposureareachanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_oncameraexposureareachanged__parameters" data-tocid="api_oncameraexposureareachanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_oncameraready" data-tocid="api_oncameraready"><a href="class_irtcengineeventhandler.aspx#api_oncameraready"><span class="- topic/ph ph">onCameraReady</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_oncameraready__prototype" data-tocid="api_oncameraready__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_oncameraready__detailed_desc" data-tocid="api_oncameraready__detailed_desc">详细描述</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiodevicestatechanged" data-tocid="api_onaudiodevicestatechanged"><a href="class_irtcengineeventhandler.aspx#api_onaudiodevicestatechanged"><span class="- topic/ph ph">onAudioDeviceStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiodevicestatechanged__prototype" data-tocid="api_onaudiodevicestatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiodevicestatechanged__detailed_desc" data-tocid="api_onaudiodevicestatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiodevicestatechanged__parameters" data-tocid="api_onaudiodevicestatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onaudiodevicevolumechanged" data-tocid="api_onaudiodevicevolumechanged"><a href="class_irtcengineeventhandler.aspx#api_onaudiodevicevolumechanged"><span class="- topic/ph ph">onAudioDeviceVolumeChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onaudiodevicevolumechanged__prototype" data-tocid="api_onaudiodevicevolumechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onaudiodevicevolumechanged__parameters" data-tocid="api_onaudiodevicevolumechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onvideodevicestatechanged" data-tocid="api_onvideodevicestatechanged"><a href="class_irtcengineeventhandler.aspx#api_onvideodevicestatechanged"><span class="- topic/ph ph">onVideoDeviceStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onvideodevicestatechanged__prototype" data-tocid="api_onvideodevicestatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideodevicestatechanged__detailed_desc" data-tocid="api_onvideodevicestatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onvideodevicestatechanged__parameters" data-tocid="api_onvideodevicestatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onstreammessage" data-tocid="api_onstreammessage"><a href="class_irtcengineeventhandler.aspx#api_onstreammessage"><span class="- topic/ph ph">onStreamMessage</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onstreammessage__prototype" data-tocid="api_onstreammessage__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreammessage__detailed_desc" data-tocid="api_onstreammessage__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreammessage__parameters" data-tocid="api_onstreammessage__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onstreammessageerror" data-tocid="api_onstreammessageerror"><a href="class_irtcengineeventhandler.aspx#api_onstreammessageerror"><span class="- topic/ph ph">onStreamMessageError</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onstreammessageerror__prototype" data-tocid="api_onstreammessageerror__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreammessageerror__detailed_desc" data-tocid="api_onstreammessageerror__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onstreammessageerror__parameters" data-tocid="api_onstreammessageerror__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onuploadlogresult" data-tocid="api_onuploadlogresult"><a href="class_irtcengineeventhandler.aspx#api_onuploadlogresult"><span class="- topic/ph ph">onUploadLogFile</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onuploadlogresult__prototype" data-tocid="api_onuploadlogresult__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuploadlogresult__detailed_desc" data-tocid="api_onuploadlogresult__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onuploadlogresult__parameters" data-tocid="api_onuploadlogresult__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onwarning" data-tocid="api_onwarning"><a href="class_irtcengineeventhandler.aspx#api_onwarning"><span class="- topic/ph ph">onWarning</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onwarning__prototype" data-tocid="api_onwarning__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onwarning__detailed_desc" data-tocid="api_onwarning__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onwarning__parameters" data-tocid="api_onwarning__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onerror" data-tocid="api_onerror"><a href="class_irtcengineeventhandler.aspx#api_onerror"><span class="- topic/ph ph">onError</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onerror__prototype" data-tocid="api_onerror__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onerror__detailed_desc" data-tocid="api_onerror__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onerror__parameters" data-tocid="api_onerror__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onapicallexecuted" data-tocid="api_onapicallexecuted"><a href="class_irtcengineeventhandler.aspx#api_onapicallexecuted"><span class="- topic/ph ph">onApiCallExecuted</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onapicallexecuted__prototype" data-tocid="api_onapicallexecuted__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onapicallexecuted__parameters" data-tocid="api_onapicallexecuted__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_onmediaengineloadsuccess" data-tocid="api_onmediaengineloadsuccess"><a href="class_irtcengineeventhandler.aspx#api_onmediaengineloadsuccess"><span class="- topic/ph ph">onMediaEngineLoadSuccess</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onmediaengineloadsuccess__prototype" data-tocid="api_onmediaengineloadsuccess__prototype">原型</a></div></li></ul></li><li class="topic-item"><a href="#api_onmediaenginestartcallsuccess" data-tocid="api_onmediaenginestartcallsuccess"><a href="class_irtcengineeventhandler.aspx#api_onmediaenginestartcallsuccess"><span class="- topic/ph ph">onMediaEngineStartCallSuccess</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onmediaenginestartcallsuccess__prototype" data-tocid="api_onmediaenginestartcallsuccess__prototype">原型</a></div></li></ul></li></ul></div>
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