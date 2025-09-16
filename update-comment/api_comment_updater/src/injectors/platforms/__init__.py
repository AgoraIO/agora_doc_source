# -*- coding: utf-8 -*-
"""
平台特定的代码定位器和注释注入器
"""

from .base import BaseLocator, BaseInjector
from .cpp_locator import CppLocator
from .cpp_injector import CppInjector
from .java_locator import JavaLocator
from .java_injector import JavaInjector
from .oc_locator import OcLocator
from .oc_injector import OcInjector

__all__ = [
    'BaseLocator', 'BaseInjector',
    'CppLocator', 'CppInjector',
    'JavaLocator', 'JavaInjector',
    'OcLocator', 'OcInjector'
]
