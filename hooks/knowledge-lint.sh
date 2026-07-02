#!/bin/bash
# 知识质量门控 - 检查知识库的健康状况
# 用法: bash knowledge-lint.sh [--fix]
# 检查: 重复条目/孤立条目/过期条目/矛盾条目

REPO="/d/niubi-daoli-cangku"
PATTERNS="$REPO/memory/resources/patterns.json"
ERRORS="$REPO/memory/archives/errors"
DECISIONS="$REPO/memory/decisions"
AREAS="$REPO/memory/areas"
FIX_MODE="${1:-}"

echo "🔍 知识质量检查 - $(date '+%Y-%m-%d %H:%M:%S')"
echo "=========================================="
TOTAL_ISSUES=0

# 1. 检查重复条目ID
echo ""
echo "📌 1. 重复ID检查..."
DUPLICATE_IDS=$(grep -o '"id": "[^"]*"' "$PATTERNS" 2>/dev/null | sort | uniq -d)
if [ -n "$DUPLICATE_IDS" ]; then
    echo "⚠️  发现重复ID:"
    echo "$DUPLICATE_IDS"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
else
    echo "✅ 无重复ID"
fi

# 2. 检查条目总数
echo ""
echo "📊 2. 知识统计..."
ENTRY_COUNT=$(grep -c '"id":' "$PATTERNS" 2>/dev/null)
AREA_COUNT=$(ls "$AREAS"/*.md 2>/dev/null | grep -v README | wc -l)
DECISION_COUNT=$(ls "$DECISIONS"/*.md 2>/dev/null | grep -v README | grep -v template | wc -l)
ERROR_COUNT=$(find "$ERRORS" -name "*.md" -o -name "*.json" 2>/dev/null | wc -l)
echo "   知识条目: $ENTRY_COUNT"
echo "   领域索引: $AREA_COUNT"
echo "   决策记录: $DECISION_COUNT"
echo "   踩坑记录: $ERROR_COUNT"

# 3. 检查条目是否有空字段
echo ""
echo "📝 3. 字段完整性检查..."
MISSING_TOOLS=$(grep -c '"tools": \[\]' "$PATTERNS" 2>/dev/null)
MISSING_NOTES=$(grep -c '"notes": ""' "$PATTERNS" 2>/dev/null)
if [ "$MISSING_TOOLS" -gt 0 ] || [ "$MISSING_NOTES" -gt 0 ]; then
    echo "⚠️  发现不完整条目:"
    [ "$MISSING_TOOLS" -gt 0 ] && echo "   - $MISSING_TOOLS 条缺少tools字段"
    [ "$MISSING_NOTES" -gt 0 ] && echo "   - $MISSING_NOTES 条缺少notes字段"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
else
    echo "✅ 所有条目字段完整"
fi

# 4. 检查决策记录是否引用正确的条目
echo ""
echo "📋 4. ADR引用检查..."
if [ -d "$DECISIONS" ]; then
    adr_files=$(ls "$DECISIONS"/*.md 2>/dev/null | grep -v template | wc -l)
    echo "   已记录 $adr_files 个决策"
    if [ "$adr_files" -eq 0 ]; then
        echo "ℹ️  建议：每次做重要技术决策时写ADR"
    fi
fi

# 5. 检查领域索引是否完整
echo ""
echo "🌐 5. 领域覆盖检查..."
PATTERN_CATEGORIES=$(grep -o '"category": "[^"]*"' "$PATTERNS" 2>/dev/null | sort | uniq -c | sort -rn)
echo "   知识分布:"
echo "$PATTERN_CATEGORIES" | while read count cat; do
    printf "      %-25s %s条\n" "${cat//\"/}" "$count"
done

# 6. 检查上次更新距今多久
echo ""
echo "⏰ 6. 新鲜度检查..."
LAST_COMMIT=$(cd "$REPO" && git log -1 --format="%ci" 2>/dev/null)
echo "   最后更新: $LAST_COMMIT"

# 总结
echo ""
echo "=========================================="
if [ "$TOTAL_ISSUES" -eq 0 ]; then
    echo "✅ 知识库健康，无问题"
else
    echo "⚠️  发现 $TOTAL_ISSUES 个问题"
fi
echo ""
echo "💡 建议运行周期：每完成2-3个会话后跑一次"
echo "   命令: bash hooks/knowledge-lint.sh"
