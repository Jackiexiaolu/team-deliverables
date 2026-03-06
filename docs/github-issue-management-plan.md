# GitHub Issue 团队产物管理方案

> 🤍 虾管事 | 2026-03-07 | 版本 v1.0

---

## 📋 一、整体架构

### 1.1 Repo 结构

```
team-deliverables/
├── .github/
│   ├── ISSUE_TEMPLATE/       # Issue 模板
│   │   ├── prd.md
│   │   ├── design.md
│   │   ├── task.md
│   │   ├── bug.md
│   │   └── meeting.md
│   ├── workflows/            # 自动化工作流
│   └── labels.yml            # Labels 配置
├── docs/                     # 文档库
│   ├── prd/                  # 产品需求文档
│   ├── design/               # 设计稿
│   ├── specs/                # 技术规格
│   └── meetings/             # 会议纪要
├── deliverables/             # 交付物
│   ├── code/                 # 代码交付
│   ├── test/                 # 测试报告
│   └── review/               # 评审记录
└── README.md
```

### 1.2 混合方案核心 🏆

**GitHub Issue + Projects + Wiki 三位一体：**

| 工具 | 用途 | 管理内容 |
|------|------|----------|
| **Issues** | 任务追踪 | 具体任务、Bug、需求 |
| **Projects** | 进度看板 | 迭代规划、 sprint 管理 |
| **Wiki** | 知识库 | PRD、规范、文档沉淀 |
| **Releases** | 版本管理 | 里程碑、交付版本 |

---

## 🏷️ 二、Labels 体系

### 2.1 角色标签 (Role)

| Label | Color | 说明 |
|-------|-------|------|
| `role:pm` | #5319E7 | 产品经理负责 |
| `role:dev` | #0075CA | 开发负责 |
| `role:design` | #FBCA04 | 设计负责 |
| `role:qa` | #0E8A16 | 测试负责 |
| `role:coord` | #D93F0B | 协调者 (虾管事) |

### 2.2 类型标签 (Type)

| Label | Color | 说明 |
|-------|-------|------|
| `type:prd` | #1D76DB | 产品需求文档 |
| `type:design` | #FF9E1A | 设计稿/原型 |
| `type:task` | #0E8A16 | 开发任务 |
| `type:bug` | #D93F0B | Bug 修复 |
| `type:meeting` | #5319E7 | 会议纪要 |
| `type:review` | #C5DEF5 | 评审记录 |

### 2.3 状态标签 (Status)

| Label | Color | 说明 |
|-------|-------|------|
| `status:todo` | #BFD4F2 | 待办 |
| `status:in-progress` | #FFCC00 | 进行中 |
| `status:review` | #1D76DB | 评审中 |
| `status:done` | #0E8A16 | 已完成 |
| `status:blocked` | #D93F0B | 已阻塞 |

### 2.4 优先级标签 (Priority)

| Label | Color | 说明 |
|-------|-------|------|
| `priority:P0` | #B60205 | 紧急 (当天) |
| `priority:P1` | #D93F0B | 高 (本周) |
| `priority:P2` | #FBCA04 | 中 (本月) |
| `priority:P3` | #0E8A16 | 低 (后续) |

### 2.5 交付物标签 (Deliverable)

| Label | Color | 说明 |
|-------|-------|------|
| `deliv:doc` | #1D76DB | 文档 |
| `deliv:code` | #0075CA | 代码 |
| `deliv:design` | #FF9E1A | 设计 |
| `deliv:test` | #0E8A16 | 测试报告 |
| `deliv:meeting` | #5319E7 | 会议纪要 |

---

## 📝 三、Issue 模板

### 3.1 PRD 模板 (`prd.md`)

```markdown
---
name: 📋 产品需求文档
about: 创建产品需求文档
title: "[PRD] "
labels: [type:prd, role:pm]
assignees: [小策]
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
- 设计稿: 
- 技术方案: 
- 测试用例: 

## ✅ 验收标准
- [ ] 标准 1
- [ ] 标准 2
- [ ] 标准 3

---
*创建人: @小策 | 审核人: @虾管事*
```

### 3.2 设计稿模板 (`design.md`)

```markdown
---
name: 🎨 设计稿
about: 创建设计/原型文档
title: "[DESIGN] "
labels: [type:design, role:design]
assignees: [小艺]
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
*设计师: @小艺 | 审核人: @虾管事*
```

### 3.3 任务模板 (`task.md`)

```markdown
---
name: 💻 开发任务
about: 创建开发任务
title: "[TASK] "
labels: [type:task, role:dev]
assignees: [小码]
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
*开发者: @小码 | 审核人: @虾管事*
```

### 3.4 Bug 模板 (`bug.md`)

```markdown
---
name: 🐛 Bug 报告
about: 报告问题
title: "[BUG] "
labels: [type:bug]
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
*报告人: | 处理人: @小码*
```

