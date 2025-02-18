---
title: "Pyton İle Siteden Veri Çekme"
date: 2025-02-18T22:16:20+00:00
author: Serdar Uslu
layout: post
permalink: /pyton-ile-siteden-veri-cekme/
categories: Pyton
tags: [python, veri]
---
## Pyton İle Siteden Veri Çekme

Python ile siteden veri çekmek için genellikle `requests` ve `BeautifulSoup` kütüphanelerini kullanabilirsiniz. İşte temel bir örnek:

### Adımlar:

1. **Gerekli Kütüphaneleri Yükleme**
2. **Veriyi Çekme**
3. **HTML'den İlgili Veriyi Ayıklama**

### Örnek Kod:

Örneğin, bir haber sitesinden başlıkları çekmek isteyelim:

```
import requests
from bs4 import BeautifulSoup

# URL'yi belirleyin
url = 'https://example.com'

# URL'ye GET isteği yapın
response = requests.get(url)

# HTML içeriğini BeautifulSoup ile ayrıştırın
soup = BeautifulSoup(response.content, 'html.parser')

# İlgili veriyi (örneğin başlıklar) ayıklayın
headlines = soup.find_all('h2')  # H2 başlıklarını bul

# Başlıkları yazdırın
for headline in headlines:
    print(headline.text)

```
