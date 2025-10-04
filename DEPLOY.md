# PeaceStar 后端部署指南

## 部署到 peacestar.top

### 0. 清理旧项目（可选）

如果服务器上有旧项目，可以先清理：

#### 方式一：安全清理（推荐）
```bash
chmod +x safe-cleanup.sh
./safe-cleanup.sh
```

#### 方式二：快速清理
```bash
chmod +x cleanup.sh
./cleanup.sh
```

### 1. 上传文件到服务器

将以下文件上传到你的服务器：
- `server.js` - 主服务器文件
- `package.json` - 依赖配置
- `package-lock.json` - 依赖锁定文件

### 2. 安装依赖

在服务器上执行：
```bash
npm install
```

### 3. 启动服务

#### 方式一：直接启动
```bash
node server.js
```

#### 方式二：使用 PM2（推荐）
```bash
# 安装 PM2
npm install -g pm2

# 启动服务
pm2 start server.js --name "peacestar-api"

# 设置开机自启
pm2 startup
pm2 save
```

### 4. 配置 Nginx（可选）

如果需要使用 Nginx 作为反向代理：

```nginx
server {
    listen 80;
    server_name peacestar.top www.peacestar.top;
    
    location / {
        proxy_pass http://localhost:80;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### 5. 配置 HTTPS（推荐）

使用 Let's Encrypt 免费 SSL 证书：

```bash
# 安装 Certbot
sudo apt install certbot python3-certbot-nginx

# 获取证书
sudo certbot --nginx -d peacestar.top -d www.peacestar.top
```

### 6. 验证部署

访问以下地址验证部署是否成功：
- http://peacestar.top/api/status
- http://peacestar.top/api/health

### 7. 环境变量（可选）

可以创建 `.env` 文件来配置环境变量：

```env
PORT=80
NODE_ENV=production
```

## 故障排除

### 端口被占用
```bash
# 查看端口占用
netstat -tulpn | grep :80

# 杀死占用进程
sudo kill -9 <PID>
```

### 权限问题
```bash
# 给文件执行权限
chmod +x server.js
```

### 防火墙设置
```bash
# Ubuntu/Debian
sudo ufw allow 80
sudo ufw allow 443

# CentOS/RHEL
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload
```

## 监控和维护

### 查看日志
```bash
# PM2 日志
pm2 logs peacestar-api

# 系统日志
tail -f /var/log/nginx/error.log
```

### 重启服务
```bash
# PM2 重启
pm2 restart peacestar-api

# 直接重启
pkill -f server.js && node server.js
```
