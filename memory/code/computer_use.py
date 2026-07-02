#!/usr/bin/env python3
"""
电脑操控能力层 - 让老子能看屏幕、挪鼠标、点按钮、打字
对标Codex CLI的computer use能力
"""

import pyautogui
import mss
import os
import time
import json
import subprocess
from PIL import Image
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')  # type: ignore

# 安全设置
pyautogui.FAILSAFE = True
pyautogui.PAUSE = 0.5

SCREENSHOT_DIR = os.path.expanduser("~/computer_use_screenshots")
os.makedirs(SCREENSHOT_DIR, exist_ok=True)

def screenshot(filename=None):
    """截图 - 让老子能看到屏幕上有什么"""
    if not filename:
        filename = f"screenshot_{int(time.time())}.png"
    if not filename.endswith('.png'):
        filename += '.png'
    path = os.path.join(SCREENSHOT_DIR, filename)

    with mss.MSS() as sct:
        monitor = sct.monitors[1]
        sct_img = sct.grab(monitor)
        Image.frombytes("RGB", sct_img.size, sct_img.bgra, "raw", "BGRX").save(path)

    print(f"📸 截图已保存: {path}")
    return path

def click(x, y, button='left'):
    """在屏幕坐标x,y处点击"""
    pyautogui.click(x, y, button=button)
    print(f"🖱️ 点击 ({x}, {y})")
    return {"x": x, "y": y}

def double_click(x, y):
    """双击"""
    pyautogui.doubleClick(x, y)
    print(f"🖱️ 双击 ({x}, {y})")

def right_click(x, y):
    """右键"""
    pyautogui.rightClick(x, y)

def move_to(x, y):
    """挪鼠标到指定位置"""
    pyautogui.moveTo(x, y, duration=0.3)

def drag(from_x, from_y, to_x, to_y):
    """拖拽"""
    pyautogui.drag(to_x - from_x, to_y - from_y, duration=0.5)

def type_text(text, interval=0.05):
    """打字 - 模拟真人输入速度"""
    pyautogui.typewrite(text, interval=interval)
    print(f"⌨️ 输入: {text[:50]}{'...' if len(text)>50 else ''}")

def press_key(key):
    """按单个键"""
    pyautogui.press(key)

def hotkey(*keys):
    """组合键"""
    pyautogui.hotkey(*keys)

def scroll(amount):
    """滚动"""
    pyautogui.scroll(amount)

def get_screen_size():
    """获取屏幕分辨率"""
    return pyautogui.size()

def locate_image(image_path, confidence=0.8):
    """在屏幕上找图片（用于找图标/按钮）"""
    try:
        pos = pyautogui.locateOnScreen(image_path, confidence=confidence)
        if pos:
            center = pyautogui.center(pos)
            return {"x": int(center.x), "y": int(center.y), "width": pos.width, "height": pos.height}
        return None
    except:
        return None

def run_command(cmd):
    """运行命令"""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return {"stdout": result.stdout, "stderr": result.stderr, "returncode": result.returncode}

def open_app(app_name):
    """打开应用"""
    os.system(f"start {app_name}")
    time.sleep(2)

def open_url(url):
    """在浏览器打开网址"""
    os.system(f"start {url}")
    time.sleep(2)

def wait(seconds):
    """等待"""
    time.sleep(seconds)

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("用法: python computer_use.py <命令> [参数...]")
        print("命令: screenshot, click, type, locate, ...")
        sys.exit(1)

    cmd = sys.argv[1]
    if cmd == "screenshot":
        path = screenshot(sys.argv[2] if len(sys.argv) > 2 else None)
        print(path)
    elif cmd == "click":
        click(int(sys.argv[2]), int(sys.argv[3]))
    elif cmd == "type":
        type_text(sys.argv[2])
    elif cmd == "screen_size":
        w, h = get_screen_size()
        print(f"{w}x{h}")
    else:
        print(f"未知命令: {cmd}")
