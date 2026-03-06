# Scrapling 技能

**描述：** 高性能网页抓取和数据提取技能  
**来源：** https://github.com/D4Vinci/Scrapling  
**版本：** 1.0.0

---

## 📦 安装

```bash
pip install scrapling
```

---

## 🚀 使用方法

### 基础抓取

```python
from scrapling import Fetcher

fetcher = Fetcher()
page = fetcher.get('https://example.com')

# 提取标题
title = page.css_first('h1').text
print(title)

# 提取所有链接
links = page.css('a').attrs('href')
print(links)
```

### 高级功能

```python
# 带请求头
page = fetcher.get('https://example.com', headers={'User-Agent': 'Custom'})

# 使用 XPath
items = page.xpath('//div[@class="item"]')

# 使用 CSS 选择器
items = page.css('div.item')

# 提取文本
text = page.css_first('p.content').text

# 提取 HTML
html = page.css_first('div.container').html

# 提取属性
src = page.css_first('img').attrs('src')
```

### 动态网站（需要 JavaScript）

```python
from scrapling import StealthyFetcher

fetcher = StealthyFetcher()
page = fetcher.fetch('https://example.com')
```

---

## 📋 技能命令

### 抓取单个页面

```bash
python skills/scrapling/scrape.py --url "https://example.com" --selector "h1"
```

### 批量抓取

```bash
python skills/scrapling/scrape.py --file urls.txt --selector ".title" --output results.json
```

### 提取结构化数据

```bash
python skills/scrapling/extract.py --url "https://example.com" --config config.json
```

---

## 🔧 配置文件

### config.json 示例

```json
{
  "url": "https://example.com",
  "selectors": {
    "title": "h1",
    "content": "article.content",
    "links": "a[href]"
  },
  "output": "results.json",
  "format": "json"
}
```

---

## 📝 使用场景

- 新闻网站文章抓取
- 电商价格监控
- 社交媒体数据采集
- 竞品分析
- 数据聚合

---

## ⚠️ 注意事项

1. 遵守 robots.txt
2. 控制请求频率
3. 尊重网站服务条款
4. 注意数据隐私

---

## 📚 参考

- GitHub: https://github.com/D4Vinci/Scrapling
- 文档：https://github.com/D4Vinci/Scrapling#readme
- PyPI: https://pypi.org/project/scrapling/
