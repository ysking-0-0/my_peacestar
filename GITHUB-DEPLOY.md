# GitHub 部署指南

## 方法一：直接上传（简单快速）

### 1. 使用 SCP 上传
```bash
# 在本地执行
scp -r backend/* root@peacestar.top:/var/www/peacestar/
```

### 2. 使用 SFTP 上传
```bash
# 连接服务器
sftp root@peacestar.top

# 在SFTP中执行
put -r backend/*
```

### 3. 使用 rsync 上传
```bash
rsync -avz backend/ root@peacestar.top:/var/www/peacestar/
```

## 方法二：通过 GitHub（推荐用于团队开发）

### 1. 创建 GitHub 仓库

1. 登录 GitHub
2. 点击 "New repository"
3. 仓库名：`peacestar-backend`
4. 设置为私有（可选）
5. 点击 "Create repository"

### 2. 上传代码到 GitHub

```bash
# 在本地 backend 目录执行
cd backend

# 初始化 Git
git init

# 添加文件
git add .

# 提交
git commit -m "Initial commit: PeaceStar backend"

# 添加远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/yourusername/peacestar-backend.git

# 推送到 GitHub
git push -u origin main
```

### 3. 在服务器上部署

```bash
# 连接到服务器
ssh root@peacestar.top

# 运行 GitHub 部署脚本
chmod +x github-deploy.sh
./github-deploy.sh
```

## 方法三：使用 FTP 客户端

### 推荐 FTP 客户端：
- **FileZilla**（免费）
- **WinSCP**（Windows）
- **Cyberduck**（Mac）

### 连接信息：
- 主机：`peacestar.top`
- 端口：`22`（SSH）或 `21`（FTP）
- 用户名：`root` 或你的用户名
- 密码：你的服务器密码

## 推荐方案

### 🚀 快速部署（推荐新手）
使用 **SCP** 直接上传：
```bash
scp -r backend/* root@peacestar.top:/var/www/peacestar/
```

### 🔄 持续开发（推荐团队）
使用 **GitHub** 方式，便于版本控制和团队协作。

### 📱 图形界面（推荐非技术用户）
使用 **FileZilla** 等 FTP 客户端，操作简单直观。

## 部署后验证

访问以下地址确认部署成功：
- http://peacestar.top/api/status
- http://peacestar.top/api/health

## 常见问题

### 权限问题
```bash
sudo chown -R $USER:$USER /var/www/peacestar/
```

### 端口被占用
```bash
sudo lsof -i :80
sudo kill -9 <PID>
```

### 防火墙设置
```bash
sudo ufw allow 80
sudo ufw allow 443
```
