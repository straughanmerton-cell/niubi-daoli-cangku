// 多Agent并行工作流模板 - 用Workflow工具调用
// 用法：复制这个文件，改子任务列表就行
// 调用：Workflow({ scriptPath: 'memory/workflows/你的工作流.js', args: {...} })

export const meta = {
  name: 'multi-agent-template',
  description: '多Agent并行工作模板 - 分解→并行→合并',
  phases: [
    { title: '分析', detail: '分解任务' },
    { title: '并行执行', detail: 'Agent们各干各的' },
    { title: '合并', detail: '汇总结果' },
  ],
}

const taskDesc = args?.task || '未指定任务'
const subTasks = args?.subTasks || ['信息收集', '方案设计', '代码实现']

// Phase 1: 先编译知识上下文
phase('分析')
log(`📋 任务: ${taskDesc}`)
log(`🔀 子任务: ${subTasks.join(', ')}`)

// Phase 2: 并行执行子任务
phase('并行执行')
const results = await parallel(subTasks.map((st, i) => () =>
  agent(`执行子任务: ${st}\n\n父任务: ${taskDesc}\n\n完成后输出结构化结果`, {
    label: `agent-${i+1}:${st}`,
    phase: '并行执行',
  })
))

// Phase 3: 合并结果
phase('合并')
const validResults = results.filter(Boolean)
log(`✅ ${validResults.length}/${subTasks.length} 个子任务完成`)

const merged = validResults.join('\n\n---\n\n')
return {
  task: taskDesc,
  subTasks: subTasks,
  completedCount: validResults.length,
  results: merged,
}
