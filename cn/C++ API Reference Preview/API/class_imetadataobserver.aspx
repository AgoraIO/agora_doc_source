
<!DOCTYPE html
  SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:whc="http://www.oxygenxml.com/webhelp/components" xml:lang="zh-cn" lang="zh-cn" whc:version="22.0">
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta charset="UTF-8" /><meta name="copyright" content="(C) 版权 2021" /><meta name="DC.rights.owner" content="(C) 版权 2021" /><meta name="DC.type" content="reference" /><meta name="description" content="Metadata 观测器。" /><meta name="DC.subject" content="IMetadataObserver, Metadata, METADATA_TYPE, getMaxMetadataSize, onReadyToSendMetadata, onMetadataReceived" /><meta name="keywords" content="IMetadataObserver, Metadata, METADATA_TYPE, getMaxMetadataSize, onReadyToSendMetadata, onMetadataReceived" /><meta name="indexterms" content="getMaxMetadataSize, onReadyToSendMetadata, onMetadataReceived" /><meta name="DC.format" content="HTML5" /><meta name="DC.identifier" content="class_imetadataobserver" />        
      <title>IMetadataObserver</title><!--  Generated with Oxygen version 23.0, build number 2020121702.  --><meta name="wh-path2root" content="../" /><meta name="wh-toc-id" content="class_imetadataobserver-d4991e19199" /><meta name="wh-source-relpath" content="API/class_imetadataobserver.dita" /><meta name="wh-out-relpath" content="API/class_imetadataobserver.aspx" />
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
  <div data-tooltip-position="bottom" class=" wh_breadcrumb "><ol xmlns:html="http://www.w3.org/1999/xhtml" class="d-print-none"><li><span class="home"><a href="../index.aspx"><span>主页</span></a></span></li><li><span class="topicref"><span class="title"><a href="../API/rtc_api_overview.aspx">C++ API Reference for All Platforms</a></span></span></li><li class="active"><span class="topicref" data-id="class_imetadataobserver"><span class="title"><a href="../API/class_imetadataobserver.aspx#class_imetadataobserver"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imetadataobserver.html#class_imetadataobserver"><span class="ph">IMetadataObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Metadata 观测器。</span></p></span></span></span></li></ol></div>

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
 <div class=" wh_publication_toc " data-tooltip-position="right"><ul role="tree" aria-label="Table of Contents"><span class="expand-button-action-labels"><span id="button-expand-action" aria-label="Expand"></span><span id="button-collapse-action" aria-label="Collapse"></span><span id="button-pending-action" aria-label="Pending"></span></span><li role="treeitem" aria-expanded="true"><span data-tocid="tocId-d4991e13735" class="topicref" data-state="expanded"><span role="button" tabindex="0" aria-labelledby="button-collapse-action tocId-d4991e13735-link" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="tocId-d4991e13735-link">C++ API Reference for All Platforms</a></span></span><ul role="group" class="navbar-nav nav-list"><li role="treeitem"><span data-tocid="api-title-d4991e13736" class="topicref" data-id="api-title" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_overview.aspx" id="api-title-d4991e13736-link">API Overview</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">声网通过全球部署的虚拟网络，提供可以灵活搭配的 API 组合，提供质量可靠的实时音视频通信。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_rtcengine-d4991e13748" class="topicref" data-id="class_rtcengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengine.aspx#class_rtcengine" id="class_rtcengine-d4991e13748-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengine.html#class_rtcengine"><span class="ph">IRtcEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Agora Native SDK 的基础接口类，包含应用程序调用的主要方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichannel-d4991e15906" class="topicref" data-id="class_ichannel" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichannel.aspx#class_ichannel" id="class_ichannel-d4991e15906-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichannel.html#class_ichannel"><span class="ph">IChannel</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">调用 <a href="../API/class_irtcengine.html#api_createChannel" class="xref"><span class="keyword">createChannel</span></a> 创建一个 <span class="keyword apiname">IChannel</span> 对象。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ichanneleventhandler-d4991e16473" class="topicref" data-id="class_ichanneleventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ichanneleventhandler.aspx#class_ichanneleventhandler" id="class_ichanneleventhandler-d4991e16473-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ichanneleventhandler.html#class_ichanneleventhandler"><span class="ph">IChannelEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IChannelEventHandler</span> 接口类用于 SDK 向 app 发送 <a href="../API/class_ichannel.html#class_ichannel" class="xref"><span class="keyword">IChannel</span></a> 频道的回调事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_imediaengine-d4991e16949" class="topicref" data-id="class_imediaengine" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imediaengine.aspx#class_imediaengine" id="class_imediaengine-d4991e16949-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imediaengine.html#class_imediaengine"><span class="ph">IMediaEngine</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IMediaEngine</span> 类。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ipacketobserver-d4991e17061" class="topicref" data-id="class_ipacketobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ipacketobserver.aspx#class_ipacketobserver" id="class_ipacketobserver-d4991e17061-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ipacketobserver.html#class_ipacketobserver"><span class="ph">IPacketObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IPacketObserver 定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicemanager-d4991e17126" class="topicref" data-id="class_iaudiodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicemanager.aspx#class_iaudiodevicemanager" id="class_iaudiodevicemanager-d4991e17126-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicemanager.html#class_iaudiodevicemanager"><span class="ph">IAudioDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">音频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudiodevicecollection-d4991e17443" class="topicref" data-id="class_iaudiodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudiodevicecollection.aspx#class_iaudiodevicecollection" id="class_iaudiodevicecollection-d4991e17443-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudiodevicecollection.html#class_iaudiodevicecollection"><span class="ph">IAudioDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IAudioDeviceCollection 类。你可以通过该接口类获取音频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideosource-d4991e17560" class="topicref" data-id="class_ivideosource" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideosource.aspx#class_ivideosource" id="class_ivideosource-d4991e17560-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideosource.html#class_ivideosource"><span class="ph">IVideoSource</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoSource 类，可以设置自定义的视频源。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeconsumer-d4991e17664" class="topicref" data-id="class_ivideoframeconsumer" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeconsumer.aspx#class_ivideoframeconsumer" id="class_ivideoframeconsumer-d4991e17664-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeconsumer.html#class_ivideoframeconsumer"><span class="ph">IVideoFrameConsumer</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IVideoFrameConsumer</span> 类，用于让 SDK 接收你采集的视频帧。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicemanager-d4991e17692" class="topicref" data-id="class_ivideodevicemanager" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicemanager.aspx#class_ivideodevicemanager" id="class_ivideodevicemanager-d4991e17692-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicemanager.html#class_ivideodevicemanager"><span class="ph">IVideoDeviceManager</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频设备管理方法。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideodevicecollection-d4991e17788" class="topicref" data-id="class_ivideodevicecollection" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideodevicecollection.aspx#class_ivideodevicecollection" id="class_ivideodevicecollection-d4991e17788-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideodevicecollection.html#class_ivideodevicecollection"><span class="ph">IVideoDeviceCollection</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">IVideoDeviceCollection 类。你可以通过该接口类获取视频设备相关的信息。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_rtcengineeventhandler-d4991e17857" class="topicref" data-id="class_rtcengineeventhandler" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_irtcengineeventhandler.aspx#class_rtcengineeventhandler" id="class_rtcengineeventhandler-d4991e17857-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_irtcengineeventhandler.html#class_rtcengineeventhandler"><span class="ph">IRtcEngineEventHandler</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph"><span class="keyword apiname">IRtcEngineEventHandler</span> 接口类用于 SDK 向 app 发送回调事件通知，app 通过继承该接口类的方法获取 SDK的事件通知。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_iaudioframeobserver-d4991e18897" class="topicref" data-id="class_iaudioframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_iaudioframeobserver.aspx#class_iaudioframeobserver" id="class_iaudioframeobserver-d4991e18897-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_iaudioframeobserver.html#class_iaudioframeobserver"><span class="ph">IAudioFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">语音观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="class_ivideoframeobserver-d4991e19014" class="topicref" data-id="class_ivideoframeobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_ivideoframeobserver.aspx#class_ivideoframeobserver" id="class_ivideoframeobserver-d4991e19014-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_ivideoframeobserver.html#class_ivideoframeobserver"><span class="ph">IVideoFrameObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">视频观测器。</span></p></span></span></span></li><li role="treeitem" class="active"><span data-tocid="class_imetadataobserver-d4991e19199" class="topicref" data-id="class_imetadataobserver" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/class_imetadataobserver.aspx#class_imetadataobserver" id="class_imetadataobserver-d4991e19199-link"><a xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" href="../API/class_imetadataobserver.html#class_imetadataobserver"><span class="ph">IMetadataObserver</span></a></a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">Metadata 观测器。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="datatype-d4991e19289" class="topicref" data-id="datatype" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/rtc_api_data_type.aspx#datatype" id="datatype-d4991e19289-link">类型定义</a><span class="wh-tooltip"><p xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml" class="shortdesc"><span class="ph">本页列出 <span class="ph">Windows</span> API 所有的类型定义。</span></p></span></span></span></li><li role="treeitem"><span data-tocid="错误码和警告码-d4991e20757" class="topicref" data-id="错误码和警告码" data-state="leaf"><span role="button" class="wh-expand-btn"></span><span class="title"><a href="../API/error_rtc.aspx" id="错误码和警告码-d4991e20757-link">错误码和警告码</a></span></span></li></ul></li></ul></div>
      </nav>
  
  
  <div class="col-lg-7 col-md-9 col-sm-12" id="wh_topic_body">
      <div class=" wh_topic_content body "><main role="main"><article role="article" aria-labelledby="ariaid-title1"><article class="nested0" aria-labelledby="ariaid-title1" id="class_imetadataobserver">
    <h1 class="- topic/title title topictitle1" id="ariaid-title1"><a href="class_imetadataobserver.aspx#class_imetadataobserver"><span class="- topic/ph ph">IMetadataObserver</span></a></h1>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_imetadataobserver__shortdesc">Metadata 观测器。</span></p>
        <section class="- topic/section section" id="class_imetadataobserver__section_act_15g_s4b">
   <p class="- topic/p p">你可以调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_registermediametadataobserver" title="注册媒体 metadata 观测器用于接收或发送 metadata。"><span class="- topic/keyword keyword">registerMediaMetadataObserver</span></a> 注册或取消注册 <span class="+ topic/keyword pr-d/apiname keyword apiname">IMetadataObserver</span> 观测器。</p>
        </section>
    </div>
