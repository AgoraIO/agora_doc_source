本文介绍如何获取灵动课堂 Web 端 GitHub 源码并运行项目，快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## 前提条件

~cdf5e010-5377-11ed-8dae-bf25bf08a626~

<a name="dev-env"></a>

## 准备开发环境

~e31d5f40-5377-11ed-8dae-bf25bf08a626~
## 获取源码

灵动课堂 Web 端的源码位于 GitHub [flexible-classroom-desktop](https://github.com/AgoraIO-Community/flexible-classroom-desktop) 仓库，你可参考以下步骤获取源码：

~f38d4cd0-3fce-11ed-8dae-bf25bf08a626~

## 启动灵动课堂

按照以下步骤启动灵动课堂：

1. 运行以下命令安装项目依赖：

    ```bash
    # 安装项目依赖
    yarn
    ```

    如遇安装依赖超时，请切换到淘宝镜像源或其他可用镜像源。

    ```bash
    # 切换到淘宝镜像
    yarn config set registry https://registry.npmmirror.com/
    # 安装依赖
    yarn
    ```
    
2. 运行以下命令安装依赖包：

    ```bash
    yarn bootstrap
    ```

3. 将项目根目录下的 `.env.example` 文件重命名为 `.env`：

    ```bash
    mv .env.example .env
    ```

4. 将你的 App ID 和 App Certificate 填写到 `.env` 文件中指定位置：

    ```typescript
    REACT_APP_AGORA_APP_ID={your appid}
    REACT_APP_AGORA_APP_CERTIFICATE={your app certificate}
    ```

    为方便你快速测试，`flexible-classroom-desktop` 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。但是在正式环境中，为确保安全，RTM Token 必须在服务端生成。

5. 运行以下命令以开发模式启动灵动课堂 Web 端：

    ```bash
    yarn dev
    ```

    如果使用 Node.js 17 版本，可能会遇到 `ERR_OSSL_EVP_UNSUPPORTED` 错误，这是因为 Node.js 17 版本已切换到 OpenSSL 3.0 并且和项目中某些依赖中正在使用的加密算法或密钥有冲突，可以尝试以下两种解决方案:

    - 添加 `NODE_OPTION` 参数 `--openssl-legacy-provider`

      ```bash
      # 找到 Node.js 配置文件 packages/agora-demo-app/package.json
      # 为修改 script 字段下的启动命令，添加 NODE_OPTION 参数，例如：
      
      # 原命令
      "dev": "cross-env NODE_ENV=development NODE_OPTIONS=--max_old_space_size=6144 webpack serve --config ./webpack/webpack.dev.js"
      # 改为
      "dev": "cross-env NODE_ENV=development NODE_OPTIONS=\"--max_old_space_size=6144 --openssl-legacy-provider\" webpack serve --config ./webpack/webpack.dev.js"
      # 然后启动项目
      yarn dev
      ```

    - 使用 nvm 将 Node.js 版本降级到 16

      ```bash
      # 使用 nvm 管理 Node.js 版本
      # 安装 nvm
      yarn global add nvm
      # 使用 Node.js 16 版本
      nvm use 16
      # 启动灵动课堂
      yarn dev
      ```

6. 打开浏览器，输入地址 `http://localhost:3000`，即可看到灵动课堂的 Demo 首页。点击**加入房间**或**创建房间**开始体验灵动课堂。

## 后续步骤

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_web?platform=Web)。
