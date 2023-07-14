在虚拟场景中，塑造一个独一无二的虚拟形象是进入场景的第一步。MetaWorld 支持导入自定义人物素材模型，并支持换装和捏脸功能。本文介绍如何在 MetaWorld 中实现对虚拟形象的换装和捏脸。

## 示例项目

声网在 GitHub 上提供开源 [Agora-MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

如果你还需了解 Unity 部分的工程文件和功能指南，请联系 [sales@agora.io](mailto:sales@agora.io) 获取。


## 前提条件

实现该进阶功能前，请确保你已实现基础的元语聊或元直播功能，如创建 Meta 服务、获取并下载场景资源、创建场景、设置虚拟形象的信息并进入场景。详见[基础功能](https://docs.agora.io/cn/metaworld/mw_integration_metachat_android?platform=All%20Platforms)。

## 实现步骤

下图展示 API 调用时序：

![](https://web-cdn.agora.io/docs-files/1688114635443)


### 1. 解压资源并设置 UI

解压用于换装和捏脸的资源压缩包，并根据下载的资源文件显示特定的 UI。

```java
// 解压换装捏脸资源
// 如下只是示例，你可以根据自己的开发环境自行实现解压
private void unzipIcons(String filePath) {
    // 创建目标文件夹路径，用于存储解压后的文件
    File targetFolderPath = new File(filePath + File.separator + FILE_NAME_ICON_FOLDER);
    if (targetFolderPath.exists()) {
        Utils.deleteFile(targetFolderPath);
    }
    // 调用 unzip 方法解压 icon 资源压缩包
    Utils.unzip(filePath + File.separator + FILE_NAME_ICONS_ZIP, filePath);
}

// unzip 方法的实现
// 通过系统原生的 ZipInputStream 类和 FileOutputStream 类实现 unzip 方法
// 用于解压 icon 资源压缩包
public static void unzip(String zipFilePath, String destDirectory) {
    File destDir = new File(destDirectory);
    if (!destDir.exists()) {
        destDir.mkdir();
    }
    try (ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(zipFilePath));) {
        ZipEntry zipEntry = zipInputStream.getNextEntry();
        byte[] buffer = new byte[1024];
        while (zipEntry != null) {
            if (!zipEntry.isDirectory()) {
                String fileName = zipEntry.getName();
                File newFile = new File(destDirectory + File.separator + fileName);
                // create all non exists folders
                new File(newFile.getParent()).mkdirs();
                FileOutputStream fileOutputStream = new FileOutputStream(newFile);
                int len;
                while ((len = zipInputStream.read(buffer)) > 0) {
                    fileOutputStream.write(buffer, 0, len);
                }
                fileOutputStream.close();
            }
            zipEntry = zipInputStream.getNextEntry();
        }
        zipInputStream.closeEntry();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

private void setupUI() {
    // 根据下载的资源文件显示特定的 UI
    ......
}
```

### 2. 发送换装和捏脸消息

通过 [`sendSceneMessage`](./mw_api_ref_android?platform=All%20Platforms#sendscenemessage) 方法向虚拟场景中发送用户虚拟角色的换装和捏脸消息。

```java
public static final String KEY_UNITY_MESSAGE_UPDATE_DRESS = "updateDress";
public static final String KEY_UNITY_MESSAGE_UPDATE_FACE = "updateFace";

// 发送换装消息到虚拟场景中
public void sendRoleDressInfo(int[] resIdArray) {
    // 注意：message 协议格式需要由你们的 Unity 开发人员和 Native 开发人员协商后规定
    UnityMessage message = new UnityMessage();
    message.setKey(MetaConstants.KEY_UNITY_MESSAGE_UPDATE_DRESS);
    JSONObject valueJson = new JSONObject();
    valueJson.put("id", resIdArray);
    message.setValue(valueJson.toJSONString());
    sendSceneMessage(JSONObject.toJSONString(message));
}

// 发送捏脸消息到虚拟场景中
public void sendRoleFaceInfo(FaceParameterItem[] faceParameterItems) {
    // 注意：message 协议格式需要由你们的 Unity 开发人员和 Native 开发人员协商后规定
    UnityMessage message = new UnityMessage();
    message.setKey(MetaConstants.KEY_UNITY_MESSAGE_UPDATE_FACE);
    JSONObject valueJson = new JSONObject();
    valueJson.put("value", faceParameterItems);
    message.setValue(valueJson.toJSONString());
    sendSceneMessage(JSONObject.toJSONString(message));
}

// 发送消息到虚拟场景中
public void sendSceneMessage(String msg) {
    if (metaScene == null) {
        Log.e(TAG, "sendMessageToScene metaScene is null");
        return;
    }

    if (metaScene.sendSceneMessage(msg.getBytes()) == 0) {
        Log.i(TAG, "send " + msg + " successful");
    } else {
        Log.e(TAG, "send " + msg + " fail");
    }
}
```