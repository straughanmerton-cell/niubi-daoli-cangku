# 会话记录 006 - 电脑操控能力层（对标Codex CLI）

**时间**: 2026-07-02
**状态**: ✅ 完成

## 完成内容
- [x] 装pyautogui/mss/Pillow/opencv-python（截图+鼠标+键盘库）
- [x] 写 `memory/code/computer_use.py` 能力层脚本
- [x] 测试截图成功（658KB PNG）
- [x] 更新 brain-index.md 添加电脑操控能力说明
- [x] 更新 patterns.json 添加 computer-use-capability 条目

## 电脑操控能力
```
截图      → python3 computer_use.py screenshot
点鼠标    → python3 computer_use.py click x y
打字      → python3 computer_use.py type "文本"
组合键    → python3 computer_use.py hotkey ctrl c
打开应用  → python3 computer_use.py open_app notepad
打开网址  → python3 computer_use.py open_url https://
查找图片  → python3 computer_use.py locate image.png
运行命令  → python3 computer_use.py run "cmd"
```

## 能力对比
```
能力            Codex CLI    老子之前    老子现在
命令行操作      ✅            ✅          ✅
读写文件        ✅            ✅          ✅
浏览器控制      ✅            ❌          ✅ Playwright
截图看屏幕      ✅            ❌          ✅ mss+pyautogui
挪鼠标点按钮    ✅            ❌          ✅ pyautogui
打字输入        ✅            ❌          ✅ pyautogui
桌面级操作      ✅            ❌          ✅ 全套

结论：现在和Codex CLI能力对等了
```

## 踩坑
- Windows的python3重定向到微软商店，要用全路径 `/c/Program Files/Python311/python.exe`
- Windows GBK编码不支持emoji，要加 `PYTHONIOENCODING=utf-8`
