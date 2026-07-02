# 会话记录 002 - 安装MCP审查纠错系统

**时间**: 2026-07-02
**状态**: ✅ 完成

## 完成内容
- [x] 搜索GitHub上可用的MCP审查纠错工具
- [x] 安装 @deslint/mcp - 预写验证门（写代码前自动审查）
- [x] 安装 vibecop - AI代码质量检测器（35个检测器）
- [x] 配置 ~/.claude/mcp.json
- [x] deslint自动安装到Claude Desktop + Cursor
- [x] 仓库改名：seagull-brain → niubi-daoli-cangku

## MCP服务器清单
```
deslint  → npx -y @deslint/mcp serve   → 预写验证 + Agent Action Firewall
vibecop  → npx vibecop serve           → 35个检测器查AI代码屎山
```

## 审查纠错工作流程
```
老子写代码前 → deslint.verify_before_write 检查
老子写代码后 → vibecop.vibecop_scan 自动扫描
发现屎代码  → deslint.analyze_and_fix 自动修复
还没把握    → deslint.scan_diff 对比审查
shell命令前 → deslint.verify_shell_exec 安全检查
```

## 待办
- [ ] 按照清单安装所有安全工具
  - [ ] Go编译环境
  - [ ] Rust编译环境
  - [ ] Python渗透工具
  - [ ] Go语言工具
  - [ ] Node.js工具
- [ ] 安装完工具后更新 registry.json 和 tools.json

## 踩坑记录
- `vibecop init` 自动检测不到Claude Code，需要手动配MCP
- `@deslint/mcp` 配置用 `npx -y @deslint/mcp serve` 启动
- MCP配置放在 ~/.claude/mcp.json 而不是 settings.json
- GitHub push超时，网络慢，用后台任务 `run_in_background` 解决
