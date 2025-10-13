# API注释更新工具 Makefile

.PHONY: help install install-dev test lint format clean run

help:
	@echo "可用命令:"
	@echo "  install      - 安装项目依赖"
	@echo "  install-dev  - 安装开发依赖"
	@echo "  test         - 运行测试"
	@echo "  lint         - 运行代码检查"
	@echo "  format       - 格式化代码"
	@echo "  clean        - 清理构建文件"
	@echo "  run          - 运行工具(示例)"

install:
	pip install -r requirements.txt

install-dev:
	pip install -r requirements.txt
	pip install -e .

test:
	python -m pytest tests/ -v

lint:
	python -m flake8 src/
	python -m black --check src/

format:
	python -m black src/

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

run:
	python -m src.main --help
