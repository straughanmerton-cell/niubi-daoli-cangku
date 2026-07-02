#!/bin/bash
# 知识Compile机制 - 干活前自动编译相关知识到临时上下文
# 用法: bash knowledge-compile.sh "关键词"
# 效果: 生成 /tmp/knowledge-context.md 包含所有相关内容

REPO="/c/Users/Administrator/niubi-daoli-cangku"
PATTERNS="$REPO/memory/resources/patterns.json"
DECISIONS="$REPO/memory/decisions"
AREAS="$REPO/memory/areas"
ERRORS="$REPO/memory/archives/errors"
REGISTRY="$REPO/memory/resources/tools/registry.json"
OUTPUT="/tmp/knowledge-context.md"
KEYWORD="${1:-}"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "🧠 知识编译中... 关键词: ${KEYWORD:-无}"

cat > "$OUTPUT" << EOF
# 🧠 编译知识上下文
> 自动生成于: $TIMESTAMP
> 关键词: ${KEYWORD:-无}

EOF

# 1. 如果是"私服游戏"或类似关键词，用默认的全量编译
if [ -z "$KEYWORD" ]; then
    cat >> "$OUTPUT" << EOF
## 📋 默认加载（无特定关键词）

### 最近会话记录
$(ls -t "$REPO/memory/projects/"*.md 2>/dev/null | head -3 | while read f; do echo "- $(basename $f .md)"; done)

### 活跃领域
$(ls "$AREAS"/*.md 2>/dev/null | grep -v README | while read f; do echo "- $(basename $f .md)"; done)

### 工具总览
$(grep '"version"' "$REGISTRY" 2>/dev/null | head -20 | sed 's/",/"/g' | sed 's/.*"\(.*\)"/- \1/g')

### 已知踩坑
$(find "$ERRORS" -name "*.md" 2>/dev/null | while read f; do echo "- $(basename $f .md)"; done)

EOF
    echo "  默认全量编译完成"
    echo "📄 $OUTPUT"
    exit 0
fi

# 2. 有关键词 - 智能编译
echo "## 📌 匹配的知识经验" >> "$OUTPUT"

# 在patterns.json中搜关键词（匹配id、category、description）
MATCHES=$(grep -i -A 20 "\"id\".*${KEYWORD}\|\"category\".*${KEYWORD}\|\"description\".*${KEYWORD}" "$PATTERNS" 2>/dev/null | grep -E '"id"|"category"|"description"|"steps"|"notes"|"tools"|"payloads"' | sed 's/^[[:space:]]*//' | head -80)

if [ -n "$MATCHES" ]; then
    echo '```json' >> "$OUTPUT"
    echo "$MATCHES" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "  找到匹配的经验条目"
else
    echo "  (patterns.json中无精确匹配)" >> "$OUTPUT"
    echo "  未找到精确匹配"
fi

# 3. 加载对应领域的area索引
AREA_FILE=$(ls "$AREAS"/*.md 2>/dev/null | grep -v README | xargs grep -il "$KEYWORD" 2>/dev/null | head -1)
if [ -n "$AREA_FILE" ]; then
    echo "" >> "$OUTPUT"
    echo "## 📂 相关领域索引" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    cat "$AREA_FILE" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "  加载领域索引: $(basename $AREA_FILE)"
fi

# 4. 检查ADR决策记录
ADR_MATCH=$(grep -rl "$KEYWORD" "$DECISIONS" 2>/dev/null | head -3)
if [ -n "$ADR_MATCH" ]; then
    echo "" >> "$OUTPUT"
    echo "## 📝 相关决策记录" >> "$OUTPUT"
    for adr in $ADR_MATCH; do
        echo "- $(basename $adr)" >> "$OUTPUT"
    done
    echo "  找到相关决策记录"
fi

# 5. 检查踩坑记录
ERROR_MATCH=$(grep -il "$KEYWORD" "$ERRORS" 2>/dev/null | head -3)
if [ -n "$ERROR_MATCH" ]; then
    echo "" >> "$OUTPUT"
    echo "## ⚠️ 相关踩坑记录" >> "$OUTPUT"
    for err in $ERROR_MATCH; do
        echo "- $(basename $err)" >> "$OUTPUT"
    done
    echo "  找到相关踩坑记录"
fi

# 6. 工具版本检查
TOOL_VERSION=$(grep -i "$KEYWORD" "$REGISTRY" 2>/dev/null | head -10)
if [ -n "$TOOL_VERSION" ]; then
    echo "" >> "$OUTPUT"
    echo "## 🔧 工具版本" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "$TOOL_VERSION" >> "$OUTPUT"
    echo '```' >> "$OUTPUT"
    echo "  加载工具版本信息"
fi

echo "✅ 编译完成: $OUTPUT"
echo "📄 $OUTPUT"
