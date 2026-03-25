# 独立 Agent 协作方案

**版本**: 2026-03-25 v2  
**状态**: ✅ 已发布  
**维护人**: 🤍 虾管事

---

## 📋 核心架构

### Agent 列表

| 角色 | Agent ID | 身份 | 工作空间 |
|------|----------|------|----------|
| 🤍 协调者 | `main` | 虾管事 | `~/.openclaw/workspace` |
| 📊 PMO | `xiaoguan-pmo` | 小管 | `~/.openclaw/agents/xiaoguan-pmo/workspace` |
| 📋 产品经理 | `xiaoce-pm` | 小策 | `~/.openclaw/agents/xiaoce-pm/workspace` |
| 🎨 设计师 | `xiaoyi-design` | 小艺 | `~/.openclaw/agents/xiaoyi-design/workspace` |
| 💻 开发者 | `xiaoma-dev` | 小码 | `~/.openclaw/agents/xiaoma-dev/workspace` |
| 🧪 测试工程师 | `xiaoce-tester` | 小测 | `~/.openclaw/agents/xiaoce-tester/workspace` |

### 目录结构

```
~/.openclaw/agents/
├── main/                  # 虾管事 (协调者)
│   ├── agent/             # 配置：models.json
│   ├── sessions/          # 会话历史
│   └── workspace/         # 工作目录
├── xiaoguan-pmo/          # 小管 (PMO)
│   ├── agent/
│   ├── sessions/
│   └── workspace/
├── xiaoce-pm/             # 小策 (PM)
├── xiaoyi-design/         # 小艺 (设计)
├── xiaoma-dev/            # 小码 (开发)
└── xiaoce-tester/         # 小测 (测试)
```

---

## 🔄 协作模式

### 模式一：任务队列驱动 (推荐) ⭐

```
┌─────────────┐
│   老板      │
│  下达任务   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  虾管事     │
│ (main)      │
│ 分解任务    │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────────┐
│      /shared-memory/tasks/          │
│  TASK-003-pm.json  ← 任务文件        │
│  TASK-003-design.json               │
│  TASK-003-dev.json                  │
│  TASK-003-test.json                 │
└─────────────────────────────────────┘
       │
       │ 各 Agent 轮询任务队列
       ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   小策      │  │   小艺      │  │   小码      │
│ (xiaoce-pm) │  │(xiaoyi-     │  │(xiaoma-     │
│ 执行任务    │  │ design)     │  │ dev)        │
│ 创建交付物  │  │ 执行任务    │  │ 执行任务    │
└─────────────┘  └─────────────┘  └─────────────┘
       │               │               │
       └───────────────┼───────────────┘
                       │
                       ▼
              ┌─────────────────┐
              │   小管 (PMO)    │
              │(xiaoguan-pmo)   │
              │  跟踪 + 报告    │
              └─────────────────┘
```

### 模式二：会话消息驱动

```
虾管事 (main) → sessions_spawn → 小弟 Agent
                    │
                    ├─→ xiaoce-pm (PM 任务)
                    ├─→ xiaoyi-design (设计任务)
                    ├─→ xiaoma-dev (开发任务)
                    └─→ xiaoce-tester (测试任务)
```

### 模式三：GitHub Issue 驱动 🆕

```
GitHub Issue → 小策 (PM) 分析 → 创建 PRD → 分解任务 → 团队执行
```

---

## 🐙 GitHub Issue 集成 (可选)

### Issue 工作流 (简化版)

```
GitHub Issue → 虾管事分析 → sessions_spawn 小策 → PRD → 分解任务 → 团队执行
```

### Issue 处理

1. **虾管事监控 Issues** (或通过 webhook)
2. **发现新 Issue** → 调用小策分析
3. **小策返回 PRD** → 虾管事分解任务
4. **调用团队执行** → 完成后关闭 Issue

**注意**: Issue 相关功能为可选，核心流程仍是 `sessions_spawn` 直接调用

---

## 👤 小策 (PM) 详细职责

### 核心职责

| 职责 | 说明 | 频率 |
|------|------|------|
| 📋 需求分析 | 分析老板/Issue 的需求，明确范围 | 按需 |
| 📄 PRD 撰写 | 创建产品需求文档 | 每个任务 |
| 🐙 Issue 管理 | 创建/更新/关闭 GitHub Issues | 每日 |
| 📊 任务分解 | 将 PRD 分解为设计/开发/测试子任务 | 每个 PRD |
| 🔍 验收 | 验证交付物是否符合需求 | 每个任务 |

### 小策的工作流程

