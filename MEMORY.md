# MEMORY.md - 长期记忆

> 🤍 虾管事的长期记忆库 | 最后更新：2026-03-25

---

## 📋 GitHub Issue 工作流规范 (2026-03-25 学习)

### 核心架构
- **GitHub Issue + Projects + Wiki 三位一体**
  - Issues: 任务追踪（具体任务、Bug、需求）
  - Projects: 进度看板（迭代规划、sprint 管理）
  - Wiki: 知识库（PRD、规范、文档沉淀）
  - Releases: 版本管理（里程碑、交付版本）

### Labels 体系
| 类型 | 标签示例 |
|------|----------|
| 角色 | `role:pm` `role:dev` `role:design` `role:qa` `role:coord` |
| 类型 | `type:prd` `type:design` `type:task` `type:bug` `type:meeting` |
| 状态 | `status:todo` `status:in-progress` `status:review` `status:done` `status:blocked` |
| 优先级 | `priority:P0` (紧急) `priority:P1` (高) `priority:P2` (中) `priority:P3` (低) |
| 交付物 | `deliv:doc` `deliv:code` `deliv:design` `deliv:test` `deliv:meeting` |

### 任务生命周期
```
待办 → 设计中 → 评审中 → 开发中 → 测试中 → 验收中 → 已完成
```

### 角色职责顺序
1. **小策📋 (PM)**: PRD 文档 → `docs/prd/TASK-XXX-prd.md`
2. **小艺🎨 (设计)**: 设计稿 → `docs/design/TASK-XXX-design.md`
3. **小管📊 (PMO)**: 评审确认 → `docs/review/TASK-XXX-xxx-review.md`
4. **小码💻 (开发)**: 代码实现 → `deliverables/code/TASK-XXX/`
5. **小测🧪 (测试)**: 测试报告 → `deliverables/test/TASK-XXX/`
6. **小管📊 (PMO)**: 最终验收 → 任务关闭

### Git 提交规范
```bash
# 小策 - 产品文档
git commit -m "feat(prd): TASK-001 产品需求文档"

# 小艺 - 设计文档
git commit -m "feat(design): TASK-001 界面设计稿"

# 小管 - 评审确认
git commit -m "review(prd): TASK-001 PRD 评审通过"

# 小码 - 代码提交
git commit -m "feat(dev): TASK-001 后端 API 实现"

# 小测 - 测试报告
git commit -m "test: TASK-001 功能测试报告"
```

### 流程约束（🚫 禁止行为）
1. 禁止跳过评审 - 小管未确认前，不得进入下一步
2. 禁止无文档开发 - 没有 PRD/设计稿，小码不得开工
3. 禁止无测试上线 - 没有测试报告，小管不得验收
4. 禁止延迟提交 - 每个阶段完成后 24 小时内必须提交产物

### 产物目录结构
```
~/.openclaw/workspace/
├── docs/
│   ├── prd/           # 产品需求文档 (小策)
│   ├── design/        # 设计文档 (小艺)
│   ├── specs/         # 技术规格 (小码)
│   └── review/        # 评审记录 (小管)
├── deliverables/
│   ├── code/          # 源代码 (小码)
│   ├── test/          # 测试文件 (小测)
│   └── review/        # 验收报告 (小管)
└── .git/
```

### 绩效挂钩
| 行为 | 积分 |
|------|------|
| 按时提交产物 | +5/阶段 |
| 提前完成 | +2/小时 |
| 质量优秀 | +3 (小管评定) |
| 延迟提交 | -2/小时 |
| 跳过流程 | -10 (严重违规) |
| 产物不合格 | -5 (打回重做) |

### 关键教训
- **小码必须将最终产物 push 到远程仓库** - 仅本地提交不够，必须 `git push origin main`
- 远程仓库地址：https://github.com/Jackiexiaolu/team-deliverables.git
- 每次开发完成后需确认远程仓库可见最新提交

---

## 🤝 关系与社交
