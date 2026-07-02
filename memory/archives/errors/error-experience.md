---
name: error-experience
description: 所有犯错记录和吸取的教训 - 避免重复踩坑
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c902d9b6-91ae-4336-8f65-cb0192809c0d
---

# ⚠️ 错误经验追踪

> 每次犯错都记在这里，以后同样的错误不再犯！
> 格式：日期 | 错误描述 | 根因 | 教训 | 修复方式

## 2026-07-02

### ERR-001: git push总是超时
- **错误**: `git push origin main` 超时exit 128
- **根因**: git没有凭证缓存，需要交互式输入用户名密码
- **教训**: 装gh后要执行 `gh auth setup-git` 配置凭证
- **解决方案**: gh auth token 获取token，gh auth setup-git配置helper
- **状态**: ✅ 已解决

### ERR-002: 文件路径引用错误
- **错误**: 重构PARA结构后，patterns.json路径从 `memory/code/` 变成 `memory/resources/`
- **根因**: 移动文件后忘了更新引用路径
- **教训**: 重构文件结构后必须全局搜索旧路径并更新
- **解决方案**: 用 `grep -r "旧路径" .` 找到所有引用并修复
- **状态**: ✅ 已解决

### ERR-003: pip安装权限错误
- **错误**: `pip3 install pypykatz` 报错 `OSError: Invalid argument`
- **根因**: Windows下pip往C:\Program Files\Python311\Scripts\写文件没有权限
- **教训**: 用 `--no-compile` 或 `--no-deps` 跳过脚本安装
- **解决方案**: pip3 install --no-compile pypykatz
- **状态**: ✅ 已解决

### ERR-004: 工具版本查询参数不一致
- **错误**: ffuf --version报错 "flag provided but not defined"
- **根因**: 不同工具的参数格式不同，ffuf用 `-V` 不是 `--version`
- **教训**: 查版本前先 `tool --help` 看看参数格式
- **解决方案**: ffuf -V
- **状态**: ✅ 已解决

### ERR-006: python3命令被Windows Store劫持
- **错误**: `python3` 调出微软商店，不是Python解释器
- **根因**: Windows的python3别名重定向到商店
- **教训**: 用全路径 `/c/Program Files/Python311/python.exe` 或 `py -3`
- **解决方案**: 别名问题，用全路径绕过
- **状态**: ✅ 已解决

### ERR-007: Windows终端GBK编码不支持emoji
- **错误**: Python脚本print emoji报 `UnicodeEncodeError: gbk`
- **根因**: Windows终端用GBK编码，不支持Unicode emoji
- **教训**: Python脚本前加 `PYTHONIOENCODING=utf-8`
- **解决方案**: export PYTHONIOENCODING=utf-8 或去掉emoji
- **状态**: ✅ 已解决

### ERR-005: 知识Compile脚本没有准确匹配关键词
- **错误**: 跑 knowledge-compile.sh "游戏" 没有匹配到游戏相关的条目
- **根因**: patterns.json被移到了resources/目录，但脚本还在搜旧的路径
- **教训**: 每次重构文件后要更新所有相关脚本的路径
- **解决方案**: 更新knowledge-compile.sh中的PATTERNS路径
- **状态**: ✅ 已解决

## 原则提炼（从错误中总结）
1. **改路径必搜引用** - 移动/改名文件后，全局搜旧路径
2. **查版本先看help** - 不同工具的参数格式不统一
3. **Windows权限问题** - 装Python包加--no-compile
4. **git凭证要提前配** - 装完gh就配auth setup-git
5. **重构后跑lint** - 改完结构跑一次knowledge-lint.sh验证
6. **用户偏好一定要记** - 用户说了一次的话，下次不准让ta重复
7. **Windows全路径** - 系统命令(python3/pip3)可能被商店劫持，用全路径绕过
8. **GBK编码** - Windows终端用 `PYTHONIOENCODING=utf-8` 防乱码
