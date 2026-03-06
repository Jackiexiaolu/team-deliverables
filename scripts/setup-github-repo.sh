#!/bin/bash
# GitHub Repo 初始化脚本
# 使用前请先运行：gh auth login

set -e

REPO_NAME="team-deliverables"
REPO_DESC="团队产物管理 - GitHub Issue 工作流"

echo "🚀 开始配置 GitHub Repo..."

# 检查登录状态
if ! gh auth status &>/dev/null; then
    echo "❌ 未登录 GitHub，请先运行：gh auth login"
    exit 1
fi

# 创建 Repo
echo "📦 创建 Repo: $REPO_NAME"
gh repo create "$REPO_NAME" --public --description "$REPO_DESC" --source=. --remote=origin --push

# 创建 Labels
echo "🏷️ 创建 Labels..."

# 角色标签
gh label create "role:pm" --color "5319E7" --description "产品经理负责"
gh label create "role:dev" --color "0075CA" --description "开发负责"
gh label create "role:design" --color "FBCA04" --description "设计负责"
gh label create "role:qa" --color "0E8A16" --description "测试负责"
gh label create "role:coord" --color "D93F0B" --description "协调者"

# 类型标签
gh label create "type:prd" --color "1D76DB" --description "产品需求文档"
gh label create "type:design" --color "FF9E1A" --description "设计稿/原型"
gh label create "type:task" --color "0E8A16" --description "开发任务"
gh label create "type:bug" --color "D93F0B" --description "Bug 修复"
gh label create "type:meeting" --color "5319E7" --description "会议纪要"
gh label create "type:review" --color "C5DEF5" --description "评审记录"

# 状态标签
gh label create "status:todo" --color "BFD4F2" --description "待办"
gh label create "status:in-progress" --color "FFCC00" --description "进行中"
gh label create "status:review" --color "1D76DB" --description "评审中"
gh label create "status:done" --color "0E8A16" --description "已完成"
gh label create "status:blocked" --color "D93F0B" --description "已阻塞"

# 优先级标签
gh label create "priority:P0" --color "B60205" --description "紧急 (当天)"
gh label create "priority:P1" --color "D93F0B" --description "高 (本周)"
gh label create "priority:P2" --color "FBCA04" --description "中 (本月)"
gh label create "priority:P3" --color "0E8A16" --description "低 (后续)"

# 交付物标签
gh label create "deliv:doc" --color "1D76DB" --description "文档"
gh label create "deliv:code" --color "0075CA" --description "代码"
gh label create "deliv:design" --color "FF9E1A" --description "设计"
gh label create "deliv:test" --color "0E8A16" --description "测试报告"
gh label create "deliv:meeting" --color "5319E7" --description "会议纪要"

echo "✅ Labels 创建完成!"

# 创建目录结构
echo "📁 创建目录结构..."
mkdir -p .github/ISSUE_TEMPLATE
mkdir -p docs/prd docs/design docs/specs docs/meetings
mkdir -p deliverables/code deliverables/test deliverables/review

# 创建 Issue 模板
echo "📝 创建 Issue 模板..."

# PRD 模板
cat > .github/ISSUE_TEMPLATE/prd.md << 'EOF'
---
name: 📋 产品需求文档
about: 创建产品需求文档
title: "[PRD] "
labels: [type:prd, role:pm]
assignees: []
---

## 📌 基本信息
- **需求名称**: 
- **提出日期**: 
- **期望完成**: 
- **优先级**: P0/P1/P2/P3

## 🎯 目标
_这个需求要解决什么问题？_

## 👥 用户故事
_作为 [角色], 我想要 [功能], 以便 [价值]_

## 📋 功能清单
- [ ] 功能点 1
- [ ] 功能点 2
- [ ] 功能点 3

## 🔗 相关链接
- 设计稿：
- 技术方案：
- 测试用例：

## ✅ 验收标准
- [ ] 标准 1
- [ ] 标准 2
- [ ] 标准 3

---
*创建人：@ | 审核人：@虾管事*
EOF

# 设计稿模板
cat > .github/ISSUE_TEMPLATE/design.md << 'EOF'
---
name: 🎨 设计稿
about: 创建设计/原型文档
title: "[DESIGN] "
labels: [type:design, role:design]
assignees: []
---

## 📌 基本信息
- **设计名称**: 
- **关联需求**: #Issue 编号
- **设计类型**: UI/UX/原型/视觉

## 🖼️ 设计稿链接
- Figma: 
- 蓝湖：
- 本地文件：

## 📐 设计规范
- 尺寸规范：
- 颜色规范：
- 组件规范：

## 🔄 修改记录
| 版本 | 日期 | 修改内容 | 修改人 |
|------|------|----------|--------|
| v1.0 | | 初稿 | |

## ✅ 评审状态
- [ ] 内部评审
- [ ] 产品确认
- [ ] 技术可行性确认

---
*设计师：@ | 审核人：@虾管事*
EOF

