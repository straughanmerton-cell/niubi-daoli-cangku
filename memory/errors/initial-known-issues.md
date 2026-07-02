# 已知问题 & 解决方案

## 1. Git Bash 路径问题
**问题**: `gh` 命令在Git Bash中PATH不包含`/c/Program Files/GitHub CLI/`
**解决**: 用全路径 `/c/Program Files/GitHub CLI/gh` 或添加PATH
```
export PATH="$PATH:/c/Program Files/GitHub CLI/"
```

## 2. Git Bash cwd重置
**问题**: git操作、cd到其他目录后，shell的cwd会被重置到 C:\Windows
**解决**: 每次cd后用绝对路径，不要依赖相对路径

## 3. Windows下PowerShell不可用
**问题**: 环境只有Git Bash，没有PowerShell工具
**解决**: 所有命令用Bash兼容语法，避免PowerShell专属命令

## 4. 文件路径格式
**问题**: Windows用反斜杠，Git Bash用正斜杠
**解决**: 始终用 `/c/...` POSIX路径格式，不要用 `C:\...`
