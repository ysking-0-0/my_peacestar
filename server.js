const express = require('express')
const cors = require('cors')
const path = require('path')

const app = express()
const PORT = process.env.PORT || 80

// 中间件
app.use(cors())
app.use(express.json())
app.use(express.static(path.join(__dirname, 'public')))

// 开发状态API
app.get('/api/status', (req, res) => {
  res.json({
    status: 'developing',
    message: '正在开发中',
    progress: 75,
    version: '1.0.0',
    timestamp: new Date().toISOString()
  })
})

// 健康检查
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    message: '服务器运行正常',
    timestamp: new Date().toISOString()
  })
})

// 默认路由 - 显示正在开发中页面
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'))
})

// 404处理
app.use('*', (req, res) => {
  res.status(404).json({
    error: '接口不存在',
    message: '请检查请求路径是否正确'
  })
})

// 错误处理
app.use((err, req, res, next) => {
  console.error(err.stack)
  res.status(500).json({
    error: '服务器内部错误',
    message: '请稍后重试'
  })
})

app.listen(PORT, () => {
  console.log(`🚀 PeaceStar 服务器启动成功！`)
  console.log(`📍 服务地址: http://localhost:${PORT}`)
  console.log(`🔧 状态接口: http://localhost:${PORT}/api/status`)
  console.log(`💚 健康检查: http://localhost:${PORT}/api/health`)
})
