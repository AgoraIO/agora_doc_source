## 概览

由于客户对在线课堂场景存在多种多样、定制化的需求，Agora 提供 Widget 帮助用户根据自身的需求开发插件并内嵌至灵动课堂内。

Widget 是包含界面与功能的独立插件。开发者可基于 `IAgoraExtensionApp` 自定义实现一个 Widget，然后在 Agora Classroom SDK 内注册该 Widget。Agora Classroom SDK 支持注册多个 Widget。 Widget 与 Widget 之间，以及 Widget 与 UI 层的其他插件都能进行通讯。

<div class="alert info">Agora 提供了以下基于 Widget 实现的插件：倒计时、投票器和答题器。你可在 <a href="https://github.com/AgoraIO-Community/CloudClass-Desktop">CloudClass-Desktop</a> 仓库 <code>/packages/agora-plugin-gallery/src/gallery</code> 目录下查看这些插件的源码。</div>

## 基本步骤

本节介绍通过 Widget 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

1. 参考[集成灵动课堂文档](/cn/agora-class/agora_class_integrate_web#change_default_ui)获取灵动课堂 GitHub 源码。

2. 在 `/packages/agora-plugin-gallery/src/gallery` 文件夹下创建一个新的文件夹，例如 `agora`。

3. 在 `/agora` 文件夹中创建一个 `index.tsx` 文件，包含以下代码：

    ```tsx
    import {
        IAgoraExtensionApp,
        AgoraExtensionAppTypeEnum,
        ExtensionStoreEach as ExtensionStore,
        ExtensionController,
    } from "agora-edu-core";

    import {transI18n} from "~ui-kit";
    import {Provider} from "mobx-react";

    // 导出 AgoraWidget 类，实现从 agora-edu-core 中导出的 IAgoraExtensionApp
    export class AgoraWidget implements IAgoraExtensionApp {
        static store: PluginStore | null = null;
        // 你需要设置以下插件属性
        appIdentifier = AGORA_WIDGET; // 插件 ID
        appName = transI18n("widget_agora.appName"); // 插件名称
        icon = "agora"; // 插件的图标
        type = AgoraExtensionAppTypeEnum.POPUP; // 插件类型：POPUP 为弹窗性插件；PLUGININ 为嵌入式插件
        width = 258; // 插件宽度
        height = 144; // 插件高度
        minWidth = 258; // 插件最小宽度
        minHeight = 144; // 插件最小高度
        trackPath = true; // 插件是否可以同步位置信息

        // 在插件注册成功后调用 apply，用于为插件注入可监听的数据和可调用的方法，详见下文监听数据和调用方法章节
        apply(storeobserver: ExtensionStore, controller: ExtensionController) {
            this.appName = transI18n("widget_agora.appName");
            AgoraWidget.store = new PluginStore(controller, storeobserver); // 插件内部的数据管理
        }

        // 渲染插件
        render(dom: Element | null) {
            dom &&
                ReactDOM.render(
                    <Provider store={AgoraWidget.store}>
                        <App />
                    </Provider>,
                    dom,
                );
        }
        // 当插件被销毁的时候调用
        destory() {
            AgoraWidget.store?.resetStore(); // 重置数据
        }
    }
    ```

4. 在 `launchOption` 中配置插件，将该插件注册到 Agora Classroom SDK 中：

    ```tsx
    launchOption.extensions = [...new Agora()] as IAgoraExtensionApp[];
    ```

## 监听数据

灵动课堂通过 MobX 进行数据管理。在 `apply` 注入的 `ExtensionStore` 是一个 observable 对象，你可以通过监听 `ExtensionStore` 的数据变化做相应的数据处理。

`apply` 方法中注入的 `ExtensionStore` 提供以下数据可供插件监听：

-   `context` 为插件提供的上下文数据：

    -   `localUserInfo` 提供当前用户的 `userUuid`、`userName` 和 `roleType`。
    -   `roomInfo` 提供当前教室的 `roomUuid`、`roomName` 和 `roomType`。

-   `roomProperties` 为插件提供可监控的房间相关属性：

    -   `state`: 插件开关状态。
    -   `extra`: 用于用户自定义数据交互信息。

-   `userProperties` 为当前用户提供的一个空间，用于做当前用户的信息交互。

以下示例代码展示了如何使用 MobX 提供的 `autorun` 或者 `reaction` 来监听 `roomProperties` 里的数据：

```tsx
React.useEffect(() => {
// 使用 autorun
autorun(() => {
        // pluginStore.context.roomProperties.extra  这里处理用户自定义数据的变更
    });

// 使用 reaction
reaction(() => pluginStore.context.roomProperties, () => { ... })
  }, []);
```

## 调用方法

`apply` 方法中注入的 `ExtensionController` 提供以下 API 可供插件调用：

-   `updateWidgetProperties(data)`: 更新插件属性
-   `deleteWidgetProperties(data)`: 删除插件属性
-   `removeWidgetExtraProperties`: 移除插件 `extra` 属性
-   `setWidgetUserProperties` 设置插件用户属性
-   `removeWidgetUserProperties` 移除插件用户属性

以下示例代码展示了如何调用 `updateWidgetProperties` 修改 `roomProperties`:

```tsx
pluginStore.controller.updateWidgetProperties({
  extra: { ... }, // 这里为用户自定义数据
});
```

## 实现插件多语言

Agora 为插件单独提供多语言的功能，你可参考以下步骤实现：

1. 在插件文件夹中创建一个 `i18n` 文件夹，里面包含需要支持的语言文件夹，如 `en`、`zh`。

2. 在 `/en` 或 `/zh` 文件夹下创建 `index.ts` 文件用于配置多语言字段：

    ```ts
    const selector_en = {
        widget_selector: {
            appName: "Pop-up quiz",
            start: "Begin Answering",
            submit: "Post",
            change: "Change My Answer",
            "number-answered": "Submission List",
            acc: "Accuracy",
            "right-key": "The Correct Answer",
            "my-answer": "My Answer",
            over: "End Of Answer",
            "student-name": "Name",
            "answer-time": "Time",
            "selected-answer": "Answer",
            restart: "Start Again",
            award: "Send Award",
            award_winner: "Award Winner",
            award_all: "Award all participants",
        },
    };

    export default selector_en;
    ```

3. 在 `/i18n` 文件夹下创建 `config.ts` 文件：

    ```ts
    import i18n from "i18next";
    import en from "./en";
    ```

4. 在插件的 `index.tsx` 文件中导入 `config.ts` 和 `transI18n`：

    ```tsx
    import "./i18n/config";
    import {transI18n} from "~ui-kit";
    ```
