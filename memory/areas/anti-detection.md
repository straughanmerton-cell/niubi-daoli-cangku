# 🕵️ 反侦查/OPSEC

## 核心原则
1. **永远不要用本机IP干敏感事** - 最低要求proxychains+Tor
2. **隔离隔离再隔离** - 工具VM和目标VM分离
3. **操作完了要擦屁股** - 日志/Prefetch/注册表都要清

## 常用命令速查
```bash
# 清事件日志（管理员）
for /f %f in ('wevtutil el') do @wevtutil cl "%f" 2>nul

# 清Prefetch
del C:\Windows\Prefetch\* /f /q

# 清PowerShell历史
del %USERPROFILE%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

## 相关经验（patterns.json）
- opsec-anonymity-infra
- opsec-vm-isolation
- opsec-log-cleanup
- opsec-amsi-etw-bypass
- opsec-tool-fingerprint
- opsec-behavior-evasion
- opsec-network-traffic
- opsec-signs-of-compromise

## 关键工具
Tor / Whonix / Tails / GhostVPN / Nidhogg / BleachBit
