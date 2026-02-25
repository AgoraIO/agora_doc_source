#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
API注释自动化更新工具
"""

from setuptools import setup, find_packages

with open("requirements.txt", "r", encoding="utf-8") as f:
    requirements = [line.strip() for line in f if line.strip() and not line.startswith("#")]

setup(
    name="api-comment-updater",
    version="1.0.0",
    description="自动从HTML文档提取注释并更新代码仓库的工具",
    author="Agora Doc Team",
    author_email="",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    install_requires=requirements,
    python_requires=">=3.8",
    entry_points={
        "console_scripts": [
            "api-comment-updater=main:main",
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
)
