
<!DOCTYPE html
  SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:whc="http://www.oxygenxml.com/webhelp/components" xml:lang="zh-cn" lang="zh-cn" whc:version="22.0">
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta charset="UTF-8" /><meta name="copyright" content="(C) 版权 2021" /><meta name="DC.rights.owner" content="(C) 版权 2021" /><meta name="DC.type" content="reference" /><meta name="description" content="IChannelEventHandler 接口类用于 SDK 向 app 发送 IChannel 频道的回调事件通知。" /><meta name="DC.subject" content="IChannelEventHandler, onChannelWarning, onChannelError, onJoinChannelSuccess, onRejoinChannelSuccess, onLeaveChannel, onClientRoleChanged, onUserJoined, onUserOffline, onConnectionLost, onRequestToken, onTokenPrivilegeWillExpire, onRtcStats, onNetworkQuality, onRemoteVideoStats, onRemoteAudioStats, onRemoteAudioStateChanged, onAudioPublishStateChanged, onVideoPublishStateChanged, onAudioSubscribeStateChanged, onVideoSubscribeStateChanged, onActiveSpeaker, onVideoSizeChanged, onRemoteVideoStateChanged, onStreamMessage, onStreamMessageError, onChannelMediaRelayStateChanged, onChannelMediaRelayEvent, onRtmpStreamingStateChanged, onRtmpStreamingEvent, onTranscodingUpdated, onStreamInjectedStatus, onLocalPublishFallbackToAudioOnly, onRemoteSubscribeFallbackToAudioOnly, onConnectionStateChanged" /><meta name="keywords" content="IChannelEventHandler, onChannelWarning, onChannelError, onJoinChannelSuccess, onRejoinChannelSuccess, onLeaveChannel, onClientRoleChanged, onUserJoined, onUserOffline, onConnectionLost, onRequestToken, onTokenPrivilegeWillExpire, onRtcStats, onNetworkQuality, onRemoteVideoStats, onRemoteAudioStats, onRemoteAudioStateChanged, onAudioPublishStateChanged, onVideoPublishStateChanged, onAudioSubscribeStateChanged, onVideoSubscribeStateChanged, onActiveSpeaker, onVideoSizeChanged, onRemoteVideoStateChanged, onStreamMessage, onStreamMessageError, onChannelMediaRelayStateChanged, onChannelMediaRelayEvent, onRtmpStreamingStateChanged, onRtmpStreamingEvent, onTranscodingUpdated, onStreamInjectedStatus, onLocalPublishFallbackToAudioOnly, onRemoteSubscribeFallbackToAudioOnly, onConnectionStateChanged" /><meta name="indexterms" content="onChannelWarning, onChannelError, onJoinChannelSuccess, onRejoinChannelSuccess, onLeaveChannel, onClientRoleChanged, onUserJoined, onUserOffline, onConnectionLost, onRequestToken, onTokenPrivilegeWillExpire, onRtcStats, onNetworkQuality, onRemoteVideoStats, onRemoteAudioStats, onRemoteAudioStateChanged, onAudioPublishStateChanged, onVideoPublishStateChanged, onAudioSubscribeStateChanged, onVideoSubscribeStateChanged, onActiveSpeaker, onVideoSizeChanged, onRemoteVideoStateChanged, onStreamMessage, onStreamMessageError, onChannelMediaRelayStateChanged, onChannelMediaRelayEvent, onRtmpStreamingStateChanged, onRtmpStreamingEvent, onTranscodingUpdated, onStreamInjectedStatus, onLocalPublishFallbackToAudioOnly, onRemoteSubscribeFallbackToAudioOnly, onConnectionStateChanged" /><meta name="DC.format" content="HTML5" /><meta name="DC.identifier" content="class_ichanneleventhandler" />        
      <title>IChannelEventHandler</title><!--  Generated with Oxygen version 23.0, build number 2020121702.  --><meta name="wh-path2root" content="../" /><meta name="wh-toc-id" content="class_ichanneleventhandler-d4991e16473" /><meta name="wh-source-relpath" content="API/class_ichanneleventhandler.dita" /><meta name="wh-out-relpath" content="API/class_ichanneleventhandler.aspx" />
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
  <div data-tooltip-position="bottom" class=" wh_breadcrumb "><ol xmlns:html="http://www.w3.org/1999/xhtml" class="d-print-none"><li><span class="home"><a href="../index.aspx"><span>主页</span></a></span></li><li><span class="topicref"><span class="title"><a href="../API/rtc_api_overview.aspx">C++ API Reference for All Platforms</a></span></span></li><li class="active"><span class="topicref" data-id="class_ichanneleventhandler"><span class="title"><a href="../API/class_ichanneleventhandler.aspx#class_ichanneleventhandler"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichanneleventhandler.html#class_ichanneleventhandler"><span class="ph">IChannelEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IChannelEventHandler</span> 接口类用于 SDK 向 app 发送 <a href="../API/class_ichannel.html#class_ichannel" class="xref"><span class="keyword">IChannel</span></a> 频道的回调事件通知。</span></p></span></span></span></li></ol></div>

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
 <div class=" wh_publication_toc " data-tooltip-position="right"><ul role="tree" aria-label="Table of Contents"><span class="expand-button-action-labels"><span id="button-expand-action" aria-label="Expand"></span><span id="button-collapse-action" aria-label="Collapse"></span><span id="button-pending-action" aria-label="Pending"></span></span><li role="treeitem" aria-expanded="true"><span data-tocid="tocId-d4991e13735" class="topicref" data-state="expanded"><span role="button" tabindex="0" aria-labelledby="button-collapse-action tocId-d4991e13735-link" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="tocId-d4991e13735-link">C++ API Reference for All Platforms</a></span></span><ul role="group" class="navbar-nav nav-list"><li role="treeitem"><span data-tocid="api-title-d4991e13736" class="topicref" data-id="api-title" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="api-title-d4991e13736-link">API Overview</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">声网通过全球部署的虚拟网络，提供可以灵活搭配的 API 组合，提供质量可靠的实时音视频通信。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_rtcengine-d4991e13748" class="topicref" data-id="class_rtcengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengine.aspx#class_rtcengine" id="class_rtcengine-d4991e13748-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengine.html#class_rtcengine"><span class="ph">IRtcEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichannel-d4991e15906" class="topicref" data-id="class_ichannel" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichannel.aspx#class_ichannel" id="class_ichannel-d4991e15906-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichannel.html#class_ichannel"><span class="ph">IChannel</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">调用 <a href="../API/class_irtcengine.html#api_createChannel" class="xref"><span class="keyword">createChannel</span></a> 创建一个 <span class="keyword apiname">IChannel</span> 对象。</span></p></span></span></span></li><li role="treeitem" class="active"><span data-tocid="class_ichanneleventhandler-d4991e16473" class="topicref" data-id="class_ichanneleventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichanneleventhandler.aspx#class_ichanneleventhandler" id="class_ichanneleventhandler-d4991e16473-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichanneleventhandler.html#class_ichanneleventhandler"><span class="ph">IChannelEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IChannelEventHandler</span> 接口类用于 SDK 向 app 发送 <a href="../API/class_ichannel.html#class_ichannel" class="xref"><span class="keyword">IChannel</span></a> 频道的回调事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imediaengine-d4991e16949" class="topicref" data-id="class_imediaengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imediaengine.aspx#class_imediaengine" id="class_imediaengine-d4991e16949-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imediaengine.html#class_imediaengine"><span class="ph">IMediaEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IMediaEngine</span> 类。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ipacketobserver-d4991e17061" class="topicref" data-id="class_ipacketobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ipacketobserver.aspx#class_ipacketobserver" id="class_ipacketobserver-d4991e17061-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ipacketobserver.html#class_ipacketobserver"><span class="ph">IPacketObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IPacketObserver 定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicemanager-d4991e17126" class="topicref" data-id="class_iaudiodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicemanager.aspx#class_iaudiodevicemanager" id="class_iaudiodevicemanager-d4991e17126-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicemanager.html#class_iaudiodevicemanager"><span class="ph">IAudioDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">音频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicecollection-d4991e17443" class="topicref" data-id="class_iaudiodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicecollection.aspx#class_iaudiodevicecollection" id="class_iaudiodevicecollection-d4991e17443-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicecollection.html#class_iaudiodevicecollection"><span class="ph">IAudioDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IAudioDeviceCollection 类。你可以通过该接口类获取音频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideosource-d4991e17560" class="topicref" data-id="class_ivideosource" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideosource.aspx#class_ivideosource" id="class_ivideosource-d4991e17560-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideosource.html#class_ivideosource"><span class="ph">IVideoSource</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoSource 类，可以设置自定义的视频源。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeconsumer-d4991e17664" class="topicref" data-id="class_ivideoframeconsumer" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeconsumer.aspx#class_ivideoframeconsumer" id="class_ivideoframeconsumer-d4991e17664-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeconsumer.html#class_ivideoframeconsumer"><span class="ph">IVideoFrameConsumer</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IVideoFrameConsumer</span> 类，用于让 SDK 接收你采集的视频帧。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicemanager-d4991e17692" class="topicref" data-id="class_ivideodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicemanager.aspx#class_ivideodevicemanager" id="class_ivideodevicemanager-d4991e17692-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicemanager.html#class_ivideodevicemanager"><span class="ph">IVideoDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicecollection-d4991e17788" class="topicref" data-id="class_ivideodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicecollection.aspx#class_ivideodevicecollection" id="class_ivideodevicecollection-d4991e17788-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicecollection.html#class_ivideodevicecollection"><span class="ph">IVideoDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoDeviceCollection 类。你可以通过该接口类获取视频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_rtcengineeventhandler-d4991e17857" class="topicref" data-id="class_rtcengineeventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengineeventhandler.aspx#class_rtcengineeventhandler" id="class_rtcengineeventhandler-d4991e17857-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengineeventhandler.html#class_rtcengineeventhandler"><span class="ph">IRtcEngineEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IRtcEngineEventHandler</span> 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK的事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudioframeobserver-d4991e18897" class="topicref" data-id="class_iaudioframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudioframeobserver.aspx#class_iaudioframeobserver" id="class_iaudioframeobserver-d4991e18897-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudioframeobserver.html#class_iaudioframeobserver"><span class="ph">IAudioFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">语音观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeobserver-d4991e19014" class="topicref" data-id="class_ivideoframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeobserver.aspx#class_ivideoframeobserver" id="class_ivideoframeobserver-d4991e19014-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeobserver.html#class_ivideoframeobserver"><span class="ph">IVideoFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imetadataobserver-d4991e19199" class="topicref" data-id="class_imetadataobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imetadataobserver.aspx#class_imetadataobserver" id="class_imetadataobserver-d4991e19199-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imetadataobserver.html#class_imetadataobserver"><span class="ph">IMetadataObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Metadata 观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="datatype-d4991e19289" class="topicref" data-id="datatype" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_data_type.aspx#datatype" id="datatype-d4991e19289-link">类型定义</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">本页列出 <span class="ph">Windows</span> API 所有的类型定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="错误码和警告码-d4991e20757" class="topicref" data-id="错误码和警告码" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/error_rtc.aspx" id="错误码和警告码-d4991e20757-link">错误码和警告码</a></span></span></li></ul></li></ul></div>
      </nav>
  
  
  <div class="col-lg-7 col-md-9 col-sm-12" id="wh_topic_body">
      <div class=" wh_topic_content body "><main role="main"><article role="article" aria-labelledby="ariaid-title1"><article class="nested0" aria-labelledby="ariaid-title1" id="class_ichanneleventhandler">
    <h1 class="- topic/title title topictitle1" id="ariaid-title1"><a href="class_ichanneleventhandler.aspx#class_ichanneleventhandler"><span class="- topic/ph ph">IChannelEventHandler</span></a></h1>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_ichanneleventhandler__shortdesc"><span class="+ topic/keyword pr-d/apiname keyword apiname">IChannelEventHandler</span> 接口类用于 SDK 向 app 发送 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 频道的回调事件通知。</span></p><section class="- topic/section section"><p class="- topic/p p">你可以通过 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_setchanneleventhandler" title="设置 IChannel 对象的事件句柄。"><span class="- topic/keyword keyword">setChannelEventHandler</span></a> 设置监听回调。</p></section></div>