```
1. 接收需求 (老板口头/Issue/任务文件)
       ↓
2. 需求分析 → 明确功能点、用户故事、验收标准
       ↓
3. 创建 PRD 文档 → docs/prd/TASK-XXX-prd.md
       ↓
4. 创建子任务文件:
   - TASK-XXX-design.json → 小艺
   - TASK-XXX-dev.json → 小码
   - TASK-XXX-test.json → 小测
       ↓
5. 通知虾管事和小管 → 任务已分解
       ↓
6. 跟踪进度 → 协助解决需求问题
       ↓
7. 验收交付物 → 确认符合 PRD
       ↓
8. 同步结果 → 群聊 + Issue 评论
```

### 小策的轮询任务

```javascript
// 小策 Agent 的轮询逻辑
async function pollTasks() {
  // 1. 检查 GitHub Issues (如果有配置)
  const newIssues = await checkNewIssues();
  for (const issue of newIssues) {
    await createIssueTask(issue);
  }
  
  // 2. 检查任务队列
  const tasks = await readDir('/shared-memory/tasks/');
  const myTasks = tasks.filter(t => 
    t.assignee === '小策' && 
    t.status === 'pending'
  );
  
  // 3. 执行任务
  for (const task of myTasks) {
    if (task.taskType === 'issue-analysis') {
      await analyzeIssue(task);
      await createPRD(task);
      await createSubTasks(task);
    } else if (task.taskType === 'prd') {
      await createPRD(task);
    }
    
    // 4. 更新状态 + 通知
    task.status = 'completed';
    await updateTaskFile(task);
    await notifyCompletion(task);
  }
}

setInterval(pollTasks, 30000); // 每 30 秒
```

### PRD 文档模板

```markdown
# {任务名称} PRD

**状态**: ✅ 已完成  
**负责人**: 小策  
**创建时间**: 2026-03-25  
**关联 Issue**: #{issueNumber}

---

## 1. 背景与目标

### 1.1 背景
为什么需要做这个功能？

### 1.2 目标
完成后的预期效果？

## 2. 功能需求

### 2.1 功能列表
- 功能点 1
- 功能点 2

### 2.2 用户故事
- 作为 XX，我希望 XX，以便 XX

## 3. 非功能需求

- 性能要求
- 兼容性要求

## 4. 验收标准

- [ ] 标准 1
- [ ] 标准 2

## 5. 子任务分解

| 任务 ID | 角色 | 负责人 | 状态 |
|--------|------|--------|------|
| TASK-XXX-design | 设计 | 小艺 | ⏳ |
| TASK-XXX-dev | 开发 | 小码 | ⏳ |
| TASK-XXX-test | 测试 | 小测 | ⏳ |

---

*最后更新：{timestamp}*
```

---

## 📝 任务文件格式

### 标准任务文件 (`/shared-memory/tasks/TASK-XXX-role.json`)

```json
{
  "taskId": "TASK-003-pm",
  "taskType": "prd",
  "title": "任务看板页面需求文档",
  "description": "为 TASK-002 撰写 PRD 文档，包含功能需求、用户故事、验收标准",
  "priority": "high",
  "status": "pending",
  "createdAt": "2026-03-25T10:00:00+08:00",
  "dueAt": "2026-03-25T18:00:00+08:00",
  "to": "product-manager",
  "assignee": "小策",
  "agentId": "xiaoce-pm",
  "action": "create_file",
  "deliverables": {
    "path": "/shared-memory/docs/prd/TASK-003-prd.md",
    "action": "create",
    "template": "docs/templates/prd-template.md"
  },
  "dependencies": [],
  "chatId": "oc_b3806fc23c91c1014dbb7be1510ee2d7",
  "replyTemplate": "【任务完成同步】\n任务：{taskId}\n状态：✅ 已完成\n交付物：{deliverablePath}\n备注：{notes}"
}
```

### 字段说明

| 字段 | 必填 | 说明 |
|------|------|------|
| `taskId` | ✅ | 任务 ID，格式 `TASK-XXX-role` |
| `taskType` | ✅ | 任务类型：`prd`/`design`/`code`/`test`/`review` |
| `title` | ✅ | 任务标题 |
| `description` | ✅ | 任务详细描述 |
| `priority` | ✅ | 优先级：`high`/`medium`/`low` |
| `status` | ✅ | 状态：`pending`/`in-progress`/`completed`/`blocked` |
| `to` | ✅ | 目标角色：`product-manager`/`designer`/`developer`/`tester`/`pmo` |
| `assignee` | ✅ | 负责人姓名 |
| `agentId` | ✅ | 对应的 Agent ID |
| `action` | ✅ | 执行动作：`create_file`/`edit_file`/`reply_in_chat` |
| `deliverables` | ⚠️ | 交付物配置 (文件操作时必填) |
| `chatId` | ⚠️ | 群聊 ID (回复消息时必填) |
| `replyTemplate` | ⚠️ | 回复模板 (可选) |

