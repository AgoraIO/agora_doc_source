#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
C++回归测试运行脚本
简化版本，用于快速运行回归测试
"""

import sys
from pathlib import Path

# 添加项目根目录到Python路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from tests.cpp_regression_test import CppRegressionTest

def main():
    """运行C++回归测试"""
    print("🚀 启动C++回归测试")
    
    test = CppRegressionTest()
    success = test.run_full_test()
    
    if success:
        print("\n🎉 所有测试通过！")
        return 0
    else:
        print("\n💥 测试失败！")
        return 1

if __name__ == "__main__":
    sys.exit(main())
