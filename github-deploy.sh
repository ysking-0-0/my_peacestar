#!/bin/bash

# PeaceStar GitHub 部署脚本
echo "🚀 通过 GitHub 部署 PeaceStar 项目..."

# 检查 Git
if ! command -v git &> /dev/null; then
    echo "❌ Git 未安装，请先安装 Git"
    echo "安装命令: sudo apt install git"
    exit 1
fi

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装，请先安装 Node.js"
    echo "安装命令: sudo apt install nodejs npm"
    exit 1
fi

# 设置项目目录
PROJECT_DIR="/var/www/peacestar"
REPO_URL="https://github.com/yourusername/peacestar-backend.git"

echo "📁 项目目录: $PROJECT_DIR"

# 创建项目目录
sudo mkdir -p $PROJECT_DIR
sudo chown $USER:$USER $PROJECT_DIR

# 进入项目目录
cd $PROJECT_DIR

# 清理旧项目
echo "🧹 清理旧项目..."
rm -rf * .*

# 克隆仓库
echo "📥 从 GitHub 克隆项目..."
git clone $REPO_URL .

if [ $? -ne 0 ]; then
    echo "❌ 克隆失败，请检查仓库地址"
    exit 1
fi

# 安装依赖
echo "📦 安装依赖..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ 依赖安装失败"
    exit 1
fi

# 停止旧服务
echo "🛑 停止旧服务..."
pkill -f "node server.js" || true
sleep 2

# 启动服务
echo "🚀 启动服务..."
nohup node server.js > server.log 2>&1 &

# 等待服务启动
sleep 3

# 检查服务状态
if curl -s http://localhost/api/health > /dev/null; then
    echo "✅ 服务启动成功！"
    echo "📍 API 地址: http://peacestar.top/api/status"
    echo "💚 健康检查: http://peacestar.top/api/health"
else
    echo "❌ 服务启动失败，请检查日志"
    echo "📋 查看日志: tail -f server.log"
    exit 1
fi

echo "🎉 GitHub 部署完成！"
echo "💡 下次更新代码时，只需运行: git pull && pm2 restart peacestar-api"
