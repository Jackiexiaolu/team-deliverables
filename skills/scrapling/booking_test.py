#!/usr/bin/env python3
"""
测试抓取 Booking.com 东京酒店
"""

from scrapling import StealthyFetcher
import json

fetcher = StealthyFetcher()

url = "https://www.booking.com/searchresults.zh-cn.html?ss=东京&checkin=2026-03-05&checkout=2026-03-06"

print(f"📥 正在抓取：{url}")
page = fetcher.fetch(url)

# 提取页面标题
title = page.css_first('title')
print(f"\n📄 页面标题：{title.text if title else 'N/A'}")

# 尝试提取酒店卡片
hotels = []

# 查找所有可能的酒店卡片
cards = page.css('[data-testid="property-card"]') or page.css('.property-card') or page.css('article')

print(f"\n🏨 找到 {len(cards)} 个酒店卡片")

for i, card in enumerate(cards[:10]):
    hotel = {'index': i + 1}
    
    # 酒店名称
    name_el = card.css_first('h3') or card.css_first('h2') or card.css_first('[data-testid="title"]')
    hotel['name'] = name_el.text.strip() if name_el and name_el.text else 'N/A'
    
    # 价格
    price_el = card.css_first('[data-testid="price-and-discounted-price"]') or card.css_first('[class*="price"]')
    hotel['price'] = price_el.text.strip() if price_el and price_el.text else 'N/A'
    
    # 评分
    rating_el = card.css_first('[data-testid="review-score"]') or card.css_first('[class*="score"]')
    hotel['rating'] = rating_el.text.strip() if rating_el and rating_el.text else 'N/A'
    
    # 位置
    location_el = card.css_first('[data-testid="unit-location"]') or card.css_first('address')
    hotel['location'] = location_el.text.strip() if location_el and location_el.text else 'N/A'
    
    hotels.append(hotel)
    print(f"\n{i+1}. {hotel['name']}")
    print(f"   💰 {hotel['price']}")
    print(f"   ⭐ {hotel['rating']}")
    print(f"   📍 {hotel['location']}")

# 保存结果
with open('/tmp/booking_hotels.json', 'w', encoding='utf-8') as f:
    json.dump(hotels, f, ensure_ascii=False, indent=2)

print(f"\n✅ 结果已保存到：/tmp/booking_hotels.json")
print(f"📊 共提取 {len(hotels)} 个酒店")