<article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title2" id="class_metadata">
    <h2 class="- topic/title title topictitle2" id="ariaid-title2"><a href="class_imetadataobserver.aspx#class_metadata"><span class="- topic/ph ph">Metadata</span></a></h2>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_metadata__shortdesc">媒体附属信息。</span></p>
        <section class="- topic/section section" id="class_metadata__prototype">
   <div class="- topic/p p">
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">struct</strong> Metadata
{
    <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> uid;
    <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">int</strong> size;
    <strong class="hl-keyword">unsigned</strong> <strong class="hl-keyword">char</strong> *buffer;
    <strong class="hl-keyword">long</strong> <strong class="hl-keyword">long</strong> timeStampMs;
};</pre>
  </div>
        </section>
        <section class="- topic/section section" id="class_metadata__parameters"><h3 class="- topic/title title sectiontitle">
       属性
       
       
       
       
       
   </h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">uid</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd">
      <div class="- topic/p p">用户 ID。<ul class="- topic/ul ul" id="class_metadata__ul_c1t_3wg_s4b">
 <li class="- topic/li li">对于接收者：发送该 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 的远端用户的 ID。</li>
     <li class="- topic/li li">对于发送者：请忽略。</li>
 </ul></div>
  </dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">size</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的或发送的 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 的缓存大小。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">buffer</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的或发送的 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 的缓存地址。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">timeStampMs</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 的时间戳，单位为毫秒。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title3" id="enum_metadatatype">
    <h2 class="- topic/title title topictitle2" id="ariaid-title3"><a href="class_imetadataobserver.aspx#enum_metadatatype"><span class="- topic/ph ph">METADATA_TYPE</span></a></h2>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="enum_metadatatype__shortdesc">观测器的 Metadata 类型。当前仅支持视频类型的 Metadata 。</span></p>
        <section class="- topic/section section" id="enum_metadatatype__parameters"><h3 class="- topic/title title sectiontitle">枚举值</h3>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">UNKNOWN_METADATA</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_metadata" title="媒体附属信息。"><span class="- topic/keyword keyword">Metadata</span></a> 类型未知。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm"><span class="- topic/ph ph">VIDEO_METADATA</span></dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_metadata" title="媒体附属信息。"><span class="- topic/keyword keyword">Metadata</span></a> 类型为视频。</dd>
       
   </dl>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title4" id="api_getmaxmetadatasize">
    <h2 class="- topic/title title topictitle2" id="ariaid-title4"><a href="class_imetadataobserver.aspx#api_getmaxmetadatasize"><span class="- topic/ph ph">getMaxMetadataSize</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_getmaxmetadatasize__shortdesc">请求最大的 <a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_metadata" title="媒体附属信息。"><span class="- topic/keyword keyword">Metadata</span></a> 大小。</span></p><section class="- topic/section section" id="api_getmaxmetadatasize__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> getMaxMetadataSize() = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_getmaxmetadatasize__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">在成功调用 <a class="- topic/xref xref" href="class_irtcengine.aspx#api_registermediametadataobserver" title="注册媒体 metadata 观测器用于接收或发送 metadata。"><span class="- topic/keyword keyword">registerMediaMetadataObserver</span></a> 完成注册后，SDK 会触发该回调；你需要在该方法的返回值中指定
  <a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_metadata" title="媒体附属信息。"><span class="- topic/keyword keyword">Metadata</span></a> 的最大数据大小。</p>
        </section>
        <section class="- topic/section section" id="api_getmaxmetadatasize__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <p class="- topic/p p">指定 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 中 <span class="+ topic/keyword pr-d/parmname keyword parmname">buffer</span> 的最大数据大小，单位为 Byte，最大值不超过 1024。请确保在该返回值中进行传参。</p>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title5" id="api_onreadytosendmetadata">
    <h2 class="- topic/title title topictitle2" id="ariaid-title5"><a href="class_imetadataobserver.aspx#api_onreadytosendmetadata"><span class="- topic/ph ph">onReadyToSendMetadata</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onreadytosendmetadata__shortdesc">发送端已准备好发送 <a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_metadata" title="媒体附属信息。"><span class="- topic/keyword keyword">Metadata</span></a>。</span></p><section class="- topic/section section" id="api_onreadytosendmetadata__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">bool</strong> onReadyToSendMetadata(Metadata &amp;metadata) = <span class="hl-number">0</span>;</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onreadytosendmetadata__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当 SDK 准备好接收和发送 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 时，会触发该回调。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 请确保在该方法中传入的 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 大小不超过 <a class="- topic/xref xref" href="class_imetadataobserver.aspx#api_getmaxmetadatasize" title="请求最大的 Metadata 大小。"><span class="- topic/keyword keyword">getMaxMetadataSize</span></a> 中设定的值。</div>
        </section>
        <section class="- topic/section section" id="api_onreadytosendmetadata__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">metadata</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">用户想要发送的 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span>。</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="api_onreadytosendmetadata__return_values"><h3 class="- topic/title title sectiontitle">返回值</h3>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li"><span class="- topic/ph ph">true</span>: 发送</li>
       <li class="- topic/li li"><span class="- topic/ph ph">false</span>: 不发送</li>
   </ul>
        </section></div>
