# 🕷️ Scrapling 网页抓取技能

高性能、智能的网页抓取和数据提取工具。

---

## ✅ 安装状态

- **Scrapling 库：** 已安装 ✅
- **技能文件：** 已创建 ✅
- **位置：** `~/.openclaw/workspace/skills/scrapling/`

---

## 🚀 快速开始

### 1. 基础抓取

```bash
# 抓取页面标题和链接
python ~/.openclaw/workspace/skills/scrapling/scrape.py \
  --url "https://example.com"

# 使用 CSS 选择器提取特定元素
python ~/.openclaw/workspace/skills/scrapling/scrape.py \
  --url "https://example.com" \
  --css "h1"

# 提取所有链接的 href 属性
python ~/.openclaw/workspace/skills/scrapling/scrape.py \
  --url "https://example.com" \
  --css "a" \
  --attr "href"
```

### 2. 高级用法

```bash
# 使用 XPath
python ~/.openclaw/workspace/skills/scrapling/scrape.py \
  --url "https://example.com" \
  --xpath "//div[@class='item']"

# 动态网站（需要 JavaScript）
python ~/.openclaw/workspace/skills/scrapling/scrape.py \
  --url "https://dynamic-site.com" \
  --stealth \
  --css ".content"

# 保存结果到文件
python ~/.openclaw/workspace/skills/scrapling/scrape.py \
  --url "https://example.com" \
  --css ".article-title" \
  --output "titles.json"
```

### 3. Python 代码集成

```python
from scrapling import Fetcher

fetcher = Fetcher()
page = fetcher.get('https://example.com')

# CSS 选择器
title = page.css_first('h1').text
links = [a.attrs('href') for a in page.css('a')]

# XPath
items = page.xpath('//div[@class="item"]')

# 提取文本、HTML、属性
text = page.css_first('p').text
html = page.css_first('div').html
src = page.css_first('img').attrs('src')
```

---

## 📁 文件结构

```
scrapling/
├── SKILL.md              # 技能说明
├── README.md             # 使用文档
├── scrape.py             # 命令行工具
├── config.example.json   # 配置示例
└── results/              # 输出目录（自动创建）
```

---

## 🎯 使用场景

| 场景 | 示例 |
|------|------|
| 新闻抓取 | 提取标题、内容、作者、发布时间 |
| 电商监控 | 抓取商品价格、库存、评价 |
| 竞品分析 | 收集竞品网站结构和内容 |
| 数据采集 | 聚合多个数据源 |
| 链接检查 | 检查网站死链 |

---

## ⚙️ 配置选项

### 命令行参数

| 参数 | 说明 | 示例 |
|------|------|------|
| `--url` | 目标 URL（必需） | `--url "https://..."` |
| `--css` | CSS 选择器 | `--css ".title"` |
| `--xpath` | XPath 选择器 | `--xpath "//h1"` |
| `--attr` | 提取属性 | `--attr "href"` |
| `--stealth` | 动态网站模式 | `--stealth` |
| `--output` | 输出文件 | `--output "data.json"` |
| `--format` | 输出格式 | `--format json` |

---

## ⚠️ 注意事项

1. **遵守 robots.txt** - 检查目标网站是否允许抓取
2. **控制频率** - 添加延迟避免被封禁
3. **尊重版权** - 仅抓取允许使用的数据
4. **用户代理** - 使用合适的 User-Agent
5. **错误处理** - 处理网络超时和解析错误

---

## 🔗 相关资源

- **GitHub:** https://github.com/D4Vinci/Scrapling
- **PyPI:** https://pypi.org/project/scrapling/
- **文档:** https://github.com/D4Vinci/Scrapling#readme

---

## 📞 使用帮助

在小白中直接使用：
```
/scraper --url "https://example.com" --css ".title"
```

或运行脚本：
```bash
python ~/.openclaw/workspace/skills/scrapling/scrape.py --help
```

---

*🤍 小白 - 您的私人管家*
