# 基于 DITA 的文档内容仓库

[![Awesome JSON CI build](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app.yml)
[![Awesome prototype syncs](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-sync-proto.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-sync-proto.yml)
[![Awesome DITA API doc prototype validation](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-validate-prototype.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-validate-prototype.yml)
[![OxygenScript for DITA processing](https://github.com/AgoraDoc/doc_source/actions/workflows/OxygenScript.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/OxygenScript.yml)
[![Awesome OxygenScript for DITA doc building (CG SDK)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml)
[![Awesome OxygenScript for DITA doc building (NG SDK)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding.yml)

## 概览

文档内容主要分为两种文件格式：

-   .dita 主要是 API 文档
-   .md 其他文档

dita 目录下为所有的中文文档的源内容及相关配置文件。对应的英文内容在 en-US/dita 目录下。

-   \*.xpr 文件  
    Oxygen Project 文件，用于在 Oxygen 中管理文档项目，一般建议一个产品创建一个 Oxygen Project。
-   .config 文件夹  
    用于存放全局的 DITA 相关配置。  
    -   \*.xml  
        DITA project file，用于发布文档。
    -   custom-checks.sch  
        自定义的验证配置，目前会检查 topic ID 和文件名是否一致。
-   templates-cn 文件夹
    -   产品文件夹，如 RTC。  
        各个产品根据需要自行创建模板。
        - *.dita  
            DITA topic 模板文件
        - *.ditamap  
            DITA map 模板文件
        - *.properties  
            模板属性，可以用于设置模板的文件名前缀/后缀及模板在 Oxygen 中显示的名称。
-   RTC 文件夹和 RTC-NG 文件夹  
    RTC 产品的文档源内容及相关配置
    -   \*.md  
        使用 lwdita 或者原生的 markdown 写作的文档。  
        如果一篇文档需要拆分为多个 topic，子 topic 放在单独的文档目录下，比如快速开始在 RTC 根目录下只有 get-started.md，其他的 topic 都放在 quick-start 文件夹下。
    -   API 文件夹
        -   RTC 所有 API 的 dita topic
    -   quick-start 文件夹  
        用于存放快速开始的子 topic
    -   config 文件夹
        -   filter-***.ditaval  
            过滤条件配置
        -   keys-***.ditamap  
            各个平台的变量定义，一般是 API 名、链接或者其他有平台差异的变量。
        -   relations-*.ditamap  
            Topic 之间的关系
        -   subject-scheme-rtc.ditamap  
            自定义的过滤属性值，用于控制文档中可以设置的 props 值。
    -   conref 文件夹  
        用于存放所有被 conref 的 dita 源文件  
        -   conref_api_metatdata.dita  
            由于英文中不同平台的类的表达不一样，用于 conref + filter 在不同平台显示对应的英文表达。
    -   *.ditamap  
        一个 DITA map 对应一套文档。

### DITA map 架构

一个产品的所有平台的文档对应一个 DITA map。一个 DITA map 中，通常包含文档中用到的变量、 subject scheme （定义可用的条件）以及具体的文档 topic。

下图可以大致看出 DITA map 和最终的文档结构（互动直播 Android 平台）之间的对应：

![image2022-2-9_18-8-10](https://user-images.githubusercontent.com/10089260/167323245-1ed6c57b-0ae6-465a-9dd2-303bd3f81a87.png)

产品文档的 DITA map 可能包含以下几种类型的元素

-   title   
    map 的标题
-   topichead  
    用于将内容分组，分组下如果是文档内容，topichead 会生成为文档左侧导航栏的一级目录
-   mapref  
    指向一个 DITA map 的引用，可能是 key map，也可以是另一套文档的 DITA map。mapref 的引用均使用 href 指定文件路径，不要用 keyref。
-   keydef  
    用于定义 map 中用到的变量，一般有图片、网页、文档 topic、短语。  
    如果是指向 md 文件的 key，注意 format 设置为 mdita。
-   topicref  
    指向一个文档 topic 的引用，均通过 keyref 指定文件或链接，不要用 href。  
    如果一篇文档分成多个层级的 topic，需要将第一级的 topicref 的 chunk 属性设置为 to-content，其他的子 topicref 的 toc 属性设置为 no。  
    如果这个 topic 只适用于部分平台，还需要在 topicref 上设置 props 属性。

下面以互动直播产品为例，说明 DITA map 的架构。

这里给出的 map 内容仅作为举例说明，并非完整有效的 DITA map。

```xml
<map>
    <title>互动直播</title>
 
    topichead 用于将 map 内容分组，并不决定文档内容的层级。这里的 Configurations 下全部是互动直播文档的配置文件，包括条件取值的定义和各个平台的变量。
    <topichead navtitle="Configurations" toc="no">
        这个 ditamap 用于规定文档中可用的过滤条件，注意 type 必须设置为 subjectScheme
        <mapref href="config/conditions.ditamap" format="ditamap" type="subjectScheme" navtitle="Conditions"/>       
        Android 平台的变量定义，过滤条件设置为 android。
        <mapref href="config/keys-android.ditamap" props="android"/>
        <mapref href="config/keys-ios.ditamap" props="ios"/>
 
        随产品变化的变量，直接定义在该产品的 DITA map 中。可以用 topichead 进行分组，方便查看和管理。
        <topichead navtitle="Variables">
            <topichead navtitle="Figures">
                <keydef keys="start-api-sequence-android" href="https://web-cdn.agora.io/docs-files/1625208380588" scope="external" format="png"/>
                <keydef keys="start-api-sequence-apple" href="https://web-cdn.agora.io/docs-files/1627888336100" scope="external" format="png" navtitle="API seqeunce of live streaming"/>
            </topichead>
 
            <topichead navtitle="Docs">
                这个 topichead 下是互动直播各平台共用的文档 topic 的 key 定义，为了方便重用，所有的 topicref 都通过 keyref 指向具体的文件。
                <keydef keys="product-overview" href="product-overview-live.md" format="mdita" locktitle="yes">
                    <topicmeta>
                        <navtitle>产品概述</navtitle>
                        <keywords>
                            <keyword>产品概述</keyword>
                        </keywords>
                    </topicmeta>
                </keydef>
                <keydef keys="product-compare" href="product-overview/product-solution-comparison.md" format="mdita">
                    <topicmeta>
                        <keywords>
                            <keyword>直播产品区别</keyword>
                        </keywords>
                    </topicmeta>
                </keydef>
            </topichead>
 
            互动直播产品用到的其他变量
            <keydef keys="product-name">
                <topicmeta>
                    <keywords>
                        <keyword>互动直播</keyword>
                    </keywords>
                </topicmeta>
            </keydef>
        </topichead>
    </topichead>
     
    这里向下是互动直播产品的文档内容，每一个 topichead 对应文档站左侧的第一级导航
    <topichead navtitle="产品介绍">
        topichead 下的第一级 topicref 对应现在的单篇文档，如果一篇文档有子 topic，这里的 topicref 要设置 chunk，将下面的子 topic 合并到一个页面发布。
        这里 topicref 的 navtitle 只影响在 DITA map manager 中显示的标题，生成的文档目录中会使用文档内的一级标题。如果希望文档目录的标题和文档内的一级标题不一样（比如文档标题过长），需要在 key 的定义中添加 navtitle 元素，同时将 locktitle 属性设置为 yes。
        <topicref keyref="product-overview" navtitle="产品概述" chunk="to-content">
            <topicref keyref="product-compare" toc="no"/>
            <topicref keyref="product-compatibility" toc="no"/>
        </topicref>
    </topichead>
 
    <topichead navtitle="参考文档">
        这里的 API 文档直接引用已经做好的 API 文档的 DITA map，每个平台对应一个，设置好 props。
        <topicref href="RTC_NG_API_Android.ditamap" navtitle="Android API 参考" format="ditamap" props="android"/>
        <topicref href="RTC_NG_API_iOS.ditamap" navtitle="iOS API 参考" format="ditamap" props="ios"/>
        <topicref keyref="error-code" navtitle="错误码"/>
    </topichead>
    这个 faq 是外部链接，key 在各个平台的 key map 中定义。
    <topicref keyref="faq">
        <topicmeta>
            <navtitle>FAQ</navtitle>
            <shortdesc>互动直播产品的常见问题</shortdesc>
        </topicmeta>
    </topicref>
</map>
```

### 内容重用机制

我们的 DITA 文档用到了以下几种重用方式：

-   topic  
    一个产品不同平台的功能相同，因此每个 API topic 的描述大部分情况下可以用于所有平台。
-   keyref  
    不同平台的 API 名称、链接等可能会有差异，在同一个 API topic 中，对有平台差异的 API 名称使用 keyref，key 的具体值在单独的 ditamap 中定义。这样每个平台只需要定义好自己的 key，就可以共用一套 API topic。
-   conref  
    相当于文档后台的 fragment，在多个不同的 topic 中引用同样的一段内容。  
    -   被 conref 的内容需要定义 id
    -   插入设置了 conref 的元素必须和被 conref 的元素一致
-   conditional output
    -   使用 [subject scheme map](https://www.oxygenxml.com/dita/1.3/specs/archSpec/base/subject-scheme-maps-and-usage.html) 规定文档中可以使用的条件属性及取值。
    -   写作时定义适用的条件  
        DITA 中有很多支持条件化输出的属性，我们目前只使用 props 属性（和 Lightweight DITA 内容兼容）。
    -   输出时应用 ditaval 进行过滤
-   conkeyref
    -   通过 key + element ID 指定要重用的内容
    -   可以用于重用一个 API topic 中的一段内容。

## API 注释自动化协作规范

![企业微信20220509-090330](https://user-images.githubusercontent.com/10089260/167324076-0c4b0d8a-fb33-430c-91e6-8e31d18fd69e.png)

### 代码配置：打 Tag

拟采用给 API 打 Tag 的方式配置代码信息，便于与注释 Json 文件中的内容进行关联。

-   在脚本验证阶段，文档组按照本页规定添加代码 Tag
-   脚本成熟运行阶段，需要研发在进代码的时候添加代码配置信息；建议 CI 流程中做一层检查，提交时如新增或改动 API ，检查是否已打 Tag。

如果类名称为本不该暴露的基类（仅发生于 C++），例如 callback-iaudioframeobserverbase-onmixedaudioframe，则必须把基类替换为它的扩展类，例如 callback-iaudioframeobserver-onplaybackaudioframebeforemixin。否则无法在不同平台之间通用。

#### 方法：api{-类名称}-C++ 原型{n}

- 如果类名为 RtcEngine，则类名称可省略；其余类不可省略
- 如果该方法为平台特有，C++ 没有，确定 C++ 不需要添加之后原型
- n 为重载方法的序号；如有两个同名方法，则先添加的无序号，后添加的加 2

例如：api-joinchannel、api-joinchannel2、api-rtcchannel-joinchannel、api-iaudioframeobserver-onplaybackaudioframe


> OC 与 C++ 类名称以 C++ 为准；OC 独有的以 OC 命名
> 标记重载需要开发在添加一个方法时，先确认该方法是否有重载
> 由于 SDK 包中无 Java 文件，因此本页不适用 Java
