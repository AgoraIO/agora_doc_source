# API注释自动化更新工具

## 简介

这是一个自动从HTML文档提取API注释并更新代码仓库的工具。该工具支持多个平台（cpp-ng、android-ng、ios-ng、mac-ng），能够解析HTML文档中的API、类和枚举信息，生成标准化的注释，并将其注入到对应的代码文件中。

## 特性

- 🔄 **多平台支持**: 支持C++、Android、iOS、macOS平台
- 📝 **智能解析**: 自动解析HTML文档中的API信息
- 🎯 **精确定位**: 基于签名和名称的智能代码定位
- 📊 **标准化输出**: 生成符合规范的API注释
- 🔍 **保留信息**: 自动保留现有的@technical preview、@since、@deprecated标记
- 📋 **分级日志**: 完善的日志系统，支持调试和监控

## 安装

### 环境要求

- Python 3.8+
- pip

### 安装步骤

1. 克隆项目
```bash
git clone <repository-url>
cd api_comment_updater
```

2. 安装依赖
```bash
make install
# 或者
pip install -r requirements.txt
```

3. 开发环境安装
```bash
make install-dev
```

## 使用方法

### 基本命令

```bash
# 查看帮助
python -m src.main --help

# 初始化配置
python -m src.main init --config-dir ./config

# 提取指定平台的注释（生成JSON）
python -m src.main extract --platform cpp-ng

# 注入注释到代码仓库
python -m src.main inject --platform cpp-ng --json-file output/cpp-ng.json

# 一体化流程（提取+注入）
python -m src.main update --platform cpp-ng

# 多平台批量处理
python -m src.main update --platform all
```

### 测试模式

为了方便调试和测试，工具提供了专门的测试模式：

```bash
# 测试模式帮助
python -m src.main test --help

# 完整测试流程（提取+注入）
python -m src.main test

# 指定平台测试
python -m src.main test --platform cpp-ng

# 只提取注释（用于调试解析逻辑）
python -m src.main test --action extract

# 只注入注释（用于调试注入逻辑）
python -m src.main test --action inject

# 使用自定义JSON文件测试注入
python -m src.main test --action inject --json-file output/custom-test.json
```

**测试模式特点：**
- 🧪 使用 `config/test_config.yml` 测试配置文件
- 📁 测试源代码放在 `tests/src/` 目录
- 🎯 生成的JSON文件带 `-test` 后缀，避免与生产文件冲突
- 📋 显示详细的测试状态和文件信息
- 🔍 提供更详细的调试日志输出

**测试环境设置：**
1. 创建测试配置文件 `config/test_config.yml`
2. 将测试源代码文件放入 `tests/src/` 目录
3. 运行测试命令进行调试

### 配置文件

项目使用YAML格式的配置文件：

- `config/repo_config.yml`: 主配置文件
- `config/platforms/`: 各平台特定配置
- `config/comment_templates.yml`: 注释模板

## 开发

### 代码规范

```bash
# 代码格式化
make format

# 代码检查
make lint

# 运行测试
make test
```

### 项目结构

```
api_comment_updater/
├── src/                    # 源代码
│   ├── config/            # 配置管理
│   ├── parsers/           # HTML解析器
│   ├── processors/        # 注释处理器
│   ├── injectors/         # 注释注入器
│   ├── utils/             # 工具模块
│   └── main.py           # 入口文件
├── config/                # 配置文件
├── output/               # 生成的JSON文件
├── logs/                 # 日志文件
├── tests/                # 测试文件
└── docs/                 # 文档
```

## 许可证

MIT License