# 任务模板
cat > .github/ISSUE_TEMPLATE/task.md << 'EOF'
---
name: 💻 开发任务
about: 创建开发任务
title: "[TASK] "
labels: [type:task, role:dev]
assignees: []
---

## 📌 基本信息
- **任务名称**: 
- **关联需求**: #Issue 编号
- **预估工时**: 
- **实际工时**: 

## 🎯 任务描述
_具体要做什么？_

## 📋 技术要点
- [ ] 技术点 1
- [ ] 技术点 2

## 🔗 相关资源
- 设计稿：
- API 文档：
- 技术方案：

## ✅ 完成标准
- [ ] 代码完成
- [ ] 单元测试
- [ ] 代码审查
- [ ] 部署验证

## 📝 提交记录
| Commit | 说明 | 日期 |
|--------|------|------|
| | | |

---
*开发者：@ | 审核人：@虾管事*
EOF

# Bug 模板
cat > .github/ISSUE_TEMPLATE/bug.md << 'EOF'
---
name: 🐛 Bug 报告
about: 报告问题
title: "[BUG] "
labels: [type:bug]
assignees: []
---

## 🐛 Bug 描述
_清晰简洁地描述问题_

## 🔁 复现步骤
1. 
2. 
3. 

## ✅ 预期行为
_应该发生什么？_

## ❌ 实际行为
_实际发生了什么？_

## 📸 截图/日志
_如有必要，添加截图或日志_

## 🖥️ 环境信息
- OS: 
- Browser: 
- Version: 

## 🔍 严重程度
- [ ] P0 - 阻塞
- [ ] P1 - 严重
- [ ] P2 - 一般
- [ ] P3 - 轻微

---
*报告人：@ | 处理人：@*
EOF

# 会议纪要模板
cat > .github/ISSUE_TEMPLATE/meeting.md << 'EOF'
---
name: 📝 会议纪要
about: 记录会议内容
title: "[MEETING] "
labels: [type:meeting]
assignees: []
---

## 📌 会议信息
- **主题**: 
- **日期**: 
- **时间**: 
- **参会人**: 

## 📋 议程
1. 
2. 
3. 

## 💬 讨论要点
_记录关键讨论内容_

## ✅ 决议事项
- [ ] 决议 1
- [ ] 决议 2

## 📅 待办事项
| 事项 | 负责人 | 截止日期 | 状态 |
|------|--------|----------|------|
| | | | |

## 🔗 相关资料
- 会议录音：
- 演示文稿：

---
*记录人：@虾管事*
EOF

echo "✅ Issue 模板创建完成!"

# 创建 README
cat > README.md << 'EOF'
# 团队产物管理 🤍

> GitHub Issue 工作流 - Sprint 0 (试用中)

## 📋 快速开始

### 创建 Issue
1. 点击 **Issues** → **New issue**
2. 选择合适的模板 (PRD/设计/任务/Bug/会议)
3. 填写信息并提交

### Labels 说明

| 类型 | 标签 |
|------|------|
| 角色 | `role:pm` `role:dev` `role:design` `role:qa` `role:coord` |
| 类型 | `type:prd` `type:design` `type:task` `type:bug` `type:meeting` |
| 状态 | `status:todo` `status:in-progress` `status:review` `status:done` |
| 优先级 | `priority:P0` `priority:P1` `priority:P2` `priority:P3` |

### Projects 看板
访问 **Projects** 查看任务进度看板

## 👥 团队成员

| 角色 | 成员 | 负责 |
|------|------|------|
| 协调者 | 虾管事 | 任务分配、进度跟踪 |
| PM | 小策 | 需求分析、PRD |
| Dev | 小码 | 开发实现 |
| Design | 小艺 | 设计稿 |
| QA | 小测 | 测试 |
| PMO | 小管 | 进度管理 |

## 📊 Sprint 状态

- **当前 Sprint:** Sprint 0 (试用)
- **周期:** 2026-03-07 ~ 2026-03-21
- **目标:** 验证 GitHub Issue 管理流程

## 📚 文档

- [管理方案](docs/)
- [Sprint 计划](docs/sprint-plan.md)

---
*🤍 虾管事 维护*
EOF

# 提交并推送
echo "📤 提交配置..."
git add -A
git commit -m "chore: 初始化 GitHub Issue 工作流配置

- 添加 5 个 Issue 模板 (PRD/设计/任务/Bug/会议)
- 配置 Labels 体系
- 创建目录结构
- 添加 README

Sprint 0 试用配置"
git push -u origin main

echo ""
echo "✅ GitHub Repo 配置完成!"
echo ""
echo "📦 Repo 地址：https://github.com/$(gh config get user -h github.com)/$REPO_NAME"
echo ""
echo "🎯 下一步:"
echo "1. 访问 Projects 创建看板"
echo "2. 邀请团队成员"
echo "3. 开始 Sprint 0 试用!"
