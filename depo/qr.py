import qrcode

# QR koduna dönüştürülecek veri
data = "https://srdru.github.io/depo/"

# QR kodu oluşturma
img = qrcode.make(data)

# QR kodunu kaydetme
img.save("karekod.png")

print("QR kodu başarıyla oluşturuldu!")