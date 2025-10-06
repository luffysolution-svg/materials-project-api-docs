# 🔒 API密钥泄露应急处理指南

## ⚠️ 紧急情况说明

你的 Materials Project API密钥已经暴露在Git历史中：
- **暴露的密钥**: `YOUR_EXPOSED_API_KEY_HERE`
- **暴露位置**: `01-API完整使用指南.md` (第84行)
- **状态**: 已提交到Git历史

---

## 🚨 立即执行的步骤

### 步骤1: 撤销暴露的API密钥（最重要！）

1. 访问 https://materialsproject.org/
2. 登录你的账号
3. 进入 **Dashboard** → **API**
4. **撤销（Revoke）** 旧密钥: `YOUR_EXPOSED_API_KEY_HERE`
5. **生成新的API密钥**并安全保存

⏰ **建议立即完成此步骤**，防止密钥被滥用！

---

### 步骤2: 清理Git历史中的API密钥

文档文件已修改，移除了明文API密钥。但Git历史中仍然保留。

#### 方法A: 使用BFG Repo-Cleaner（推荐，最快）

```powershell
# 1. 下载BFG
# 访问: https://rtyley.github.io/bfg-repo-cleaner/
# 下载 bfg.jar

# 2. 创建替换文件
"YOUR_EXPOSED_API_KEY_HERE" > replacements.txt

# 3. 运行BFG清理
java -jar bfg.jar --replace-text replacements.txt "h:\material project\MP官方调用文档示例"

# 4. 清理reflog和垃圾回收
cd "h:\material project\MP官方调用文档示例"
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

#### 方法B: 手动使用git filter-branch

```powershell
cd "h:\material project\MP官方调用文档示例"

# 创建备份分支
git branch backup-main

# 使用filter-branch清理
$env:FILTER_BRANCH_SQUELCH_WARNING = "1"
git filter-branch --force --tree-filter "if (Test-Path '01-API完整使用指南.md') { (Get-Content '01-API完整使用指南.md' -Raw) -replace 'YOUR_EXPOSED_API_KEY_HERE', 'YOUR_API_KEY_HERE' | Set-Content '01-API完整使用指南.md' -NoNewline }" --tag-name-filter cat -- --all

# 清理
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

---

### 步骤3: 强制推送到GitHub

```powershell
cd "h:\material project\MP官方调用文档示例"

# 强制推送所有分支
git push origin --force --all

# 强制推送所有标签
git push origin --force --tags
```

⚠️ **注意**: 强制推送会覆盖远程历史，确保通知所有协作者！

---

### 步骤4: 验证清理结果

```powershell
# 在Git历史中搜索API密钥（应该找不到）
cd "h:\material project\MP官方调用文档示例"
git log --all --full-history -p | Select-String "YOUR_EXPOSED_API_KEY_HERE"

# 如果没有输出，说明清理成功！
```

---

### 步骤5: 通知协作者

如果有其他人克隆了这个仓库，需要通知他们：

```powershell
# 删除本地仓库
cd "h:\material project\"
Remove-Item -Path "MP官方调用文档示例" -Recurse -Force

# 重新克隆
git clone https://github.com/luffysolution-svg/materials-project-docs.git MP官方调用文档示例
```

---

## 📝 更新配置文件

确保在 `h:\material project\半导体信息查询\config.py` 中使用新的API密钥：

```python
# Materials Project API Key
API_KEY = "新生成的API密钥"
```

---

## 🔐 未来预防措施

### 1. 使用环境变量

```python
import os
API_KEY = os.getenv("MATERIALS_PROJECT_API_KEY")
```

### 2. 使用 .env 文件

```bash
# .env
MATERIALS_PROJECT_API_KEY=your_new_api_key
```

```python
from dotenv import load_dotenv
import os

load_dotenv()
API_KEY = os.getenv("MATERIALS_PROJECT_API_KEY")
```

### 3. 确保 .gitignore 包含

```gitignore
# API密钥和配置
config.py
.env
.env.local
*.key
```

### 4. 使用 git-secrets

```powershell
# 安装git-secrets防止未来的密钥泄露
# https://github.com/awslabs/git-secrets
```

---

## ✅ 检查清单

- [ ] 在Materials Project网站上撤销旧API密钥
- [ ] 生成新的API密钥
- [ ] 清理Git历史（方法A或B）
- [ ] 强制推送到GitHub
- [ ] 验证清理结果
- [ ] 更新本地config.py使用新密钥
- [ ] 通知协作者（如果有）
- [ ] 添加git-secrets预防未来泄露

---

## 📞 需要帮助？

如果在执行过程中遇到问题，可以：
1. 查看Git文档: https://git-scm.com/docs
2. BFG Repo-Cleaner文档: https://rtyley.github.io/bfg-repo-cleaner/
3. Materials Project支持: https://matsci.org/materials-project

---

**最后更新**: 2025年10月6日
