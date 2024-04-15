## 运行灵动课堂 Web 项目报错

如果你在运行灵动课堂 Web 项目时碰到以下报错：

```
./node_modules/agora-electron-sdk/js/Api/index.js
Module not found: Can't resolve '../../build/Release/agora_node_ext'
in'/Users/magikarp/workspace/web/teacher-classroom/node_modules/agora-electron-sdk/js/Api'
```

或者
```
Error running install script for optional dependency: "/root/flexible-classroom-desktop/node modules/agora-rdc-core: Command failed.
```


可通过以下方式解决：

-   如果你的 Web 项目是通过 Next.js 创建的，可在 `next.config.js` 文件中添加以下代码：

    ```javascript
    module.exports = {
        reactStrictMode: true,
        webpack: (config, options) => {
            // 添加下面这行代码
            config.externals.push({"agora-electron-sdk": "commonjs2 agora-electron-sdk", "agora-rdc-core": "commonjs2 agora-rdc-core"});
            return config;
        },
    };
    ```

-   如果你的 Web 项目是通过 React 创建的，可在 `webpack.base.js` 中添加以下代码：

    ```javascript
    module.exports = {
    // 添加下面这行代码
    externals: { 'agora-electron-sdk': 'commonjs2 agora-electron-sdk' , "agora-rdc-core": "commonjs2 agora-rdc-core"},
    resolve: {
    fallback: {
        crypto: require.resolve('crypto-browserify'),
        stream: require.resolve('stream-browserify'),
        buffer: require.resolve('buffer/'),
    },
    ```

-   如果你的 Web 项目是通过 Vue.js 创建的，可在 `vue.config.js` 中添加以下代码：

    ```javascript
    const vueConfig = {
        // publicPath: './',
        configureWebpack: {
        // webpack plugins
        plugins: [
            ..........................
        ],

        externals:{
            // 添加下面这行代码
            'agora-electron-sdk': 'commonjs2 agora-electron-sdk',
             "agora-rdc-core": "commonjs2 agora-rdc-core"
        }
    },
    ```


## 在 Linux 环境下运行灵动课堂报错

如果你在 Linux 环境下运行灵动课堂时碰到 `Error:unsupported platform!` 报错，可在 `agora-classroom-sdk` 文件夹中的 `package.json` 文件中添加 `platform` 属性。

修改前：

```json
"agora_electron": {
    "electron_version": "12.0.0",
    "prebuilt": true
},
```

修改后：

```json
"agora_electron": {
    "electron_version": "12.0.0",
    "prebuilt": true,
    "platform":"win32" | "darwin", //"darwin"或者"win32"二选一
},
```


## 如何处理加入课堂相关报错？

### Web 端加入房间时报 `600001-1` 错误，或登录教室时服务端报 401 错误怎么办？

![](https://web-cdn.agora.io/docs-files/1680084824802)

 `600001-1` 和 `401` 错误一般是因为 [`launch`](agora_class_api_ref_web?platform=Web#launch) 方法传入的 RTM Token 错误，或者 RTM Token 和 App ID 不匹配。请检查 RTM Token 是否正确，以及保证 App ID 和 RTM Token 匹配。

声网推荐你在后端生成 RTM Token，前端调用生成的 token，详情参考[使用 AccessToken 鉴权](https://docs.agora.io/cn/Real-time-Messaging/token_upgrade_rtm)。

如果需要临时生成 token 测试，可以使用这个[工具](https://webdemo.agora.io/token-builder/)。

### 报错 "代码 30409104 详细信息：roomType conflict" 怎么办？

![](https://web-cdn.agora.io/docs-files/1680084854943)

该错误是因为该房间编号（`roomUuid`）已经创建了一个小班课课堂，同一个房间编号被配置为不同的房间类型，从而导致房间类型冲突。
声网建议不要使用同一个房间编号创建多个课堂，并且每个房间都应配置一个不同的房间类型。

其他相关服务端错误码可参考[响应状态码](agora_class_restful_api#响应状态码)

### 进入教室报错 “Error Domain=last launch not finished Code=-1 "(null)" ” 怎么办？

该错误错误一般是因为 [`launch`](agora_class_api_ref_web?platform=Web#launch) 方法传入的 RTM Token 错误或过期，或者 RTM Token 和 App ID 或 User ID 不匹配。请检查 RTM Token 是否正确和有效，以及保证 RTM Token 和 App ID 以及 User ID 匹配。

