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

<!-- TOC -->

- [基于 DITA 的文档内容仓库](#基于-dita-的文档内容仓库)
  - [概览](#概览)
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

API 文档中包含代码中的函数、类、枚举、结构体等的原型。这个原型需要和代码保持一致。、

> 该流程仅仅检查中文文档的原型，因为仓库会将原型自动同步到英文文档。

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
