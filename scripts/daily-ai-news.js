#!/usr/bin/env node

/**
 * Daily AI News - 每天早晨获取最热门的 AI 新闻
 * 通过 Tavily API 搜索并发送邮件
 */

const https = require('https');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

// 配置
const TAVILY_API_KEY = process.env.TAVILY_API_KEY || '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';
const EMAIL_TO = 'luwenxiang97@163.com';
const EMAIL_FROM = 'luwenxiang97@163.com';

// 读取邮件配置
const envPath = path.join(__dirname, '../../../.agents/skills/imap-smtp-email/.env');
let emailConfig = {};
try {
  const envContent = fs.readFileSync(envPath, 'utf8');
  envContent.split('\n').forEach(line => {
    const [key, value] = line.split('=');
    if (key && value) {
      emailConfig[key.trim()] = value.trim().replace(/['"]/g, '');
    }
  });
} catch (e) {
  console.error('无法读取邮件配置:', e.message);
  process.exit(1);
}

// Tavily 搜索
function searchAINews() {
  return new Promise((resolve, reject) => {
    const today = new Date();
    const dateStr = today.toLocaleDateString('zh-CN', { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric',
      weekday: 'long'
    });
    
    const postData = JSON.stringify({
      query: `AI artificial intelligence news ${today.getFullYear()} ${today.getMonth() + 1}`,
      max_results: 10,
      include_domains: ['techcrunch.com', 'theverge.com', 'wired.com', 'arstechnica.com', 'venturebeat.com'],
      search_depth: 'advanced'
    });
    
    const options = {
      hostname: 'api.tavily.com',
      port: 443,
      path: '/search',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${TAVILY_API_KEY}`,
        'Content-Length': Buffer.byteLength(postData)
      }
    };
    
    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(data);
          resolve({ date: dateStr, results: result.results || [] });
        } catch (e) {
          reject(new Error('解析失败: ' + e.message));
        }
      });
    });
    
    req.on('error', reject);
    req.write(postData);
    req.end();
  });
}

// 生成 HTML 邮件内容
function generateEmailContent(newsData) {
  const { date, results } = newsData;
  
  let html = `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; line-height: 1.6; color: #333; max-width: 800px; margin: 0 auto; padding: 20px; }
    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px 10px 0 0; text-align: center; }
    .header h1 { margin: 0; font-size: 28px; }
    .header p { margin: 10px 0 0; opacity: 0.9; }
    .content { background: #f9f9f9; padding: 30px; }
    .news-item { background: white; padding: 20px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    .news-item h2 { margin: 0 0 10px; font-size: 18px; color: #667eea; }
    .news-item h2 a { color: #667eea; text-decoration: none; }
    .news-item h2 a:hover { text-decoration: underline; }
    .news-item p { margin: 0 0 10px; color: #555; }
    .news-item .source { font-size: 12px; color: #999; }
    .footer { background: #333; color: white; padding: 20px; text-align: center; border-radius: 0 0 10px 10px; font-size: 14px; }
  </style>
</head>
<body>
  <div class="header">
    <h1>🤖 AI 每日新闻</h1>
    <p>${date}</p>
  </div>
  <div class="content">
`;

  if (results.length === 0) {
    html += '<p>今天没有找到 AI 新闻，明天再来看看吧！</p>';
  } else {
    results.forEach((item, index) => {
      const url = item.url || '#';
      const title = item.title || '无标题';
      const content = item.content || '暂无摘要';
      const source = new URL(url).hostname;
      
      html += `
    <div class="news-item">
      <h2><a href="${url}">${index + 1}. ${title}</a></h2>
      <p>${content}</p>
      <p class="source">📰 ${source}</p>
    </div>
`;
    });
  }

  html += `
  </div>
  <div class="footer">
    <p>由 OpenClaw AI 助手自动生成 | 使用 Tavily API 搜索</p>
  </div>
</body>
</html>
`;

  return html;
}

// 发送邮件
function sendEmail(htmlContent) {
  return new Promise((resolve, reject) => {
    const today = new Date();
    const dateStr = today.toLocaleDateString('zh-CN', { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric'
    });
    
    const scriptPath = path.join(__dirname, '../../../.agents/skills/imap-smtp-email/scripts/smtp.js');
    const subject = `🤖 AI 每日新闻 - ${dateStr}`;
    
    // 使用 smtp.js 发送
    const cmd = `cd "${path.dirname(scriptPath)}" && node smtp.js send --to "${EMAIL_TO}" --subject "${subject}" --html --body '${htmlContent.replace(/'/g, "'\"'\"'")}'`;
    
    exec(cmd, (error, stdout, stderr) => {
      if (error) {
        reject(new Error(`发送失败: ${stderr || error.message}`));
      } else {
        resolve(stdout);
      }
    });
  });
}

// 主函数
async function main() {
  console.log('🚀 开始获取 AI 新闻...');
  
  try {
    // 搜索新闻
    const newsData = await searchAINews();
    console.log(`✅ 找到 ${newsData.results.length} 条新闻`);
    
    // 生成邮件内容
    const htmlContent = generateEmailContent(newsData);
    
    // 发送邮件
    console.log('📧 正在发送邮件...');
    await sendEmail(htmlContent);
    console.log('✅ 邮件发送成功！');
    
  } catch (error) {
    console.error('❌ 错误:', error.message);
    process.exit(1);
  }
}

main();
