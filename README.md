# 基于 DITA 的文档内容仓库（附带自动化 CI/CD）

[![Awesome JSON CI build](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app.yml)

[![Awesome JSON CI build for NG Flutter SDK](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-ng-flutter.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-ng-flutter.yml)

[![Awesome JSON CI build for NG RN SDK](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-kelu.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-kelu.yml)

[![Awesome JSON CI build for NG Unity SDK](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-framework.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-framework.yml)

[![Awesome JSON CI build for NG electron SDK](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-electron-yaxi.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-electron-yaxi.yml)

[![Awesome prototype syncs](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-sync-proto.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-sync-proto.yml)

[![Awesome DITA API doc prototype validation](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-validate-prototype.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-validate-prototype.yml)

[![OxygenScript for DITA processing](https://github.com/AgoraDoc/doc_source/actions/workflows/OxygenScript.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/OxygenScript.yml)

[![Awesome OxygenScript for DITA doc building (CG SDK)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml)

[![Awesome OxygenScript for DITA doc building (NG SDK)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding.yml/badge.svg)](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding.yml)

[![(NG SDK Frameworks)Awesome OxygenScript for DITA doc building](https://github.com/AgoraIO/agora_doc_source/actions/workflows/NG-SDK-Framework-Doc-Building.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/NG-SDK-Framework-Doc-Building.yml)

[![Awesome automerge](https://github.com/AgoraIO/agora_doc_source/actions/workflows/automerge.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/automerge.yml)

[![Awesome prototype from code to DITA (Electron)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-fetch-proto-electron.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-fetch-proto-electron.yml)

[![Awesome script sync](https://github.com/AgoraIO/agora_doc_source/actions/workflows/sync-scripts-across-branches.yml/badge.svg)](https://github.com/AgoraIO/agora_doc_source/actions/workflows/sync-scripts-across-branches.yml)

<!-- TOC -->

- [基于 DITA 的文档内容仓库](#基于-dita-的文档内容仓库)
  - [概览](#概览)
    - [什么是 DITA](#什么是-DITA)
    - [DITA map 架构](#dita-map-架构)
    - [内容重用机制](#内容重用机制)
  - [API 注释自动化协作规范](#api-注释自动化协作规范)
    - [代码配置：打 Tag](#代码配置打-tag)
      - [方法：api{-类名称}-C++ 原型{n}](#方法api-类名称-c-原型n)
      - [回调 callback{-类名称}-C++ 原型](#回调-callback-类名称-c-原型)
      - [类（结构体） class-类名称-C++ 原型](#类结构体-class-类名称-c-原型)
      - [枚举 enum-枚举类名称](#枚举-enum-枚举类名称)
    - [DITA 文件命名规则](#dita-文件命名规则)
  - [自动检查 API 文档中的原型与代码是否一致](#自动检查-api-文档中的原型与代码是否一致)
  - [API 文档代码原型从中文 DITA 文件自动同步到英文 DITA 文件](#api-文档代码原型从中文-dita-文件自动同步到英文-dita-文件)
  - [从 API 文档自动构建用于自动化填充代码注释的文档模板](#从-api-文档自动构建用于自动化填充代码注释的文档模板)
  - [（Beta）API 原型自动填充](#betaapi-原型自动填充)
  - [DITA 文件自动在线构建 HTML 文档](#dita-文件自动在线构建-html-文档)
    - [监听发版分支](#监听发版分支)
      - [RTC 大重构 Native SDK](#rtc-大重构-native-sdk)
      - [RTC 大重构框架 SDK](#rtc-大重构框架-sdk)
      - [RTC 主版本 SDK](#rtc-主版本-sdk)
    - [查看构建过程](#查看构建过程)
    - [获取压缩的 HTML 文件包](#获取压缩的-html-文件包)
    - [从 DITA 生成 JSON 的流程解析](#从-DITA-生成-JSON-的流程解析)

<!-- /TOC -->


## 概览

DITA 文档体系架构如下。由于体量不大，暂时不需要做 DITA Specialization。

文档以 DITA 作为源，同时输出面向开发者的代码注释模板和文档：

![11111](https://user-images.githubusercontent.com/10089260/168726228-7ec29a80-3810-42bc-a0a9-a20a8a4fc54a.svg)

文档对 SDK 产品的 API 接口进行了如下建模：

![22222](https://user-images.githubusercontent.com/10089260/168726238-38ab71da-d6d9-4d16-861a-b925bbdaa63a.svg)


文档内容主要分为两种文件格式：

- .dita 主要是 API 文档
- .md 其他文档

dita 目录下为所有的中文文档的源内容及相关配置文件。对应的英文内容在 en-US/dita 目录下。

- \*.xpr 文件
    Oxygen Project 文件，用于在 Oxygen 中管理文档项目，一般建议一个产品创建一个 Oxygen Project。
- .config 文件夹
    用于存放全局的 DITA 相关配置。
  - \*.xml
        DITA project file，用于发布文档。
  - custom-checks.sch
        自定义的验证配置，目前会检查 topic ID 和文件名是否一致。
- templates-cn 文件夹
  - 产品文件夹，如 RTC。各个产品根据需要自行创建模板。
     - *.dita
            DITA topic 模板文件
     - *.ditamap
            DITA map 模板文件
     - *.properties
            模板属性，可以用于设置模板的文件名前缀/后缀及模板在 Oxygen 中显示的名称。
- RTC 文件夹和 RTC-NG 文件夹。包含 RTC 产品的文档源内容及相关配置。
  - \*.md
        使用 lwdita 或者原生的 markdown 写作的文档。
        如果一篇文档需要拆分为多个 topic，子 topic 放在单独的文档目录下，比如快速开始在 RTC 根目录下只有 get-started.md，其他的 topic 都放在 quick-start 文件夹下。
  - API 文件夹
    - RTC 所有 API 的 dita topic
  - quick-start 文件夹。用于存放快速开始的子 topic。
  - config 文件夹
    - filter-***.ditaval
            过滤条件配置
    - keys-***.ditamap
            各个平台的变量定义，一般是 API 名、链接或者其他有平台差异的变量。
    - relations-*.ditamap
            Topic 之间的关系
    - subject-scheme-rtc.ditamap
            自定义的过滤属性值，用于控制文档中可以设置的 props 值。
  - conref 文件夹。用于存放所有被 conref 的 dita 源文件。
    - conref_api_metatdata.dita
            由于英文中不同平台的类的表达不一样，用于 conref + filter 在不同平台显示对应的英文表达。
  - \*.ditamap
        一个 DITA map 对应一套文档。

### 什么是 DITA

The Darwin Information Typing Architecture (DITA) is an XML-based, end-to-end architecture for authoring, producing, and delivering technical information. This architecture consists of a set of design principles for creating “information-typed” modules at a topic level and for using that content in delivery modes such as online help and product support portals on the Web.

IBM developed Darwin Information Typing Architecture (DITA) in the early 2000s when it needed to upgrade its proprietary, SGML-based Information Structure Identification Language (ISIL) and resolve its issues with producing standardized content.

During this process, XML was introduced, providing a new, more concise way to formulate data formats. The World Wide Web also came into its own at this time, which forced technical writers to rethink the prevailing book model in favor of a (web) page-based model. This was further refined into a more granular and typed topic-based model. As a result, DITA began to grow and IBM released the idea freely to the OASIS standards body.

Many things have happened since the initial release of DITA 1.0 in June 2005. As of 2015, the authoring and publishing software tools industry has grown to meet the challenges of working with DITA-based content.

While DITA first took hold in the software sector, the concept of content reuse and all of its attendant advantages – content consistency, increased writing efficiency, and lower localization costs, to name just a few – are factors that have led to its rapid spread among many other industries. Though the use of DITA is not universal, the idea of structured content has become part of the general zeitgeist of technical documentation.


DITA 是由 IBM 设计的一种基于 XML 的 SGML，主要用于解决技术文档编辑与发布的标准化问题。抛开这些高大上的形容词，简单说，就是 XML 的一个子集而已。所以适用于 XML 的库（例如 Xerces，etree）都适用于 DITA。DITA 是从实际的技术文档工作中抽象出来的，因此使用 DITA 对文档进行建模的时候，也需要因地制宜，不可盲目套用。

具体标签定义详见 [DITA 1.3 Spec](http://docs.oasis-open.org/dita/dita/v1.3/errata02/os/complete/part3-all-inclusive/dita-v1.3-errata02-os-part3-all-inclusive-complete.html) 和 Oxygen 的 [DITA Style Guide](https://www.oxygenxml.com/dita/styleguide/)。

###  DITA map 架构

一个产品的所有平台的文档对应一个 DITA map。一个 DITA map 中，通常包含文档中用到的变量、 subject scheme （定义可用的条件）以及具体的文档 topic。

下图可以大致看出 DITA map 和最终的文档结构（互动直播 Android 平台）之间的对应：

![image2022-2-9_18-8-10](https://user-images.githubusercontent.com/10089260/167323245-1ed6c57b-0ae6-465a-9dd2-303bd3f81a87.png)

产品文档的 DITA map 可能包含以下几种类型的元素

- title
    map 的标题
- topichead
    用于将内容分组，分组下如果是文档内容，topichead 会生成为文档左侧导航栏的一级目录
- mapref
    指向一个 DITA map 的引用，可能是 key map，也可以是另一套文档的 DITA map。mapref 的引用均使用 href 指定文件路径，不要用 keyref。
- keydef
    用于定义 map 中用到的变量，一般有图片、网页、文档 topic、短语。
    如果是指向 md 文件的 key，注意 format 设置为 mdita。
- topicref
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

### 示例：使用 DITA 文档记录 API 参考

XML 、JSON 与 HTML 对照

#### DITA

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE reference PUBLIC "-//OASIS//DTD DITA Reference//EN" "reference.dtd">
<reference id="api_irtcengineex_setupremotevideoex">
    <title><ph keyref="setupRemoteVideoEx" /></title>
    <shortdesc id="short"><ph id="shortdesc">Initializes the video view of a remote user.</ph></shortdesc>
    <prolog>
        <metadata>
            <keywords>
                <indexterm keyref="setupRemoteVideoEx" />
            </keywords>
        </metadata>
    </prolog>
    <refbody>
        <section id="prototype">
            <p outputclass="codeblock">
            <codeblock props="android" outputclass="language-java">public abstract int setupRemoteVideoEx(VideoCanvas remote, RtcConnection connection);</codeblock>
            <codeblock props="ios mac" outputclass="language-objectivec">- (int)setupRemoteVideoEx:(AgoraRtcVideoCanvas* _Nonnull)remote
               connection:(AgoraRtcConnection * _Nonnull)connection;</codeblock>
            <codeblock props="cpp" outputclass="language-cpp">virtual int setupRemoteVideoEx(const VideoCanvas&amp; canvas, const RtcConnection&amp; connection) = 0;</codeblock>
            <codeblock props="electron" outputclass="language-typescript">abstract setupRemoteVideoEx(
    canvas: VideoCanvas,
    connection: RtcConnection
  ): number;</codeblock>
            <codeblock props="unity" outputclass="language-csharp">public abstract int SetupRemoteVideoEx(VideoCanvas canvas, RtcConnection connection);</codeblock>
            <codeblock props="rn" outputclass="language-typescript">abstract setupRemoteVideoEx(
    canvas: VideoCanvas,
    connection: RtcConnection
  ): number;</codeblock>
            <codeblock props="flutter" outputclass="language-dart">Future&lt;void&gt; setupRemoteVideoEx(
    {required VideoCanvas canvas, required RtcConnection connection});</codeblock> </p>
        </section>
        <section id="detailed_desc">
            <p>This method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.</p>
            <p>The application specifies the uid of the remote video in the <xref keyref="VideoCanvas" /> method before the remote user joins the channel.</p>
            <p>If the remote uid is unknown to the application, set it after the application receives the <xref keyref="onUserJoined" /> callback. If the Video Recording function is enabled, the Video Recording Service joins the channel as a dummy client, causing other clients to also receive the <codeph>onUserJoined</codeph> callback. Do not bind the dummy client to the application view because the dummy client does not send any video streams.</p>
            <p>To unbind the remote user from the view, set the <parmname>view</parmname> parameter to NULL.</p>
            <p>Once the remote user leaves the channel, the SDK unbinds the remote user.</p>
            <note type="attention" props="android ios mac">
            <p>To update the rendering or mirror mode of the remote video view during a call, use the <xref keyref="setRemoteRenderModeEx2" /> method.</p>
            </note> </section>
        <section id="parameters">
            <title>Parameters</title>
            <parml>
            <plentry>
                <pt props="android ios mac">remote</pt>
                <pt props="cpp unity rn electron flutter">canvas</pt>
                <pd>
                    <p>The remote video view settings. See <xref keyref="VideoCanvas" />.</p>
                </pd>
            </plentry>
            <plentry conkeyref="joinChannelEx/connection">
                <pt />
                <pd />
            </plentry>
            </parml> </section>
        <section id="return_values" props="native electron unity rn">
            <title>Returns</title>
            <ul>
            <li>0: Success.</li>
            <li>&lt; 0: Failure.</li>
            </ul> </section>
    </refbody>
</reference>
```

#### JSON

```json
{
    "id": "api_irtcengineex_setupremotevideoex",
    "name": "setupRemoteVideoEx",
    "description": "Initializes the video view of a remote user.\nThis method initializes the video view of a remote stream on the local device. It affects only the video view that the local user sees. Call this method to bind the remote video stream to a video view and to set the rendering and mirror modes of the video view.The application specifies the uid of the remote video in the VideoCanvas method before the remote user joins the channel.If the remote uid is unknown to the application, set it after the application receives the onUserJoined callback. If the Video Recording function is enabled, the Video Recording Service joins the channel as a dummy client, causing other clients to also receive the onUserJoined callback. Do not bind the dummy client to the application view because the dummy client does not send any video streams.To unbind the remote user from the view, set the view parameter to NULL.Once the remote user leaves the channel, the SDK unbinds the remote user.",
    "parameters": [
        {
            "connection": "The connection information. See RtcConnection ."
        },
        {
            "canvas": "The remote video view settings. See VideoCanvas ."
        }
    ],
    "returns": "",
    "is_hide": false
},
```

#### HTML

https://docs.agora.io/en/extension_customer/API%20Reference/java_ng/API/class_irtcengineex.html?platform=Android#api_irtcengineex_setupremotevideoex

![企业微信截图_16641736332696](https://user-images.githubusercontent.com/10089260/192207533-089eb9c7-5ea8-4bd3-81a8-15abdc690cfc.png)

###  内容重用机制

我们的 DITA 文档用到了以下几种重用方式：

- topic
    一个产品不同平台的功能相同，因此每个 API topic 的描述大部分情况下可以用于所有平台。
- keyref
    不同平台的 API 名称、链接等可能会有差异，在同一个 API topic 中，对有平台差异的 API 名称使用 keyref，key 的具体值在单独的 ditamap 中定义。这样每个平台只需要定义好自己的 key，就可以共用一套 API topic。
- conref
    相当于文档后台的 fragment，在多个不同的 topic 中引用同样的一段内容。
  - 被 conref 的内容需要定义 id
  - 插入设置了 conref 的元素必须和被 conref 的元素一致
- conditional output
  - 使用 [subject scheme map](https://www.oxygenxml.com/dita/1.3/specs/archSpec/base/subject-scheme-maps-and-usage.html) 规定文档中可以使用的条件属性及取值。
  - 写作时定义适用的条件
        DITA 中有很多支持条件化输出的属性，我们目前只使用 props 属性（和 Lightweight DITA 内容兼容）。
  - 输出时应用 ditaval 进行过滤
- conkeyref
  - 通过 key + element ID 指定要重用的内容
  - 可以用于重用一个 API topic 中的一段内容。

##  API 注释自动化协作规范

![企业微信20220509-090330](https://user-images.githubusercontent.com/10089260/167324076-0c4b0d8a-fb33-430c-91e6-8e31d18fd69e.png)

###  代码配置：打 Tag

拟采用给 API 打 Tag 的方式配置代码信息，便于与注释 Json 文件中的内容进行关联。

- 在脚本验证阶段，文档组按照本页规定添加代码 Tag
- 脚本成熟运行阶段，需要研发在进代码的时候添加代码配置信息；建议 CI 流程中做一层检查，提交时如新增或改动 API ，检查是否已打 Tag。

如果类名称为本不该暴露的基类（仅发生于 C++），例如 callback-iaudioframeobserverbase-onmixedaudioframe，则必须把基类替换为它的扩展类，例如 callback-iaudioframeobserver-onplaybackaudioframebeforemixin。否则无法在不同平台之间通用。

####  方法：api{-类名称}-C++ 原型{n}

- 如果类名为 RtcEngine，则类名称可省略；其余类不可省略
- 如果该方法为平台特有，C++ 没有，确定 C++ 不需要添加之后原型
- n 为重载方法的序号；如有两个同名方法，则先添加的无序号，后添加的加 2

例如：api-joinchannel、api-joinchannel2、api-rtcchannel-joinchannel、api-iaudioframeobserver-onplaybackaudioframe

> OC 与 C++ 类名称以 C++ 为准；OC 独有的以 OC 命名
> 标记重载需要开发在添加一个方法时，先确认该方法是否有重载
> 由于 SDK 包中无 Java 文件，因此本页不适用 Java

####  回调 callback{-类名称}-C++ 原型

如果类名称为 IRtcEngineEventHandler，则类名称可省略，其余类不可省略。

例如：callback-onjoinchannelsuccess、callback-irtcchanneleventhandler-onjoinchannelsuccess

#### 类（结构体） class-类名称-C++ 原型

例如：class-livetranscoding

#### 枚举 enum-枚举类名称

例如：enum-voicebeautifierpreset

###  DITA 文件命名规则

RTC 和 RTC-NG 所有的 API 文件全部放在 API 文件夹内。

文件名规则：

```
{type}_{class}_{api name}{n}_{ng}.dita
```

变量说明：

- type: 接口类型，可分为如下类型：

  - api：方法
  - callback：回调
  - class：接口类、结构体
  - enum：枚举类

- class: 方法或回调在 C++ 上所在的类名称，全小写。如果类名称为 IRtcEngine 或 IRtcEngineEventHandler 则省略
- api name: 该方法的 C++ 原型全小写；如果该方法为本语言独有，则按自己原型全小写
- n: 重载方法的序号。按照增加的顺序加数字，最先加的方法后面没有数字，如 joinchannel， joinchannel2， joinchannel3；重载序号主板本和 NG 不一致的，则分开创建 .dita 文件，且 NG 文件后缀为 ng。ng 后不得再加其他后缀。
- ng：NG 和主版同一个 API 不能共用一个 dita topic 时，需要为 NG 单独创建一个时使用。

> 从项目效率考虑，NG 和主版本文件现在位于不同文件夹。我们不会再为新的文件创建后缀为 \_ng 的文件。

## 自动检查 API 文档中的原型与代码是否一致

API 文档中包含代码中的函数、类、枚举、结构体等的原型。这个原型需要和 API 接口的代码保持一致。

> 该流程仅仅检查中文文档的原型，因为仓库会将原型自动同步到英文文档。

源码位于：

https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_cpp_ng_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_dart_cg_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_dart_ng_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_electron_ng_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_java_ng_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_oc_ng_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_rn_ng_prototype.py
https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/check_unity_ng_prototype.py

核心代码：

```python
    for file in os.scandir(dita_location):
        if (file.path.endswith(".dita")) and not file.path.startswith(dita_location + "/enum_") and not file.path.startswith(dita_location + "/rtc_") and file.is_file() and os.path.basename(file) in ditamap_content:
            print(file.path)
            dita_file_list.append(file.path)
            with open(file.path, encoding='utf8') as f:
                content = f.read()
                # Use substring methods to get the proto from DITA
                # Here, we assume that the DITA file contains a single codeblock for each programming language
                after_codeblock_start_tag = re.split('<codeblock props="windows" outputclass="language-cpp">',
                                                     content)
                try:
                    before_codeblock_end_tag = re.split('</codeblock>', after_codeblock_start_tag[1])
                    proto_text = before_codeblock_end_tag[0]
                except IndexError:
                    proto_text = "Error: No prototype"

                proto_text = proto_text.replace("&amp;", "&")
                proto_text = proto_text.replace("&lt;", "<")
                proto_text = proto_text.replace("&gt;", ">")

                print(proto_text)
                dita_proto_list.append(proto_text)

    dictionary = dict(zip(dita_file_list, dita_proto_list))

    # Handle the interface files

    # Decomment all oc files
    for root, dirs, files in os.walk(code_location):
        for file in files:
            if file.endswith(".h"):
                with open(os.path.join(root, file), encoding='utf8', mode='r') as f:
                    text = removeComments(f.read())
                    with open(decomment_code_location + "/" + "concatenated.h", encoding='utf8', mode='a') as f1:
                        f1.write(text)

    with open(decomment_code_location + "/" + "concatenated.h", encoding='utf8', mode='r') as f:
        content = f.read()
        content1 = content.replace("&amp;", "&")
        content2 = content1.replace("&lt;", "<")
        content3 = content2.replace("&gt;", ">")
        content4 = content3.replace(" ", "")
        content5 = content4.replace("\n", "")

        open(log_name, "w").close()

        i = 1

        write_log("The DITAMAP used is " + dita_map_location + "\n")

        for file, code in dictionary.items():
            code1 = code.replace("&amp;", "&")
            code2 = code1.replace("&lt;", "<")
            code3 = code2.replace("&gt;", ">")
            code4 = code3.replace(" ", "")
            code5 = code4.replace("\n", "")

            if content5.find(code5) == -1:
                write_log("No. " + str(i) + " Mismatch found")
                i = i + 1
                write_log("\n")
                write_log("-------------------------------------------------------------------------------")
                write_log("-------------------------------------------------------------------------------")
                write_log("For the DITA file: " + file)
                write_log("This prototype in DITA cannot be located in the source code: \n " + code + "\n")
                write_log("-------------------------------------------------------------------------------")
                write_log("-------------------------------------------------------------------------------")
                write_log("\n")
```

### 新建 CI/CD 工作

1. 在 [https://github.com/AgoraDoc/doc_source/tree/master/xml2json/code_to_check](https://github.com/AgoraDoc/doc_source/tree/master/xml2json/code_to_check) （master 分支）新增文件夹，例如 `flutter-ng`。
2. 确保你的发版分支在这个文件中：[https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml)。 如果没有，可以直接添加自己的分支。
 > 不要删除其他分支。因为可能有其他文档项目需要。
 > 所有的 CI/CD 相关改动都需要在 master 分支进行。仓库会自动将 master 分支的最新配置和脚本文件同步到 [https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml) 中所列出的分支。

3. 在 [https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-validate-prototype.yml](https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-validate-prototype.yml) 中新增工作，在参数中输入新增文件夹名和相关平台的 Keys DITAMAP 文件，例如：

```yml
- name: Run Flutter NG validation
    if: always()
    run: |
        cd xml2json
        python check_dart_ng_prototype.py --code_location ./code_to_check/flutter-ng --dita_location ../dita/RTC-NG/API --dita_map_location ../dita/RTC-NG/config/keys-rtc-ng-api-flutter.ditamap --decomment_code_location ./code_to_check/decommented
        echo "The prototype validation starts ..."
        cat prototype_check_flutter_ng.txt
        echo "The prototype validation ends ..."
```

### 对于已经存在的 CI/CD 工作

对于 DITA API 文档，在面向 release 分支的 PR 发生时，仓库 CI 会进行自动检查。为了得到准确的检查结果，你需要：

1. 将最新的 API 代码上传到 [https://github.com/AgoraDoc/doc_source/tree/master/xml2json/code_to_check](https://github.com/AgoraDoc/doc_source/tree/master/xml2json/code_to_check) （master 分支）。

2. 确保你的发版分支在这个文件中：[https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml)。 如果没有，可以直接添加自己的分支。

 > 不要删除其他分支。因为可能有其他文档项目需要。
 > 所有的 CI/CD 相关改动都需要在 master 分支进行。仓库会自动将 master 分支的最新配置和脚本文件同步到 [https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml) 中所列出的分支。

3. 在 GitHub Actions 页面，进入触发的 [https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-validate-prototype.yml](https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-validate-prototype.yml) build workflow 中。
4. 在控制台中选择要查看的平台，在搜索框中输入 `prototype validation starts` 即可定位到报告。


## API 文档代码原型从中文 DITA 文件自动同步到英文 DITA 文件

确保你的发版分支在这个文件中：[https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/sync.yml)。 如果没有，可以直接添加自己的分支。

你在向 release 分支提 PR 或合入文件时，CI 会自动生成一个 PR。将 PR 合并即可。**这个 PR 现在会自动合并。因此你什么都不用做。**

> 警告：YiCAT 的翻译会使英文文档中的代码原型出现格式问题。你必须通过自动同步的方法更新英文 DITA 文件中的代码原型。

源码位于：

https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/sync_prototype.py

核心代码：

```python
def main():

    parser = argparse.ArgumentParser(description="Prototype syncer")

    parser.add_argument("--src_dir",
                    help="src dir",
                    action="store")
    parser.add_argument("--dest_dir", help="dest dir", action="store")

    args = vars(parser.parse_args())

    src_dir = args['src_dir']
    dest_dir = args['dest_dir']

    src_proto_section_obj = None
    dest_proto_section_obj = None
    dest_dita_file_tree = None

    # Copy cn protos to en
    for file_name in os.listdir(src_dir):

        file_ready_for_copy = True

        if file_name.startswith("api_") or file_name.startswith("class_"):

            try:
                cn_path = path.join(src_dir, file_name)
                cn_dita_file_tree = ET.parse(cn_path)
                cn_dita_file_root = cn_dita_file_tree.getroot()
            except ET.ParseError as e:
                print("[ERROR] Parse error for: " + file_name + " Code: " + str(e.code) + " Position: " + str(e.position))

            en_path = path.join(dest_dir, file_name)

            try:
                dest_dita_file_tree = ET.parse(en_path)
                en_dita_file_root = dest_dita_file_tree.getroot()
            except FileNotFoundError as e:
                print("[ERROR] File not found in en: " + file_name)
                file_ready_for_copy = False

            except ET.ParseError as e:
                print("[ERROR] Parse error for: " + file_name + " Code: " + str(e.code) + " Position: " + str(e.position))
                file_ready_for_copy = False

            if file_ready_for_copy:

                for section in cn_dita_file_root.iter("section"):
                    if section.get("id") == "prototype":
                        src_proto_section_obj = section

                refbody = en_dita_file_root.find("./refbody")

                for section in en_dita_file_root.iter("section"):
                    if section.get("id") == "prototype":
                        refbody.remove(section)
                        refbody.insert(0, src_proto_section_obj)

                dest_dita_file_tree.write(dest_dir + "//" + file_name, encoding='utf-8')

                header = """<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE reference PUBLIC "-//OASIS//DTD DITA Reference//EN" "reference.dtd">\n"""

                with open(dest_dir + "//" + file_name, "r", encoding='utf-8') as f:
                    text = header + f.read()

                with open(dest_dir + "//" + file_name, "w", encoding='utf-8') as f:
                    f.write(text)
```

## 从 API 文档自动构建用于自动化填充代码注释的文档模板

文档模板文件（JSON 文件）会在 https://github.com/AgoraIO/agora_doc_source/releases/tag/main 自动生成。SDK 研发可以通过脚本自动抓取。

如果你需要为某分支生成 JSON 文件，你需要在以下文件中添加你的分支：

https://github.com/AgoraIO/agora_doc_source/blob/master/.github/sync.yml

- RTC Electron 4.x SDK: https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-3.8.200-electron-yaxi.yml
- RTC Unity 4.x SDK: https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-3.8.200-framework.yml
- RTC RN 4.x SDK: https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-3.8.200-kelu.yml
- RTC Flutter 4.x SDK: https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-ng-flutter.yml

## （Beta）API 原型自动填充

目前仅适用于大重构 SDK 封装的框架 SDK。基于如下 CI/CD 流程构建。


1. 将最新的 API 代码上传到 [https://github.com/AgoraDoc/doc_source/tree/master/xml2json/code_to_check](https://github.com/AgoraDoc/doc_source/tree/master/xml2json/code_to_check) （master 分支）。


2. 在 https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-fetch-proto-electron.yml 文件中指定注入原型的分支，例如 my-branch。并注明触发机制（push 或 pull）即可。该文件会同时填充所有四个框架平台的原型。

```yml
# GitHub CI build pipeline
name: Awesome prototype from code to DITA (Flutter, RN, Electron, Unity)

on:
    workflow_dispatch:

    # pull_request:
    #    branches:
            # - 'release/rtc-ng/3.7.203-unity'
    #        - 'release/rtc-ng/4.0.0-framework'
    push:
        branches:
            # - 'release/rtc-ng/3.8.200-framework'
            # - 'release/rtc-ng/4.0.0-framework'
            # 4.0.0-electron
            - 'my-branch'
```

3. 指定自动 PR 的 base branch。例如 `release/rtc-ng/4.0.0-framework`。

```yml
- name: Create Pull Request
    uses: peter-evans/create-pull-request@v4
    with:
        token: ${{ secrets.GITHUB_TOKEN }}
        commit-message: Fetch proto
        title: "[AUTO: MERGE AT YOUR EARLIEST CONVENIENCE] Fetch proto"
        branch: auto/sync-proto
        branch-suffix: timestamp
        delete-branch: true
        base: release/rtc-ng/4.0.0-framework
        reviewers: Cilla-luodan
        body: >
            This PR is auto-generated to Fetch proto. @HeatherWYL  @Cilla-luodan
        labels: report, automated pr
```

CI/CD 会自动触发并向该分支提 PR。你需要 review PR 并最终合入。由于此工具使用正则表达式识别与 C++ 原型相关的框架 API，因此准确率**不是 100%**。

核心代码：

```python
# Extract prototype patterns
dart_proto_re = r'(export interface|export class|export abstract class)\s{0,10}' + re.escape(
    text) + r'\s{0,10}\{\s{0,10}[A-Za-z_0-9\s\n\?\[\]\.,;\{\}\(\)<>=$@:]{0,2000}?(?<!\s\s)\}(?!\))'
    
electron_proto_re = r'(export interface|export class|export abstract class)\s{0,10}' + re.escape(
            text) + r'\s{0,10}\{\s{0,10}[A-Za-z_0-9\s\n\?\[\]\.,;\{\}\(\)<>=$@:]{0,2000}?(?<!\s\s)\}(?!\))' 
            
rn_proto_re = r'[A-Za-z]{0,10}[\s]{0,1}[\?]{0,1}' + re.escape(text) + r'[\?]{0,1}[0-9\s]{0,1}\([A-Za-z_\s\n\?,\[\]\<\>:\)]{0,200};'

unity_proto_re = r'[A-Za-z]{1,10}[\s]{0,1}[A-Za-z]{1,10}[\s]{0,1}[A-Za-z\[\]]{1,10}[\s]{0,1}' + re.escape(result) + r'\([0-9A-Za-z_\s\n=,\[\]=:]{0,200}\);'


# Inject prototypes
for file in os.scandir(dita_location):
    if (file.path.endswith(".dita")) and not file.path.startswith(dita_location + "/enum_") and not file.path.startswith(dita_location + "/rtc_") and file.is_file() and os.path.basename(file) in ditamap_content:
        #print(file.path)
        dita_file_list.append(file.path)
        with open(file.path, encoding='utf8') as f:
            content = f.read()
            # Use substring methods to get the proto from DITA
            # Here, we assume that the DITA file contains a single codeblock for each programming language
            # The ng-sdk prop is at the beginning (if exists)
            # The current sdk is default. No plan to migrate the current sdk to DITA yet
            after_codeblock_start_tag = re.split(r'<codeblock props="[a-zA-Z\s]{0,10}cpp[a-zA-Z\s]{0,10}" outputclass="language-cpp">',
                                                 content)
            try:
                before_codeblock_end_tag = re.split('</codeblock>', after_codeblock_start_tag[1])
                proto_text = before_codeblock_end_tag[0]
            except IndexError:
                proto_text = "Error: No prototype for " + file.path

            proto_text = proto_text.replace("&amp;", "&")
            proto_text = proto_text.replace("&lt;", "<")
            proto_text = proto_text.replace("&gt;", ">")

            #print(proto_text)

            dita_proto_list.append(proto_text)

dictionary = dict(zip(dita_file_list, dita_proto_list))
```


##  DITA 文件自动在线构建 HTML 文档

GitHub action 对指定的发版分支进行监听，分支有 PR 或 push 时，自动运行文档生成脚本。

如果需要添加新的文档用于自动构建，需要提供 scenario 文件。详见 [https://www.oxygenxml.com/doc/versions/24.1/ug-editor/topics/import-export-global-scenarios.html?hl=scenario%2Cfile](https://www.oxygenxml.com/doc/versions/24.1/ug-editor/topics/import-export-global-scenarios.html?hl=scenario%2Cfile)

### 监听发版分支

监听的发版分支由以下文件决定：

####  RTC 大重构（4.x）Native SDK

[https://github.com/AgoraDoc/doc_source/blob/master/.github/workflows/AwesomeOxygenScriptforDITADocBuilding.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/workflows/AwesomeOxygenScriptforDITADocBuilding.yml)

如果需要更新监听分支，在文件中更新分支名即可。

####  RTC 大重构（4.x）框架 SDK

[https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/NG-SDK-Framework-Doc-Building.yml](https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/NG-SDK-Framework-Doc-Building.yml)

####  RTC 主版本（3.x）框架 SDK

[https://github.com/AgoraDoc/doc_source/blob/master/.github/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml](https://github.com/AgoraDoc/doc_source/blob/master/.github/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml)

#### 灵动课堂 Android 与 iOS SDK（Web SDK 使用 TypeDoc 生成）

[https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-fc.yml](https://github.com/AgoraIO/agora_doc_source/blob/master/.github/workflows/python-app-fc.yml)

如果需要更新监听分支，在文件中更新分支名即可。例如：

```yml

# This workflow will use OxygenScript to build features.

name: (NG SDK Frameworks)Awesome OxygenScript for DITA doc building

on:
    push:
        branches: ["release/rtc-ng/4.0.0-framework"]

    pull_request:
        branches: ["release/rtc-ng/4.0.0-framework"]
```

###  查看构建过程

在 GitHub Actions 页面，进入触发的 build workflow 中，即可查看构建报告：

RTC 大重构 Native SDK：[https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding.yml](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding.yml)

RTC 大重构 框架 SDK：[https://github.com/AgoraDoc/doc_source/actions/workflows/NG-SDK-Framework-Doc-Building.yml](https://github.com/AgoraDoc/doc_source/actions/workflows/NG-SDK-Framework-Doc-Building.yml)

RTC 主版本 SDK：[https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml](https://github.com/AgoraDoc/doc_source/actions/workflows/AwesomeOxygenScriptforDITADocBuilding_CG.yml)

灵动课堂 Android 和 iOS SDK：[https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-fc.yml](https://github.com/AgoraDoc/doc_source/actions/workflows/python-app-fc.yml)


### 新建文档生成 CI

如果你需要为新产品新建生成 CI，需要参考已有的 yml 文件创建一个 GitHub Action（类型为 Python Application），并定制相关参数。例如：

```yml
# This workflow will use OxygenScript to build features.

name: Awesome OxygenScript for DITA doc building (CG SDK)

on:
  push:
    # branches: [ master, 'release/**' ]
    branches: [ master ]

  pull_request:
    # branches: [ 'release/rtc/3.6.2-all' ]
    branches: [ master ]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - uses: montudor/action-zip@v1
    - name: Set up JDK 8
      uses: actions/setup-java@v3
      with:
        java-version: '8.0.332+9'
        distribution: 'temurin'
    - name: DITA doc building
      run: |
          cd scripts/oxygen/scripts
          echo "Start building documentation for CSharp CN"
          echo "-----------------------------------------------------------------------------------------------"
          echo "-----------------------------------------------------------------------------------------------"
          ./transform.sh -i ../../../dita/RTC/RTC_API_CS.ditamap -sn "DITA Map HTML5 - CG CSharp" -s ../../../.github/workflows/exported_scenarios.scenarios -v
          echo "Start building documentation for Flutter CN"
          echo "-----------------------------------------------------------------------------------------------"
          echo "-----------------------------------------------------------------------------------------------"
          ./transform.sh -i ../../../dita/RTC/RTC_API_Flutter.ditamap -sn "DITA Map HTML5 - CG Flutter" -s ../../../.github/workflows/exported_scenarios.scenarios -v
          echo "Start building documentation for CSharp EN"
          echo "-----------------------------------------------------------------------------------------------"
          echo "-----------------------------------------------------------------------------------------------"
          ./transform.sh -i ../../../en-US/dita/RTC/RTC_API_CS.ditamap -sn "DITA Map HTML5 - CG CSharp" -s ../../../.github/workflows/exported_scenarios_en.scenarios -v
          echo "Start building documentation for Flutter EN"
          echo "-----------------------------------------------------------------------------------------------"
          echo "-----------------------------------------------------------------------------------------------"
          ./transform.sh -i ../../../en-US/dita/RTC/RTC_API_Flutter.ditamap -sn "DITA Map HTML5 - CG Flutter" -s ../../../.github/workflows/exported_scenarios_en.scenarios -v

    - name: zip files
      run: |
          cd dita/RTC/out
          zip -qq -r flutter_cg_cn_doc.zip "flutter_cg"
          ls
          zip -qq -r cs_cg_cn_doc.zip "csharp_cg"
          cd ../../../en-US/dita/RTC/out
          ls
          zip -qq -r flutter_cg_en_doc.zip "flutter_cg_en"
          ls
          zip -qq -r cs_cg_en_doc.zip "csharp_cg_en"
          ls

    - name: Upload Flutter CG CN doc to release
      uses: svenstaro/upload-release-action@v2
      with:
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          file: dita/RTC/out/flutter_cg_cn_doc.zip
          asset_name: flutter_cg_cn_doc.zip
          tag: main
          overwrite: true
          body: "DITA docs."

    - name: Upload CSharp CG CN doc to release
      uses: svenstaro/upload-release-action@v2
      with:
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          file: dita/RTC/out/cs_cg_cn_doc.zip
          asset_name: cs_cg_cn_doc.zip
          tag: main
          overwrite: true
          body: "DITA docs."

    - name: Upload Flutter CG EN doc to release
      uses: svenstaro/upload-release-action@v2
      with:
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          file: en-US/dita/RTC/out/flutter_cg_en_doc.zip
          asset_name: flutter_cg_en_doc.zip
          tag: main
          overwrite: true
          body: "DITA docs."

    - name: Upload CSharp CG EN doc to release
      uses: svenstaro/upload-release-action@v2
      with:
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          file: en-US/dita/RTC/out/cs_cg_en_doc.zip
          asset_name: cs_cg_en_doc.zip
          tag: main
          overwrite: true
          body: "DITA docs."
```

###  获取压缩的 HTML 文件包

在 [https://github.com/AgoraDoc/doc_source/releases/tag/main](https://github.com/AgoraDoc/doc_source/releases/tag/main) 页面获取最新的 HTML 文件包。该文件包可直接上传后台生成 API 参考。


> 注意：DITA 文档在线构建使用了 [Oxygen Script](https://www.oxygenxml.com/xml_scripting/pricing.html)，为付费产品，需要定期续费。文档构建的详细命令参数详见 Oxygen Script 官方文档。你也可以咨询 Oxygen 技术支持。

后续的 OxygenScript 更新需要直接替换 master 分支的 https://github.com/AgoraIO/agora_doc_source/tree/master/scripts/oxygen 目录。

## 从 DITA 生成 JSON 的流程解析

### 概览

主要的解析逻辑位于：

[https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/xml2json.py](https://github.com/AgoraIO/agora_doc_source/blob/master/xml2json/xml2json.py)。

基于 Python 原生的 [xml.etree.ElementTree](https://docs.python.org/3/library/xml.etree.elementtree.html) 解析 DITA 文件并生成 JSON。

运行时支持以下命令行参数：

```python
parser = argparse.ArgumentParser(description="JSON generator")

parser.add_argument("--working_dir",
                    help="Your working dir, such as C:\\Users\\WL\\Documents\\GitHub\\doc_source\\en-US\\dita\\RTC",
                    action="store")
parser.add_argument("--platform_tag", help="Your platform tag, such as flutter", action="store")
parser.add_argument("--json_file", help="Your json file name, such as flutter_interface_new.json", action="store")
parser.add_argument("--sdk_type", help="Your SDK type: sdk or sdk-ng", action="store")
parser.add_argument("--remove_sdk_type", help="Your remove SDK type: sdk or sdk-ng", action="store")
parser.add_argument("--defined_path", help="Your defined path, such as android, flutter， electron_ng", action="store")
```

目前文件中定义了以下 DITAMAP 的 key 文件地址

```python
android_path = "config/keys-rtc-api-android.ditamap"
cpp_path = "config/keys-rtc-api-cpp.ditamap"
cpp_ng_path = "config/keys-rtc-ng-api-cpp.ditamap"
rust_path = "config/keys-rtc-api-rust.ditamap"
electron_path = "config/keys-rtc-api-electron.ditamap"
unity_path = "config/keys-rtc-api-unity.ditamap"
cs_path = "config/keys-rtc-api-cs.ditamap"
flutter_path = "config/keys-rtc-api-flutter.ditamap"
rn_path = "config/keys-rtc-api-rn.ditamap"
electron_ng_path = "config/keys-rtc-ng-api-electron.ditamap"
c_sharp_ng_path = "config/keys-rtc-ng-api-unity.ditamap"
flutter_ng_path = "config/keys-rtc-ng-api-flutter.ditamap"
rn_ng_path = "config/keys-rtc-ng-api-rn.ditamap"
unity_ng_path = "config/keys-rtc-ng-api-unity.ditamap"
```

如果需要新增平台，只需要增加相应的文件地址变量。

#### 核心代码

解决 conref

```python
    # ----------------------------------------------------------------------------
    # Implement all conrefs with the actual content
    # For example:
    # <p conref="../conref/conref_rtc_api.dita#apidef/onClientRoleChanged"> </p>
    # Depends on the relative location of conref
    # ----------------------------------------------------------------------------
    for child in root.iter('*'):
        if child.get("conref") is not None:
            conref = str(child.get("conref"))
            conref = conref.split("#")
            if "../" in str(conref[0]):
                new_working_dir = path.normpath(working_dir)
                # print(new_working_dir[0])
                # print(conref[0].replace("../", ""))
            if sys.platform == 'darwin' or sys.platform == 'linux':
                print("macOS")
                conref_path = path.join(new_working_dir, str(conref[0]).replace("../", ""))

            elif sys.platform == 'win32':
                print("Windows")
                conref_path = path.join(new_working_dir, str(conref[0]).replace("../", "").replace("/", "\\"))
            print(" ---------------------- Get the conref path ----------------------------")
            print(conref_path)
            print(" ---------------------- Get the conref path ----------------------------")
            # ---------------------------------------------------------------------------------------------------
            # Read the referenced dita file and get the content
            # ---------------------------------------------------------------------------------------------------
            dita_file_tree = ET.parse(conref_path)
            dita_file_root = dita_file_tree.getroot()
            print(str(conref[1]))

            xpath_list = str(conref[1]).split("/")
            last_id = xpath_list[-1]
            # Get the last ID
            print(" ---------------------- Last ID ----------------------------")
            print(last_id)
            print(" ---------------------- Last ID ----------------------------")

            # Find tag by id
            dita_ref_text = ""
            for dita_tag in dita_file_root.iter('*'):
                # print(str(dita_tag.get("id")))
                # print(last_id)
                if dita_tag is not None:
                    if str(dita_tag.get("id")) == str(last_id):
                        print(dita_tag)
                        for tag in dita_tag.iter():
                            print(tag)
                            dita_ref_text = dita_ref_text + dita_tag.text

            print("------------------- Dita ref text -----------------------")
            print(dita_ref_text)
            print("------------------- Dita ref text -----------------------")

            # Inject text to the original conref
            child.text = dita_ref_text
            print("------------------- Final change -----------------------")
            print(child.text)
            print("------------------- Final change -----------------------")
```

#### 解决 conkeyref


```python
    # ----------------------------------------------------------------------------
    #     # Implement all conkeyrefs with the actual content 01
    #     When you update this code, remember copy the code to 02
    #     # For example:
    #     # <ph conkeyref="createAgoraRtcEngine1/shortdesc"/>
    #     # It is first a keyref then a conref
    #     # Conkeyrefs should be replaced at the element level!!!!!!!!!
    # ----------------------------------------------------------------------------
    for child in root.iter('*'):
        if child.get("conkeyref") is not None:
            conkeyref = str(child.get("conkeyref"))
            print("Conkeyref is " + conkeyref)
            conkeyref_array = conkeyref.split("/")
            # key
            key = conkeyref_array[0]
            # ref
            if len(conkeyref_array) > 1:
                ref = conkeyref_array[1]
            else:
                ref = ""
            # Assume that a conkeyref contains only two levels
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys") == key:
                    href_text = keydef.get("href")
                else:
                    href_text = ""
            print("----------------------href text--------------------")
            print(href_text)
            print("----------------------href text--------------------")

            final_parent = child

            # Get the parent old child
            for parent in root.iter('*'):
                for d in parent.iterfind(child.tag):
                    if d is child:
                        final_parent = parent

            if sys.platform == 'darwin' or sys.platform == 'linux':
                print("macOS")
                if href_text is not None and href_text != "":
                    dir = path.join(working_dir, href_text).replace("../", "")
                    dir = path.join("..", dir)
                else:
                    dir = None
            elif sys.platform == 'win32':
                print("Windows")
                if href_text is not None and href_text != "":
                    dir = path.join(working_dir, href_text).replace("../", "").replace("/", "\\")
                else:
                    dir = None
            if dir is not None:
                print(dir)
                new_dita_file_tree = ET.parse(dir)
                new_dita_file_root = new_dita_file_tree.getroot()
                # Find the keyref
                for new_child in new_dita_file_root.iter('*'):
                    if new_child.get("id") == ref:
                        print("------------ Found a match for conkeyref -----------------")
                        print(ref)
                        print("------------ Found a match for conkeyref-----------------")
                        # Set the node from new child to old child
                        final_parent.insert(0, new_child)
                        final_parent.remove(child)

                print("----------------------conkeyref text--------------------")
                print(child)
                print("----------------------conkeyref text--------------------")
```

#### 解决 keyref

```python
    for apiname in root.iter("apiname"):
        # print(xref.get("keyref"))
        # For each xref, perform the following operations:
        # 1. Get the ditamap file per platform
        # 2. Extract href text from ditamap
        # 3. Set href text in current dita
        href_text = ""
        if apiname.get("keyref") is not None:
            # xref.text = str(xref.get("keyref"))
            # ET.SubElement(xref, "text")
            # dita_file_tree = ET.parse(defined_path)
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys").strip() == apiname.get("keyref").strip():
                    href_text = "".join(keydef.itertext()).strip()
            print("----------------------apiname text--------------------")
            print(href_text.strip())
            print("----------------------apiname text--------------------")
            apiname.text = href_text
            print(apiname.text)
```

#### 解决 xref

```python
    # <xref keyref="setChannelProfile"/> for each API category

    # xref with keyref
    for xref in root.iter("xref"):
        # print(xref.get("keyref"))
        # For each xref, perform the following operations:
        # 1. Get the ditamap file per platform
        # 2. Extract href text from ditamap
        # 3. Set href text in current dita
        href_text = ""
        if xref.get("keyref") is not None:
            # xref.text = str(xref.get("keyref"))
            # ET.SubElement(xref, "text")
            # dita_file_tree = ET.parse(defined_path)
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys") == xref.get("keyref"):
                    for text in keydef.itertext():
                        href_text = href_text + text
                    xref.text = href_text
                href_text = ""

            if sys.platform == 'darwin' or sys.platform == 'linux':
                print("macOS")
                if href_text is not None and href_text != "" and not href_text.startswith("http"):
                    dir = path.join(working_dir, href_text).replace("../", "")
                    dir = path.join("..", dir)
                elif href_text is not None and href_text.startswith("http"):
                    xref.text = href_text
                    dir = None
                    print(xref.text)
                else:
                    dir = None
            elif sys.platform == 'win32':
                print("Windows")
                if href_text is not None and href_text != "" and not href_text.startswith("http"):
                    dir = path.join(working_dir, href_text).replace("../", "").replace("/", "\\")
                elif href_text is not None and href_text.startswith("http"):
                    xref.text = href_text
                    dir = None
                    print(xref.text)
                else:
                    dir = None
            """
            if dir is not None:
                print(dir)
                dita_file_tree = ET.parse(dir)
                dita_file_root = dita_file_tree.getroot()
                # Get title
                title = dita_file_root.find("./title")
                title_ph = dita_file_root.find("./title/ph")
                print(title)
                if title.text is not None:
                    title_text = title.text
                elif title_ph.get("keyref") is not None:
                    # dita_file_tree = ET.parse(defined_path)
                    dita_file_tree = ET.parse(defined_path)
                    dita_file_root = dita_file_tree.getroot()
                    for keydef in dita_file_root.iter("keydef"):
                        if keydef.get("keys").strip() == title_ph.get("keyref").strip():
                            title_text = "".join(keydef.itertext()).strip()
                print("----------------------title text--------------------")
                print(title_text)
                print("----------------------title text--------------------")
                xref.text = title_text
                print(xref.text)  """
```


#### 获取 API 描述

```python
    # Get API ID
    api_id = root.attrib
    api_id = api_id.get("id")
    print("----------------------- App ID ------------------------")
    print(api_id)
    print("----------------------- App ID ------------------------")

    # Get API name
    api_name = ""
    api_name_tag = root.find("title")
    for q in api_name_tag.itertext():
        api_name = api_name + q
    print("----------------------- App Name ------------------------")
    print(api_name)
    print("----------------------- App Name ------------------------")

    # Get short description
    short_desc_text = ""
    short_desc = root.find('shortdesc')
    if short_desc is not None:
        for text in short_desc.itertext():
            # Add "\n" to add a line break after short desc
            short_desc_text = short_desc_text.strip("\n") + text.strip("\n") + "\n"

    if short_desc is None:
        # short_desc = "Empty"
        short_desc_text = ""
    print("----------------------- Short desc ------------------------")
    print(short_desc_text)
    print("----------------------- Short desc ------------------------")

    # Get detailed description
    # Tables exist in pd and detailed desc. Need to process tables.
    detailed_desc = ""
    for section in root.findall('./refbody/section'):
        # print(section)
        if section.get("id") == "detailed_desc":
            title = section.find("./title")
            if title is not None:
                title.clear()

            for text in section.itertext():
                if text is not None:
                    print(type(text))
                    # new_text = text.text
                    # print(new_text)
                    # if new_text is not None:
                    detailed_desc = detailed_desc + text

    detailed_desc = detailed_desc.strip(" \n ")
    # detailed_desc_text = ""

    # for i in detailed_desc:
    # detailed_desc_text = detailed_desc_text + i

    print("----------------------- Detailed desc ------------------------")
    print(detailed_desc)
    print("----------------------- Detailed desc ------------------------")

    api_desc = short_desc_text + 
```

#### 获取参数描述

```python
    # Get parameter description <plentry> by id
    # parameter name <pt>
    # parameter description <pd>
    # Use a dictionary for param/desc pair
    param_pair = {}
    param_name = ""
    param_desc = ""
    # Tables exist in pd and detailed desc. Need to process tables.
    for param_list in root.findall('./refbody/section/parml'):
        # print(section)
        # For each <plentry> in <parml>, get <pt> and <pd>
        # if param_list.get("id") != "return_values":
        for child in param_list:
            if child.find("pt") is not None:
                param_name = child.find("pt").text
                if param_name is None and child.find("./pt/ph") is not None:
                    param_name = child.find("./pt/ph").text

                elif child.text is not None:
                    print("Something unexpected happened for " + child.text)

                elif child.text is None:
                    print("No text for this node")
                    print(child)

                if child.find("./pd") is not None:

                    for text in child.find("./pd").itertext():
                        if text is not None:
                            print(text)
                            param_desc = param_desc + text

                else:
                    param_desc = ""
                    print("The param desc tag is empty")


            param_pair[param_name] = param_desc
            # Clean the param_desc variable to get new values
            param_desc = ""

    print(param_pair)
```

#### 获取返回值

```python
# Get return value
# No need to tell each return value
# Get return value
return_values = ""
for section in root.findall('./refbody/section'):
    print(section)
    if section.get("id") == "return_values":
        title = section.find("./title")
        if title is not None:
            title.clear()
        for text in section.itertext():
            print(text)
            if text is not None:
                return_values = return_values + text

print("----------------------- Return values ------------------------")
print(return_values)
print("----------------------- Return values ------------------------")
```

#### 将信息组合为 JSON

```python
# ------------------------------------------------------------------
# Migrate the information to a JSON file.
# ------------------------------------------------------------------
# See the following template
# {
#   "id": "",
#   "description": "",
#   "parameters": [
#     {"param1": "desc"},
#     {"param2": "desc"}
#   ],
#   "returns": ""
# }

data = {}

data['id'] = api_id
data['name'] = api_name.strip("\n ")
data['description'] = api_desc
data['parameters'] = json_array
data['returns'] = return_values.strip("\n ")
data['is_hide'] = True if api_id in json_hide_id_list else False

print(data)

file_name = path.basename(path.normpath(file_dir))
name_list = file_name.split(".")
json_name = name_list[0]

# Write to JSON
# Test only: ensure_ascii=False is only used for UTF-8 characters
with open(path.join(path.dirname(__file__), "json_files", json_name + '.json'), 'w', encoding="utf-8") as outfile:
    json.dump(data, outfile, ensure_ascii=False, indent=4)
```

### 相关 GitHub Action

#### RTC 3.x SDK 的 CS SDK 和 Flutter SDK

https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app.yml

```yaml
# 生成 JSON 文件（中文用于调试，英文用于生产）
echo "Running for Flutter CG"
python xml2json.py --working_dir ../en-US/dita/RTC --platform_tag flutter --json_file flutter_newer.json --sdk_type sdk --remove_sdk_type sdk-ng --defined_path flutter
echo "Running for CS CG"
python xml2json.py --working_dir ../en-US/dita/RTC --platform_tag cs --json_file csharp_cg.json --sdk_type rtc --remove_sdk_type rtc-ng --defined_path cs
```

```yaml
# 上传 JSON 文件
- name: Upload Flutter CG JSON to release
  uses: svenstaro/upload-release-action@v2
  with:
      repo_token: ${{ secrets.GITHUB_TOKEN }}
      file: xml2json/flutter_newer.json
      asset_name: flutter_doc_template.json
      tag: main
      overwrite: true
      body: "Template file for automatic comment population."
- name: Upload CS CG JSON to release
  uses: svenstaro/upload-release-action@v2
  with:
      repo_token: ${{ secrets.GITHUB_TOKEN }}
      file: xml2json/csharp_cg.json
      asset_name: csharp_cg_doc_template.json
      tag: main
      overwrite: true
      body: "Template file for automatic comment population."
```

上传的 JSON 文件位于：

https://github.com/AgoraIO/agora_doc_source/releases/tag/main

#### RTC 4.x SDK 的 Flutter、RN、Unity 及 Electron SDK

每一个平台都有其单独的 Action，便于问题调试。

https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-ng-flutter.yml
https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-kelu.yml
https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-framework.yml
https://github.com/AgoraIO/agora_doc_source/actions/workflows/python-app-3.8.200-electron-yaxi.yml

```yaml
- name: Run CN json creation
  run: |
      cd xml2json
      echo "Running for flutter NG"
      python xml2json.py --working_dir ../dita/RTC-NG --platform_tag flutter --json_file flutter_cn_ng.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path flutter-ng
- name: Run EN json creation
  if: always()
  run: |
      cd xml2json
      echo "Running for flutter NG"
      python xml2json.py --working_dir ../en-US/dita/RTC-NG --platform_tag flutter --json_file flutter_en_ng.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path flutter-ng
```

```yaml
- name: Run json creation
  run: |
      cd xml2json
      echo "Running for RN NG"
      python xml2json.py --working_dir ../dita/RTC-NG --platform_tag rn --json_file rn_cn_ng.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path rn-ng
- name: Run json creation
  if: always()
  run: |
      cd xml2json
      echo "Running for RN NG"
      python xml2json.py --working_dir ../en-US/dita/RTC-NG --platform_tag rn --json_file rn_en_ng.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path rn-ng
```

```yaml
- name: Run CN json creation
  run: |
      cd xml2json
      echo "Running for unity NG CN (test)"
      python xml2json.py --working_dir ../dita/RTC-NG --platform_tag unity --json_file unity_cn_ng.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path unity-ng
- name: Run EN json creation
  run: |
      cd xml2json
      echo "Running for unity NG EN (test)"
      python xml2json.py --working_dir ../en-US/dita/RTC-NG --platform_tag unity --json_file unity_en_ng.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path unity-ng
```
      
```yaml
- name: Run cn json creation
  run: |
      cd xml2json
      echo "Running for electron NG"
      python xml2json.py --working_dir ../dita/RTC-NG --platform_tag electron --json_file electron_ng_cn.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path electron-ng
- name: Run en json creation
  run: |
      cd xml2json
      echo "Running for electron NG"
      python xml2json.py --working_dir ../en-US/dita/RTC-NG --platform_tag electron --json_file electron_ng_en.json --sdk_type rtc-ng --remove_sdk_type rtc --defined_path electron-ng
```

上传的 JSON 文件位于：

https://github.com/AgoraIO/agora_doc_source/releases/tag/main

### 常见问题

#### 为什么 JSON 生成不全，有些内容缺失？

首先需要检查相应的 DITA 文件。绝大多数情况下，是由于标签过滤造成的内容缺失，究其原因是 DITA 写法不规范。建议直接找相关的 Writer 更改 DITA 写法。

### 已知问题

Python 原生的 [xml.etree.ElementTree](https://docs.python.org/3/library/xml.etree.elementtree.html) 功能不够强大，尤其对于 node 的编辑（增删替换等）功能较弱。例如，对于 tag 过滤，需要自己造轮子：

```python
    parent_map = {c: p for p in tree.iter() for c in p}
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng":
                 print("------------------- Tag to remove ---------------------------")
                 print(child)
                 print(child.text)
                 print(child.tag)
                 print(child.get("id"))
                 print("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""
```

因此后期如果有时间，推荐使用 [lxml](https://lxml.de/) 进行重构。