<article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title2" id="api_ichannel_onchannelwarning">
    <h2 class="- topic/title title topictitle2" id="ariaid-title2"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelwarning"><span class="- topic/ph ph">onChannelWarning</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onchannelwarning__shortdesc">报告 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 的警告码。</span></p><section class="- topic/section section" id="api_ichannel_onchannelwarning__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onChannelWarning(IChannel *rtcChannel, <strong class="hl-keyword">int</strong> warn, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* msg) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)warn;
        (<strong class="hl-keyword">void</strong>)msg;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onchannelwarning__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">warn</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">警告码，详见 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">msg</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">警告信息</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title3" id="api_ichannel_onchannelerror">
    <h2 class="- topic/title title topictitle2" id="ariaid-title3"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelerror"><span class="- topic/ph ph">onChannelError</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onchannelerror__shortdesc">报告 <a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a> 的错误码。</span></p><section class="- topic/section section" id="api_ichannel_onchannelerror__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onChannelError(IChannel *rtcChannel, <strong class="hl-keyword">int</strong> err, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* msg) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)err;
        (<strong class="hl-keyword">void</strong>)msg;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onchannelerror__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">err</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">错误码，详见 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">msg</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">错误信息</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title4" id="api_ichannel_onjoinchannelsuccess">
    <h2 class="- topic/title title topictitle2" id="ariaid-title4"><a href="class_ichanneleventhandler.aspx#api_ichannel_onjoinchannelsuccess"><span class="- topic/ph ph">onJoinChannelSuccess</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onjoinchannelsuccess__d340e15">成功加入频道回调。</span></p><section class="- topic/section section" id="api_ichannel_onjoinchannelsuccess__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onJoinChannelSuccess(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onjoinchannelsuccess__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调方法表示该客户端成功加入了指定的频道。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onjoinchannelsuccess__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm" id="api_ichannel_onjoinchannelsuccess__rtcChannel">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。如果 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 中指定了 uid，则此处返回该 ID；否则使用 Agora 服务器自动分配的 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 开始到发生此事件过去的时间（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title5" id="api_ichannel_onrejoinchannelsuccess">
    <h2 class="- topic/title title topictitle2" id="ariaid-title5"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrejoinchannelsuccess"><span class="- topic/ph ph">onRejoinChannelSuccess</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onrejoinchannelsuccess__d169e15">成功重新加入频道回调。</span></p><section class="- topic/section section" id="api_ichannel_onrejoinchannelsuccess__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRejoinChannelSuccess(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">有时候由于网络原因，客户端可能会和服务器失去连接，SDK 会进行自动重连，自动重连成功后触发此回调方法。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrejoinchannelsuccess__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。该参数基于调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannel</span> 加入频道时指定的用户 ID 分配；如果加入频道时未指定用户 ID，则 Agora 服务器会自动分配一个 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地开始重连到发生此事件过去的时间（毫秒）。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title6" id="api_ichannel_onleavechannel">
    <h2 class="- topic/title title topictitle2" id="ariaid-title6"><a href="class_ichanneleventhandler.aspx#api_ichannel_onleavechannel"><span class="- topic/ph ph">onLeaveChannel</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onleavechannel__d469e15">离开频道回调。</span></p><section class="- topic/section section" id="api_ichannel_onleavechannel__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLeaveChannel(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> RtcStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onleavechannel__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">App 调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_leavechannel" title="离开频道。"><span class="- topic/keyword keyword">leaveChannel</span></a> 方法时，SDK 提示 app 离开频道成功。在该回调方法中，app 可以得到此次通话的总通话时长、SDK 收发数据的流量等信息。App 通过该回调获取通话时长以及 SDK 接收到或发送的数据统计信息。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onleavechannel__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">通话的统计数据: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rtcstats" title="通话相关的统计信息。"><span class="- topic/keyword keyword">RtcStats</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title7" id="api_ichannel_onclientrolechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title7"><a href="class_ichanneleventhandler.aspx#api_ichannel_onclientrolechanged"><span class="- topic/ph ph">onClientRoleChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onclientrolechanged__d178e15">直播场景下用户角色已切换回调。</span></p><section class="- topic/section section" id="api_ichannel_onclientrolechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onClientRoleChanged(IChannel *rtcChannel, CLIENT_ROLE_TYPE oldRole, CLIENT_ROLE_TYPE newRole) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)oldRole;
        (<strong class="hl-keyword">void</strong>)newRole;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onclientrolechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">直播场景下，当用户切换角色时会触发此回调，即主播切换为观众时，或观众切换为主播时。</p>
   <p class="- topic/p p">该回调由本地用户在加入频道后调用 <a href="class_ichannel.aspx#api_ichannel_setclientrole1"><span class="- topic/ph ph">setClientRole1</span></a> 改变用户角色触发的。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onclientrolechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
       <dt class="+ topic/dt pr-d/pt dt pt dlterm">oldRole</dt>
       <dd class="+ topic/dd pr-d/pd dd pd">切换前的角色: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_clientroletype" title="直播场景里的用户角色。"><span class="- topic/keyword keyword">CLIENT_ROLE_TYPE</span></a>。</dd>
   
       
       <dt class="+ topic/dt pr-d/pt dt pt dlterm">newRole</dt>
       <dd class="+ topic/dd pr-d/pd dd pd">切换后的角色: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_clientroletype" title="直播场景里的用户角色。"><span class="- topic/keyword keyword">CLIENT_ROLE_TYPE</span></a>。</dd>
   
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title8" id="api_ichannel_onuserjoined">
    <h2 class="- topic/title title topictitle2" id="ariaid-title8"><a href="class_ichanneleventhandler.aspx#api_ichannel_onuserjoined"><span class="- topic/ph ph">onUserJoined</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onuserjoined__d70e15">远端用户（通信场景）/主播（直播场景）加入当前频道回调。</span></p><section class="- topic/section section" id="api_ichannel_onuserjoined__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserJoined(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onuserjoined__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <ul class="- topic/ul ul">
   <li class="- topic/li li">通信场景下，该回调提示有远端用户加入了频道，并返回新加入用户的
  ID；如果加入之前，已经有其他用户在频道中了，新加入的用户也会收到这些已有用户加入频道的回调。</li>
   <li class="- topic/li li">直播场景下，该回调提示有主播加入了频道，并返回该主播的用户 ID。如果在加入之前，已经有主播在频道中了，新加入的用户也会收到已有主播加入频道的回调。Agora
  建议连麦主播不超过 17 人。</li>
        </ul>
   <div class="- topic/p p">该回调在如下情况下会被触发：
       <ul class="- topic/ul ul">
  <li class="- topic/li li">远端用户/主播调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 方法加入频道</li>
  <li class="- topic/li li">远端用户加入频道后调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_setclientrole1" title="设置直播场景下的用户角色。"><span class="- topic/keyword keyword">setClientRole1</span></a> 将用户角色改变为主播</li>
  <li class="- topic/li li">远端用户/主播网络中断后重新加入频道</li>
  <li class="- topic/li li">主播通过调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_addinjectstreamurl" title="输入在线媒体流。"><span class="- topic/keyword keyword">addInjectStreamUrl</span></a> 方法成功输入在线媒体流</li>
       </ul>
   </div>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
     <p class="- topic/p p">直播场景下，</p>
     <ul class="- topic/ul ul">
    <li class="- topic/li li">主播间能相互收到新主播加入频道的回调，并能获得该主播的 uid。</li>
    <li class="- topic/li li">观众也能收到新主播加入频道的回调，并能获得该主播的 uid。</li>
    <li class="- topic/li li">当 Web 端加入直播频道时，只要 Web 端有推流，SDK 会默认该 Web 端为主播，并触发该回调。</li>
     </ul>
      </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onuserjoined__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
<dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
<dd class="+ topic/dd pr-d/pd dd pd">新加入频道的远端用户/主播 ID。</dd>
 
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 到该回调触发的延迟（毫秒)。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title9" id="api_ichannel_onuseroffline">
    <h2 class="- topic/title title topictitle2" id="ariaid-title9"><a href="class_ichanneleventhandler.aspx#api_ichannel_onuseroffline"><span class="- topic/ph ph">onUserOffline</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onuseroffline__d136e15">远端用户（通信场景）/主播（直播场景）离开当前频道回调。</span></p><section class="- topic/section section" id="api_ichannel_onuseroffline__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onUserOffline(IChannel *rtcChannel, uid_t uid, USER_OFFLINE_REASON_TYPE reason) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)reason;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/p p">提示有远端用户/主播离开了频道（或掉线）。用户离开频道有两个原因，即正常离开和超时掉线：<ul class="- topic/ul ul">
  <li class="- topic/li li">正常离开的时候，远端用户/主播会发送类似“再见”的消息。接收此消息后，判断用户离开频道。</li>
  <li class="- topic/li li">超时掉线的依据是，在一定时间内（通信场景为 20
      秒，直播场景稍有延时），用户没有收到对方的任何数据包，则判定为对方掉线。在网络较差的情况下，有可能会误报。我们建议使用 Agora 实时消息 SDK
      来做可靠的掉线检测。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onuseroffline__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">离线用户或主播的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">离线原因: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_userofflinereasontype" title="用户离线原因。"><span class="- topic/keyword keyword">USER_OFFLINE_REASON_TYPE</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title10" id="api_ichannel_onconnectionlost">
    <h2 class="- topic/title title topictitle2" id="ariaid-title10"><a href="class_ichanneleventhandler.aspx#api_ichannel_onconnectionlost"><span class="- topic/ph ph">onConnectionLost</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onconnectionlost__d111e15">网络连接中断，且 SDK 无法在 10 秒内连接服务器回调。</span></p><section class="- topic/section section" id="api_ichannel_onconnectionlost__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onConnectionLost(IChannel *rtcChannel) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onconnectionlost__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">SDK 在调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 后无论是否加入成功，只要 10 秒和服务器无法连接就会触发该回调。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onconnectionlost__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title11" id="api_ichannel_onrequesttoken">
    <h2 class="- topic/title title topictitle2" id="ariaid-title11"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrequesttoken"><span class="- topic/ph ph">onRequestToken</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onrequesttoken__d396e15">Token 过期回调</span></p><section class="- topic/section section" id="api_ichannel_onrequesttoken__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRequestToken(IChannel *rtcChannel) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrequesttoken__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">在调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a>, 时如果指定了 Token，由于 Token 具有一定的时效，在通话过程中 SDK 可能由于网络原因和服务器失去连接，重连时可能需要新的 Token。</p>
   <p class="- topic/p p">该回调通知 App 需要生成新的 Token，并调用 <a href="class_ichannel.aspx#api_ichannel_renewtoken"><span class="- topic/ph ph">renewToken</span></a> 更新 Token。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrequesttoken__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title12" id="api_ichannel_ontokenprivilegewillexpire">
    <h2 class="- topic/title title topictitle2" id="ariaid-title12"><a href="class_ichanneleventhandler.aspx#api_ichannel_ontokenprivilegewillexpire"><span class="- topic/ph ph">onTokenPrivilegeWillExpire</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_ontokenprivilegewillexpire__d139e15">Token 服务即将过期回调。</span></p><section class="- topic/section section" id="api_ichannel_ontokenprivilegewillexpire__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onTokenPrivilegeWillExpire(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* token) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)token;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_ontokenprivilegewillexpire__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">在调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 时如果指定了 Token，由于 Token 具有一定的时效，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发该回调，提醒 App 更新 Token。当收到该回调时，用户需要重新在服务端生成新的 Token，然后调用 <a href="class_ichannel.aspx#api_ichannel_renewtoken"><span class="- topic/ph ph">renewToken</span></a> 将新生成的 Token 传给 SDK。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_ontokenprivilegewillexpire__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">token</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">即将服务失效的 Token。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title13" id="api_ichannel_onrtcstats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title13"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrtcstats"><span class="- topic/ph ph">onRtcStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onrtcstats__d357e15">当前通话统计信息回调。</span></p><section class="- topic/section section" id="api_ichannel_onrtcstats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRtcStats(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> RtcStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">SDK 定期向 App 报告当前通话的统计信息，每两秒触发一次。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrtcstats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <p class="- topic/p p">RTC 引擎统计数据，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_rtcstats" title="通话相关的统计信息。"><span class="- topic/keyword keyword">RtcStats</span></a> 。</p>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title14" id="api_ichannel_onnetworkquality">
    <h2 class="- topic/title title topictitle2" id="ariaid-title14"><a href="class_ichanneleventhandler.aspx#api_ichannel_onnetworkquality"><span class="- topic/ph ph">onNetworkQuality</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onnetworkquality__d254e15">通话中每个用户的网络上下行 last mile 质量报告回调。</span></p><section class="- topic/section section" id="api_ichannel_onnetworkquality__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onNetworkQuality(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> txQuality, <strong class="hl-keyword">int</strong> rxQuality) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)txQuality;
        (<strong class="hl-keyword">void</strong>)rxQuality;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述每个用户在通话中的 last mile 网络状态，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。</p>
   <p class="- topic/p p">该回调每 2 秒触发一次。如果远端有多个用户，该回调每 2 秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onnetworkquality__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。表示该回调报告的是持有该 ID 的用户的网络质量。当 <span class="- topic/ph ph">uid</span> 为 0
      时，返回的是本地用户的网络质量。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">txQuality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该用户的上行网络质量，基于发送码率、上行丢包率、平均往返时延和网络抖动计算。该值代表当前的上行网络质量，帮助判断是否可以支持当前设置的视频编码属性。假设上行码率是
      1000 Kbps，那么支持直播场景下 640 × 480 的分辨率、15 fps 的帧率没有问题，但是支持 1280 × 720
      的分辨率就会有困难。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_qualitytype" title="网络质量。"><span class="- topic/keyword keyword">QUALITY_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rxQuality</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">该用户的下行网络质量，基于下行网络的丢包率、平均往返延时和网络抖动计算。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_qualitytype" title="网络质量。"><span class="- topic/keyword keyword">QUALITY_TYPE</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title15" id="api_ichannel_onremotevideostats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title15"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremotevideostats"><span class="- topic/ph ph">onRemoteVideoStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onremotevideostats__d227e15">通话中远端视频流的统计信息回调。</span></p><section class="- topic/section section" id="api_ichannel_onremotevideostats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteVideoStats(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> RemoteVideoStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述远端用户在通话中端到端的视频流统计信息， 针对每个远端用户/主播每 2 秒触发一次。如果远端同时存在多个用户/主播， 该回调每 2 秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onremotevideostats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频统计数据。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_remotevideostats" title="远端视频流的统计信息。"><span class="- topic/keyword keyword">RemoteVideoStats</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title16" id="api_ichannel_onremoteaudiostats">
    <h2 class="- topic/title title topictitle2" id="ariaid-title16"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremoteaudiostats"><span class="- topic/ph ph">onRemoteAudioStats</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onremoteaudiostats__d79e15">通话中远端音频流的统计信息回调。用于取代 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onaudioquality" title="远端声音质量回调。"><span class="- topic/keyword keyword">onAudioQuality</span></a> 回调。</span></p><section class="- topic/section section" id="api_ichannel_onremoteaudiostats__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteAudioStats(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> RemoteAudioStats&amp; stats) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)stats;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调描述远端用户在通话中端到端的音频流统计信息。该回调函数针对每个发送音频流的远端用户/主播每 2 秒触发一次。如果远端有多个用户/主播发送音频流，该回调每 2
       秒会被触发多次。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onremoteaudiostats__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">stats</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的远端音频统计数据，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_remoteaudiostats" title="远端用户的音频统计数据。"><span class="- topic/keyword keyword">RemoteAudioStats</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title17" id="api_ichannel_onremoteaudiostatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title17"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremoteaudiostatechanged"><span class="- topic/ph ph">onRemoteAudioStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onremoteaudiostatechanged__d123e15">远端音频流状态发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onremoteaudiostatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteAudioStateChanged(IChannel *rtcChannel, uid_t uid, REMOTE_AUDIO_STATE state, REMOTE_AUDIO_STATE_REASON reason, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)reason;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">远端用户/主播音频状态发生改变时，SDK 会触发该回调向本地用户报告当前的远端音频流状态。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调不生效。
   </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onremoteaudiostatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生音频状态改变的远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端音频流状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remoteaudiostate" title="远端音频流状态。"><span class="- topic/keyword keyword">REMOTE_AUDIO_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端音频流状态改变的具体原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remoteaudiostatereason" title="远端音频流状态切换原因。"><span class="- topic/keyword keyword">REMOTE_AUDIO_STATE_REASON</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 方法到发生本事件经历的时间，单位为 ms。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title18" id="api_ichannel_onaudiopublishstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title18"><a href="class_ichanneleventhandler.aspx#api_ichannel_onaudiopublishstatechanged"><span class="- topic/ph ph">onAudioPublishStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onaudiopublishstatechanged__d125e15">音频发布状态改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onaudiopublishstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioPublishStateChanged(IChannel *rtcChannel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_ichannel_onaudiopublishstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">oldState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">之前的发布状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_streampublishstate" title="发布状态。"><span class="- topic/keyword keyword">STREAM_PUBLISH_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">newState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的发布状态，详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_PUBLISH_STATE</span>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapseSinceLastState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">两次状态变化时间间隔（毫秒）。</dd>
     
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title19" id="api_ichannel_onvideopublishstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title19"><a href="class_ichanneleventhandler.aspx#api_ichannel_onvideopublishstatechanged"><span class="- topic/ph ph">onVideoPublishStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onvideopublishstatechanged__d129e15">视频发布状态改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onvideopublishstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoPublishStateChanged(IChannel *rtcChannel, STREAM_PUBLISH_STATE oldState, STREAM_PUBLISH_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">oldState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">之前的发布状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_streampublishstate" title="发布状态。"><span class="- topic/keyword keyword">STREAM_PUBLISH_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">newState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的发布状态，详见 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_PUBLISH_STATE</span>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapseSinceLastState</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">两次状态变化时间间隔（毫秒）。</dd>
     
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title20" id="api_ichannel_onaudiosubscribestatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title20"><a href="class_ichanneleventhandler.aspx#api_ichannel_onaudiosubscribestatechanged"><span class="- topic/ph ph">onAudioSubscribeStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onaudiosubscribestatechanged__d247e15">音频订阅状态发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onaudiosubscribestatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onAudioSubscribeStateChanged(IChannel *rtcChannel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_ichannel_onaudiosubscribestatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
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
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title21" id="api_ichannel_onvideosubscribestatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title21"><a href="class_ichanneleventhandler.aspx#api_ichannel_onvideosubscribestatechanged"><span class="- topic/ph ph">onVideoSubscribeStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onvideosubscribestatechanged__d63e15">视频订阅状态发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onvideosubscribestatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoSubscribeStateChanged(IChannel *rtcChannel, uid_t uid, STREAM_SUBSCRIBE_STATE oldState, STREAM_SUBSCRIBE_STATE newState, <strong class="hl-keyword">int</strong> elapseSinceLastState) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)oldState;
        (<strong class="hl-keyword">void</strong>)newState;
        (<strong class="hl-keyword">void</strong>)elapseSinceLastState;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
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
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title22" id="api_ichannel_onactivespeaker">
    <h2 class="- topic/title title topictitle2" id="ariaid-title22"><a href="class_ichanneleventhandler.aspx#api_ichannel_onactivespeaker"><span class="- topic/ph ph">onActiveSpeaker</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onactivespeaker__d120e15">监测到最活跃用户回调。</span></p><section class="- topic/section section" id="api_ichannel_onactivespeaker__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onActiveSpeaker(IChannel *rtcChannel, uid_t uid) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">成功调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_enableaudiovolumeindication" title="启用用户音量提示。"><span class="- topic/keyword keyword">enableAudioVolumeIndication</span></a> 后，SDK 会持续监测音量最大的远端用户，并统计该用户被判断为音量最大者的次数。当前时间段内，该次数累积最多的远端用户为最活跃的用户。</p>
   <div class="- topic/p p">当频道内用户数量大于或等于 2 且有活跃用户时，SDK 会触发该回调并报告最活跃用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>。<ul class="- topic/ul ul">
  <li class="- topic/li li">如果最活跃用户一直是同一位用户，则 SDK 不会再次触发 <span class="+ topic/keyword pr-d/apiname keyword apiname">onActiveSpeaker</span> 回调。</li>
  <li class="- topic/li li">如果最活跃用户有变化，则 SDK 会再次触发该回调并报告新的最活跃用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span>。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onactivespeaker__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端最活跃用户的 ID。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title23" id="api_ichannel_onvideosizechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title23"><a href="class_ichanneleventhandler.aspx#api_ichannel_onvideosizechanged"><span class="- topic/ph ph">onVideoSizeChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onvideosizechanged__d398e15">本地或远端视频大小和旋转信息发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onvideosizechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onVideoSizeChanged(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> width, <strong class="hl-keyword">int</strong> height, <strong class="hl-keyword">int</strong> rotation) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)width;
        (<strong class="hl-keyword">void</strong>)height;
        (<strong class="hl-keyword">void</strong>)rotation;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onvideosizechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">图像尺寸和旋转信息发生变化的用户的用户 ID（本地用户的 <span class="+ topic/keyword pr-d/parmname keyword parmname">uid</span> 为 0）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">width</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流的宽度（像素）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">height</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">视频流的高度（像素）。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rotation</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">旋转信息 [0,360)。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title24" id="api_ichannel_onremotevideostatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title24"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremotevideostatechanged"><span class="- topic/ph ph">onRemoteVideoStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onremotevideostatechanged__d223e15">远端视频状态发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onremotevideostatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteVideoStateChanged(IChannel *rtcChannel, uid_t uid, REMOTE_VIDEO_STATE state, REMOTE_VIDEO_STATE_REASON reason, <strong class="hl-keyword">int</strong> elapsed) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)reason;
        (<strong class="hl-keyword">void</strong>)elapsed;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 频道内的用户（通信场景）或主播（直播场景）人数超过 17 人时，该回调不生效。</div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onremotevideostatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生视频状态改变的远端用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频流状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remotevideostate" title="远端视频流状态。"><span class="- topic/keyword keyword">REMOTE_VIDEO_STATE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端视频流状态改变的具体原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_remotevideostatereason" title="远端视频流状态切换原因。"><span class="- topic/keyword keyword">REMOTE_VIDEO_STATE_REASON</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">elapsed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">从本地用户调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_joinchannel" title="通过 UID 加入频道。"><span class="- topic/keyword keyword">joinChannel</span></a> 方法到发生本事件经历的时间，单位为 ms。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title25" id="api_ichannel_onstreammessage">
    <h2 class="- topic/title title topictitle2" id="ariaid-title25"><a href="class_ichanneleventhandler.aspx#api_ichannel_onstreammessage"><span class="- topic/ph ph">onStreamMessage</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onstreammessage__d43e15">接收到对方数据流消息的回调。</span></p><section class="- topic/section section" id="api_ichannel_onstreammessage__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamMessage(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> streamId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* data, size_t length) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)streamId;
        (<strong class="hl-keyword">void</strong>)data;
        (<strong class="hl-keyword">void</strong>)length;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onstreammessage__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调表示本地用户收到了远端用户调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_sendstreammessage" title="发送数据流。"><span class="- topic/keyword keyword">sendStreamMessage</span></a> 方法发送的流消息。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onstreammessage__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发送消息的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的消息的 Stream ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">data</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的数据。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">length</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的数据长度。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title26" id="api_ichannel_onstreammessageerror">
    <h2 class="- topic/title title topictitle2" id="ariaid-title26"><a href="class_ichanneleventhandler.aspx#api_ichannel_onstreammessageerror"><span class="- topic/ph ph">onStreamMessageError</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onstreammessageerror__d430e15">接收对方数据流消息发生错误的回调。</span></p><section class="- topic/section section" id="api_ichannel_onstreammessageerror__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamMessageError(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">int</strong> streamId, <strong class="hl-keyword">int</strong> code, <strong class="hl-keyword">int</strong> missed, <strong class="hl-keyword">int</strong> cached) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)streamId;
        (<strong class="hl-keyword">void</strong>)code;
        (<strong class="hl-keyword">void</strong>)missed;
        (<strong class="hl-keyword">void</strong>)cached;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onstreammessageerror__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调表示本地用户未收到远端用户调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_sendstreammessage" title="发送数据流。"><span class="- topic/keyword keyword">sendStreamMessage</span></a> 方法发送的流消息。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onstreammessageerror__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发送消息的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">streamId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的消息的 Stream ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">发生错误的错误码。详见 <a class="- topic/xref xref" href="error_rtc.aspx">错误码和警告码</a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">missed</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">丢失的消息数量。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">cached</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">数据流中断时，后面缓存的消息数量。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title27" id="api_ichannel_onchannelmediarelaystatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title27"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelmediarelaystatechanged"><span class="- topic/ph ph">onChannelMediaRelayStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onchannelmediarelaystatechanged__d293e15">跨频道媒体流转发状态发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onchannelmediarelaystatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onChannelMediaRelayStateChanged(IChannel *rtcChannel, CHANNEL_MEDIA_RELAY_STATE state,CHANNEL_MEDIA_RELAY_ERROR code) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)code;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当跨频道媒体流转发状态发生改变时，SDK 会触发该回调，并报告当前的转发状态以及相关的错误信息。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onchannelmediarelaystatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelmediarelaystate" title="跨频道媒体流转发状态码。"><span class="- topic/keyword keyword">CHANNEL_MEDIA_RELAY_STATE</span></a> 。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发出错的错误码。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelmediarelayerror" title="跨频道媒体流转发出错的错误码。"><span class="- topic/keyword keyword">CHANNEL_MEDIA_RELAY_ERROR</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title28" id="api_ichannel_onchannelmediarelayevent">
    <h2 class="- topic/title title topictitle2" id="ariaid-title28"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelmediarelayevent"><span class="- topic/ph ph">onChannelMediaRelayEvent</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onchannelmediarelayevent__d112e15">跨频道媒体流转发事件回调。</span></p><section class="- topic/section section" id="api_ichannel_onchannelmediarelayevent__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onChannelMediaRelayEvent(IChannel *rtcChannel, CHANNEL_MEDIA_RELAY_EVENT code) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)code;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调报告跨频道媒体流转发过程中发生的事件。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onchannelmediarelayevent__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">code</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">跨频道媒体流转发事件码。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_channelmediarelayevent" title="跨频道媒体流转发事件码。"><span class="- topic/keyword keyword">CHANNEL_MEDIA_RELAY_EVENT</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title29" id="api_ichannel_onrtmpstreamingstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title29"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrtmpstreamingstatechanged"><span class="- topic/ph ph">onRtmpStreamingStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onrtmpstreamingstatechanged__d403e15">RTMP/RTMPS 推流状态发生改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onrtmpstreamingstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRtmpStreamingStateChanged(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong> *url, RTMP_STREAM_PUBLISH_STATE state, RTMP_STREAM_PUBLISH_ERROR errCode) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>) url;
        (RTMP_STREAM_PUBLISH_STATE) state;
        (RTMP_STREAM_PUBLISH_ERROR) errCode;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrtmpstreamingstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调返回本地用户调用 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_addpublishstreamurl" title="增加旁路推流地址。"><span class="- topic/keyword keyword">addPublishStreamUrl</span></a> 或 <a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_removepublishstreamurl" title="删除旁路推流地址。"><span class="- topic/keyword keyword">removePublishStreamUrl</span></a> 方法的结果。RTMP/RTMPS 推流状态发生改变时，SDK
       会触发该回调，并在回调中明确状态发生改变的 URL
       地址及当前推流状态。该回调方便推流用户了解当前的推流状态；推流出错时，你可以通过返回的错误码了解出错的原因，方便排查问题。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrtmpstreamingstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">推流状态发生改变的 URL 地址。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前的推流状态，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rtmpstreampublishstate" title="推流状态。"><span class="- topic/keyword keyword">RTMP_STREAM_PUBLISH_STATE</span></a> 。当推流状态为 <span class="+ topic/keyword pr-d/apiname keyword apiname">RTMP_STREAM_PUBLISH_STATE_FAILURE</span> (4) 时，你可以在 <span class="+ topic/keyword pr-d/parmname keyword parmname">errorCode</span> 参数中查看返回的错误信息。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">errCode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">推流错误信息，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rtmpstreampublisherror" title="推流错误信息。"><span class="- topic/keyword keyword">RTMP_STREAM_PUBLISH_ERROR</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title30" id="api_ichannel_onrtmpstreamingevent">
    <h2 class="- topic/title title topictitle2" id="ariaid-title30"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrtmpstreamingevent"><span class="- topic/ph ph">onRtmpStreamingEvent</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onrtmpstreamingevent__d147e15">RTMP/RTMPS 推流事件回调。</span></p><section class="- topic/section section" id="api_ichannel_onrtmpstreamingevent__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRtmpStreamingEvent(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* url, RTMP_STREAMING_EVENT eventCode) {
        (<strong class="hl-keyword">void</strong>) rtcChannel;
        (<strong class="hl-keyword">void</strong>) url;
        (RTMP_STREAMING_EVENT) eventCode;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.1.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_ichannel_onrtmpstreamingevent__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">RTMP/RTMPS 推流 URL。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">eventCode</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">RTMP/RTMPS 推流事件码。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_rtmpstreamingevent" title="RTMP/RTMPS 推流时发生的事件。"><span class="- topic/keyword keyword">RTMP_STREAMING_EVENT</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title31" id="api_ichannel_ontranscodingupdated">
    <h2 class="- topic/title title topictitle2" id="ariaid-title31"><a href="class_ichanneleventhandler.aspx#api_ichannel_ontranscodingupdated"><span class="- topic/ph ph">onTranscodingUpdated</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_ontranscodingupdated__d216e15">旁路推流设置已被更新回调。</span></p><section class="- topic/section section" id="api_ichannel_ontranscodingupdated__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onTranscodingUpdated(IChannel *rtcChannel) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_ontranscodingupdated__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p"><a class="- topic/xref xref" href="class_ichannel.aspx#api_ichannel_setlivetranscoding" title="设置直播推流转码。"><span class="- topic/keyword keyword">setLiveTranscoding</span></a> 方法中的直播参数 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_livetranscoding" title="管理旁路推流配置的类。"><span class="- topic/keyword keyword">LiveTranscoding</span></a> 更新时，<span class="+ topic/keyword pr-d/apiname keyword apiname">onTranscodingUpdated</span> 回调会被触发并向主播报告更新信息。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 首次调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">setLiveTranscoding</span> 方法设置转码参数 <span class="+ topic/keyword pr-d/apiname keyword apiname">LiveTranscoding</span> 时，不会触发此回调。</div>
        </section>
        <section class="- topic/section section" id="api_ichannel_ontranscodingupdated__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title32" id="api_ichannel_onstreaminjectedstatus">
    <h2 class="- topic/title title topictitle2" id="ariaid-title32"><a href="class_ichanneleventhandler.aspx#api_ichannel_onstreaminjectedstatus"><span class="- topic/ph ph">onStreamInjectedStatus</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onstreaminjectedstatus__d298e15">输入在线媒体流状态回调。</span></p><section class="- topic/section section" id="api_ichannel_onstreaminjectedstatus__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onStreamInjectedStatus(IChannel *rtcChannel, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* url, uid_t uid, <strong class="hl-keyword">int</strong> status) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)url;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)status;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onstreaminjectedstatus__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">url</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">在线媒体流的地址。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">status</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">输入的在线媒体流状态: <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_injectstreamstatus" title="导入的外部视频源状态。"><span class="- topic/keyword keyword">INJECT_STREAM_STATUS</span></a> 。</dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title33" id="api_ichannel_onlocalpublishfallbacktoaudioonly">
    <h2 class="- topic/title title topictitle2" id="ariaid-title33"><a href="class_ichanneleventhandler.aspx#api_ichannel_onlocalpublishfallbacktoaudioonly"><span class="- topic/ph ph">onLocalPublishFallbackToAudioOnly</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onlocalpublishfallbacktoaudioonly__d294e15">本地发布流已回退为音频流回调。</span></p><section class="- topic/section section" id="api_ichannel_onlocalpublishfallbacktoaudioonly__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onLocalPublishFallbackToAudioOnly(IChannel *rtcChannel, <strong class="hl-keyword">bool</strong> isFallbackOrRecover) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)isFallbackOrRecover;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">如果你调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setlocalpublishfallbackoption" title="设置弱网条件下发布的音视频流回退选项。"><span class="- topic/keyword keyword">setLocalPublishFallbackOption</span></a> 接口并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> ，当上行网络环境不理想、本地发布的媒体流回退为音频流时，或当上行网络改善、媒体流恢复为音视频流时，会触发该回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span>  如果本地发流已回退为音频流，远端的 App 上会收到 <a class="- topic/xref xref" href="class_irtcengineeventhandler.aspx#api_onusermutevideo" title="远端用户暂停/恢复发送视频流回调。"><span class="- topic/keyword keyword">onUserMuteVideo</span></a>
       的回调事件。</div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onlocalpublishfallbacktoaudioonly__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">isFallbackOrRecover</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 由于网络环境不理想，本地发布的媒体流已回退为音频流；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 由于网络环境改善，发布的音频流已恢复为音视频流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title34" id="api_ichannel_onremotesubscribefallbacktoaudioonly">
    <h2 class="- topic/title title topictitle2" id="ariaid-title34"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremotesubscribefallbacktoaudioonly"><span class="- topic/ph ph">onRemoteSubscribeFallbackToAudioOnly</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onremotesubscribefallbacktoaudioonly__d116e15">远端订阅流已回退为音频流回调。</span></p><section class="- topic/section section" id="api_ichannel_onremotesubscribefallbacktoaudioonly__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onRemoteSubscribeFallbackToAudioOnly(IChannel *rtcChannel, uid_t uid, <strong class="hl-keyword">bool</strong> isFallbackOrRecover) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)uid;
        (<strong class="hl-keyword">void</strong>)isFallbackOrRecover;
    }</pre>   
  </div>
        </section>
        <section class="- topic/section section"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">如果你调用了 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_setremotesubscribefallbackoption" title="设置弱网条件下订阅的音视频流的回退选项。"><span class="- topic/keyword keyword">setRemoteSubscribeFallbackOption</span></a> 接口并将 <span class="+ topic/keyword pr-d/parmname keyword parmname">option</span> 设置为 <span class="+ topic/keyword pr-d/apiname keyword apiname">STREAM_FALLBACK_OPTION_AUDIO_ONLY</span> ，当下行网络环境不理想、仅接收远端音频流时，或当下行网络改善、恢复订阅音视频流时，会触发该回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span>  远端订阅流因弱网环境不能同时满足音视频而回退为小流时，你可以使用 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#class_remotevideostats" title="远端视频流的统计信息。"><span class="- topic/keyword keyword">RemoteVideoStats</span></a> 来监控远端视频大小流的切换。</div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onremotesubscribefallbacktoaudioonly__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">uid</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">远端用户的用户 ID。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">isFallbackOrRecover</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <ul class="- topic/ul ul">
 <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 由于网络环境不理想，远端订阅流已回退为音频流；</li>
 <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 由于网络环境改善，订阅的音频流已恢复为音视频流。</li>
      </ul>
  </dd>
       
   </dl>
        </section>
    </div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title35" id="api_ichannel_onconnectionstatechanged">
    <h2 class="- topic/title title topictitle2" id="ariaid-title35"><a href="class_ichanneleventhandler.aspx#api_ichannel_onconnectionstatechanged"><span class="- topic/ph ph">onConnectionStateChanged</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_ichannel_onconnectionstatechanged__d380e15">网络连接状态已改变回调。</span></p><section class="- topic/section section" id="api_ichannel_onconnectionstatechanged__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onConnectionStateChanged(IChannel *rtcChannel,
      CONNECTION_STATE_TYPE state,
      CONNECTION_CHANGED_REASON_TYPE reason) {
        (<strong class="hl-keyword">void</strong>)rtcChannel;
        (<strong class="hl-keyword">void</strong>)state;
        (<strong class="hl-keyword">void</strong>)reason;
    }
};</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_ichannel_onconnectionstatechanged__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">该回调在网络连接状态发生改变的时候触发，并告知用户当前的网络连接状态和引起网络状态改变的原因。</p>
        </section>
        <section class="- topic/section section" id="api_ichannel_onconnectionstatechanged__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">rtcChannel</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_ichannel.aspx#class_ichannel" title="调用 createChannel 创建一个 IChannel 对象。"><span class="- topic/keyword keyword">IChannel</span></a></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">state</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">当前网络连接状态。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_connectionstatetype" title="网络连接状态。"><span class="- topic/keyword keyword">CONNECTION_STATE_TYPE</span></a>。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">reason</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">引起当前网络连接状态改变的原因。详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_connectionchangedreasontype" title="网络连接状态发生变化的原因。"><span class="- topic/keyword keyword">CONNECTION_CHANGED_REASON_TYPE</span></a>。</dd>
       
   </dl>
        </section>
    </div>