</article><article class="- topic/topic reference/reference topic reference nested1" aria-labelledby="ariaid-title6" id="api_onmetadatareceived">
    <h2 class="- topic/title title topictitle2" id="ariaid-title6"><a href="class_imetadataobserver.aspx#api_onmetadatareceived"><span class="- topic/ph ph">onMetadataReceived</span></a></h2>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_onmetadatareceived__shortdesc">接收端已收到 <a class="- topic/xref xref" href="class_imetadataobserver.aspx#class_metadata" title="媒体附属信息。"><span class="- topic/keyword keyword">Metadata</span></a>。</span></p><section class="- topic/section section" id="api_onmetadatareceived__prototype"><h3 class="- topic/title title sectiontitle">原型</h3>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">void</strong> onMetadataReceived(<strong class="hl-keyword">const</strong> Metadata &amp;metadata) = <span class="hl-number">0</span>;
};</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_onmetadatareceived__detailed_desc"><h3 class="- topic/title title sectiontitle">详细描述</h3>
   
   <p class="- topic/p p">当接收到远端用户发送的 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span> 时，SDK 会触发该回调。</p>
        </section>
        <section class="- topic/section section" id="api_onmetadatareceived__parameters"><h3 class="- topic/title title sectiontitle">参数</h3>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">metadata</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">接收到的 <span class="+ topic/keyword pr-d/apiname keyword apiname">Metadata</span>。</dd>
       
   </dl>
        </section></div>
