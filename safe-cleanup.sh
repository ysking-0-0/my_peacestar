#!/bin/bash

# PeaceStar 安全清理脚本
echo "🧹 PeaceStar 安全清理脚本"
echo "================================"

# 显示当前目录内容
echo "📋 当前目录内容："
ls -la
echo ""

# 询问是否继续
read -p "⚠️  这将清理当前目录的所有文件，是否继续？(y/N): " confirm
if [[ $confirm != [yY] ]]; then
    echo "❌ 操作已取消"
    exit 0
fi

echo ""
echo "🔍 正在扫描可清理的文件..."

# 停止进程
echo "🛑 停止运行中的服务..."
pkill -f "node" || true
pkill -f "npm" || true
sleep 2

# 列出要删除的文件
echo ""
echo "📝 将要删除的文件和目录："
echo "------------------------"

# 检查并列出文件
files_to_delete=()

# 检查常见的前端文件
if [ -d "dist" ]; then files_to_delete+=("dist/"); fi
if [ -d "build" ]; then files_to_delete+=("build/"); fi
if [ -d "public" ]; then files_to_delete+=("public/"); fi
if [ -d "src" ]; then files_to_delete+=("src/"); fi
if [ -d "components" ]; then files_to_delete+=("components/"); fi
if [ -d "pages" ]; then files_to_delete+=("pages/"); fi
if [ -d "static" ]; then files_to_delete+=("static/"); fi
if [ -d "assets" ]; then files_to_delete+=("assets/"); fi

# 检查常见的后端文件
if [ -d "node_modules" ]; then files_to_delete+=("node_modules/"); fi
if [ -d ".next" ]; then files_to_delete+=(".next/"); fi
if [ -d ".nuxt" ]; then files_to_delete+=(".nuxt/"); fi
if [ -d ".vuepress" ]; then files_to_delete+=(".vuepress/"); fi

# 检查配置文件
if [ -f "package.json" ]; then files_to_delete+=("package.json"); fi
if [ -f "package-lock.json" ]; then files_to_delete+=("package-lock.json"); fi
if [ -f "yarn.lock" ]; then files_to_delete+=("yarn.lock"); fi
if [ -f ".env" ]; then files_to_delete+=(".env"); fi
if [ -f ".env.local" ]; then files_to_delete+=(".env.local"); fi
if [ -f ".env.production" ]; then files_to_delete+=(".env.production"); fi
if [ -f ".env.development" ]; then files_to_delete+=(".env.development"); fi

# 检查日志文件
if [ -f "*.log" ]; then files_to_delete+=("*.log"); fi
if [ -f "nohup.out" ]; then files_to_delete+=("nohup.out"); fi
if [ -f "server.log" ]; then files_to_delete+=("server.log"); fi
if [ -f "error.log" ]; then files_to_delete+=("error.log"); fi
if [ -f "access.log" ]; then files_to_delete+=("access.log"); fi

# 检查其他文件
if [ -f "README.md" ]; then files_to_delete+=("README.md"); fi
if [ -f "README.txt" ]; then files_to_delete+=("README.txt"); fi
if [ -f "index.html" ]; then files_to_delete+=("index.html"); fi
if [ -f "index.php" ]; then files_to_delete+=("index.php"); fi
if [ -f "app.js" ]; then files_to_delete+=("app.js"); fi
if [ -f "main.js" ]; then files_to_delete+=("main.js"); fi
if [ -f "server.js" ]; then files_to_delete+=("server.js"); fi
if [ -f "app.py" ]; then files_to_delete+=("app.py"); fi
if [ -f "main.py" ]; then files_to_delete+=("main.py"); fi

# 显示要删除的文件
if [ ${#files_to_delete[@]} -eq 0 ]; then
    echo "✅ 没有发现需要清理的文件"
    exit 0
fi

for file in "${files_to_delete[@]}"; do
    echo "  - $file"
done

echo ""
echo "📊 总计: ${#files_to_delete[@]} 个文件/目录"

# 最终确认
echo ""
read -p "⚠️  确认删除以上所有文件？(y/N): " final_confirm
if [[ $final_confirm != [yY] ]]; then
    echo "❌ 操作已取消"
    exit 0
fi

# 执行删除
echo ""
echo "🗑️  开始删除文件..."
for file in "${files_to_delete[@]}"; do
    if [ -e "$file" ]; then
        rm -rf "$file"
        echo "  ✅ 已删除: $file"
    fi
done

echo ""
echo "🎉 清理完成！"
echo "📋 当前目录内容："
ls -la

echo ""
echo "💡 现在可以运行 ./deploy.sh 部署 PeaceStar 项目了！"
