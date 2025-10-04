#!/bin/bash

# PeaceStar 服务器清理脚本
echo "🧹 开始清理服务器上的旧项目..."

# 停止所有 Node.js 进程
echo "🛑 停止所有 Node.js 进程..."
pkill -f "node" || true
pkill -f "npm" || true
sleep 3

# 清理常见的前端项目文件
echo "🗑️  清理前端项目文件..."
rm -rf dist/ || true
rm -rf build/ || true
rm -rf public/ || true
rm -rf src/ || true
rm -rf components/ || true
rm -rf pages/ || true
rm -rf static/ || true
rm -rf assets/ || true

# 清理后端项目文件
echo "🗑️  清理后端项目文件..."
rm -rf node_modules/ || true
rm -rf .next/ || true
rm -rf .nuxt/ || true
rm -rf .vuepress/ || true

# 清理配置文件
echo "🗑️  清理配置文件..."
rm -f package.json || true
rm -f package-lock.json || true
rm -f yarn.lock || true
rm -f .env || true
rm -f .env.local || true
rm -f .env.production || true
rm -f .env.development || true

# 清理日志文件
echo "🗑️  清理日志文件..."
rm -f *.log || true
rm -f nohup.out || true
rm -f server.log || true
rm -f error.log || true
rm -f access.log || true

# 清理临时文件
echo "🗑️  清理临时文件..."
rm -f *.tmp || true
rm -f *.temp || true
rm -f .DS_Store || true
rm -f Thumbs.db || true

# 清理 Git 相关
echo "🗑️  清理 Git 文件..."
rm -rf .git/ || true
rm -f .gitignore || true

# 清理 IDE 文件
echo "🗑️  清理 IDE 文件..."
rm -rf .vscode/ || true
rm -rf .idea/ || true
rm -f *.swp || true
rm -f *.swo || true

# 清理其他常见文件
echo "🗑️  清理其他文件..."
rm -f README.md || true
rm -f README.txt || true
rm -f index.html || true
rm -f index.php || true
rm -f app.js || true
rm -f main.js || true
rm -f server.js || true
rm -f app.py || true
rm -f main.py || true

echo "✅ 服务器清理完成！"
echo "📋 当前目录内容："
ls -la

echo ""
echo "🎯 现在可以安全地部署新项目了！"
echo "💡 运行 ./deploy.sh 开始部署 PeaceStar 项目"