</article></article></article></main></div>
      
      
      
      
  </div>
  
      <nav role="navigation" id="wh_topic_toc" aria-label="On this page" class="col-lg-2 d-none d-lg-block navbar d-print-none"> 
 <div class=" wh_topic_toc "><div class="wh_topic_label">在本页上</div><ul><li class="topic-item"><a href="#class_metadata" data-tocid="class_metadata"><a href="class_imetadataobserver.aspx#class_metadata"><span class="- topic/ph ph">Metadata</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#class_metadata__parameters" data-tocid="class_metadata__parameters">
       属性
       
       
       
       
       
   </a></div></li></ul></li><li class="topic-item"><a href="#enum_metadatatype" data-tocid="enum_metadatatype"><a href="class_imetadataobserver.aspx#enum_metadatatype"><span class="- topic/ph ph">METADATA_TYPE</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#enum_metadatatype__parameters" data-tocid="enum_metadatatype__parameters">枚举值</a></div></li></ul></li><li class="topic-item"><a href="#api_getmaxmetadatasize" data-tocid="api_getmaxmetadatasize"><a href="class_imetadataobserver.aspx#api_getmaxmetadatasize"><span class="- topic/ph ph">getMaxMetadataSize</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_getmaxmetadatasize__prototype" data-tocid="api_getmaxmetadatasize__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getmaxmetadatasize__detailed_desc" data-tocid="api_getmaxmetadatasize__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_getmaxmetadatasize__return_values" data-tocid="api_getmaxmetadatasize__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_onreadytosendmetadata" data-tocid="api_onreadytosendmetadata"><a href="class_imetadataobserver.aspx#api_onreadytosendmetadata"><span class="- topic/ph ph">onReadyToSendMetadata</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onreadytosendmetadata__prototype" data-tocid="api_onreadytosendmetadata__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onreadytosendmetadata__detailed_desc" data-tocid="api_onreadytosendmetadata__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onreadytosendmetadata__parameters" data-tocid="api_onreadytosendmetadata__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onreadytosendmetadata__return_values" data-tocid="api_onreadytosendmetadata__return_values">返回值</a></div></li></ul></li><li class="topic-item"><a href="#api_onmetadatareceived" data-tocid="api_onmetadatareceived"><a href="class_imetadataobserver.aspx#api_onmetadatareceived"><span class="- topic/ph ph">onMetadataReceived</span></a></a><ul><li class="section-item"><div class="section-title"><a href="#api_onmetadatareceived__prototype" data-tocid="api_onmetadatareceived__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onmetadatareceived__detailed_desc" data-tocid="api_onmetadatareceived__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_onmetadatareceived__parameters" data-tocid="api_onmetadatareceived__parameters">参数</a></div></li></ul></li></ul></div>
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