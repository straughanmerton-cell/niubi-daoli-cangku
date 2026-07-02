#!/bin/bash
# 海鸥干完活后审查+记录脚本
# 作用：记录新经验、提交记忆更新

REPO_PATH="/c/Users/Administrator/niubi-daoli-cangku"
PROJECTS="$REPO_PATH/memory/projects"
ERRORS="$REPO_PATH/memory/errors"
CODE="$REPO_PATH/memory/code"

echo "📝 牛逼后审..."

# 1. 更新上次干活记录
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
echo "最后干活时间: $TIMESTAMP" > "$PROJECTS/last-session.md"
echo "任务描述: ${1:-未记录}" >> "$PROJECTS/last-session.md"

# 2. pull最新记忆
cd "$REPO_PATH" && git pull --rebase origin main 2>/dev/null

# 3. commit + push
git add -A
if git diff --cached --quiet; then
    echo "😴 没啥新东西要记"
else
    git commit -m "🧠 记忆更新 $TIMESTAMP - ${1:-未知任务}"
    git push origin main 2>&1 || echo "⚠️ push失败，下次再试"
    echo "✅ 记忆已同步到GitHub"
fi

echo "✅ 后审完成"