---

## 🛠️ 工作流程 (新)

### 步骤 1: 老板下达任务

老板在群聊中或直接对虾管事说：
> "开发一个任务看板页面，展示所有任务的状态和进度"

### 步骤 2: 虾管事分解任务并直接调用

我 (虾管事) 使用 `sessions_spawn` 直接调用小弟 Agent：

```javascript
// 调用小策 (PM) 撰写 PRD
const prdResult = await sessions_spawn({
  agentId: "xiaoce-pm",
  task: "为任务看板页面撰写 PRD 文档，包含功能需求、用户故事、验收标准",
  runtime: "subagent",
  mode: "run"
});

// 调用小艺 (设计) 输出设计稿
const designResult = await sessions_spawn({
  agentId: "xiaoyi-design",
  task: "为任务看板页面设计 UI，输出高保真设计稿",
  runtime: "subagent",
  mode: "run"
});

// 调用小码 (开发) 实现功能
const devResult = await sessions_spawn({
  agentId: "xiaoma-dev",
  task: "根据 PRD 和设计稿实现任务看板页面",
  runtime: "subagent",
  mode: "run"
});

// 调用小测 (测试) 验证质量
const testResult = await sessions_spawn({
  agentId: "xiaoce-tester",
  task: "为任务看板页面编写测试用例并执行测试",
  runtime: "subagent",
  mode: "run"
});

// 调用小管 (PMO) 生成进度报告
const pmoResult = await sessions_spawn({
  agentId: "xiaoguan-pmo",
  task: "跟踪 TASK-003 进度，生成项目报告",
  runtime: "subagent",
  mode: "run"
});
```

### 步骤 3: 小弟 Agent 执行并返回结果

每个小弟 Agent 独立执行任务，完成后返回结果：

```
小策 → 返回 PRD 文档路径
小艺 → 返回设计稿路径
小码 → 返回代码目录
小测 → 返回测试报告
小管 → 返回进度报告
```

### 步骤 4: 虾管事汇总结果

我收集所有小弟的交付物，汇总后汇报给老板：

```
【TASK-003 完成汇报】

✅ 小策 (PM): PRD 文档已完成
   📄 docs/prd/TASK-003-prd.md

✅ 小艺 (设计): 设计稿已完成
   📄 docs/design/TASK-003-design.md

✅ 小码 (开发): 代码实现已完成
   📁 deliverables/code/TASK-003/

✅ 小测 (测试): 测试报告已完成
   📄 deliverables/test/TASK-003-test.md

📊 小管 (PMO): 进度报告
   📄 reports/TASK-003-progress.md

所有任务已完成，请老板验收！
```

### 步骤 5: 结果汇总汇报

我收集所有小弟的交付物，整理后直接汇报给老板：

```
【TASK-003 完成汇报】

✅ 小策 (PM): PRD 文档已完成
   📄 docs/prd/TASK-003-prd.md

✅ 小艺 (设计): 设计稿已完成
   📄 docs/design/TASK-003-design.md

✅ 小码 (开发): 代码实现已完成
   📁 deliverables/code/TASK-003/

✅ 小测 (测试): 测试报告已完成
   📄 deliverables/test/TASK-003-test.md

📊 小管 (PMO): 进度报告
   📄 reports/TASK-003-progress.md

所有任务已完成，请老板验收！
```

---

## 📡 通信机制

### 公共产物仓库 (Git 管理) ⭐

**仓库路径**: `/Users/ice/.openclaw/team-deliverables/`

**所有小弟的交付物统一存储在这里，使用 git 版本管理!**

```
team-deliverables/              # Git 仓库根目录
├── docs/                       # 文档类交付物
│   ├── prd/                   # 产品需求文档
│   │   └── TASK-XXX-prd.md
│   ├── design/                # 设计稿
│   │   └── TASK-XXX-design.md
│   └── review/                # 验收报告
│       └── TASK-XXX-review.md
├── deliverables/               # 代码/测试交付物
│   ├── code/                  # 代码实现
│   │   └── TASK-XXX/
│   └── test/                  # 测试用例
│       └── TASK-XXX-test.md
├── reports/                    # 进度报告
│   └── TASK-XXX-progress.md
├── .gitignore                 # Git 忽略配置
└── README.md                  # 仓库说明
```

### Git 使用流程

```bash
# 小弟提交交付物
cd /Users/ice/.openclaw/team-deliverables

# 添加文件
git add docs/prd/TASK-003-prd.md

# 提交
git commit -m "TASK-003: 完成 PRD 文档"

# 推送 (如果配置远程)
git push origin main
```

### 状态同步