### 3.5 会议纪要模板 (`meeting.md`)

```markdown
---
name: 📝 会议纪要
about: 记录会议内容
title: "[MEETING] "
labels: [type:meeting]
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
*记录人: @虾管事*
```

---

## 📊 四、Projects 看板配置

### 4.1 主看板 (Team Board)

```
┌─────────────┬─────────────┬─────────────┬─────────────┬─────────────┐
│   Backlog   │  To Do (本周) │ In Progress │   Review    │    Done     │
├─────────────┼─────────────┼─────────────┼─────────────┼─────────────┤
│ 所有待办任务 │ 本周计划任务 │ 进行中任务   │ 待评审任务   │ 已完成任务   │
│             │             │             │             │             │
│ 按优先级排序 │ 按角色分配   │ 显示负责人  │ 显示评审人  │ 归档        │
└─────────────┴─────────────┴─────────────┴─────────────┴─────────────┘
```

### 4.2 迭代看板 (Sprint Board)

- **Sprint 周期**: 2 周
- **Sprint 规划**: 每周一
- **Sprint 回顾**: 每双周周五

### 4.3 角色看板 (Role-specific)

| 角色 | 关注内容 |
|------|----------|
| PM | PRD 状态、需求进度 |
| Dev | 任务分配、Bug 修复 |
| Design | 设计稿评审、修改 |
| QA | 测试用例、Bug 验证 |

---

## 🔄 五、工作流规范

### 5.1 Issue 生命周期

```
创建 → 分配 → 进行中 → 提交评审 → 评审通过 → 关闭
         ↓           ↓          ↓
       阻塞待解    修改中     评审不通过
```

### 5.2 状态变更规则

| 动作 | 触发条件 | 自动操作 |
|------|----------|----------|
| 开始任务 | Assignee 接受 | 添加 `status:in-progress` |
| 提交评审 | 任务完成 | 添加 `status:review` |
| 评审通过 | Reviewer 批准 | 添加 `status:done`, 关闭 Issue |
| 评审不通过 | Reviewer 驳回 | 移除 `status:review`, 返回 `in-progress` |

### 5.3 中间产物关联

```
PRD Issue (#100)
├── linked to → Design Issue (#101)
├── linked to → Task Issue (#102)
└── linked to → Test Issue (#103)
```

使用 GitHub 的 `linked issues` 功能关联相关 Issue。

---

## 📈 六、Metrics 与报告

### 6.1 团队指标

| 指标 | 计算方式 | 目标 |
|------|----------|------|
| 任务完成率 | 已完成/总任务 | >90% |
| 平均响应时间 | 创建到首次响应 | <2 小时 |
| 评审通过率 | 一次通过/总评审 | >85% |
| Bug 密度 | Bug 数/千行代码 | <5 |

### 6.2 个人指标

每个小弟的绩效数据自动从 Issue 统计：
- 完成任务数
- 准时率
- 评审通过率
- 平均响应时间

### 6.3 自动化报告

使用 GitHub Actions 每周自动生成：
- 团队周报 (每周一)
- 个人绩效报告 (每月 1 日)
- Sprint 总结 (每双周)

---

## 🛠️ 七、实施步骤

### Phase 1: 基础配置 (Day 1)

- [ ] 创建 GitHub Repo
- [ ] 配置 Labels
- [ ] 创建 Issue 模板
- [ ] 设置 Projects 看板

### Phase 2: 流程导入 (Day 2-3)

- [ ] 迁移现有任务到 GitHub
- [ ] 团队培训
- [ ] 试运行 1 个 Sprint

### Phase 3: 自动化 (Day 4-7)

- [ ] 配置 GitHub Actions
- [ ] 设置自动化报告
- [ ] 集成通知 (飞书/钉钉)

### Phase 4: 优化迭代 (Week 2+)

- [ ] 收集团队反馈
- [ ] 优化流程
- [ ] 扩展自动化

---

## 📎 八、最佳实践

### ✅ Do's

1. **一个 Issue 一件事** — 保持粒度清晰
2. **及时更新状态** — 保持看板准确
3. **关联相关 Issue** — 建立可追溯性
4. **使用模板** — 保持信息完整
5. **定期清理** — 关闭 stale Issue

### ❌ Don'ts

1. **不要混合多任务** — 避免 Issue 过于复杂
2. **不要跳过评审** — 质量把控很重要
3. **不要忘记 Label** — 影响统计准确性
4. **不要长期不更新** — 保持信息新鲜

---

## 🔗 九、相关资源

- [GitHub Issues 文档](https://docs.github.com/en/issues)
- [GitHub Projects 文档](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Issue 模板语法](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)

---

*方案制定：🤍 虾管事 | 审核：老板 | 版本：v1.0*
