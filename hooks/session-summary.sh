#!/bin/bash
# 会话总结助手 - 每次会话结束自动更新记忆
# 用法: bash hooks/session-summary.sh "学到了什么" "犯了什么错" "用户偏好变化"

REPO="/d/niubi-daoli-cangku"
ERROR_LOG="$REPO/memory/archives/errors/error-log.json"
PATTERNS="$REPO/memory/resources/patterns.json"
USER_PROFILE="/c/Users/Administrator/.claude/projects/C--Windows/memory/user-profile.md"
SESSION_NUM=$(ls "$REPO/memory/projects/"*.md 2>/dev/null | wc -l)
SESSION_NUM=$((SESSION_NUM + 1))
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

LESSONS="${1:-}"
MISTAKES="${2:-}"
PREFERENCES="${3:-}"

echo "📝 会话总结 - $TIMESTAMP"
echo ""

# 1. 创建会话记录
cat > "$REPO/memory/projects/session-$(printf '%03d' $SESSION_NUM)-auto.md" << EOF
# 会话记录 $(printf '%03d' $SESSION_NUM) - 自动总结

**时间**: $TIMESTAMP

## 完成内容
$(echo "$LESSONS" | sed 's/^/- [x] /')

## 错误记录
$(echo "$MISTAKES" | sed 's/^/- /')

## 偏好更新
$(echo "$PREFERENCES" | sed 's/^/- /')
EOF

echo "✅ 会话记录已创建: session-$(printf '%03d' $SESSION_NUM)-auto.md"

# 2. 自动commit + push
cd "$REPO" && git add -A && git commit -m "📝 自动会话总结 $(date '+%Y-%m-%d %H:%M')" 2>/dev/null
git push origin main 2>/dev/null || echo "⚠️ push失败，下次再试"

echo ""
echo "✅ 记忆已更新并同步到GitHub"
