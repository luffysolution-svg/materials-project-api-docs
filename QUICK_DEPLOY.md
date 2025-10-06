# 快速部署指南

## 🚀 最简单的方法（推荐）

### 步骤1: 在 GitHub 创建仓库

1. 访问 https://github.com/new
2. 填写信息：
   - **Repository name**: `materials-project-api-docs`
   - **Description**: `Materials Project API 完整中文使用指南`
   - **Public** (公开)
   - ⚠️ **不要勾选** "Add a README file"
3. 点击 **Create repository**

### 步骤2: 推送代码

在 PowerShell 中执行（**替换 YOUR_USERNAME 为您的 GitHub 用户名**）：

```powershell
cd "H:\material project\官方文档"

# 添加远程仓库
git remote add origin https://github.com/YOUR_USERNAME/materials-project-api-docs.git

# 推送代码
git branch -M main
git push -u origin main
```

### 步骤3: 完成！

访问 `https://github.com/YOUR_USERNAME/materials-project-api-docs` 查看您的仓库。

---

## 📝 如果推送时需要身份验证

### 方法1: 使用 GitHub Desktop（最简单）

1. 下载 [GitHub Desktop](https://desktop.github.com/)
2. 登录您的账户
3. File → Add Local Repository → 选择 `H:\material project\官方文档`
4. Publish repository

### 方法2: 使用个人访问令牌（PAT）

1. 访问 https://github.com/settings/tokens
2. Generate new token (classic)
3. 勾选 `repo` 权限
4. 生成并复制 token
5. 推送时使用 token 作为密码

---

## ✅ 验证部署成功

访问您的仓库，应该看到：
- ✅ README.md 正确显示
- ✅ 5个文档 Markdown 文件
- ✅ 5个文档 PDF 文件
- ✅ LICENSE 文件
- ✅ .gitignore 文件
- ✅ DEPLOYMENT_GUIDE.md

---

## 🎉 后续步骤

1. **添加 Topics**：在仓库页面添加标签
   - `materials-science`
   - `materials-project`
   - `api-documentation`
   - `python`
   - `chinese`

2. **启用 GitHub Pages**（可选）
   - Settings → Pages
   - Source: Deploy from branch
   - Branch: main

3. **分享您的项目**
   - Twitter/X
   - LinkedIn
   - 微信公众号
   - 知乎

---

## 💡 一键部署脚本

如果您熟悉 PowerShell，可以使用：

```powershell
cd "H:\material project\官方文档"
.\deploy.ps1
```

运行前请编辑 `deploy.ps1` 文件，修改第11行的 GitHub 用户名。

---

## ❓ 遇到问题？

查看完整指南：`DEPLOYMENT_GUIDE.md`

---

**准备好了吗？开始部署吧！** 🚀
