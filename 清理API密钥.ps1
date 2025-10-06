# 清理Git历史中的API密钥
# 警告：此操作会重写Git历史，使用前请确保备份！

Write-Host "=" * 80
Write-Host "Git历史清理工具 - 移除暴露的API密钥"
Write-Host "=" * 80
Write-Host ""

$apiKey = "8Fv89Xd3xCyJxw9oyc2srbKbHBqA9MGK"
$replacement = "YOUR_API_KEY_HERE"

Write-Host "⚠️  警告：此操作将重写Git历史！" -ForegroundColor Yellow
Write-Host ""
Write-Host "将要执行的操作："
Write-Host "1. 从所有Git历史中查找并替换API密钥"
Write-Host "2. 重写所有commit历史"
Write-Host "3. 需要强制推送到远程仓库"
Write-Host ""
Write-Host "API密钥: $apiKey"
Write-Host "替换为: $replacement"
Write-Host ""

$confirm = Read-Host "确认执行？输入 'YES' 继续"

if ($confirm -ne "YES") {
    Write-Host "操作已取消" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "开始清理Git历史..." -ForegroundColor Green

# 设置环境变量以避免警告
$env:FILTER_BRANCH_SQUELCH_WARNING = "1"

# 备份refs
Write-Host "1. 创建备份..."
git tag backup-before-cleanup

# 使用git filter-branch清理历史
Write-Host "2. 重写Git历史（这可能需要一些时间）..."
git filter-branch --force --tree-filter "
    if (Test-Path '01-API完整使用指南.md') {
        (Get-Content '01-API完整使用指南.md' -Raw) -replace '$apiKey', '$replacement' | Set-Content '01-API完整使用指南.md' -NoNewline
    }
" --tag-name-filter cat -- --all

if ($LASTEXITCODE -eq 0) {
    Write-Host "3. 清理reflog..."
    git reflog expire --expire=now --all
    
    Write-Host "4. 运行垃圾回收..."
    git gc --prune=now --aggressive
    
    Write-Host ""
    Write-Host "✓ Git历史清理完成！" -ForegroundColor Green
    Write-Host ""
    Write-Host "下一步操作："
    Write-Host "1. 检查历史: git log --all --full-history -p -- '01-API完整使用指南.md'"
    Write-Host "2. 强制推送到远程: git push origin --force --all"
    Write-Host "3. 强制推送标签: git push origin --force --tags"
    Write-Host ""
    Write-Host "⚠️  重要提示：" -ForegroundColor Yellow
    Write-Host "- API密钥已暴露，建议在Materials Project网站上重新生成新密钥"
    Write-Host "- 通知所有协作者重新克隆仓库"
    Write-Host "- 如果不需要备份标签，可以删除: git tag -d backup-before-cleanup"
} else {
    Write-Host "✗ 清理失败！" -ForegroundColor Red
    Write-Host "可以使用备份标签恢复: git reset --hard backup-before-cleanup"
}
