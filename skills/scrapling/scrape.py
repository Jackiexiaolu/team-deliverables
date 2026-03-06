#!/usr/bin/env python3
"""
Scrapling 网页抓取工具
用法：
  python scrape.py --url "https://example.com" --selector "h1"
  python scrape.py --url "https://example.com" --css "a" --attr "href"
  python scrape.py --url "https://example.com" --xpath "//div[@class='item']"
"""

import argparse
import json
import sys
from pathlib import Path

try:
    from scrapling import Fetcher, StealthyFetcher
except ImportError:
    print("❌ 未安装 scrapling，请先运行：pip install scrapling")
    sys.exit(1)


def fetch_url(url, stealth=False, headers=None):
    """获取网页内容"""
    if stealth:
        fetcher = StealthyFetcher()
        page = fetcher.fetch(url)
    else:
        fetcher = Fetcher()
        page = fetcher.get(url, headers=headers)
    
    return page


def extract_by_css(page, selector, attribute=None):
    """使用 CSS 选择器提取数据"""
    if attribute:
        elements = page.css(selector)
        return [el.attrs(attribute) for el in elements]
    else:
        elements = page.css(selector)
        return [el.text for el in elements]


def extract_by_xpath(page, xpath, attribute=None):
    """使用 XPath 提取数据"""
    if attribute:
        elements = page.xpath(xpath)
        return [el.attrs(attribute) for el in elements]
    else:
        elements = page.xpath(xpath)
        return [el.text for el in elements]


def main():
    parser = argparse.ArgumentParser(description='Scrapling 网页抓取工具')
    parser.add_argument('--url', '-u', required=True, help='目标 URL')
    parser.add_argument('--css', '-c', help='CSS 选择器')
    parser.add_argument('--xpath', '-x', help='XPath 选择器')
    parser.add_argument('--attr', '-a', help='提取属性 (如 href, src)')
    parser.add_argument('--stealth', '-s', action='store_true', help='使用 stealth 模式（动态网站）')
    parser.add_argument('--output', '-o', help='输出文件路径')
    parser.add_argument('--format', '-f', choices=['text', 'json'], default='json', help='输出格式')
    
    args = parser.parse_args()
    
    try:
        # 获取网页
        print(f"📥 正在抓取：{args.url}")
        page = fetch_url(args.url, stealth=args.stealth)
        
        # 提取数据
        results = []
        
        if args.css:
            results = extract_by_css(page, args.css, args.attr)
        elif args.xpath:
            results = extract_by_xpath(page, args.xpath, args.attr)
        else:
            # 默认提取标题和所有链接
            results = {
                'title': page.css_first('title').text if page.css_first('title') else None,
                'links': [el.attrs('href') for el in page.css('a[href]')][:20],
                'headings': [el.text for el in page.css('h1, h2, h3')][:10]
            }
        
        # 输出结果
        if args.output:
            output_path = Path(args.output)
            with open(output_path, 'w', encoding='utf-8') as f:
                if args.format == 'json':
                    json.dump(results, f, ensure_ascii=False, indent=2)
                else:
                    f.write(str(results))
            print(f"✅ 结果已保存到：{args.output}")
        else:
            print("\n📊 抓取结果：")
            if args.format == 'json':
                print(json.dumps(results, ensure_ascii=False, indent=2))
            else:
                print(results)
        
    except Exception as e:
        print(f"❌ 抓取失败：{e}")
        sys.exit(1)


if __name__ == '__main__':
    main()
