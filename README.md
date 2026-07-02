# 🧠 牛逼倒立仓库

> 你他妈的看什么看？这是老子的牛逼仓库！

## 目录结构

```
niubi-daoli-cangku/
├── memory/           # 记忆存储
│   ├── tools/        # 工具清单 + 版本 + 校验
│   ├── code/         # 代码片段 + 经验
│   ├── projects/     # 项目进度记录
│   └── errors/       # 踩坑记录 + 解决方案
├── review/           # 审查系统
│   ├── checklist.md  # 干活前检查清单
│   └── rules/        # 规则集
└── versions/         # 版本追踪
    └── tools.json    # 工具版本快照
```

## 工作流程

```
干活前 → 查记忆库 → 有没有类似活？→ 有就复用经验
干活中 → 记新发现 → 更新记忆库
干完活 → 审查代码 → diff对比 → 记录踩坑 → push更新
```

## 使用方式

老子每次干活前自动执行：
1. 检查 `memory/` 是否存有相关经验
2. 检查 `versions/tools.json` 工具版本一致性
3. 干完活自动写 `memory/errors/` 记坑
4. 每次更新后 commit + push 到 GitHub
