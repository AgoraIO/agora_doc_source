灵动课堂目前支持中文、英文和西班牙语。如果你需要添加更多语言，只需要在指定目录找到语言相关的 key 值，进行修改即可。

## Web 端多语言配置

Web 端源码中，主 SDK （Classroom SDK 和 Proctor SDK） 和插件（包括答题器、倒计时、投票器、环信 IM 模块）有各自单独的多语言文件。具体修改方法如下:

- 主 SDK：
  
  1. 在 `packages/agora-classroom-sdk/src/infra/translate` 目录下增加对应的 TypeScript 格式的语言文件（文件名只需要保证唯一性即可）文件内容可参考英语的语言文件，如下图所示：
  ![](https://web-cdn.agora.io/docs-files/1680084679972)

  2. 在 `packages/agora-classroom-sdk/src/infra/api/index.tsx` 文件中增加一行对应的 `addResourceBundle();` 代码，位置如下图所示：
  ![](https://web-cdn.agora.io/docs-files/1680084689520)

  例如：你想要添加日语，那么你需要在 `packages/agora-classroom-sdk/src/infra/translate` 目录下增加一个 `jpn.ts` 文件，并在 `packages/agora-classroom-sdk/src/infra/api/index.tsx` 文件中合适的位置增加一行 `addResourceBundle('jp', jp);`。
  <div class="alert info"><code>addResourceBundle()</code> 中所填的参数只要具有唯一性且容易对应到该语言即可。</div>


- 插件：

  1. 在 `packages/agora-plugin-gallery/src/gallery/answer/i18n` 目录下增加对应的文件夹（文件夹名只需要保证唯一性即可），在该文件夹内增加一个 TypeScript 格式的语言文件 `index.ts`，文件内容可参考英语（`en` 文件夹）或中文（`zh` 文件夹）的语言文件。以下为英语语言文件的内容：
  ![](https://web-cdn.agora.io/docs-files/1680084701486)

  2. 在 `packages/agora-plugin-gallery/src/gallery/answer/i18n/config.ts` 文件中增加一行 `import` 声明和一行对应的 `addResourceBundle();` 代码，位置如下图所示：
  ![](https://web-cdn.agora.io/docs-files/1680084710288)

  例如：你想要添加日语，那么你需要在 `packages/agora-plugin-gallery/src/gallery/answer/i18n` 目录下增加一个 `jp` 文件夹，内有一个 `index.ts` 文件，并在 `packages/agora-plugin-gallery/src/gallery/answer/i18n/config.ts` 文件中合适的位置增加一行 `import jp from './jp';` 声明和一行 `addResourceBundle(jp", jp);` 代码。
  <div class="alert info"><code>addResourceBundle()</code> 中所填的参数只要具有唯一性且容易对应到该语言即可。 </div>

## Android 端多语言配置

你需要在以下 3 个目录下增加对应的语言的文件夹（文件夹名只需要保证唯一性即可），在该文件夹内增加一个对应语言的 `string.xml` 文件，内容可参考英语（`value` 文件夹）或中文（`value-zh` 文件夹）的语言文件。

- `/AgoraClassSDK/src/main/res`
  ![](https://web-cdn.agora.io/docs-files/1680084721653)

- `/AgoraEduUIKit/src/main/res`
  ![](https://web-cdn.agora.io/docs-files/1680084729669)

  例如：你想要添加日语，那么你需要在以上目录下增加一个 `value-jp` 文件夹，内有一个 `strings.xml` 文件。

## iOS 端多语言配置

1. 在 `others ` 文件夹下，复制一个原有的语言文件夹（例如 `en.Iproj`），重命名为新语言对应的名称（例如 `jp.Iproj`）。
   <div class="alert info">文件夹名只要具有唯一性且容易对应到该语言即可，但后缀必须为 <code>.lproj</code>。</div>
2. 把文件夹内的 `Localizable.strings` 文件里的 `value` 都替换为新增语言对应的值。
3. 在进入房间前，将 `AgoraUIBaseViews` 里的全局变量 `agora_ui_language` 的指设置为新增语言对应的文件夹名，再进入房间即可生效。



