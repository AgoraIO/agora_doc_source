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

-   如果你的 Web 项目是通过 Next.js 创建的，可在 `next.config.js` 中添加以下代码：

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

如果你在 Linux 环境下运行灵动课堂时碰到 `Error:unsupported platform!` 报错，可修改 `agora-classroom-sdk` 文件夹中的`package.json` 文件。

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




