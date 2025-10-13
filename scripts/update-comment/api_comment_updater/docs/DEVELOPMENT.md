# 开发指南

## 开发规范

### 代码风格

- 使用Python 3.8+语法
- 所有注释和日志信息使用中文
- 遵循PEP 8代码规范
- 使用Black进行代码格式化
- 行长度限制为88字符

### 注释规范

```python
def example_function(param1: str, param2: int) -> bool:
    """
    示例函数说明
    
    Args:
        param1: 字符串参数说明
        param2: 整数参数说明
        
    Returns:
        bool: 返回值说明
        
    Raises:
        ValueError: 异常情况说明
    """
    pass
```

### 日志规范

```python
from loguru import logger

# 调试信息
logger.debug("开始解析HTML文件: {}", html_file)

# 一般信息
logger.info("成功提取API: {}", api_name)

# 警告信息
logger.warning("未找到API定义: {}", api_name)

# 错误信息
logger.error("HTML解析失败: {}", error_msg)
```

### 错误处理

- 优雅降级：单个文件失败不影响整体流程
- 详细日志：记录所有错误和警告信息
- 异常传播：关键错误向上传播

### 测试规范

- 每个模块编写对应的单元测试
- 测试覆盖率目标 > 85%
- 使用pytest框架
- 测试文件命名: `test_<module_name>.py`

## 模块设计

### 配置管理 (config)

负责加载和验证配置文件，提供统一的配置访问接口。

### HTML解析 (parsers)

解析不同类型的HTML文件，提取API、类、枚举信息。

### 注释处理 (processors)

将HTML内容转换为标准化的注释格式。

### 注释注入 (injectors)

在代码仓库中定位API位置并注入注释。

### 工具模块 (utils)

提供文件操作、文本处理、日志管理等工具函数。

## 实施清单跟踪

按照实施方案中的编号清单进行开发，每完成一项标记为完成状态。

## 质量保证

- 代码审查
- 自动化测试
- 集成测试
- 性能测试
