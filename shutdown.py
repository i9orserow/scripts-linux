import evdev
import time
import select
import os

keyboard_device = '/dev/input/event4'  # путь к клавиатуре
mouse_device = '/dev/input/event7'     # путь к мыши

idle_time = 7200  # время ожидания в секундах до выключения
last_activity_time = time.time()

def check_idle():
    return time.time() - last_activity_time > idle_time

def shutdown():
    print("No activity detected. Shutting down...")
    os.system("shutdown now")  # или poweroff

keyboard = evdev.InputDevice(keyboard_device)
mouse = evdev.InputDevice(mouse_device)

# НЕ ЗАХВАТЫВАЕМ УСТРОЙСТВА
# keyboard.grab()
# mouse.grab()

while True:
    r, _, _ = select.select([keyboard, mouse], [], [], 1)
    
    for device in r:
        for event in device.read():
            last_activity_time = time.time()  # сброс таймера при активности
    
    if check_idle():
        shutdown()
        break
    
    time.sleep(1)

