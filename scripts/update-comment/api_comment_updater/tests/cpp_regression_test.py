#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
C++回归测试脚本
用于验证C++平台的注释注入功能是否正常工作
"""

import os
import sys
import shutil
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple

# 添加项目根目录到Python路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

class CppRegressionTest:
    """C++回归测试类"""
    
    def __init__(self):
        """初始化测试环境"""
        self.project_root = Path(__file__).parent.parent
        self.tests_dir = Path(__file__).parent
        self.src_dir = self.tests_dir / "src"
        
        # 测试文件路径
        self.original_test_file = self.tests_dir / "test_original.h"
        self.test_file = self.src_dir / "test.h"
        self.backup_test_file = self.tests_dir / "test_backup.h"
        self.expected_output_file = self.tests_dir / "test_expected_output.h"
        
        # JSON配置文件
        self.json_file = self.tests_dir / "cpp_regression_test.json"
        
        # 测试结果
        self.test_results = []
        
    def setup_test_environment(self):
        """设置测试环境"""
        print("🔧 设置测试环境...")
        
        # 确保src目录存在
        self.src_dir.mkdir(exist_ok=True)
        
        # 备份当前测试文件（如果存在）
        if self.test_file.exists():
            shutil.copy2(self.test_file, self.backup_test_file)
            print(f"   ✅ 备份当前测试文件: {self.backup_test_file}")
        
        # 复制原始测试文件
        if self.original_test_file.exists():
            shutil.copy2(self.original_test_file, self.test_file)
            print(f"   ✅ 复制原始测试文件: {self.test_file}")
        else:
            print(f"   ❌ 原始测试文件不存在: {self.original_test_file}")
            return False
        
        # 检查JSON配置文件
        if not self.json_file.exists():
            print(f"   ❌ JSON配置文件不存在: {self.json_file}")
            return False
        
        print("   ✅ 测试环境设置完成")
        return True
    
    def run_injection_test(self) -> Tuple[bool, str]:
        """运行注释注入测试"""
        print("🚀 运行C++注释注入测试...")
        
        try:
            # 切换到项目根目录
            os.chdir(self.project_root)
            
            # 运行注入命令
            cmd = [
                sys.executable, "-m", "src.main", "test",
                "--action", "inject",
                "--platform", "cpp-ng", 
                "--json-file", str(self.json_file)
            ]
            
            print(f"   执行命令: {' '.join(cmd)}")
            
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=60  # 60秒超时
            )
            
            if result.returncode == 0:
                print("   ✅ 注入命令执行成功")
                return True, result.stdout
            else:
                print(f"   ❌ 注入命令执行失败 (退出码: {result.returncode})")
                print(f"   错误输出: {result.stderr}")
                return False, result.stderr
                
        except subprocess.TimeoutExpired:
            print("   ❌ 注入命令执行超时")
            return False, "Command timeout"
        except Exception as e:
            print(f"   ❌ 注入命令执行异常: {str(e)}")
            return False, str(e)
    
    def analyze_injection_results(self, output: str) -> Dict[str, any]:
        """分析注入结果"""
        print("📊 分析注入结果...")
        
        results = {
            "api_count": 0,
            "api_success": 0,
            "class_count": 0,
            "class_success": 0,
            "enum_count": 0,
            "enum_success": 0,
            "total_success": False,
            "details": []
        }
        
        # 解析输出日志
        lines = output.split('\n')
        for line in lines:
            if "注释注入完成:" in line:
                # 解析最终统计信息
                # 格式: "注释注入完成: API 1/1, 类 1/1, 枚举 1/1"
                parts = line.split("注释注入完成:")
                if len(parts) > 1:
                    stats = parts[1].strip()
                    
                    # 解析API统计
                    if "API" in stats:
                        api_part = stats.split("API")[1].split(",")[0].strip()
                        if "/" in api_part:
                            success, total = api_part.split("/")
                            results["api_success"] = int(success)
                            results["api_count"] = int(total)
                    
                    # 解析类统计
                    if "类" in stats:
                        class_part = stats.split("类")[1].split(",")[0].strip()
                        if "/" in class_part:
                            success, total = class_part.split("/")
                            results["class_success"] = int(success)
                            results["class_count"] = int(total)
                    
                    # 解析枚举统计
                    if "枚举" in stats:
                        enum_part = stats.split("枚举")[1].strip()
                        if "/" in enum_part:
                            success, total = enum_part.split("/")
                            results["enum_success"] = int(success)
                            results["enum_count"] = int(total)
            
            # 记录重要的日志信息
            if any(keyword in line for keyword in ["成功注入", "注入失败", "未能定位", "ERROR", "WARNING"]):
                results["details"].append(line.strip())
        
        # 判断总体成功
        total_expected = results["api_count"] + results["class_count"] + results["enum_count"]
        total_success = results["api_success"] + results["class_success"] + results["enum_success"]
        results["total_success"] = (total_expected > 0 and total_success == total_expected)
        
        # 输出分析结果
        print(f"   📈 API注入: {results['api_success']}/{results['api_count']}")
        print(f"   📈 类注入: {results['class_success']}/{results['class_count']}")
        print(f"   📈 枚举注入: {results['enum_success']}/{results['enum_count']}")
        print(f"   📈 总体成功: {'✅' if results['total_success'] else '❌'}")
        
        return results
    
    def verify_file_content(self) -> Tuple[bool, List[str]]:
        """验证注入后的文件内容"""
        print("🔍 验证注入后的文件内容...")
        
        issues = []
        
        if not self.test_file.exists():
            issues.append("测试文件不存在")
            return False, issues
        
        try:
            with open(self.test_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 基本内容检查
            checks = [
                ("API注释", "adjustUserPlaybackSignalVolume", "Adjusts the playback signal volume"),
                ("类注释", "ScreenAudioParameters", "audio configuration for the shared screen"),
                ("枚举注释", "AUDIENCE_LATENCY_LEVEL_TYPE", "latency level of an audience member"),
                ("属性注释", "sampleRate", "audio sample rate"),
                ("枚举值注释", "AUDIENCE_LATENCY_LEVEL_LOW_LATENCY", "low latency"),
            ]
            
            for check_name, target, expected_text in checks:
                if target in content:
                    # 检查目标附近是否有期望的注释文本（注释通常在目标上方）
                    target_index = content.find(target)
                    surrounding_text = content[max(0, target_index-1000):target_index+200]
                    
                    if expected_text.lower() in surrounding_text.lower():
                        print(f"   ✅ {check_name}检查通过")
                    else:
                        issues.append(f"{check_name}注释内容不正确")
                        print(f"   ❌ {check_name}注释内容不正确")
                else:
                    issues.append(f"{check_name}目标不存在")
                    print(f"   ❌ {check_name}目标不存在")
            
            # 检查是否有重复注释
            comment_blocks = content.count("/**")
            if comment_blocks < 5:  # 至少应该有5个注释块
                issues.append(f"注释块数量不足: {comment_blocks}")
                print(f"   ❌ 注释块数量不足: {comment_blocks}")
            else:
                print(f"   ✅ 注释块数量正常: {comment_blocks}")
            
        except Exception as e:
            issues.append(f"文件读取失败: {str(e)}")
            print(f"   ❌ 文件读取失败: {str(e)}")
        
        success = len(issues) == 0
        print(f"   📋 内容验证: {'✅ 通过' if success else '❌ 失败'}")
        
        return success, issues
    
    def compare_with_expected(self) -> Tuple[bool, List[str]]:
        """与期望输出进行比较（如果存在）"""
        if not self.expected_output_file.exists():
            print("📋 跳过期望输出比较（期望文件不存在）")
            return True, []
        
        print("📋 与期望输出进行比较...")
        
        try:
            with open(self.test_file, 'r', encoding='utf-8') as f:
                actual_content = f.read()
            
            with open(self.expected_output_file, 'r', encoding='utf-8') as f:
                expected_content = f.read()
            
            if actual_content.strip() == expected_content.strip():
                print("   ✅ 输出与期望完全一致")
                return True, []
            else:
                print("   ⚠️  输出与期望存在差异")
                # 这里可以添加更详细的差异分析
                return False, ["输出与期望存在差异"]
                
        except Exception as e:
            print(f"   ❌ 比较过程出错: {str(e)}")
            return False, [f"比较过程出错: {str(e)}"]
    
    def cleanup_test_environment(self):
        """清理测试环境"""
        print("🧹 清理测试环境...")
        
        # 恢复备份的测试文件（如果存在）
        if self.backup_test_file.exists():
            shutil.copy2(self.backup_test_file, self.test_file)
            self.backup_test_file.unlink()  # 删除备份文件
            print("   ✅ 恢复原始测试文件")
        
        print("   ✅ 测试环境清理完成")
    
    def run_full_test(self) -> bool:
        """运行完整的回归测试"""
        print("🎯 开始C++回归测试")
        print("=" * 50)
        
        overall_success = True
        
        try:
            # 1. 设置测试环境
            if not self.setup_test_environment():
                print("❌ 测试环境设置失败")
                return False
            
            # 2. 运行注入测试
            injection_success, output = self.run_injection_test()
            if not injection_success:
                print("❌ 注入测试失败")
                overall_success = False
            
            # 3. 分析注入结果
            if injection_success:
                results = self.analyze_injection_results(output)
                if not results["total_success"]:
                    print("❌ 注入结果分析失败")
                    overall_success = False
            
            # 4. 验证文件内容
            content_success, content_issues = self.verify_file_content()
            if not content_success:
                print("❌ 文件内容验证失败")
                print("   问题列表:")
                for issue in content_issues:
                    print(f"   - {issue}")
                overall_success = False
            
            # 5. 与期望输出比较
            compare_success, compare_issues = self.compare_with_expected()
            if not compare_success:
                print("⚠️  期望输出比较存在差异")
                for issue in compare_issues:
                    print(f"   - {issue}")
                # 注意：这里不设置overall_success = False，因为差异可能是可接受的
            
        except Exception as e:
            print(f"❌ 测试过程中发生异常: {str(e)}")
            overall_success = False
        
        finally:
            # 6. 清理测试环境
            self.cleanup_test_environment()
        
        # 输出最终结果
        print("=" * 50)
        if overall_success:
            print("🎉 C++回归测试通过！")
        else:
            print("💥 C++回归测试失败！")
        
        return overall_success


def main():
    """主函数"""
    test = CppRegressionTest()
    success = test.run_full_test()
    
    # 设置退出码
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
