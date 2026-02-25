# -*- coding: utf-8 -*-
"""
HTML解析器测试
"""

import pytest
import tempfile
from pathlib import Path

from src.parsers.parser_factory import HTMLParserFactory
from src.parsers.toc_parser import TocHTMLParser
from src.parsers.class_parser import ClassHTMLParser
from src.parsers.enum_parser import EnumHTMLParser


@pytest.fixture
def platform_config():
    """测试用的平台配置"""
    return {
        "platform": "cpp-ng",
        "language": "cpp",
        "html_parsing": {
            "api_name_selector": "h2.title.topictitle2 span.ph",
            "signature_selector": "section[id$='__prototype'] pre",
            "parent_class_selector": "nav.related-links .linklist a"
        }
    }


@pytest.fixture
def sample_toc_html():
    """示例TOC HTML内容"""
    return """
    <!DOCTYPE html>
    <html>
    <body>
        <article class="topic reference nested1" id="api_test">
            <h2 class="title topictitle2">
                <span class="ph">testAPI</span>
            </h2>
            <div class="body refbody">
                <p class="shortdesc">Test API description</p>
                <section class="section" id="api_test__prototype">
                    <pre>virtual int testAPI(int param) = 0;</pre>
                </section>
                <section class="section" id="api_test__parameters">
                    <dl class="dl parml">
                        <dt class="dt pt dlterm">param</dt>
                        <dd class="dd pd">Test parameter description</dd>
                    </dl>
                </section>
            </div>
            <nav role="navigation" class="related-links">
                <div class="linklist relinfo">
                    <ul class="linklist">
                        <li class="linklist">
                            <a class="link" href="#" title="Test">TestClass</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </article>
    </body>
    </html>
    """


@pytest.fixture 
def sample_class_html():
    """示例Class HTML内容"""
    return """
    <!DOCTYPE html>
    <html>
    <body>
        <h1 class="title topictitle1"><span class="ph">TestClass</span></h1>
        <div class="body refbody">
            <p class="shortdesc">Test class description</p>
            <section class="section" id="class_test__prototype">
                <pre>struct TestClass { int value; };</pre>
            </section>
            <section class="section" id="class_test__parameters">
                <dl class="dl parml">
                    <dt class="dt pt dlterm">value</dt>
                    <dd class="dd pd">Test value description</dd>
                </dl>
            </section>
        </div>
    </body>
    </html>
    """


@pytest.fixture
def sample_enum_html():
    """示例Enum HTML内容"""
    return """
    <!DOCTYPE html>
    <html>
    <body>
        <h1 class="title topictitle1"><span class="ph">TEST_ENUM</span></h1>
        <div class="body refbody">
            <p class="shortdesc">Test enum description</p>
            <section class="section" id="enum_test__parameters">
                <dl class="dl parml">
                    <dt class="dt pt dlterm"><span class="ph">VALUE_ONE</span></dt>
                    <dd class="dd pd">First value description</dd>
                    <dt class="dt pt dlterm"><span class="ph">VALUE_TWO</span></dt>
                    <dd class="dd pd">Second value description</dd>
                </dl>
            </section>
        </div>
    </body>
    </html>
    """


def test_parser_factory_create_toc_parser(platform_config):
    """测试创建TOC解析器"""
    parser = HTMLParserFactory.create_parser("toc_test.html", platform_config)
    assert isinstance(parser, TocHTMLParser)


def test_parser_factory_create_class_parser(platform_config):
    """测试创建Class解析器"""
    parser = HTMLParserFactory.create_parser("class_test.html", platform_config)
    assert isinstance(parser, ClassHTMLParser)


def test_parser_factory_create_enum_parser(platform_config):
    """测试创建Enum解析器"""  
    parser = HTMLParserFactory.create_parser("enum_test.html", platform_config)
    assert isinstance(parser, EnumHTMLParser)


def test_parser_factory_unsupported_file():
    """测试不支持的文件类型"""
    with pytest.raises(ValueError):
        HTMLParserFactory.create_parser("unknown_test.html", {})


def test_get_html_type():
    """测试获取HTML文件类型"""
    assert HTMLParserFactory.get_html_type("toc_test.html") == "toc"
    assert HTMLParserFactory.get_html_type("class_test.html") == "class"
    assert HTMLParserFactory.get_html_type("enum_test.html") == "enum"


def test_is_supported_html_file():
    """测试检查是否为支持的HTML文件"""
    assert HTMLParserFactory.is_supported_html_file("toc_test.html") == True
    assert HTMLParserFactory.is_supported_html_file("class_test.html") == True
    assert HTMLParserFactory.is_supported_html_file("enum_test.html") == True
    assert HTMLParserFactory.is_supported_html_file("unknown_test.html") == False


def test_toc_parser_extract_data(platform_config, sample_toc_html):
    """测试TOC解析器提取数据"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.html', delete=False) as f:
        temp_file = f.name
        f.write(sample_toc_html)
        f.flush()
    
    try:
        parser = TocHTMLParser(platform_config)
        result = parser.parse_file(temp_file)
        
        assert result["type"] == "toc"
        assert len(result["apis"]) == 1
        
        api = result["apis"][0]
        assert api["name"] == "testAPI"
        assert api["signature"] == "virtual int testAPI(int param) = 0;"
        assert api["parent_class"] == "TestClass"
        assert len(api["comment"]) > 0
        assert api["comment"][0] == "/**"
    finally:
        try:
            Path(temp_file).unlink()
        except:
            pass


def test_class_parser_extract_data(platform_config, sample_class_html):
    """测试Class解析器提取数据"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.html', delete=False) as f:
        temp_file = f.name
        f.write(sample_class_html)
        f.flush()
    
    try:
        parser = ClassHTMLParser(platform_config)
        result = parser.parse_file(temp_file)
        
        assert result["type"] == "class"
        assert len(result["classes"]) == 1
        
        class_data = result["classes"][0]
        assert class_data["name"] == "TestClass"
        assert "struct TestClass" in class_data["signature"]
        assert len(class_data["class_comment"]) >= 1
        
        # 检查类描述注释
        desc_comment = next((c for c in class_data["class_comment"] if c["type"] == "desc"), None)
        assert desc_comment is not None
        assert len(desc_comment["comment"]) > 0
    finally:
        try:
            Path(temp_file).unlink()
        except:
            pass


def test_enum_parser_extract_data(platform_config, sample_enum_html):
    """测试Enum解析器提取数据"""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.html', delete=False) as f:
        temp_file = f.name
        f.write(sample_enum_html)
        f.flush()
    
    try:
        parser = EnumHTMLParser(platform_config)
        result = parser.parse_file(temp_file)
        
        assert result["type"] == "enum"
        assert len(result["enums"]) == 1
        
        enum_data = result["enums"][0]
        assert enum_data["name"] == "TEST_ENUM"
        assert len(enum_data["enum_comment"]) >= 1
        
        # 检查枚举值注释
        enum_values = [c for c in enum_data["enum_comment"] if c["type"] == "enumerator"]
        assert len(enum_values) == 2
        assert enum_values[0]["value"] == "VALUE_ONE"
        assert enum_values[1]["value"] == "VALUE_TWO"
    finally:
        try:
            Path(temp_file).unlink()
        except:
            pass
