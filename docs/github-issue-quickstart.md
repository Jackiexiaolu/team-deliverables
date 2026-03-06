# GitHub Issue 快速上手指南

> 🤍 虾管事 | Sprint 0 试用版

---

## 🚀 5 分钟快速开始

### Step 1: 登录 GitHub

```bash
gh auth login
```

按提示完成登录（选择 GitHub.com → HTTPS → 浏览器登录）

### Step 2: 初始化 Repo

```bash
cd /Users/ice/.openclaw/workspace
chmod +x scripts/setup-github-repo.sh
./scripts/setup-github-repo.sh
```

### Step 3: 访问 Repo

脚本完成后会显示 Repo 地址，例如：
```
https://github.com/your-username/team-deliverables
```

### Step 4: 创建第一个 Issue

1. 打开 Repo 页面
2. 点击 **Issues** → **New issue**
3. 选择模板（如「💻 开发任务」）
4. 填写信息并提交

---

## 📝 Issue 模板说明

### 📋 PRD 模板
**用途：** 产品需求文档  
**负责人：** 小策  
**必填：** 需求名称、目标、用户故事、验收标准

### 🎨 设计稿模板
**用途：** UI/UX/原型设计  
**负责人：** 小艺  
**必填：** 设计稿链接、设计规范、评审状态

### 💻 任务模板
**用途：** 开发任务  
**负责人：** 小码  
**必填：** 任务描述、完成标准、提交记录

### 🐛 Bug 模板
**用途：** 问题报告  
**负责人：** 发现者  
**必填：** Bug 描述、复现步骤、严重程度

### 📝 会议纪要模板
**用途：** 会议记录  
**负责人：** 虾管事  
**必填：** 会议信息、决议事项、待办事项

---

## 🏷️ Labels 使用指南

### 必须添加的 Labels

| 场景 | 必须标签 |
|------|----------|
| 创建 PRD | `type:prd` + `role:pm` |
| 创建设计 | `type:design` + `role:design` |
| 创建任务 | `type:task` + `role:dev` |
| 报告 Bug | `type:bug` + `priority:P?` |
| 会议纪要 | `type:meeting` |

### 状态更新规则

| 动作 | 操作 |
|------|------|
| 开始工作 | 添加 `status:in-progress` |
| 完成任务 | 添加 `status:review`，@审核人 |
| 审核通过 | 添加 `status:done`，关闭 Issue |
| 审核不通过 | 移除 `status:review`，继续修改 |

---

## 📊 Projects 看板使用

### 看板列说明

| 列名 | 说明 | 移动规则 |
|------|------|----------|
| Backlog | 待办池 | 所有新 Issue 默认放入 |
| To Do | 本周计划 | Sprint 规划时移动 |
| In Progress | 进行中 | 开始工作时移动 |
| Review | 评审中 | 提交评审时移动 |
| Done | 已完成 | 审核通过后移动 |

### 如何移动卡片

1. 打开 **Projects** 看板
2. 拖拽卡片到对应列
3. 或点击卡片 → 添加至 → 选择列

---

## ✅ 每日检查清单

### 个人检查
- [ ] 我的 Issue 状态是否最新？
- [ ] 有需要评审的 Issue 吗？
- [ ] 有阻塞问题需要帮助吗？

### 协调者检查
- [ ] 所有 Issue 都有正确的 Labels 吗？
- [ ] 有需要分配的任务吗？
- [ ] 有需要升级的阻塞吗？

---

## 🎯 Sprint 0 练习任务

### 每人必须完成

| 角色 | 练习任务 |
|------|----------|
| 小策 | 创建 1 个 PRD Issue |
| 小艺 | 创建 1 个设计 Issue |
| 小码 | 创建 1 个任务 Issue |
| 小测 | 创建 1 个 Bug Issue |
| 小管 | 创建 1 个会议纪要 Issue |
| 虾管事 | 创建 1 个评审 Issue |

### 练习要求
1. 使用正确的模板
2. 填写完整信息
3. 添加正确的 Labels
4. 完成从创建到关闭的完整流程

---

## ❓ 常见问题

### Q: 忘记添加 Labels 怎么办？
A: 随时可以编辑 Issue 补充 Labels

### Q: Issue 描述写错了能改吗？
A: 可以，随时编辑修改

### Q: 如何关联相关 Issue？
A: 在描述中使用 `#Issue 编号` 或右侧「Development」关联

### Q: 如何@某人？
A: 使用 `@username`，对方会收到通知

### Q: 如何上传截图/文件？
A: 直接拖拽文件到 Issue 编辑区

---

## 🔗 相关资源

- [GitHub Issues 官方文档](https://docs.github.com/en/issues)
- [Issues 模板语法](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms)
- [Projects 看板指南](https://docs.github.com/en/issues/planning-and-tracking-with-projects)

---

## 📞 需要帮助？

- 直接 @虾管事
- 或在团队群提问
- 或创建 Issue 标注 `status:blocked`

---

*🤍 祝试用顺利！*
