#!/bin/bash

# PeaceStar 后端部署脚本
echo "🚀 开始部署 PeaceStar 后端到 peacestar.top..."

# 清理旧项目
echo "🧹 清理旧项目..."
echo "正在停止所有 Node.js 进程..."
pkill -f "node" || true
sleep 2

echo "正在清理旧文件..."
rm -rf node_modules/ || true
rm -f *.log || true
rm -f nohup.out || true
rm -f server.log || true

echo "✅ 旧项目清理完成"

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装，请先安装 Node.js"
    exit 1
fi

# 检查 npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm 未安装，请先安装 npm"
    exit 1
fi

echo "✅ Node.js 版本: $(node --version)"
echo "✅ npm 版本: $(npm --version)"

# 安装依赖
echo "📦 安装依赖..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ 依赖安装失败"
    exit 1
fi

echo "✅ 依赖安装成功"

# 检查端口是否被占用
if lsof -Pi :80 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  端口 80 已被占用，正在尝试停止现有服务..."
    pkill -f "node server.js" || true
    sleep 2
fi

# 启动服务
echo "🚀 启动服务..."
nohup node server.js > server.log 2>&1 &

# 等待服务启动
sleep 3

# 检查服务是否启动成功
if curl -s http://localhost/api/health > /dev/null; then
    echo "✅ 服务启动成功！"
    echo "📍 API 地址: http://peacestar.top/api/status"
    echo "💚 健康检查: http://peacestar.top/api/health"
else
    echo "❌ 服务启动失败，请检查日志"
    echo "📋 查看日志: tail -f server.log"
    exit 1
fi

echo "🎉 部署完成！"
