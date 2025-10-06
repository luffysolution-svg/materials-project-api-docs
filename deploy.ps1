# Materials Project API 文档 - 一键部署脚本
# 作者: Luffy.Solution
# 日期: 2025年10月6日

# ============================================
# 配置区域 - 请修改以下信息
# ============================================

# 您的 GitHub 用户名
$GITHUB_USERNAME = "luffysolution"  # 请修改为您的实际用户名

# 仓库名称
$REPO_NAME = "materials-project-api-docs"

# 仓库描述
$REPO_DESCRIPTION = "Materials Project API 完整中文使用指南 | Complete Chinese Guide"

# ============================================
# 部署流程
# ============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Materials Project API 文档部署工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查当前目录
$currentPath = Get-Location
Write-Host "[1/6] 当前目录: $currentPath" -ForegroundColor Green

if (-not (Test-Path ".git")) {
    Write-Host "错误: 当前目录不是 Git 仓库！" -ForegroundColor Red
    Write-Host "请先运行: cd 'H:\material project\官方文档'" -ForegroundColor Yellow
    exit 1
}

# 2. 检查 Git 配置
Write-Host "[2/6] 检查 Git 配置..." -ForegroundColor Green
$gitUser = git config --global user.name
$gitEmail = git config --global user.email

Write-Host "   Git 用户名: $gitUser" -ForegroundColor White
Write-Host "   Git 邮箱: $gitEmail" -ForegroundColor White

if ([string]::IsNullOrEmpty($gitUser) -or [string]::IsNullOrEmpty($gitEmail)) {
    Write-Host "警告: Git 用户信息未配置！" -ForegroundColor Yellow
    Write-Host "请运行以下命令配置：" -ForegroundColor Yellow
    Write-Host "   git config --global user.name '您的名字'" -ForegroundColor White
    Write-Host "   git config --global user.email '您的邮箱'" -ForegroundColor White
    $continue = Read-Host "是否继续？(y/n)"
    if ($continue -ne "y") { exit 0 }
}

# 3. 检查是否有未提交的更改
Write-Host "[3/6] 检查仓库状态..." -ForegroundColor Green
$status = git status --porcelain

if ($status) {
    Write-Host "发现未提交的更改：" -ForegroundColor Yellow
    git status --short
    
    $commit = Read-Host "是否提交这些更改？(y/n)"
    if ($commit -eq "y") {
        git add .
        $message = Read-Host "请输入提交信息"
        git commit -m "$message"
        Write-Host "✓ 更改已提交" -ForegroundColor Green
    }
}

# 4. 提示用户创建 GitHub 仓库
Write-Host ""
Write-Host "[4/6] 创建 GitHub 仓库" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "请按照以下步骤在 GitHub 上创建仓库：" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. 打开浏览器访问: https://github.com/new" -ForegroundColor White
Write-Host "2. 仓库名称: $REPO_NAME" -ForegroundColor White
Write-Host "3. 描述: $REPO_DESCRIPTION" -ForegroundColor White
Write-Host "4. 选择 Public（公开）" -ForegroundColor White
Write-Host "5. 【重要】不要勾选 'Initialize this repository with a README'" -ForegroundColor Red
Write-Host "6. 点击 'Create repository'" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

$created = Read-Host "仓库创建完成了吗？(y/n)"
if ($created -ne "y") {
    Write-Host "部署已取消。请先创建 GitHub 仓库。" -ForegroundColor Yellow
    exit 0
}

# 5. 添加远程仓库并推送
Write-Host ""
Write-Host "[5/6] 连接到 GitHub 仓库..." -ForegroundColor Green

$remoteUrl = "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
Write-Host "远程 URL: $remoteUrl" -ForegroundColor White

# 检查是否已存在 origin
$existingRemote = git remote get-url origin 2>$null

if ($existingRemote) {
    Write-Host "警告: 已存在远程仓库 origin" -ForegroundColor Yellow
    Write-Host "当前 URL: $existingRemote" -ForegroundColor White
    $replace = Read-Host "是否替换为新的 URL？(y/n)"
    
    if ($replace -eq "y") {
        git remote remove origin
        git remote add origin $remoteUrl
        Write-Host "✓ 远程仓库已更新" -ForegroundColor Green
    }
} else {
    git remote add origin $remoteUrl
    Write-Host "✓ 远程仓库已添加" -ForegroundColor Green
}

# 6. 推送到 GitHub
Write-Host ""
Write-Host "[6/6] 推送代码到 GitHub..." -ForegroundColor Green

# 重命名分支为 main
$currentBranch = git branch --show-current
if ($currentBranch -ne "main") {
    git branch -M main
    Write-Host "✓ 分支已重命名为 main" -ForegroundColor Green
}

# 推送
Write-Host "正在推送..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓ 部署成功！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "仓库地址: https://github.com/$GITHUB_USERNAME/$REPO_NAME" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "下一步操作：" -ForegroundColor Yellow
    Write-Host "1. 访问仓库页面查看文档" -ForegroundColor White
    Write-Host "2. 添加 Topics 标签（materials-science, api-documentation, python）" -ForegroundColor White
    Write-Host "3. 启用 GitHub Pages（可选）" -ForegroundColor White
    Write-Host "4. 分享您的项目！" -ForegroundColor White
    Write-Host ""
    
    # 询问是否打开浏览器
    $openBrowser = Read-Host "是否在浏览器中打开仓库？(y/n)"
    if ($openBrowser -eq "y") {
        Start-Process "https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "✗ 推送失败！" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因：" -ForegroundColor Yellow
    Write-Host "1. GitHub 用户名不正确" -ForegroundColor White
    Write-Host "2. 需要 GitHub 身份验证" -ForegroundColor White
    Write-Host "3. 网络连接问题" -ForegroundColor White
    Write-Host "4. 仓库已存在内容" -ForegroundColor White
    Write-Host ""
    Write-Host "解决方案：" -ForegroundColor Yellow
    Write-Host "1. 确认 GitHub 用户名: $GITHUB_USERNAME" -ForegroundColor White
    Write-Host "2. 使用个人访问令牌（PAT）进行身份验证" -ForegroundColor White
    Write-Host "   访问: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "3. 或使用 SSH 方式推送" -ForegroundColor White
    Write-Host ""
}

Write-Host "查看完整部署指南: .\DEPLOYMENT_GUIDE.md" -ForegroundColor Cyan
Write-Host ""
