# 🚀 GitHub部署脚本
# 用于强制推送已清理API密钥的代码到GitHub

Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host "GitHub 强制推送部署脚本" -ForegroundColor Cyan
Write-Host "=" * 80 -ForegroundColor Cyan
Write-Host ""

Write-Host "⚠️  注意事项：" -ForegroundColor Yellow
Write-Host "1. 此操作将覆盖GitHub上的历史记录" -ForegroundColor Yellow
Write-Host "2. 确保你已经撤销了暴露的API密钥" -ForegroundColor Yellow
Write-Host "3. 如果有协作者，需要通知他们重新克隆仓库" -ForegroundColor Yellow
Write-Host ""

# 检查网络连接
Write-Host "正在检查GitHub连接..." -ForegroundColor Green
try {
    $response = Test-Connection github.com -Count 1 -ErrorAction Stop
    Write-Host "✓ GitHub连接正常" -ForegroundColor Green
} catch {
    Write-Host "✗ 无法连接到GitHub，请检查网络连接或代理设置" -ForegroundColor Red
    Write-Host "  提示：如果使用代理，请配置git代理：" -ForegroundColor Yellow
    Write-Host "  git config --global http.proxy http://proxy.example.com:8080" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "当前Git状态：" -ForegroundColor Green
git status --short

Write-Host ""
Write-Host "最近的提交：" -ForegroundColor Green
git log --oneline -n 5

Write-Host ""
Write-Host "远程仓库：" -ForegroundColor Green
git remote -v

Write-Host ""
$confirm = Read-Host "确认要强制推送到GitHub吗？(输入 YES 继续)"

if ($confirm -ne "YES") {
    Write-Host "操作已取消" -ForegroundColor Red
    exit 0
}

Write-Host ""
Write-Host "开始推送..." -ForegroundColor Green

# 强制推送main分支
Write-Host "1. 强制推送main分支..." -ForegroundColor Cyan
git push origin main --force

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ main分支推送成功" -ForegroundColor Green
    
    # 推送所有标签（如果有）
    Write-Host ""
    Write-Host "2. 推送标签..." -ForegroundColor Cyan
    git push origin --tags --force
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ 标签推送成功" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "=" * 80 -ForegroundColor Green
    Write-Host "✓ 部署成功！" -ForegroundColor Green
    Write-Host "=" * 80 -ForegroundColor Green
    Write-Host ""
    Write-Host "下一步行动：" -ForegroundColor Cyan
    Write-Host "1. 访问 https://materialsproject.org/ 撤销旧API密钥"
    Write-Host "2. 生成新的API密钥并安全保存"
    Write-Host "3. 在GitHub上检查提交历史确认API密钥已移除"
    Write-Host "4. 更新本地config.py使用新密钥"
    Write-Host ""
    Write-Host "GitHub仓库: https://github.com/luffysolution-svg/materials-project-api-docs" -ForegroundColor Green
    
} else {
    Write-Host ""
    Write-Host "=" * 80 -ForegroundColor Red
    Write-Host "✗ 推送失败" -ForegroundColor Red
    Write-Host "=" * 80 -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因：" -ForegroundColor Yellow
    Write-Host "1. 网络连接问题"
    Write-Host "2. 需要GitHub身份验证"
    Write-Host "3. 没有推送权限"
    Write-Host ""
    Write-Host "解决方案：" -ForegroundColor Yellow
    Write-Host "1. 检查网络连接"
    Write-Host "2. 设置GitHub Personal Access Token："
    Write-Host "   git remote set-url origin https://YOUR_TOKEN@github.com/luffysolution-svg/materials-project-api-docs.git"
    Write-Host "3. 或使用SSH："
    Write-Host "   git remote set-url origin git@github.com:luffysolution-svg/materials-project-api-docs.git"
}