</article></article></article></main></div>
      
      
      
      
  </div>
  
      <nav role="navigation" id="wh_topic_toc" aria-label="On this page" class="col-lg-2 d-none d-lg-block navbar d-print-none"> 
 <div class=" wh_topic_toc "><div class="wh_topic_label">在本页上</div><ul><li class="topic-item"><a href="#api_ichannel_onchannelwarning" data-tocid="api_ichannel_onchannelwarning"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelwarning"><span class="- topic/ph ph">onChannelWarning</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelwarning__prototype" data-tocid="api_ichannel_onchannelwarning__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelwarning__parameters" data-tocid="api_ichannel_onchannelwarning__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onchannelerror" data-tocid="api_ichannel_onchannelerror"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelerror"><span class="- topic/ph ph">onChannelError</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelerror__prototype" data-tocid="api_ichannel_onchannelerror__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelerror__parameters" data-tocid="api_ichannel_onchannelerror__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onjoinchannelsuccess" data-tocid="api_ichannel_onjoinchannelsuccess"><a href="class_ichanneleventhandler.aspx#api_ichannel_onjoinchannelsuccess"><span class="- topic/ph ph">onJoinChannelSuccess</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onjoinchannelsuccess__prototype" data-tocid="api_ichannel_onjoinchannelsuccess__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onjoinchannelsuccess__detailed_desc" data-tocid="api_ichannel_onjoinchannelsuccess__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onjoinchannelsuccess__parameters" data-tocid="api_ichannel_onjoinchannelsuccess__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onrejoinchannelsuccess" data-tocid="api_ichannel_onrejoinchannelsuccess"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrejoinchannelsuccess"><span class="- topic/ph ph">onRejoinChannelSuccess</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrejoinchannelsuccess__prototype" data-tocid="api_ichannel_onrejoinchannelsuccess__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrejoinchannelsuccess__parameters" data-tocid="api_ichannel_onrejoinchannelsuccess__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onleavechannel" data-tocid="api_ichannel_onleavechannel"><a href="class_ichanneleventhandler.aspx#api_ichannel_onleavechannel"><span class="- topic/ph ph">onLeaveChannel</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onleavechannel__prototype" data-tocid="api_ichannel_onleavechannel__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onleavechannel__detailed_desc" data-tocid="api_ichannel_onleavechannel__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onleavechannel__parameters" data-tocid="api_ichannel_onleavechannel__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onclientrolechanged" data-tocid="api_ichannel_onclientrolechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onclientrolechanged"><span class="- topic/ph ph">onClientRoleChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onclientrolechanged__prototype" data-tocid="api_ichannel_onclientrolechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onclientrolechanged__detailed_desc" data-tocid="api_ichannel_onclientrolechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onclientrolechanged__parameters" data-tocid="api_ichannel_onclientrolechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onuserjoined" data-tocid="api_ichannel_onuserjoined"><a href="class_ichanneleventhandler.aspx#api_ichannel_onuserjoined"><span class="- topic/ph ph">onUserJoined</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onuserjoined__prototype" data-tocid="api_ichannel_onuserjoined__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onuserjoined__detailed_desc" data-tocid="api_ichannel_onuserjoined__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onuserjoined__parameters" data-tocid="api_ichannel_onuserjoined__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onuseroffline" data-tocid="api_ichannel_onuseroffline"><a href="class_ichanneleventhandler.aspx#api_ichannel_onuseroffline"><span class="- topic/ph ph">onUserOffline</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onuseroffline__prototype" data-tocid="api_ichannel_onuseroffline__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onuseroffline__parameters" data-tocid="api_ichannel_onuseroffline__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onconnectionlost" data-tocid="api_ichannel_onconnectionlost"><a href="class_ichanneleventhandler.aspx#api_ichannel_onconnectionlost"><span class="- topic/ph ph">onConnectionLost</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onconnectionlost__prototype" data-tocid="api_ichannel_onconnectionlost__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onconnectionlost__detailed_desc" data-tocid="api_ichannel_onconnectionlost__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onconnectionlost__parameters" data-tocid="api_ichannel_onconnectionlost__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onrequesttoken" data-tocid="api_ichannel_onrequesttoken"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrequesttoken"><span class="- topic/ph ph">onRequestToken</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrequesttoken__prototype" data-tocid="api_ichannel_onrequesttoken__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrequesttoken__detailed_desc" data-tocid="api_ichannel_onrequesttoken__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrequesttoken__parameters" data-tocid="api_ichannel_onrequesttoken__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_ontokenprivilegewillexpire" data-tocid="api_ichannel_ontokenprivilegewillexpire"><a href="class_ichanneleventhandler.aspx#api_ichannel_ontokenprivilegewillexpire"><span class="- topic/ph ph">onTokenPrivilegeWillExpire</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_ontokenprivilegewillexpire__prototype" data-tocid="api_ichannel_ontokenprivilegewillexpire__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_ontokenprivilegewillexpire__detailed_desc" data-tocid="api_ichannel_ontokenprivilegewillexpire__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_ontokenprivilegewillexpire__parameters" data-tocid="api_ichannel_ontokenprivilegewillexpire__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onrtcstats" data-tocid="api_ichannel_onrtcstats"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrtcstats"><span class="- topic/ph ph">onRtcStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtcstats__prototype" data-tocid="api_ichannel_onrtcstats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtcstats__parameters" data-tocid="api_ichannel_onrtcstats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onnetworkquality" data-tocid="api_ichannel_onnetworkquality"><a href="class_ichanneleventhandler.aspx#api_ichannel_onnetworkquality"><span class="- topic/ph ph">onNetworkQuality</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onnetworkquality__prototype" data-tocid="api_ichannel_onnetworkquality__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onnetworkquality__parameters" data-tocid="api_ichannel_onnetworkquality__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onremotevideostats" data-tocid="api_ichannel_onremotevideostats"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremotevideostats"><span class="- topic/ph ph">onRemoteVideoStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremotevideostats__prototype" data-tocid="api_ichannel_onremotevideostats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremotevideostats__parameters" data-tocid="api_ichannel_onremotevideostats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onremoteaudiostats" data-tocid="api_ichannel_onremoteaudiostats"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremoteaudiostats"><span class="- topic/ph ph">onRemoteAudioStats</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremoteaudiostats__prototype" data-tocid="api_ichannel_onremoteaudiostats__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremoteaudiostats__parameters" data-tocid="api_ichannel_onremoteaudiostats__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onremoteaudiostatechanged" data-tocid="api_ichannel_onremoteaudiostatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremoteaudiostatechanged"><span class="- topic/ph ph">onRemoteAudioStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremoteaudiostatechanged__prototype" data-tocid="api_ichannel_onremoteaudiostatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremoteaudiostatechanged__parameters" data-tocid="api_ichannel_onremoteaudiostatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onaudiopublishstatechanged" data-tocid="api_ichannel_onaudiopublishstatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onaudiopublishstatechanged"><span class="- topic/ph ph">onAudioPublishStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onaudiopublishstatechanged__prototype" data-tocid="api_ichannel_onaudiopublishstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onaudiopublishstatechanged__parameters" data-tocid="api_ichannel_onaudiopublishstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onvideopublishstatechanged" data-tocid="api_ichannel_onvideopublishstatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onvideopublishstatechanged"><span class="- topic/ph ph">onVideoPublishStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onvideopublishstatechanged__prototype" data-tocid="api_ichannel_onvideopublishstatechanged__prototype">原型</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onaudiosubscribestatechanged" data-tocid="api_ichannel_onaudiosubscribestatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onaudiosubscribestatechanged"><span class="- topic/ph ph">onAudioSubscribeStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onaudiosubscribestatechanged__prototype" data-tocid="api_ichannel_onaudiosubscribestatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onaudiosubscribestatechanged__parameters" data-tocid="api_ichannel_onaudiosubscribestatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onvideosubscribestatechanged" data-tocid="api_ichannel_onvideosubscribestatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onvideosubscribestatechanged"><span class="- topic/ph ph">onVideoSubscribeStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onvideosubscribestatechanged__prototype" data-tocid="api_ichannel_onvideosubscribestatechanged__prototype">原型</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onactivespeaker" data-tocid="api_ichannel_onactivespeaker"><a href="class_ichanneleventhandler.aspx#api_ichannel_onactivespeaker"><span class="- topic/ph ph">onActiveSpeaker</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onactivespeaker__prototype" data-tocid="api_ichannel_onactivespeaker__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onactivespeaker__parameters" data-tocid="api_ichannel_onactivespeaker__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onvideosizechanged" data-tocid="api_ichannel_onvideosizechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onvideosizechanged"><span class="- topic/ph ph">onVideoSizeChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onvideosizechanged__prototype" data-tocid="api_ichannel_onvideosizechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onvideosizechanged__parameters" data-tocid="api_ichannel_onvideosizechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onremotevideostatechanged" data-tocid="api_ichannel_onremotevideostatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremotevideostatechanged"><span class="- topic/ph ph">onRemoteVideoStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremotevideostatechanged__prototype" data-tocid="api_ichannel_onremotevideostatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremotevideostatechanged__parameters" data-tocid="api_ichannel_onremotevideostatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onstreammessage" data-tocid="api_ichannel_onstreammessage"><a href="class_ichanneleventhandler.aspx#api_ichannel_onstreammessage"><span class="- topic/ph ph">onStreamMessage</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreammessage__prototype" data-tocid="api_ichannel_onstreammessage__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreammessage__detailed_desc" data-tocid="api_ichannel_onstreammessage__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreammessage__parameters" data-tocid="api_ichannel_onstreammessage__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onstreammessageerror" data-tocid="api_ichannel_onstreammessageerror"><a href="class_ichanneleventhandler.aspx#api_ichannel_onstreammessageerror"><span class="- topic/ph ph">onStreamMessageError</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreammessageerror__prototype" data-tocid="api_ichannel_onstreammessageerror__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreammessageerror__detailed_desc" data-tocid="api_ichannel_onstreammessageerror__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreammessageerror__parameters" data-tocid="api_ichannel_onstreammessageerror__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onchannelmediarelaystatechanged" data-tocid="api_ichannel_onchannelmediarelaystatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelmediarelaystatechanged"><span class="- topic/ph ph">onChannelMediaRelayStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelmediarelaystatechanged__prototype" data-tocid="api_ichannel_onchannelmediarelaystatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelmediarelaystatechanged__parameters" data-tocid="api_ichannel_onchannelmediarelaystatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onchannelmediarelayevent" data-tocid="api_ichannel_onchannelmediarelayevent"><a href="class_ichanneleventhandler.aspx#api_ichannel_onchannelmediarelayevent"><span class="- topic/ph ph">onChannelMediaRelayEvent</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelmediarelayevent__prototype" data-tocid="api_ichannel_onchannelmediarelayevent__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onchannelmediarelayevent__parameters" data-tocid="api_ichannel_onchannelmediarelayevent__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onrtmpstreamingstatechanged" data-tocid="api_ichannel_onrtmpstreamingstatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrtmpstreamingstatechanged"><span class="- topic/ph ph">onRtmpStreamingStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtmpstreamingstatechanged__prototype" data-tocid="api_ichannel_onrtmpstreamingstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtmpstreamingstatechanged__detailed_desc" data-tocid="api_ichannel_onrtmpstreamingstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtmpstreamingstatechanged__parameters" data-tocid="api_ichannel_onrtmpstreamingstatechanged__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onrtmpstreamingevent" data-tocid="api_ichannel_onrtmpstreamingevent"><a href="class_ichanneleventhandler.aspx#api_ichannel_onrtmpstreamingevent"><span class="- topic/ph ph">onRtmpStreamingEvent</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtmpstreamingevent__prototype" data-tocid="api_ichannel_onrtmpstreamingevent__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onrtmpstreamingevent__parameters" data-tocid="api_ichannel_onrtmpstreamingevent__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_ontranscodingupdated" data-tocid="api_ichannel_ontranscodingupdated"><a href="class_ichanneleventhandler.aspx#api_ichannel_ontranscodingupdated"><span class="- topic/ph ph">onTranscodingUpdated</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_ontranscodingupdated__prototype" data-tocid="api_ichannel_ontranscodingupdated__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_ontranscodingupdated__detailed_desc" data-tocid="api_ichannel_ontranscodingupdated__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_ontranscodingupdated__parameters" data-tocid="api_ichannel_ontranscodingupdated__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onstreaminjectedstatus" data-tocid="api_ichannel_onstreaminjectedstatus"><a href="class_ichanneleventhandler.aspx#api_ichannel_onstreaminjectedstatus"><span class="- topic/ph ph">onStreamInjectedStatus</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreaminjectedstatus__prototype" data-tocid="api_ichannel_onstreaminjectedstatus__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onstreaminjectedstatus__parameters" data-tocid="api_ichannel_onstreaminjectedstatus__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onlocalpublishfallbacktoaudioonly" data-tocid="api_ichannel_onlocalpublishfallbacktoaudioonly"><a href="class_ichanneleventhandler.aspx#api_ichannel_onlocalpublishfallbacktoaudioonly"><span class="- topic/ph ph">onLocalPublishFallbackToAudioOnly</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onlocalpublishfallbacktoaudioonly__prototype" data-tocid="api_ichannel_onlocalpublishfallbacktoaudioonly__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onlocalpublishfallbacktoaudioonly__parameters" data-tocid="api_ichannel_onlocalpublishfallbacktoaudioonly__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onremotesubscribefallbacktoaudioonly" data-tocid="api_ichannel_onremotesubscribefallbacktoaudioonly"><a href="class_ichanneleventhandler.aspx#api_ichannel_onremotesubscribefallbacktoaudioonly"><span class="- topic/ph ph">onRemoteSubscribeFallbackToAudioOnly</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremotesubscribefallbacktoaudioonly__prototype" data-tocid="api_ichannel_onremotesubscribefallbacktoaudioonly__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onremotesubscribefallbacktoaudioonly__parameters" data-tocid="api_ichannel_onremotesubscribefallbacktoaudioonly__parameters">参数</a></div></li></ul></li><li class="topic-item"><a href="#api_ichannel_onconnectionstatechanged" data-tocid="api_ichannel_onconnectionstatechanged"><a href="class_ichanneleventhandler.aspx#api_ichannel_onconnectionstatechanged"><span class="- topic/ph ph">onConnectionStateChanged</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_ichannel_onconnectionstatechanged__prototype" data-tocid="api_ichannel_onconnectionstatechanged__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onconnectionstatechanged__detailed_desc" data-tocid="api_ichannel_onconnectionstatechanged__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_ichannel_onconnectionstatechanged__parameters" data-tocid="api_ichannel_onconnectionstatechanged__parameters">参数</a></div></li></ul></li></ul></div>
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