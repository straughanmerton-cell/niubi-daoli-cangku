# 审查清单

## 干活前（Pre-check）
- [ ] 查 memory/projects/ 有没有类似任务记录
- [ ] 查 memory/code/ 有没有现成代码可用
- [ ] 查 memory/errors/ 有没有相关踩坑经验
- [ ] 查 versions/tools.json 确认工具版本

## 写代码时（Code Review）
- [ ] 是否用了旧的、已知有问题的代码模式？
- [ ] 是否重复造了轮子？（查 memory/code/）
- [ ] 工具版本是否正确？（查 registry.json）
- [ ] 路径写死了还是可配置的？

## 干完活（Post-check）
- [ ] 更新 memory/projects/ 记录进度
- [ ] 如果有踩坑，更新 memory/errors/
- [ ] 如果有新代码经验，更新 memory/code/
- [ ] commit + push 到 seagull-brain
