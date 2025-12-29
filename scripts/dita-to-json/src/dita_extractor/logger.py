"""日志配置模块"""

import sys
from datetime import datetime
from pathlib import Path

from loguru import logger


def setup_logger(log_dir: Path) -> Path:
    """配置日志系统
    
    Args:
        log_dir: 日志目录路径
        
    Returns:
        当前日志文件路径
    """
    # 确保日志目录存在
    log_dir.mkdir(parents=True, exist_ok=True)
    
    # 清理旧日志，保留最近 10 个
    log_files = sorted(log_dir.glob("*.log"), key=lambda p: p.stat().st_mtime)
    while len(log_files) >= 10:
        oldest = log_files.pop(0)
        oldest.unlink()
        logger.debug(f"删除旧日志文件: {oldest}")
    
    # 生成新日志文件名
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_file = log_dir / f"extract_{timestamp}.log"
    
    # 移除默认处理器
    logger.remove()
    
    # 添加文件处理器 (DEBUG 级别)
    logger.add(
        log_file,
        level="DEBUG",
        encoding="utf-8",
        format="{time:YYYY-MM-DD HH:mm:ss} | {level: <8} | {name}:{function}:{line} - {message}",
    )
    
    # 添加控制台处理器 (WARNING 级别)
    logger.add(
        sys.stderr,
        level="WARNING",
        format="<level>{level: <8}</level> | {message}",
    )
    
    logger.info(f"日志系统初始化完成，日志文件: {log_file}")
    
    return log_file


def log_statistics(
    elapsed: float,
    platform_count: int,
    api_count: int,
    callback_count: int,
    struct_count: int,
    enum_count: int,
    error_count: int,
) -> None:
    """输出统计信息
    
    Args:
        elapsed: 运行耗时（秒）
        platform_count: 处理的平台数量
        api_count: API 数量
        callback_count: Callback 数量
        struct_count: Struct 数量
        enum_count: Enum 数量
        error_count: 验证错误数量
    """
    logger.info("=" * 50)
    logger.info(f"提取完成，耗时: {elapsed:.2f}s")
    logger.info(f"平台数: {platform_count}")
    logger.info(f"API 数量: {api_count}")
    logger.info(f"Callback 数量: {callback_count}")
    logger.info(f"Struct 数量: {struct_count}")
    logger.info(f"Enum 数量: {enum_count}")
    logger.info(f"验证错误数: {error_count}")
    logger.info("=" * 50)

