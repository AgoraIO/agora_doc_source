# -*- coding: utf-8 -*-
"""
文件工具模块
"""

import os
import glob
from pathlib import Path
from typing import List, Generator
from loguru import logger


def find_files_by_patterns(base_path: str, include_patterns: List[str], 
                          exclude_patterns: List[str] = None) -> List[str]:
    """
    根据包含和排除模式查找文件，支持精确排除逻辑
    
    Args:
        base_path: 基础搜索路径
        include_patterns: 包含模式列表
        exclude_patterns: 排除模式列表，支持!前缀表示否定（防止排除）
        
    Returns:
        List[str]: 匹配的文件路径列表
        
    Examples:
        exclude_patterns = [
            "proj.android/src/main/java/io/agora/*/internal/*",
            "!proj.android/src/main/java/io/agora/rtc2/internal/AudioEncodedFrameObserverConfig.java"
        ]
    """
    if exclude_patterns is None:
        exclude_patterns = []
        
    base_path = Path(base_path)
    found_files = set()
    
    # 查找匹配include模式的文件
    for pattern in include_patterns:
        search_path = base_path / pattern
        matching_files = glob.glob(str(search_path), recursive=True)
        found_files.update(matching_files)
        
    # 分离普通排除模式和否定模式
    normal_exclude_patterns = []
    negation_patterns = []
    
    for pattern in exclude_patterns:
        if pattern.startswith('!'):
            # 否定模式：去掉!前缀
            negation_patterns.append(pattern[1:])
        else:
            # 普通排除模式
            normal_exclude_patterns.append(pattern)
    
    logger.debug("普通排除模式: {}", normal_exclude_patterns)
    logger.debug("否定模式（防止排除): {}", negation_patterns)
    
    # 过滤掉匹配exclude模式的文件，但保护否定模式匹配的文件
    filtered_files = []
    for file_path in found_files:
        should_exclude = False
        is_protected = False
        
        # 首先检查是否被否定模式保护
        for negation_pattern in negation_patterns:
            negation_path = base_path / negation_pattern
            if file_path in glob.glob(str(negation_path), recursive=True):
                is_protected = True
                logger.debug("文件被否定模式保护: {}", file_path)
                break
        
        # 如果被保护，跳过排除检查
        if not is_protected:
            # 检查是否匹配普通排除模式
            for exclude_pattern in normal_exclude_patterns:
                exclude_path = base_path / exclude_pattern
                if file_path in glob.glob(str(exclude_path), recursive=True):
                    should_exclude = True
                    logger.debug("文件被排除模式匹配: {} -> {}", file_path, exclude_pattern)
                    break
        
        if not should_exclude:
            filtered_files.append(file_path)
    
    logger.debug("找到 {} 个匹配文件，路径: {}", len(filtered_files), base_path)
    return sorted(filtered_files)


def read_file_content(file_path: str, encoding: str = 'utf-8') -> str:
    """
    读取文件内容
    
    Args:
        file_path: 文件路径
        encoding: 文件编码
        
    Returns:
        str: 文件内容
        
    Raises:
        FileNotFoundError: 文件不存在
        UnicodeDecodeError: 编码错误
    """
    try:
        with open(file_path, 'r', encoding=encoding) as f:
            content = f.read()
        # logger.debug("成功读取文件: {}", file_path)
        return content
    except Exception as e:
        logger.error("读取文件失败 {}: {}", file_path, str(e))
        raise


def write_file_content(file_path: str, content: str, encoding: str = 'utf-8'):
    """
    写入文件内容
    
    Args:
        file_path: 文件路径
        content: 文件内容
        encoding: 文件编码
        
    Raises:
        OSError: 写入失败
    """
    try:
        # 确保目录存在
        Path(file_path).parent.mkdir(parents=True, exist_ok=True)
        
        with open(file_path, 'w', encoding=encoding) as f:
            f.write(content)
        logger.debug("成功写入文件: {}", file_path)
    except Exception as e:
        logger.error("写入文件失败 {}: {}", file_path, str(e))
        raise


def ensure_directory_exists(dir_path: str):
    """
    确保目录存在
    
    Args:
        dir_path: 目录路径
    """
    Path(dir_path).mkdir(parents=True, exist_ok=True)


def get_html_files(html_dir: str) -> Generator[str, None, None]:
    """
    获取HTML目录下的所有HTML文件
    
    Args:
        html_dir: HTML文件目录
        
    Yields:
        str: HTML文件路径
    """
    html_path = Path(html_dir)
    if not html_path.exists():
        logger.warning("HTML目录不存在: {}", html_dir)
        return
        
    for html_file in html_path.glob("*.html"):
        yield str(html_file)


def classify_html_files(html_files: List[str]) -> dict:
    """
    将HTML文件按类型分类
    
    Args:
        html_files: HTML文件路径列表
        
    Returns:
        dict: 分类后的文件字典 {"toc": [...], "class": [...], "enum": [...]}
    """
    classified = {
        "toc": [],
        "class": [], 
        "enum": []
    }
    
    for html_file in html_files:
        filename = Path(html_file).name
        if filename.startswith("toc_"):
            classified["toc"].append(html_file)
        elif filename.startswith("class_"):
            classified["class"].append(html_file)
        elif filename.startswith("enum_"):
            classified["enum"].append(html_file)
        else:
            logger.debug("跳过未分类的HTML文件: {}", html_file)
    
    logger.info("HTML文件分类完成: toc={}, class={}, enum={}", 
               len(classified["toc"]), len(classified["class"]), len(classified["enum"]))
    
    return classified
