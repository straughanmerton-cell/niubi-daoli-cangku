# 🧠 记忆系统

## 核心架构
```
PARA组织:
  projects/  → 活跃项目（session记录）
  areas/     → 领域知识索引（本目录）
  resources/ → 参考材料（patterns.json + 工具注册表）
  archives/  → 已完成/归档内容
  decisions/ → ADR决策记录
```

## 工作流程
```
干活前 → knowledge-compile（自动编译上下文）
干活中 → 多Agent并行
干完活 → 更新areas/ → 记录ADR → git push
每周  → knowledge-lint（检查知识质量）
```

## 相关经验（patterns.json）
- claude-mcp-memory-workflow

## 关键工具
mcp-memory-graph / niubi-daoli-cangku / CLAUDE.md hooks
