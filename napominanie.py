import tkinter as tk
from tkinter import messagebox
import time
from datetime import datetime
import json
import os

reminder_times = ["08:00", "12:00", "22:00"]
state_file = os.path.expanduser("~/.napominanie_state.json")

# Загрузка состояния из файла
def load_state():
    if os.path.exists(state_file):
        with open(state_file, "r") as f:
            return json.load(f)
    return {"day": None, "shown": []}

# Сохранение состояния в файл
def save_state(state):
    with open(state_file, "w") as f:
        json.dump(state, f)

def show_reminder():
    root = tk.Tk()
    root.withdraw()
    messagebox.showinfo("Напоминание", "Пора принять таблетку!")
    root.destroy()

# Начальное состояние
state = load_state()

while True:
    now = datetime.now()
    current_day = now.strftime("%Y-%m-%d")
    current_time = now.strftime("%H:%M")

    # Сброс если день сменился
    if state["day"] != current_day:
        state["day"] = current_day
        state["shown"] = []

    if current_time in reminder_times and current_time not in state["shown"]:
        show_reminder()
        state["shown"].append(current_time)
        save_state(state)

    time.sleep(30)