1. **任务状态**: 通过 `sessions_spawn` 返回结果
2. **交付物存储**: 统一存到 `team-deliverables/` 仓库
3. **版本管理**: 每次提交都有 git 记录
4. **结果汇报**: 直接向老板汇报

---

## 🔧 调用方式

### 虾管事调用小弟 Agent

```javascript
// 方式 1: 运行模式 (一次性任务)
const result = await sessions_spawn({
  agentId: "xiaoce-pm",
  task: "为 XXX 撰写 PRD 文档",
  runtime: "subagent",
  mode: "run"  // 一次性执行
});

// 方式 2: 会话模式 (持续对话)
const session = await sessions_spawn({
  agentId: "xiaoce-pm",
  task: "开始处理 TASK-003",
  runtime: "subagent",
  mode: "session",  // 保持会话
  thread: true      // 线程模式
});

// 发送后续消息
await sessions_send({
  sessionKey: session.sessionKey,
  message: "请更新 PRD 文档，增加用户故事部分"
});
```

### 调用参数说明

| 参数 | 必填 | 说明 |
|------|------|------|
| `agentId` | ✅ | 小弟 Agent ID |
| `task` | ✅ | 任务描述 |
| `runtime` | ✅ | `subagent` 或 `acp` |
| `mode` | ✅ | `run`(一次性) 或 `session`(持续) |
| `thread` | ⚠️ | `true` 启用线程模式 |
| `model` | ⚠️ | 指定模型 |
| `timeoutSeconds` | ⚠️ | 超时时间 |

### 小弟 Agent 配置

每个小弟 Agent 需要配置：
1. **身份定义** (`IDENTITY.md`)
2. **专业技能** (在提示词中定义)
3. **交付物规范** (输出格式要求)

---

## 📊 管理命令

### Agent 管理

```bash
# 查看所有 Agent
openclaw agents list

# 查看特定 Agent 状态
openclaw agents status --agent xiaoce-pm

# 重启 Agent
openclaw agents restart --agent xiaoce-pm

# 查看 Agent 日志
openclaw agents logs --agent xiaoce-pm --follow
```

### 任务管理

```bash
# 查看任务看板
cat ~/.openclaw/workspace/TASK-QUEUE.md

# 查看交付物
ls ~/.openclaw/workspace/docs/prd/
ls ~/.openclaw/workspace/deliverables/code/
```

### 会话管理

```bash
# 查看活跃会话
openclaw sessions list

# 查看会话历史
openclaw sessions history --session <key>
```

---

## ⚠️ 注意事项

### 1. 会话超时

- 设置合理的 `timeoutSeconds` 避免长时间等待
- 长时间任务使用 `mode: "session"` 保持会话

### 2. 并发调用

- 可以同时调用多个小弟 Agent 并行执行
- 注意任务依赖关系 (设计→开发→测试)

### 3. 错误处理

- 捕获 `sessions_spawn` 异常并记录
- 任务失败时重新调用或通知老板

### 4. 结果聚合

- 等待所有小弟完成后汇总
- 使用 `Promise.all` 并行等待多个结果

---

## 📈 优化建议

### 短期优化

1. ✅ 建立标准任务模板
2. ✅ 配置自动轮询机制
3. ✅ 设置飞书通知集成
4. ⚠️ 添加任务依赖关系处理

### 中期优化

1. ⚠️ 实现任务优先级队列
2. ⚠️ 添加任务分配负载均衡
3. ⚠️ 实现自动重试机制
4. ⚠️ 添加性能监控

### 长期优化

1. ⚠️ 机器学习优化任务分配
2. ⚠️ 自动化工作流编排
3. ⚠️ 跨 Agent 知识共享
4. ⚠️ 自适应团队协作

---

## 📎 附录

### 任务模板示例

```json
{
  "taskId": "TASK-XXX-{role}",
  "taskType": "{type}",
  "title": "{title}",
  "description": "{description}",
  "priority": "high",
  "status": "pending",
  "createdAt": "{timestamp}",
  "dueAt": "{timestamp}",
  "to": "{role}",
  "assignee": "{name}",
  "agentId": "{agent-id}",
  "action": "create_file",
  "deliverables": {
    "path": "{path}",
    "action": "create"
  },
  "chatId": "oc_b3806fc23c91c1014dbb7be1510ee2d7",
  "replyTemplate": "【任务完成同步】\n任务：{taskId}\n状态：✅ 已完成\n交付物：{deliverablePath}\n备注：无遗留问题"
}
```

### 相关文档

- [团队协作管理方案](./团队协作管理方案.md)
- [MEMORY.md](../MEMORY.md)
- [TASK-QUEUE.md](../TASK-QUEUE.md)

---

*最后更新：2026-03-25 10:11*  
*发布人：虾管事*
