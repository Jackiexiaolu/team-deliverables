# 📚 标准化知识库生成方案

**Skills + OpenSpec + 代码读取** 三位一体的知识库自动化生成系统

---

## 🎯 方案目标

通过自动化工具链，从代码库生成结构清晰、可维护、可检索的标准化知识库。

---

## 🏗️ 整体架构

```
┌─────────────────────────────────────────────────────────────┐
│                    知识库生成流水线                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1️⃣ OpenSpec 规范定义                                        │
│     └─ 定义知识库结构、内容标准、输出格式                    │
│                                                             │
│  2️⃣ Skills 技能执行                                          │
│     ├─ 代码读取技能 (读取源码/注释/文档)                     │
│     ├─ 分析技能 (提取 API/架构/依赖)                         │
│     └─ 生成技能 (生成标准化文档)                             │
│                                                             │
│  3️⃣ 标准化输出                                               │
│     └─ 统一结构的知识库文档                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 标准化知识库结构

```
knowledge-base/
├── openspec/                    # OpenSpec 规范目录
│   ├── specs/
│   │   ├── kb-structure.md      # 知识库结构规范
│   │   ├── content-standard.md  # 内容编写标准
│   │   └── output-format.md     # 输出格式规范
│   └── changes/
│       └── generate-kb/         # 每次生成的变更
│           ├── proposal.md
│           ├── tasks.md
│           └── output/
│
├── docs/                        # 生成的知识库内容
│   ├── overview.md              # 项目概述
│   ├── architecture/            # 架构文档
│   │   ├── system-design.md
│   │   ├── components.md
│   │   └── data-flow.md
│   ├── api/                     # API 文档
│   │   ├── endpoints.md
│   │   └── schemas.md
│   ├── guides/                  # 使用指南
│   │   ├── getting-started.md
│   │   ├── tutorials/
│   │   └── faq.md
│   └── reference/               # 参考文档
│       ├── commands.md
│       ├── config.md
│       └── glossary.md
│
├── skills/                      # 自定义技能
│   ├── code-reader/             # 代码读取技能
│   │   ├── SKILL.md
│   │   ├── index.js
│   │   └── parsers/
│   ├── analyzer/                # 分析技能
│   │   ├── SKILL.md
│   │   └── index.js
│   └── generator/               # 生成技能
│       ├── SKILL.md
│       └── index.js
│
└── scripts/                     # 辅助脚本
    ├── generate.sh              # 一键生成脚本
    └── validate.sh              # 验证脚本
```

---

## 🛠️ 实施步骤

### 步骤 1：安装必要技能

```bash
# 安装知识库相关技能
npx skills add tursodatabase/turso@index-knowledge -g -y
npx skills add jacobrask/claude-skills@knowledge-base -g -y

# 安装代码分析技能（如有）
npx skills find code analysis
```

### 步骤 2：用 OpenSpec 定义规范

```bash
# 初始化 OpenSpec（如未安装）
npm install -g @studyzy/openspec-cn@latest
openspec-cn init

# 创建知识库生成规范
/opsx:new 标准化知识库生成
```

生成的规范文件：

**`openspec/specs/kb-structure.md`**
```markdown
# 知识库结构规范

## 目录层级
- 最多 3 层深
- 每层有 index.md 索引

## 文件命名
- 小写 + 连字符：`getting-started.md`
- 禁止中文文件名

## 文档头部
每个文档必须包含：
- title: 文档标题
- description: 一句话描述
- lastUpdated: 最后更新时间
- tags: [标签列表]
```

### 步骤 3：创建代码读取技能

**`skills/code-reader/SKILL.md`**
```markdown
name: code-reader
description: 读取代码库并提取结构化信息
---

# Code Reader Skill

自动读取代码库，提取：
- 文件结构
- API 端点
- 函数/类定义
- 注释/文档字符串
- 依赖关系

## 触发条件
- 用户要求"读取代码"
- 用户要求"生成文档"
- 用户提到"分析项目"

## 输出格式
JSON 结构，包含：
- files: 文件列表
- apis: API 端点
- components: 组件/类
- dependencies: 依赖
```

### 步骤 4：创建生成脚本

**`scripts/generate.sh`**
```bash
#!/bin/bash

# 知识库生成脚本

PROJECT_ROOT="${1:-.}"
OUTPUT_DIR="$PROJECT_ROOT/knowledge-base"

echo "📚 开始生成知识库..."

# 1. 读取代码结构
echo "📖 读取代码..."
node skills/code-reader/index.js "$PROJECT_ROOT" > /tmp/code-structure.json

# 2. 分析提取信息
echo "🔍 分析代码..."
node skills/analyzer/index.js /tmp/code-structure.json > /tmp/analysis.json

# 3. 生成文档
echo "✍️  生成文档..."
node skills/generator/index.js /tmp/analysis.json "$OUTPUT_DIR"

# 4. 验证结构
echo "✅ 验证结构..."
./scripts/validate.sh "$OUTPUT_DIR"

echo "🎉 知识库生成完成！"
```

### 步骤 5：一键执行

```bash
# 执行生成
cd /Users/ice/.openclaw/workspace
./scripts/generate.sh

# 查看生成的知识库
tree knowledge-base -L 2
```

---

## 📋 输出示例

### 生成的 API 文档

**`docs/api/endpoints.md`**
```markdown
# API 端点

最后更新：2026-03-11

## 用户模块

### POST /api/users
创建新用户

**请求体**:
```json
{
  "name": "string",
  "email": "string"
}
```

**响应**:
```json
{
  "id": "number",
  "name": "string",
  "createdAt": "datetime"
}
```

---

## 🔧 可选增强

### 1. 自动化 CI/CD

```yaml
# .github/workflows/kb-gen.yml
name: 知识库生成

on:
  push:
    branches: [main]

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install -g @studyzy/openspec-cn
      - run: ./scripts/generate.sh
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./knowledge-base/docs
```

### 2. 添加搜索功能

集成 [tursodatabase/turso@index-knowledge](https://skills.sh/tursodatabase/turso/index-knowledge) 技能，为知识库添加向量搜索。

### 3. 自动生成变更日志

```bash
/opsx:archive
# 自动归档本次生成，记录变更
```

---

## 🎯 快速开始

```bash
# 1. 克隆方案到工作区
cd /Users/ice/.openclaw/workspace

# 2. 安装依赖
npm install -g @studyzy/openspec-cn
npx skills add tursodatabase/turso@index-knowledge -g -y

# 3. 初始化
mkdir -p skills/{code-reader,analyzer,generator}
mkdir -p scripts
mkdir -p knowledge-base/docs

# 4. 执行生成
./scripts/generate.sh
```

---

## 📖 参考资源

- [OpenSpec 文档](https://github.com/studyzy/OpenSpec-cn)
- [Skills 市场](https://skills.sh/)
- [知识库技能示例](https://skills.sh/tursodatabase/turso/index-knowledge)

---

*方案版本：v1.0*  
*创建时间：2026-03-11*  
*创建人：虾管事 🤍*
