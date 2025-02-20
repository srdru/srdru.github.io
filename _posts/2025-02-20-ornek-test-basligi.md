---
title: 'Örnek Test Başlığı'
date: 2025-02-20T00:00:00+00:00
author: Serdar
layout: post
permalink: /ornek-test-basligi/
categories: Genel
tags: [etiket1, etiket2]
---
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

```
class Calisan:
    def __init__(self,ad,soyad):
        self.ad = ad
        self.soyad = soyad
        self.mail = f"{ad}{soyad}@sirket.com"
    def tamad(self):
        return f"Adı : {self.ad}, Soyadı : {self.soyad}, Mail : {self.mail}"
  
calisan1 = Calisan("serdar","uslu")
print(calisan1.tamad())
```
