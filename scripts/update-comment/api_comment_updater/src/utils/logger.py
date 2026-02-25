# -*- coding: utf-8 -*-
"""
日志管理器
"""

import sys
from pathlib import Path
from datetime import datetime
from loguru import logger
from typing import Dict, Any


class LogManager:
    """日志管理器，负责配置和管理日志输出"""
    
    def __init__(self):
        """初始化日志管理器"""
        self._initialized = False
        
    def setup_logging(self, config: Dict[str, Any]):
        """
        根据配置设置日志系统
        
        Args:
            config: 日志配置信息
        """
        if self._initialized:
            return
            
        # 移除默认的logger配置
        logger.remove()
        
        # 创建日志目录
        log_dir = Path(config.get("log_dir", "./logs"))
        log_dir.mkdir(parents=True, exist_ok=True)
        
        # 配置文件日志
        file_level = config.get("file_level", "debug").upper()
        max_log_files = config.get("max_log_files", 30)
        
        # 生成当前运行时间戳的日志文件名
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        log_filename = f"api_updater_{timestamp}.log"
        
        logger.add(
            log_dir / log_filename,
            level=file_level,
            rotation=None,  # 不进行轮转，每次运行独立文件
            retention=f"{max_log_files} days",  # 按天数保留（loguru不支持按文件数量）
            format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {module}:{function}:{line} | {message}",
            encoding="utf-8"
        )
        
        # 配置控制台日志
        console_level = config.get("console_level", "warning").upper()
        logger.add(
            sys.stdout,
            level=console_level,
            format="<green>{time:HH:mm:ss}</green> | <level>{level}</level> | {message}"
        )
        
        self._initialized = True
        logger.info("日志系统初始化完成")
        logger.debug("文件日志级别: {}, 控制台日志级别: {}", file_level, console_level)
        logger.debug("日志文件: {}", log_dir / log_filename)
    
    def get_logger(self):
        """
        获取logger实例
        
        Returns:
            logger: loguru logger实例
        """
        return logger
