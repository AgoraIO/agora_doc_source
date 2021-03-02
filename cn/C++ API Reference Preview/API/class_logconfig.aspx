
<!DOCTYPE html
  SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:whc="http://www.oxygenxml.com/webhelp/components" xml:lang="zh-cn" lang="zh-cn" whc:version="22.0">
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta charset="UTF-8" /><meta name="copyright" content="(C) 版权 2021" /><meta name="DC.rights.owner" content="(C) 版权 2021" /><meta name="DC.type" content="reference" /><meta name="description" content="Agora SDK 日志文件的配置。" /><meta name="DC.subject" content="LogConfig" /><meta name="keywords" content="LogConfig" /><meta name="DC.format" content="HTML5" /><meta name="DC.identifier" content="class_logconfig" />        
      <title>LogConfig</title><!--  Generated with Oxygen version 23.0, build number 2020121702.  --><meta name="wh-path2root" content="../" /><meta name="wh-source-relpath" content="API/class_logconfig.dita" /><meta name="wh-out-relpath" content="API/class_logconfig.aspx" />
    <!-- Latest compiled and minified Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../oxygen-webhelp/lib/bootstrap/css/bootstrap.min.css" />
    
    <link rel="stylesheet" href="../oxygen-webhelp/lib/jquery-ui/jquery-ui.min.css" />
    
    <!-- Template default styles  -->
    <link rel="stylesheet" type="text/css" href="../oxygen-webhelp/app/topic-page.css?buildId=2020121702" />
    
    
    <script type="text/javascript" src="../oxygen-webhelp/lib/jquery/jquery-3.5.1.min.js"><!----></script>
    
    <script data-main="../oxygen-webhelp/app/topic-page.js" src="../oxygen-webhelp/lib/requirejs/require.js"></script>
<link rel="stylesheet" type="text/css" href="../oxygen-webhelp/template/cobalt.css?buildId=2020121702" /></head>

    <body id="class_logconfig" class="wh_topic_page frmBody">
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
  <div data-tooltip-position="bottom" class=" wh_breadcrumb "></div>

  <div class="wh_right_tools">
      <button class="wh_hide_highlight" aria-label="切换搜索突出显示" title="切换搜索突出显示"></button>
      <button class="webhelp_expand_collapse_sections" data-next-state="collapsed" aria-label="折叠截面" title="折叠截面"></button>
      <div class=" wh_navigation_links "><span id="topic_navigation_links" class="navheader"></span></div>
      <div class=" wh_print_link print d-none d-md-inline-block "><button onClick="window.print()" title="打印此页" aria-label="打印此页"></button></div>
      
      <!-- Expand/Collapse publishing TOC 
  The menu button for mobile devices is copied in the output only when the publication TOC is available
      -->
      
  </div>
       </nav>
   </div>

   <div class="wh_content_area">
       <div class="row">
  
  
  <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12" id="wh_topic_body">
      <div class=" wh_topic_content body "><main role="main"><article role="article" aria-labelledby="ariaid-title1">
    <h1 class="- topic/title title topictitle1" id="ariaid-title1"><a href="class_logconfig.aspx"><span class="- topic/ph ph">LogConfig</span></a></h1>
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="class_logconfig__shortdesc">Agora SDK 日志文件的配置。</span></p>
        <section class="- topic/section section" id="class_logconfig__prototype">
   <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">struct</strong> LogConfig
{
    <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* filePath;
    <strong class="hl-keyword">int</strong> fileSize;
    LOG_LEVEL level;
    LogConfig()
    :filePath(NULL)
    ,fileSize(-<span class="hl-number">1</span>)
    ,level(LOG_LEVEL::LOG_LEVEL_INFO)
    {}
};</pre>   
  </div>
        </section>
        <section class="- topic/section section" id="class_logconfig__detailed_desc"><h2 class="- topic/title title sectiontitle">详细描述</h2>
   
   <dl class="- topic/dl dl since">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v3.3.0</dd>
       
   </dl>
        </section>
        <section class="- topic/section section" id="class_logconfig__parameters"><h2 class="- topic/title title sectiontitle">
       属性
       
       
       
       
       
   </h2>
   
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">filePath</dt>
  <dd class="+ topic/dd pr-d/pd dd pd"><p class="- topic/p p">日志文件的完整路径。</p>
  <div class="- topic/p p">各平台日志的默认路径为：<ul class="- topic/ul ul">
      <li class="- topic/li li">Android: <code class="+ topic/ph pr-d/codeph ph codeph">/storage/emulated/0/Android/data/&lt;package name&gt;/files/agorasdk.log</code></li>
      <li class="- topic/li li">iOS: <code class="+ topic/ph pr-d/codeph ph codeph">App Sandbox/Library/caches/agorasdk.log</code></li>
      <li class="- topic/li li">macOS: <ul class="- topic/ul ul">
 <li class="- topic/li li">开启沙盒: <code class="+ topic/ph pr-d/codeph ph codeph">App Sandbox/Library/Logs/agorasdk.log</code>，例如 <code class="+ topic/ph pr-d/codeph ph codeph">/Users/&lt;username&gt;/Library/Containers/&lt;App Bundle Identifier&gt;/Data/Library/Logs/agorasdk.log</code>。</li>
 <li class="- topic/li li">关闭沙盒: <code class="+ topic/ph pr-d/codeph ph codeph">～/Library/Logs/agorasdk.log</code></li>
      </ul></li>
      <li class="- topic/li li">Windows: <code class="+ topic/ph pr-d/codeph ph codeph">C:\Users\&lt;user_name&gt;\AppData\Local\Agora\&lt;process_name&gt;\agorasdk.log</code>。</li>
  </ul></div>
  <p class="- topic/p p">请确保你指定的目录存在且可写。你可以通过该参数修改日志文件名。</p></dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">fileSize</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">单个日志文件的大小，单位为 KB。默认值为 2014 KB。如果你将 <span class="+ topic/keyword pr-d/parmname keyword parmname">fileSize</span> 设为 1024 KB，SDK 会最多输出总计 5 MB 的日志文件。如果你将 <span class="+ topic/keyword pr-d/parmname keyword parmname">fileSize</span> 设为小于 1024 KB，则设置不生效，单个日志文件最大仍为 1024 KB。</dd>
       
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">level</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">Agora SDK 的日志输出等级，详见 <a class="- topic/xref xref" href="rtc_api_data_type.aspx#enum_loglevel" title="日志输出等级。"><span class="- topic/keyword keyword">LOG_LEVEL</span></a>。</dd>
       
   </dl>
        </section></div>
</article></main></div>
      
      
      
      
  </div>
  
      <nav role="navigation" id="wh_topic_toc" aria-label="On this page" class="col-lg-2 d-none d-lg-block navbar d-print-none"> 
 <div class=" wh_topic_toc "><div class="wh_topic_label">在本页上</div><ul><li class="section-item"><div class="section-title"><a href="#class_logconfig__detailed_desc" data-tocid="class_logconfig__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#class_logconfig__parameters" data-tocid="class_logconfig__parameters">
       属性
       
       
       
       
       
   </a></div></li></ul></div>
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