import qrcode

data = "https://srdru.github.io/depo/"

img = qrcode.make(data)
img.save("karekod.png")

print("QR kodu başarıyla oluşturuldu!")
