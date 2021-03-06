## 2.6.0 版

灵动课堂 2.6.0 版于 2022 年 6 月 30 日发布。

#### 新增功能

2.6.0 版新增以下功能 ：

- 截图（仅 Electron）：2.6.0 版在一对一、小班课和大班课场景中新增截图功能。老师或助教可在工具栏选择直接截取屏幕内容或隐藏教室截图。截图会居中显示在白板上。
- 自动分组：对于分组讨论功能，2.6.0 版支持自动分组。老师可设置小组数量，系统随机将全班学生平均分配给各个小组。
- 拖拽图片到白板（Web/Electron）：老师或助教可在 PC 端将本地图片拖动到白板区域，松开鼠标即可将该图片插入白板。
- 保存板书：2.6.0 版支持老师或助教通过工具栏将板书以 JPG 格式保存到本地。
- 上传在线课件：2.6.0 版支持老师在“我的资源”中上传在线课件，例如 YouTube 链接、Google Drive 链接。在线课件的后缀名默认为 `.alf` (agora link file)。上传成功后，老师点击云盘中在线课件，即可打开该课件。

**问题修复**

2.6.0 版修复了以下问题：

- iOS 端接收全体消息时出现 crash。
- 小班课中，iOS 端的老师未选择画笔，但是在白板上涂写却能出现红色线条。
- 小班课中，iOS 端的老师双击设置、聊天、花名册按钮，这些按钮 的蓝色高亮状态不会消失。
- 小班课中，Android 端的学生进入某一小组后，邀请老师进入同一小组，但是老师进入的是另一个小组。
- （全平台）小班课中，老师在学生进入教师前开启分组又结束分组，学生进入后再次开启分组，必现 500 报错。