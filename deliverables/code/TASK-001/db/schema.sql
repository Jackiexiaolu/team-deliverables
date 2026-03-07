-- TASK-001 数据库架构
-- 创建时间：2026-03-07 10:06
-- 负责人：小码💻

-- 启用外键约束
PRAGMA foreign_keys = ON;

-- ============================================
-- 团队成员表
-- ============================================
CREATE TABLE IF NOT EXISTS members (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    role TEXT NOT NULL,
    emoji TEXT,
    status TEXT DEFAULT 'online' CHECK(status IN ('online', 'working', 'away', 'offline')),
    performance INTEGER DEFAULT 80 CHECK(performance >= 0 AND performance <= 100),
    rating TEXT DEFAULT 'B',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 成员索引
CREATE INDEX IF NOT EXISTS idx_members_status ON members(status);
CREATE INDEX IF NOT EXISTS idx_members_performance ON members(performance);

-- ============================================
-- 任务表
-- ============================================
CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'todo' CHECK(status IN ('todo', 'designing', 'reviewing', 'developing', 'testing', 'verifying', 'done', 'blocked')),
    priority TEXT DEFAULT 'P1' CHECK(priority IN ('P0', 'P1', 'P2', 'P3')),
    assigned_to TEXT,
    followed_by TEXT,
    progress INTEGER DEFAULT 0 CHECK(progress >= 0 AND progress <= 100),
    estimated_hours INTEGER,
    actual_hours INTEGER DEFAULT 0,
    due_at DATETIME,
    risk_note TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 任务索引
CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_tasks_assigned ON tasks(assigned_to);
CREATE INDEX IF NOT EXISTS idx_tasks_priority ON tasks(priority);

-- ============================================
-- 子任务表
-- ============================================
CREATE TABLE IF NOT EXISTS subtasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_id TEXT NOT NULL,
    title TEXT NOT NULL,
    status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'in_progress', 'completed')),
    assignee TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

-- 子任务索引
CREATE INDEX IF NOT EXISTS idx_subtasks_task ON subtasks(task_id);

-- ============================================
-- 活动日志表
-- ============================================
CREATE TABLE IF NOT EXISTS activities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id TEXT,
    member_name TEXT,
    action_type TEXT NOT NULL,
    action TEXT NOT NULL,
    task_id TEXT,
    task_title TEXT,
    details TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE SET NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE SET NULL
);

-- 活动日志索引
CREATE INDEX IF NOT EXISTS idx_activities_member ON activities(member_id);
CREATE INDEX IF NOT EXISTS idx_activities_task ON activities(task_id);
CREATE INDEX IF NOT EXISTS idx_activities_created ON activities(created_at);

-- ============================================
-- 绩效记录表
-- ============================================
CREATE TABLE IF NOT EXISTS performance_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id TEXT NOT NULL,
    task_id TEXT,
    action TEXT NOT NULL,
    points INTEGER NOT NULL,
    reason TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE SET NULL
);

-- 绩效记录索引
CREATE INDEX IF NOT EXISTS idx_performance_member ON performance_records(member_id);

-- ============================================
-- 初始化数据
-- ============================================

-- 插入团队成员
INSERT OR REPLACE INTO members (id, name, role, emoji, status, performance, rating) VALUES
    ('coordinator', '虾管事', '协调者', '🤍', 'online', 92, 'A'),
    ('pmo', '小管', 'PMO', '📊', 'online', 90, 'A'),
    ('product-manager', '小策', '产品经理', '📋', 'working', 88, 'A'),
    ('designer', '小艺', '设计师', '🎨', 'working', 85, 'A'),
    ('developer', '小码', '开发', '💻', 'working', 82, 'B'),
    ('tester', '小测', '测试', '🧪', 'online', 86, 'A');

-- 插入示例任务
INSERT OR REPLACE INTO tasks (id, title, description, status, priority, assigned_to, followed_by, progress, due_at, risk_note) VALUES
    ('TASK-001', '团队管理面板开发', '开发智能体团队管理面板，包含成员状态、任务管理、活动日志', 'designing', 'P1', 'developer', 'pmo', 5, '2026-03-07 18:00:00', '已开工 - 小策/小艺/小码同步进行中');

-- 插入子任务
INSERT INTO subtasks (task_id, title, status, assignee) VALUES
    ('TASK-001', 'PRD 需求文档', 'in_progress', 'product-manager'),
    ('TASK-001', '界面设计稿', 'in_progress', 'designer'),
    ('TASK-001', '后端 API 框架', 'in_progress', 'developer'),
    ('TASK-001', '数据库设计', 'in_progress', 'developer'),
    ('TASK-001', '前端页面开发', 'pending', 'developer'),
    ('TASK-001', '功能测试', 'pending', 'tester');

-- 插入初始活动日志
INSERT INTO activities (member_id, member_name, action_type, action, task_id, task_title, details) VALUES
    ('coordinator', '虾管事', 'task', '创建了 TASK-001 团队管理面板开发任务', 'TASK-001', '团队管理面板开发', '初始化团队任务'),
    ('pmo', '小管', 'followup', '跟进 TASK-001 风险和延迟原因', 'TASK-001', '团队管理面板开发', '与小码沟通，解决延期问题'),
    ('coordinator', '虾管事', 'workflow', '发布 TASK-WORKFLOW.md 工作流规范', NULL, NULL, '制定团队任务管理规范'),
    ('product-manager', '小策', 'task', '开始编写 TASK-001 PRD 文档', 'TASK-001', '团队管理面板开发', '123 都开始吧'),
    ('designer', '小艺', 'task', '开始设计 TASK-001 界面', 'TASK-001', '团队管理面板开发', '123 都开始吧'),
    ('developer', '小码', 'task', '开始搭建 TASK-001 后端 API 框架', 'TASK-001', '团队管理面板开发', '123 都开始吧');
