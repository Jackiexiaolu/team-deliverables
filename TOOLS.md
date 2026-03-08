# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## 用户偏好

### 飞书记录规范
- 所有记录明细保存到飞书云盘「日常」目录下
- 按日期分类：日常/YYYY-MM-DD/
- 每次记录创建或更新当日文档

---

## 🤖 飞书机器人配置

### 小弟机器人列表

| 小弟 | 角色 | 用户 ID | Chat ID | 状态 | 配置时间 |
|------|------|---------|---------|------|----------|
| 🤍 虾管事 | 协调者 | ou_e97870160e7b4f6dfd345a4d20422e1d | - | ✅ 已配置 | 2026-03-07 |
| 📊 小管 | PMO | ou_xiaoguan_pmo | - | ✅ 已配置 | 2026-03-07 20:07 |
| 📋 小策 | 产品经理 | ou_xiaoce_pm | - | ⏳ 待配置 | - |
| 🧪 小测 | 测试工程师 | ou_xiaoce_qa | - | ⏳ 待配置 | - |
| 🎨 小艺 | 设计师 | ou_xiaoyi_design | - | ⏳ 待配置 | - |
| 💻 小码 | 开发者 | ou_xiaoma_dev | - | ⏳ 待配置 | - |

### 小管机器人配置详情

**角色**: PMO (进度管理)  
**用户 ID**: ou_xiaoguan_pmo  
**通知类型**:
- 任务分配通知
- 进度更新提醒
- 风险预警通知
- 周报提醒

**App ID**: `cli_a926b1f37eb8dccb`  
**App Secret**: `TbFSKkMqxljHa4EP1IYMYg2bkx5Apd0q`  
**配置时间**: 2026-03-07 19:44  
**部署方式**: Docker  
**状态**: ✅ 已配置，待启动

---

## 飞书应用配置步骤

1. 登录飞书开放平台：https://open.feishu.cn/
2. 创建企业自建应用
3. 获取 App ID 和 App Secret
4. 配置权限 scopes
5. 添加机器人到群聊
6. 配置 Webhook 接收事件

---

Add whatever helps you do your job. This is your cheat sheet.
