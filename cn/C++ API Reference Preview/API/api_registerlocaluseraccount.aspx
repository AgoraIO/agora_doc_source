
<!DOCTYPE html
  SYSTEM "about:legacy-compat">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:whc="http://www.oxygenxml.com/webhelp/components" xml:lang="zh-cn" lang="zh-cn" whc:version="22.0">
    <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta charset="UTF-8" /><meta name="copyright" content="(C) 版权 2021" /><meta name="DC.rights.owner" content="(C) 版权 2021" /><meta name="DC.type" content="reference" /><meta name="description" content="注册本地用户 User Account。" /><meta name="DC.subject" content="registerLocalUserAccount" /><meta name="keywords" content="registerLocalUserAccount" /><meta name="indexterms" content="registerLocalUserAccount" /><meta name="DC.format" content="HTML5" /><meta name="DC.identifier" content="api_registerlocaluseraccount" />        
      <title>registerLocalUserAccount</title><!--  Generated with Oxygen version 23.0, build number 2020121702.  --><meta name="wh-path2root" content="../" /><meta name="wh-source-relpath" content="API/api_registerlocaluseraccount.dita" /><meta name="wh-out-relpath" content="API/api_registerlocaluseraccount.aspx" />
    <!-- Latest compiled and minified Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../oxygen-webhelp/lib/bootstrap/css/bootstrap.min.css" />
    
    <link rel="stylesheet" href="../oxygen-webhelp/lib/jquery-ui/jquery-ui.min.css" />
    
    <!-- Template default styles  -->
    <link rel="stylesheet" type="text/css" href="../oxygen-webhelp/app/topic-page.css?buildId=2020121702" />
    
    
    <script type="text/javascript" src="../oxygen-webhelp/lib/jquery/jquery-3.5.1.min.js"><!----></script>
    
    <script data-main="../oxygen-webhelp/app/topic-page.js" src="../oxygen-webhelp/lib/requirejs/require.js"></script>
<link rel="stylesheet" type="text/css" href="../oxygen-webhelp/template/cobalt.css?buildId=2020121702" /></head>

    <body id="api_registerlocaluseraccount" class="wh_topic_page frmBody">
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
    <h1 class="- topic/title title topictitle1" id="ariaid-title1"><a href="api_registerlocaluseraccount.aspx"><span class="- topic/ph ph">registerLocalUserAccount</span></a></h1>
    
    
    <div class="- topic/body reference/refbody body refbody"><p class="- topic/shortdesc shortdesc"><span class="- topic/ph ph" id="api_registerlocaluseraccount__shortdesc">注册本地用户 User Account。</span></p><section class="- topic/section section" id="api_registerlocaluseraccount__prototype"><h2 class="- topic/title title sectiontitle">原型</h2>
        
        <div class="- topic/p p">       
      <pre class="+ topic/pre pr-d/codeblock pre codeblock language-cpp"><strong class="hl-keyword">virtual</strong> <strong class="hl-keyword">int</strong> registerLocalUserAccount(
    <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* appId, <strong class="hl-keyword">const</strong> <strong class="hl-keyword">char</strong>* userAccount) = <span class="hl-number">0</span>;
      </pre>   
  </div>
        </section>
        <section class="- topic/section section" id="api_registerlocaluseraccount__detailed_desc"><h2 class="- topic/title title sectiontitle">详细描述</h2>
   
   <dl class="- topic/dl dl">
       
  <dt class="- topic/dt dt dlterm">自从</dt>
  <dd class="- topic/dd dd">v2.8.0</dd>
       
   </dl>
   <p class="- topic/p p">该方法为本地用户注册一个 User Account。注册成功后，该 User Account 即可标识该本地用户的身份，用户可以使用它加入频道。</p>
   <p class="- topic/p p">成功注册 User Account 后，本地会触发 <a class="- topic/xref xref" href="api_onlocaluserregistered.aspx" title="本地用户成功注册 User Account 回调。"><span class="- topic/keyword keyword">onLocalUserRegistered</span></a> 回调，告知本地用户的 UID 和 User Account。</p>
   <div class="- topic/p p">该方法为可选。如果你希望用户使用 User Account 加入频道，可以选用以下两种方式：<ul class="- topic/ul ul">
       <li class="- topic/li li">先调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">registerLocalUserAccount</span> 方法注册 Account，再调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannelWithUserAccount</span> 方法加入频道。</li>
       <li class="- topic/li li">直接调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannelWithUserAccount</span> 方法加入频道。</li>
   </ul></div>
   <p class="- topic/p p">两种方式的区别在于，提前调用 <span class="+ topic/keyword pr-d/apiname keyword apiname">registerLocalUserAccount</span>，可以缩短使用 <span class="+ topic/keyword pr-d/apiname keyword apiname">joinChannelWithUserAccount</span> 进入频道的时间。</p>
   <div class="- topic/note note note note_note"><span class="note__title">注：</span> 
       <ul class="- topic/ul ul">
  <li class="- topic/li li"><span class="+ topic/keyword pr-d/parmname keyword parmname">userAccount</span> 不能为空，否则该方法不生效。</li>
  <li class="- topic/li li">请确保在该方法中设置的 User Account 在频道中的唯一性。</li>
  <li class="- topic/li li">为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。 如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。</li>
       </ul>
   </div>
        </section>
        <section class="- topic/section section" id="api_registerlocaluseraccount__parameters"><h2 class="- topic/title title sectiontitle">参数</h2>
   <dl class="+ topic/dl pr-d/parml dl parml">
       
  <dt class="+ topic/dt pr-d/pt dt pt dlterm">appId</dt>
  <dd class="+ topic/dd pr-d/pd dd pd">你的项目在 Agora 控制台注册的 App ID。</dd>
       
       
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
        <section class="- topic/section section" id="api_registerlocaluseraccount__return_values"><h2 class="- topic/title title sectiontitle">返回值</h2>
   
   <ul class="- topic/ul ul">
       <li class="- topic/li li">0: 方法调用成功。</li>
       <li class="- topic/li li">&lt;0: 方法调用失败。</li>
   </ul>
        </section></div>
</article></main></div>
      
      
      
      
  </div>
  
      <nav role="navigation" id="wh_topic_toc" aria-label="On this page" class="col-lg-2 d-none d-lg-block navbar d-print-none"> 
 <div class=" wh_topic_toc "><div class="wh_topic_label">在本页上</div><ul><li class="section-item"><div class="section-title"><a href="#api_registerlocaluseraccount__prototype" data-tocid="api_registerlocaluseraccount__prototype">原型</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registerlocaluseraccount__detailed_desc" data-tocid="api_registerlocaluseraccount__detailed_desc">详细描述</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registerlocaluseraccount__parameters" data-tocid="api_registerlocaluseraccount__parameters">参数</a></div></li><li class="section-item"><div class="section-title"><a href="#api_registerlocaluseraccount__return_values" data-tocid="api_registerlocaluseraccount__return_values">返回值</a></div></li></ul></div>
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