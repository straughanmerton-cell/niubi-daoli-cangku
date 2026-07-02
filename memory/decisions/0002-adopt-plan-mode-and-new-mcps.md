# ADR-002: 采用Plan Mode工作流 + 新增3个MCP

**状态**: 已接受
**提出日期**: 2026-07-02
**最后更新**: 2026-07-02

---

### 背景

目前的工作流程是直接开干，缺少前期规划和验证环节。搜索了全球顶级Claude大神（Boris Cherny、Anthropic团队）的最佳实践后，发现：

1. **Boris Cherny工作流** （Claude Code 2026最受推崇的流程）：Plan Mode → 写plan.md → 审查 → 实现 → commit
2. **80%的会话应从Plan Mode开始** — 先探索再动手，避免方向错误
3. API参数总是猜错，需要实时文档支持
4. 复杂问题缺少分步推演

### 决策

1. 流程改为：Plan Mode → 知识Compile → 干活 → 审查 → 更新大脑
2. 新增3个MCP：context7（实时文档）、sequential-thinking（分步推理）、playwright（UI验证）

### 后果

- **正面**: 方向错了概率降低50%+，API参数不再靠猜
- **负面**: 需要多花5-10分钟做Plan Mode探索
- **风险**: 如果养成习惯后不Plan Mode可能会导致出问题
- **缓解**: CLAUDE.md写死流程，每次会话强制执行
