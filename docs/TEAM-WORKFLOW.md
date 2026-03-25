# 团队协作工作流规范

> 🤍 虾管事 | 版本 v1.0 | 最后更新：2026-03-25

---

## 📋 目录

1. [核心架构](#核心架构)
2. [角色职责](#角色职责)
3. [任务生命周期](#任务生命周期)
4. [Git 提交规范](#git-提交规范)
5. [流程约束](#流程约束)
6. [产物目录](#产物目录)
7. [绩效规则](#绩效规则)

---

## 🏗️ 核心架构

**GitHub Issue + Projects + Wiki 三位一体**

| 工具 | 用途 | 负责人 |
|------|------|--------|
| **Issues** | 任务追踪（具体任务、Bug、需求） | 全员 |
| **Projects** | 进度看板（迭代规划、sprint 管理） | 小管 |
| **Wiki** | 知识库（PRD、规范、文档沉淀） | 全员 |
| **Releases** | 版本管理（里程碑、交付版本） | 小管 |

---

## 👥 角色职责

| 角色 | 成员 | 职责 | 产出物 |
|------|------|------|--------|
| 📋 **PM** | 小策 | 产品需求分析、PRD 撰写 | `docs/prd/TASK-XXX-prd.md` |
| 🎨 **设计** | 小艺 | UI/UX设计、原型制作 | `docs/design/TASK-XXX-design.md` |
| 📊 **PMO** | 小管 | 进度管理、评审验收 | `docs/review/`, `deliverables/review/` |
| 💻 **开发** | 小码 | 代码实现、单元测试 | `deliverables/code/TASK-XXX/` |
| 🧪 **测试** | 小测 | 测试用例、测试报告 | `deliverables/test/TASK-XXX/` |
| 🤍 **协调** | 虾管事 | 会议记录、流程协调 | `docs/meeting/` |

---

## 🔄 任务生命周期

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│  待办   │ →  │ 设计中  │ →  │ 评审中  │ →  │ 开发中  │ →  │ 测试中  │ →  │ 验收中  │ →  │ 已完成  │
│  todo   │    │designing│    │reviewing│    │developing│   │ testing │    │verifying│    │  done   │
└─────────┘    └─────────┘    └─────────┘    └─────────┘    └─────────┘    └─────────┘    └─────────┘
     ↑              ↑              ↑              ↑              ↑              ↑
     │              │              │              │              │              │
   创建           设计完成        PRD 评审        开发完成        测试完成        最终验收
                (小艺)          (小管)          (小码)          (小测)          (小管)
```

### 详细流程

#### 1️⃣ 需求阶段 (小策)
```
创建 PRD Issue → 撰写 PRD 文档 → 提交 Git → 通知小管评审
```

#### 2️⃣ 设计阶段 (小艺)
```
PRD 评审通过 → 开始设计 → 完成设计稿 → 提交 Git → 通知小管评审
```

#### 3️⃣ 开发阶段 (小码)
```
设计评审通过 → 开始开发 → 编写代码 → 单元测试 → 提交 Git → **Push 远程** → 通知小管验收
```

#### 4️⃣ 测试阶段 (小测)
```
开发完成 → 编写测试用例 → 执行测试 → 提交测试报告 → 通知小管验收
```

#### 5️⃣ 验收阶段 (小管)
```
收到验收通知 → Code Review → 功能验证 → 验收通过/驳回 → 关闭 Issue
```

---

## 📝 Git 提交规范

### Commit Message 格式

```
<type>(<scope>): <subject>

TASK-XXX: <详细说明>
```

### 类型 (type)

| 类型 | 用途 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat(api): 用户登录接口` |
| `fix` | Bug 修复 | `fix(auth): 修复登录超时问题` |
| `docs` | 文档更新 | `docs(prd): TASK-001 产品需求文档` |
| `design` | 设计稿 | `design(ui): TASK-001 界面设计` |
| `test` | 测试相关 | `test: TASK-001 功能测试报告` |
| `review` | 评审记录 | `review(prd): TASK-001 PRD 评审通过` |
| `chore` | 构建/工具 | `chore: 更新依赖` |

### 提交示例

```bash
# 小策 - 产品文档
git commit -m "docs(prd): TASK-001 产品需求文档"

# 小艺 - 设计文档
git commit -m "design(ui): TASK-001 界面设计稿"

# 小管 - 评审确认
git commit -m "review(prd): TASK-001 PRD 评审通过"

# 小码 - 代码提交
git commit -m "feat(api): TASK-001 用户登录接口"
git commit -m "feat(dev): TASK-001 后端 API 实现"

# 小测 - 测试报告
git commit -m "test: TASK-001 功能测试报告"
```

### Push 到远程

```bash
# ⚠️ 必须执行！仅本地提交无效！
git push origin main
```

**远程仓库**: https://github.com/Jackiexiaolu/team-deliverables.git

---

## 🚫 流程约束（禁止行为）

| 编号 | 禁止行为 | 处罚 |
|------|----------|------|
| 🚫 1 | **跳过评审** - 小管未确认前进入下一步 | -10 积分 |
| 🚫 2 | **无文档开发** - 没有 PRD/设计稿，小码开工 | -10 积分 |
| 🚫 3 | **无测试上线** - 没有测试报告，小管验收 | -10 积分 |
| 🚫 4 | **延迟提交** - 阶段完成后 24 小时内未提交 | -2 积分/小时 |
| 🚫 5 | **未 Push 远程** - 仅本地提交，未 push | -5 积分 |

---

## 📁 产物目录结构

```
~/.openclaw/workspace/
│
├── .github/
│   └── ISSUE_TEMPLATE/     # Issue 模板
│       ├── prd.md
│       ├── design.md
│       ├── task.md
│       ├── bug.md
│       └── meeting.md
│
├── docs/
│   ├── prd/                # 产品需求文档 (小策)
│   │   └── TASK-XXX-prd.md
│   ├── design/             # 设计文档 (小艺)
│   │   └── TASK-XXX-design.md
│   ├── specs/              # 技术规格 (小码)
│   │   └── TASK-XXX-api.md
│   ├── review/             # 评审记录 (小管)
│   │   └── TASK-XXX-xxx-review.md
│   └── meeting/            # 会议纪要 (虾管事)
│       └── YYYY-MM-DD-meeting.md
│
├── deliverables/
│   ├── code/               # 源代码 (小码)
│   │   └── TASK-XXX/
│   │       ├── src/
│   │       ├── db/
│   │       └── README.md
│   ├── test/               # 测试文件 (小测)
│   │   └── TASK-XXX/
│   │       ├── cases/
│   │       └── report.md
│   └── review/             # 验收报告 (小管)
│       └── TASK-XXX-acceptance.md
│
└── .git/
```

---

## 📊 绩效规则

### 积分获取

| 行为 | 积分 | 说明 |
|------|------|------|
| 按时提交产物 | +5/阶段 | 24 小时内完成 |
| 提前完成 | +2/小时 | 每提前 1 小时 |
| 质量优秀 | +3 | 小管评定 |
| 主动帮助他人 | +2/次 | 协助解决问题 |
| 提出有效建议 | +2/条 | 被采纳的建议 |

### 积分扣除

| 行为 | 积分 | 说明 |
|------|------|------|
| 延迟提交 | -2/小时 | 超过 24 小时 |
| 跳过流程 | -10 | 严重违规 |
| 产物不合格 | -5 | 打回重做 |
| 未 Push 远程 | -5 | 仅本地提交 |
| 无故缺席会议 | -3 | 未请假 |

### 绩效等级

| 等级 | 积分范围 | 奖励 |
|------|----------|------|
| S | ≥100 | 月度优秀 |
| A | 80-99 | 表扬 |
| B | 60-79 | 合格 |
| C | 40-59 | 需改进 |
| D | <40 | 警告 |

---

## 🔗 相关资源

- [GitHub Issue 快速上手](./github-issue-quickstart.md)
- [Issue 模板说明](../.github/ISSUE_TEMPLATE/)
- [Labels 配置](../.github/labels.yml)

---

## ❓ 常见问题

### Q: 如何创建新任务？
A: 在 GitHub Issues 页面点击「New issue」，选择对应模板

### Q: 如何更新任务状态？
A: 编辑 Issue，修改 Labels 中的 `status:*` 标签

### Q: 如何关联相关 Issue？
A: 在描述中使用 `#Issue 编号` 或右侧「Development」关联

### Q: 小码忘记 Push 远程怎么办？
A: 小管验收时发现远程无代码，退回并扣除 5 积分

---

*🤍 团队协作，高效交付*
