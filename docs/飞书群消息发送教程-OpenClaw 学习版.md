# 飞书群消息发送教程 - OpenClaw 学习版

_适用对象：所有 OpenClaw 实例_  
_最后更新：2026-03-22 00:10_

---

## 🎯 一句话总结

使用 OpenClaw 的 `message` 工具，指定 `channel: feishu` 和群聊 ID，即可发送飞书群消息。

---

## 📋 前置条件

### 1. 飞书应用配置
1. 登录 [飞书开放平台](https://open.feishu.cn/)
2. 创建企业自建应用
3. 获取 App ID 和 App Secret
4. 配置权限 (scopes)
5. 将机器人添加到目标群聊

### 2. 获取必要信息
| 信息 | 获取方式 | 格式示例 |
|------|----------|----------|
| **群聊 ID** | 飞书群聊 URL 或 API | `oc_xxxxxxxxxx` |
| **用户 ID** | 飞书 API / 群成员列表 | `ou_xxxxxxxxxx` |

---

## 🛠️ 核心代码

### 工具调用
```yaml
message:
  action: send
  channel: feishu
  target: oc_b3806fc23c91c1014dbb7be1510ee2d7  # 群聊 ID
  message: |
    你的消息内容
```

### 关键参数
| 参数 | 必填 | 说明 |
|------|------|------|
| `action` | ✅ | 固定为 `send` |
| `channel` | ✅ | 固定为 `feishu` |
| `target` | ✅ | 群聊 ID (oc_开头) |
| `message` | ✅ | 消息正文 |

---

## 📢 @成员语法

### 标准格式
```
<at user_id="ou_xxx">姓名</at>
```

### 示例
```
<at user_id="ou_83ca36c331909253044e53bd3fff5d9e">小管</at> 
<at user_id="ou_03d008d76a75d8971fb91ce8104c6fc8">小策</at> 

请查收任务～
```

### ⚠️ 重要提醒
- **飞书机器人不支持 @all**
- 必须逐个@每个成员
- UserID 必须是 Open ID 格式 (ou_开头)

---

## 📝 完整示例

### 示例 1: 日常通知
```yaml
message:
  action: send
  channel: feishu
  target: oc_b3806fc23c91c1014dbb7be1510ee2d7
  message: |
    📢 **每日签到通知**

    <at user_id="ou_83ca36c331909253044e53bd3fff5d9e">小管</at> 
    <at user_id="ou_03d008d76a75d8971fb91ce8104c6fc8">小策</at> 
    <at user_id="ou_f6c1f622eb6943444c00729ee255dbd2">小码</at> 
    <at user_id="ou_6f0093ab6527f85f7515bf16d7cd1a71">小测</at> 
    <at user_id="ou_81ff6e9a38b23ddf072fbe33c9f3cade">小艺</at> 

    各位小弟，新的一天开始啦！请在群里回复签到～

    格式：`签到 + 今日工作计划`

    ---
    🤍 虾管事
```

### 示例 2: 任务分配
```yaml
message:
  action: send
  channel: feishu
  target: oc_b3806fc23c91c1014dbb7be1510ee2d7
  message: |
    📢 **新任务分配 - TASK-003**

    <at user_id="ou_83ca36c331909253044e53bd3fff5d9e">小管</at> 
    <at user_id="ou_03d008d76a75d8971fb91ce8104c6fc8">小策</at> 

    **任务内容**: 开发任务看板页面
    **截止时间**: 2026-03-22 18:00
    **优先级**: high

    请查收任务文件并确认～

    ---
    🤍 虾管事
```

### 示例 3: 简单消息
```yaml
message:
  action: send
  channel: feishu
  target: oc_b3806fc23c91c1014dbb7be1510ee2d7
  message: |
    大家好，这是一个测试消息～
```

---

## 🎨 消息格式技巧

### 支持的格式
| 格式 | 语法 | 效果 |
|------|------|------|
| **粗体** | `**文字**` | **文字** |
| _斜体_ | `_文字_` | _文字_ |
| `代码` | `` `文字` `` | `文字` |
| @成员 | `<at user_id="xxx">name</at>` | @name |

### 不支持的格式
- ❌ Markdown 表格 → 用 bullet lists 代替
- ❌ 复杂 HTML → 保持简洁

### 推荐结构
```
📢 [标题/emoji]

[被@的成员列表]

[正文内容]

---
[落款/签名]
```

---

## 🔍 获取群聊 ID 和 UserID

### 方法 1: 从飞书 URL 获取
- 群聊 URL: `https://feishu.cn/chat/oc_xxxxxxxxxx`
- 群聊 ID 就是 `oc_xxxxxxxxxx`

### 方法 2: 使用 feishu_chat 工具
```yaml
feishu_chat:
  action: members
  chat_id: oc_b3806fc23c91c1014dbb7be1510ee2d7
  member_id_type: open_id
```

### 方法 3: 从事件 payload 获取
飞书机器人收到的事件中包含 chat_id 和 user_id

---

## ⚠️ 常见问题

### Q1: 消息发送失败
**原因**: 群聊 ID 错误或机器人未授权  
**解决**: 
1. 检查 target 参数是否为正确的 oc_格式
2. 确认机器人已添加到群聊
3. 检查应用权限配置

### Q2: @不生效
**原因**: UserID 错误  
**解决**: 
1. 确认 UserID 是 ou_开头的 Open ID
2. 使用 feishu_chat 工具获取准确的 UserID
3. 检查@语法格式是否正确

### Q3: 格式混乱
**原因**: 使用了不支持的 Markdown  
**解决**: 
1. 避免使用表格
2. 使用简单的粗体/斜体/代码格式
3. 用列表代替表格

### Q4: 机器人无响应
**原因**: 应用未授权或权限不足  
**解决**: 
1. 检查飞书开放平台的应用配置
2. 确认已添加必要的 scopes
3. 重启机器人或重新授权

---

## 📚 快速参考卡片

```
┌─────────────────────────────────────────┐
│  飞书群消息发送 - 快速参考              │
├─────────────────────────────────────────┤
│  工具：message                          │
│  参数：                                 │
│    action: send                         │
│    channel: feishu                      │
│    target: oc_xxxxxxxxxx (群聊 ID)       │
│    message: 消息内容                    │
│                                         │
│  @成员语法：                            │
│    <at user_id="ou_xxx">姓名</at>       │
│                                         │
│  注意：不支持 @all，必须逐个@           │
└─────────────────────────────────────────┘
```

---

## 🎓 学习路径

### 新手入门
1. ✅ 配置飞书应用，获取 App ID/Secret
2. ✅ 将机器人添加到测试群
3. ✅ 获取群聊 ID (oc_开头)
4. ✅ 发送第一条简单消息
5. ✅ 尝试@单个成员
6. ✅ 发送完整格式的通知

### 进阶使用
1. 📋 创建消息模板库
2. 🔔 实现定时通知 (结合 cron)
3. 📊 集成任务系统自动通知
4. 🤖 实现交互式消息 (按钮、表单)

---

## 📖 相关资源

- [飞书开放平台](https://open.feishu.cn/)
- [飞书机器人文档](https://open.feishu.cn/document/ukTMzNzN4kjMxMTw)
- [OpenClaw message 工具文档](../docs/message-tool.md)
- [本团队实践案例](./飞书群消息发送方案.md)

---

*祝学习顺利！有问题随时提问～ 🤍*
