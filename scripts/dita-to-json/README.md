# DITA Extractor

将 DITA 文档提取为结构化 JSON 的工具。

## 功能特性

- 支持 12 个平台：electron、flutter、rn、unity、csharp、unreal-cpp、unreal-bp、windows、ios、android、macos、harmonyos
- 自动解析 ditamap、keysmap、linksmap 映射文件
- 支持 conkeyref 内容引用解析
- 将 DITA XML 元素转换为 Markdown 格式
- 数据验证，检测 XML 残留和必填字段
- 详细的日志记录和统计信息

## 安装

### 使用 pip

```bash
cd scripts/dita-to-json
pip install lxml loguru
```

### 使用 uv

```bash
cd scripts/dita-to-json
uv sync
```

## 使用方法

### 基本用法

```bash
# 从项目根目录运行
cd E:/AgoraTWrepo/agora_doc_source

# 设置 Python 路径
export PYTHONPATH=scripts/dita-to-json/src

# 提取所有平台
python -m dita_extractor.main --platforms all --output output.json

# 提取单个平台
python -m dita_extractor.main --platforms flutter --output flutter_output.json

# 提取多个平台
python -m dita_extractor.main --platforms flutter electron rn --output multi_output.json
```

### 命令行参数

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `--platforms` | 要提取的平台，可指定多个，或使用 `all` 提取所有平台 | `all` |
| `--base-dir` | DITA 文件根目录 | `dita/RTC-NG` |
| `--output` | 输出 JSON 文件路径 | `output.json` |
| `--name-groups` | name_groups.json 文件路径 | `scripts/dita-to-json/name_groups.json` |
| `--log-dir` | 日志目录 | `scripts/dita-to-json/logs` |
| `--skip-validation` | 跳过数据验证 | `false` |

### 示例

```bash
# 提取 flutter 平台到指定文件
python -m dita_extractor.main --platforms flutter --output scripts/dita-to-json/flutter.json

# 跳过验证快速提取
python -m dita_extractor.main --platforms flutter --skip-validation --output quick_output.json
```

## 输出格式

输出 JSON 结构如下：

```json
[
  {
    "file": "flutter.diff",
    "changes": {
      "api_changes": [...],
      "struct_changes": [...],
      "enum_changes": [...]
    }
  }
]
```

### api_changes 结构

```json
{
  "diff": [],
  "parent_class": "IRtcEngine",
  "package_name": "",
  "details": {
    "api_name": "joinChannel",
    "api_signature": "Future<void> joinChannel(...)",
    "change_type": "create",
    "change_desc": "",
    "shortdesc": "加入频道。",
    "platforms": "flutter",
    "parent_class": "IRtcEngine",
    "detailed_desc": {
      "since": "自从 v4.0.0",
      "desc": "详细描述...",
      "deprecated": "",
      "note": "注意事项..."
    },
    "scenarios": "适用场景...",
    "related": "相关回调...",
    "timing": "调用时机...",
    "parameters": [
      {
        "name": "token",
        "desc": "参数描述...",
        "note": "参数备注..."
      }
    ],
    "return_value": "返回值说明..."
  }
}
```

### struct_changes 结构

与 api_changes 类似，但：
- `api_name` 改为 `struct_name`
- `api_signature` 改为 `struct_signature`
- 不包含 `scenarios`、`related`、`timing`、`return_value` 字段

### enum_changes 结构

与 struct_changes 类似，但：
- `struct_name` 改为 `enum_name`
- 不包含 `struct_signature` 字段
- `parameters` 为枚举值列表

## 日志

日志文件保存在 `scripts/dita-to-json/logs` 目录下：
- 文件名格式：`extract_YYYYMMDD_HHMMSS.log`
- 最多保留 10 个日志文件
- 文件日志级别：DEBUG
- 控制台输出级别：WARNING

日志末尾会输出统计信息：
```
==================================================
提取完成，耗时: 3.38s
平台数: 1
API 数量: 462
Callback 数量: 121
Struct 数量: 143
Enum 数量: 143
验证错误数: 9
==================================================
```

## 项目结构

```
scripts/dita-to-json/
├── pyproject.toml              # 项目配置
├── README.md                   # 本文档
├── name_groups.json            # API/Struct/Enum 的 parent_class 映射
├── logs/                       # 日志目录
└── src/
    └── dita_extractor/
        ├── __init__.py
        ├── main.py             # CLI 入口
        ├── config.py           # 平台映射配置
        ├── models.py           # 数据模型
        ├── scope_resolver.py   # 提取范围解析
        ├── keymap_parser.py    # keysmap/linksmap 解析
        ├── dita_parser.py      # DITA 文件解析
        ├── markdown_converter.py # XML 到 Markdown 转换
        ├── json_builder.py     # JSON 构建
        ├── validator.py        # 数据验证
        └── logger.py           # 日志配置
```

## 支持的平台

| 平台 | props 值 | ditamap 后缀 |
|------|----------|--------------|
| electron | electron | Electron |
| flutter | flutter | Flutter |
| rn | rn | RN |
| unity | unity | UNITY |
| csharp | cs | CS |
| unreal-cpp | unreal | Unreal |
| unreal-bp | bp | Blueprint |
| windows | cpp | CPP |
| ios | ios | iOS |
| android | android | Android |
| macos | mac | macOS |
| harmonyos | hmos | Harmony |

## 验证规则

1. **必填字段检查**：
   - api_changes: `api_name`、`api_signature`、`shortdesc`、`platforms`、`parent_class`
   - struct_changes: `struct_name`、`shortdesc`、`platforms`
   - enum_changes: `enum_name`、`shortdesc`、`platforms`

2. **XML 残留检测**：检测输出中是否包含未转换的 DITA 标签

## 常见问题

### 验证错误：shortdesc 必填字段为空

这通常是数据源问题，某些 API/Struct/Enum 在 DITA 文件中确实缺少 shortdesc。需要检查并补充源文件。

### 验证错误：api_signature 必填字段为空

可能原因：
1. DITA 文件中没有该平台对应的 codeblock
2. codeblock 的 props 属性不匹配当前平台

### 找不到 key 对应的文件

检查 keysmap 文件中是否包含该 key 的定义，以及 href 路径是否正确。

