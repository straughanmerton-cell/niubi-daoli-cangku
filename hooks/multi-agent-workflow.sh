#!/bin/bash
# 多Agent并行工作流 - 复杂任务分解成多个子任务并行干
# 用法: bash multi-agent-workflow.sh "任务描述" "子任务1,子任务2,子任务3..."
# 或者交互式：bash multi-agent-workflow.sh "任务描述"
#
# 效果：每个子任务用一个独立Agent跑，最后合并结果

REPO="/c/Users/Administrator/niubi-daoli-cangku"
TASK_DESC="${1:-}"
SUB_TASKS="${2:-}"

if [ -z "$TASK_DESC" ]; then
    echo "用法: bash multi-agent-workflow.sh \"任务描述\" [\"子任务1,子任务2,...\"]"
    echo ""
    echo "不传子任务参数时自动分解:"
    echo "  1. 先编译知识上下文"
    echo "  2. 分析任务需要几步"
    echo "  3. 并行执行"
    exit 1
fi

echo "🚀 多Agent工作流启动"
echo "📋 任务: $TASK_DESC"
echo ""

# 先编译知识上下文
echo "📚 编译知识上下文..."
bash "$REPO/hooks/knowledge-compile.sh" "$TASK_DESC"
echo ""

if [ -z "$SUB_TASKS" ]; then
    echo "⚡ 未指定子任务，使用默认并行模式："
    echo "   1. 资料收集Agent"
    echo "   2. 方案设计Agent"
    echo "   3. 实现Agent"
    echo "   请在Workflow中手动分配Agent"
    echo ""
    echo "💡 提示：用Workflow工具调用此脚本时传入子任务参数"
    echo "   示例: bash multi-agent-workflow.sh \"私服逆向\" "抓包分析,协议逆向,功能实现""
else
    echo "📋 子任务列表:"
    IFS=',' read -ra TASKS <<< "$SUB_TASKS"
    for i in "${!TASKS[@]}"; do
        echo "   Agent $((i+1)): ${TASKS[$i]}"
    done
    echo ""
    echo "✅ 已配置 $(( ${#TASKS[@]} )) 个并行Agent"
    echo "运行方式: 在Workflow工具中使用 pipeline() 或 parallel()"
fi

echo ""
echo "📄 上下文已存到: /tmp/knowledge-context.md"
echo "🔍 审查看这里: /c/Users/Administrator/niubi-daoli-cangku/review/checklist.md"
