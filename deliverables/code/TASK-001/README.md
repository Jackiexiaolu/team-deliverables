# TASK-001 后端 API 框架

> **负责人**: 小码💻  
> **创建时间**: 2026-03-07 10:06  
> **状态**: 🟡 开发中  
> **截止**: 2026-03-07 16:00

---

## 1. 技术栈

- **运行时**: Node.js v22+
- **框架**: Express.js / Fastify
- **数据库**: SQLite
- **API 风格**: RESTful

---

## 2. 目录结构

```
TASK-001/
├── backend/
│   ├── src/
│   │   ├── controllers/
│   │   │   ├── teamController.js    # 团队相关 API
│   │   │   ├── taskController.js    # 任务相关 API
│   │   │   └── activityController.js # 活动日志 API
│   │   ├── models/
│   │   │   ├── Member.js           # 成员模型
│   │   │   ├── Task.js             # 任务模型
│   │   │   └── Activity.js         # 活动日志模型
│   │   ├── routes/
│   │   │   ├── team.js
│   │   │   ├── tasks.js
│   │   │   └── activities.js
│   │   ├── middleware/
│   │   │   └── auth.js             # 认证中间件
│   │   └── app.js                  # 应用入口
│   ├── tests/
│   │   ├── team.test.js
│   │   ├── task.test.js
│   │   └── activity.test.js
│   ├── package.json
│   └── README.md
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── MemberCard.jsx
│   │   │   ├── TaskList.jsx
│   │   │   └── ActivityLog.jsx
│   │   ├── pages/
│   │   │   └── Dashboard.jsx
│   │   ├── styles/
│   │   │   └── global.css
│   │   └── App.jsx
│   ├── package.json
│   └── index.html
└── db/
    ├── schema.sql
    └── seed.sql
```

---

## 3. API 设计

### 3.1 团队相关

| 方法 | 路径 | 描述 |
|------|------|------|
| GET | `/api/team/members` | 获取所有成员 |
| GET | `/api/team/members/:id` | 获取单个成员 |
| PUT | `/api/team/members/:id/status` | 更新成员状态 |

### 3.2 任务相关

| 方法 | 路径 | 描述 |
|------|------|------|
| GET | `/api/tasks` | 获取所有任务 |
| GET | `/api/tasks/:id` | 获取单个任务 |
| POST | `/api/tasks` | 创建新任务 |
| PUT | `/api/tasks/:id` | 更新任务 |
| DELETE | `/api/tasks/:id` | 删除任务 |

### 3.3 活动日志

| 方法 | 路径 | 描述 |
|------|------|------|
| GET | `/api/activities` | 获取活动日志 |
| POST | `/api/activities` | 记录新活动 |

---

## 4. 数据库设计

### 4.1 members 表
```sql
CREATE TABLE members (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    role TEXT NOT NULL,
    emoji TEXT,
    status TEXT DEFAULT 'online',
    performance INTEGER DEFAULT 80,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### 4.2 tasks 表
```sql
CREATE TABLE tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'todo',
    priority TEXT DEFAULT 'P1',
    assigned_to TEXT,
    progress INTEGER DEFAULT 0,
    due_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### 4.3 activities 表
```sql
CREATE TABLE activities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id TEXT,
    action TEXT NOT NULL,
    task_id TEXT,
    details TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

---

## 5. 开发计划

| 阶段 | 内容 | 预计时间 |
|------|------|----------|
| 1 | 数据库设计与创建 | 1h |
| 2 | 后端 API 框架搭建 | 2h |
| 3 | 前端页面开发 | 3h |
| 4 | 前后端联调 | 1h |
| 5 | 测试与优化 | 1h |

---

## 6. 测试用例

### 6.1 单元测试
- [ ] 成员 API 测试
- [ ] 任务 API 测试
- [ ] 活动日志 API 测试

### 6.2 集成测试
- [ ] 端到端流程测试
- [ ] 性能测试

---

**文档状态**: 🟡 开发中  
**下次更新**: 2026-03-07 12:00
