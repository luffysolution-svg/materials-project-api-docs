# Materials Project API 文档部署指南

## 方式一：通过 GitHub Desktop（推荐新手）

1. 下载并安装 [GitHub Desktop](https://desktop.github.com/)
2. 登录您的 GitHub 账户
3. 点击 "File" → "Add Local Repository"
4. 选择文件夹：`H:\material project\官方文档`
5. 点击 "Publish Repository"
6. 仓库名称：`materials-project-api-docs`
7. 描述：Materials Project API 完整中文使用指南
8. 取消勾选 "Keep this code private"（如果想公开）
9. 点击 "Publish Repository"

---

## 方式二：通过命令行（适合有经验的用户）

### 步骤 1: 在 GitHub 网站创建新仓库

1. 访问 https://github.com/new
2. 仓库名称：`materials-project-api-docs`
3. 描述：Materials Project API 完整中文使用指南 - Complete Chinese Guide for Materials Project API
4. 选择 Public（公开）
5. **不要**勾选 "Initialize this repository with a README"
6. 点击 "Create repository"

### 步骤 2: 连接本地仓库到 GitHub

在 PowerShell 中执行以下命令：

```powershell
# 进入项目目录
cd "H:\material project\官方文档"

# 添加远程仓库（替换 YOUR_USERNAME 为您的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/materials-project-api-docs.git

# 推送到 GitHub
git branch -M main
git push -u origin main
```

### 步骤 3: 使用更好的 README

```powershell
# 用更详细的 GitHub README 替换原文件
Remove-Item README.md
Rename-Item GITHUB_README.md README.md

# 提交更新
git add README.md
git commit -m "Update: 使用 GitHub 专用 README"
git push
```

---

## 方式三：使用 GitHub CLI（最快）

### 前置条件
安装 GitHub CLI：
```powershell
winget install --id GitHub.cli
```

### 部署命令

```powershell
# 进入项目目录
cd "H:\material project\官方文档"

# 登录 GitHub（首次使用）
gh auth login

# 创建仓库并推送
gh repo create materials-project-api-docs --public --source=. --remote=origin --push

# 用更好的 README 替换
Remove-Item README.md
Rename-Item GITHUB_README.md README.md
git add README.md
git commit -m "Update: 使用 GitHub 专用 README"
git push
```

---

## 部署后的工作

### 1. 设置 GitHub Pages（可选）

在仓库页面：
1. Settings → Pages
2. Source: Deploy from a branch
3. Branch: main, folder: / (root)
4. Save

您的文档将发布在：`https://YOUR_USERNAME.github.io/materials-project-api-docs/`

### 2. 添加 Topics（标签）

在仓库主页点击"Add topics"，添加：
- `materials-science`
- `materials-project`
- `api-documentation`
- `computational-materials-science`
- `python`
- `chinese`

### 3. 编辑仓库描述

在仓库主页点击 "About" 旁边的设置图标，填写：
- Description: Materials Project API 完整中文使用指南 | Complete Chinese Guide for Materials Project API
- Website: https://materialsproject.org/
- Topics: （已在上一步添加）

### 4. 添加 Star 徽章

将以下代码添加到 README.md 开头：
```markdown
[![GitHub stars](https://img.shields.io/github/stars/YOUR_USERNAME/materials-project-api-docs.svg?style=social&label=Star)](https://github.com/YOUR_USERNAME/materials-project-api-docs)
```

---

## 验证部署

访问您的仓库：
```
https://github.com/YOUR_USERNAME/materials-project-api-docs
```

检查清单：
- ✅ README.md 正确显示
- ✅ 所有文档文件都已上传
- ✅ PDF 文件可以下载
- ✅ LICENSE 文件存在
- ✅ .gitignore 正常工作

---

## 推广您的项目

### 社交媒体
分享到：
- Twitter/X
- LinkedIn
- 微信公众号
- 知乎

### 学术社区
- [Materials Project Forum](https://matsci.org/materials-project)
- Reddit r/materials
- ResearchGate

### 添加到列表
- [Awesome Materials Science](https://github.com/topics/materials-science)
- 提交到相关 awesome-list 项目

---

## 维护建议

### 定期更新
- 随 Materials Project API 更新而更新
- 添加新的代码示例
- 修复用户反馈的问题

### 版本管理
使用语义化版本号：
- v1.0.0 - 初始版本
- v1.1.0 - 添加新功能
- v1.0.1 - 修复bug

### 用户反馈
- 监控 Issues
- 回复 Discussions
- 处理 Pull Requests

---

## 需要帮助？

如果部署过程中遇到问题：

1. **Git 错误**
   - 检查 Git 是否正确安装：`git --version`
   - 检查网络连接
   - 使用 SSH 代替 HTTPS

2. **权限问题**
   - 确保已登录 GitHub
   - 检查仓库访问权限
   - 使用个人访问令牌（PAT）

3. **文件编码问题**
   - 确保文件使用 UTF-8 编码
   - 检查文件名中的特殊字符

---

**准备好了吗？选择一种方式开始部署吧！** 🚀
