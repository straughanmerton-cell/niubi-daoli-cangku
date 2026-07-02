#!/bin/bash
# 海鸥干活前检查脚本
# 作用：查记忆库、查版本、避免重复造轮子

REPO_PATH="/c/Users/Administrator/niubi-daoli-cangku"
MEMORY="$REPO_PATH/memory"
VERSIONS="$REPO_PATH/versions"

echo "🔍 牛逼预检..."

# 1. 检查记忆库
if [ -f "$MEMORY/projects/last-session.md" ]; then
    echo "📋 上次干活记录："
    head -5 "$MEMORY/projects/last-session.md"
fi

# 2. 检查工具版本
if [ -f "$VERSIONS/tools.json" ]; then
    TOOL_COUNT=$(grep -c '"version"' "$VERSIONS/tools.json" 2>/dev/null)
    echo "🔧 已追踪 $TOOL_COUNT 个工具版本"
fi

# 3. 检查是否有相关代码经验
TASK_KEYWORD="${1:-}"
if [ -n "$TASK_KEYWORD" ] && [ -f "$MEMORY/code/patterns.json" ]; then
    MATCH=$(grep -i "$TASK_KEYWORD" "$MEMORY/code/patterns.json" 2>/dev/null)
    if [ -n "$MATCH" ]; then
        echo "💡 找到相关经验！"
        echo "$MATCH"
    fi
fi

# 4. 检查踩坑记录
if [ -f "$MEMORY/errors/error-log.json" ]; then
    ERROR_COUNT=$(grep -c '"solution"' "$MEMORY/errors/error-log.json" 2>/dev/null)
    echo "⚠️  $ERROR_COUNT 条踩坑记录可参考"
fi

echo "✅ 预检完成"
