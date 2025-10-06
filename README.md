# Materials Project API - 官方文档导航

> Materials Project API 完整使用指南 v1.0

---

## 📚 文档目录

本文档集包含4个主要文件，涵盖从基础入门到高级应用的完整内容。

### 1️⃣ API完整使用指南
**文件**: `01-API完整使用指南.md`  
**大小**: ~70KB  
**适合对象**: 初学者到中级用户  

**内容概览**:
- **第1-6部分：基础知识**
  - API概览和认证方式
  - 请求结构和响应格式
  - 错误处理和速率限制
  
- **第7-10部分：核心端点**
  - Summary端点（材料基础信息）
  - Electronic Structure端点（电子结构）
  - Dielectric/Optical端点（光学性质）
  - Elasticity端点（力学性质）

**推荐阅读顺序**: 按序阅读第1-10部分，掌握API基础和核心功能

---

### 2️⃣ 高级端点详解
**文件**: `02-高级端点详解.md`  
**大小**: ~45KB  
**适合对象**: 中级到高级用户  

**内容概览**:
- **第11-12部分：材料性质端点**
  - Magnetism（磁性性质）- 永磁材料筛选应用
  - Surface Properties（表面性质）- 催化剂活性预测应用
  
- **第13-15部分：专业端点**
  - Piezoelectric（压电性质）
  - Phonon（声子性质）- 动力学稳定性检查
  - Thermodynamics（热力学）- 合成路径分析

**推荐使用场景**:
- 磁性材料研究 → 第11部分
- 催化剂设计 → 第12部分
- 材料稳定性分析 → 第14-15部分

---

### 3️⃣ 高级功能与最佳实践
**文件**: `03-高级功能与最佳实践.md`  
**大小**: ~55KB  
**适合对象**: 高级用户、系统开发者  

**内容概览**:
- **第16-18部分：高级搜索**
  - 复合条件搜索
  - 化学式和结构相似性搜索
  - 批量查询和分页处理
  - 相图分析和凸包计算
  
- **第19-20部分：实用工具**
  - 合成路径查询
  - 前驱体分析
  - 单位转换器
  - 材料评估工具
  
- **第21-22部分：工程实践**
  - 性能优化（缓存、并发）
  - 错误处理和日志记录
  
- **第23-24部分：完整案例**
  - 光伏材料筛选完整流程
  - 端点总览和学习资源

**推荐使用场景**:
- 大规模材料筛选 → 第16-17部分
- 生产环境部署 → 第21-22部分
- 完整项目开发 → 第23部分

---

### 4️⃣ 快速参考手册
**文件**: `04-快速参考手册.md`  
**大小**: ~30KB  
**适合对象**: 所有用户（速查工具）  

**内容概览**:
- 快速开始（最小工作示例）
- 常用端点速查表
- 代码片段库（12个实用函数）
- 常见问题FAQ（10个常见问题）
- 性能优化提示
- 单位转换表
- 晶系和空间群速查

**推荐使用方式**: 收藏备查，开发时快速查找代码模板

---

## 🎯 根据需求选择文档

### 场景1: 新手入门
```
推荐阅读路线:
1. 01-API完整使用指南（第1-6部分）- 了解基础
2. 04-快速参考手册 - 运行第一个示例
3. 01-API完整使用指南（第7-10部分）- 学习核心端点
```

### 场景2: 半导体材料研究
```
推荐端点:
- Summary: 基础信息和带隙搜索
- Electronic Structure: CBM/VBM能级
- Dielectric: 光学吸收性质

参考文档:
- 01-API完整使用指南（第7-9部分）
- 04-快速参考手册（代码片段#1、#3、#6、#8、#10）
```

### 场景3: 催化剂设计
```
推荐端点:
- Summary: 过渡金属氧化物搜索
- Surface Properties: 表面能和功函数
- Electronic Structure: 电子结构

参考文档:
- 02-高级端点详解（第12部分）
- 04-快速参考手册（代码片段#7）
```

### 场景4: 结构材料
```
推荐端点:
- Summary: 密度和稳定性
- Elasticity: 力学性质
- Thermodynamics: 相稳定性

参考文档:
- 01-API完整使用指南（第10部分）
- 02-高级端点详解（第15部分）
```

### 场景5: 大规模材料筛选
```
关键技术:
- 批量查询（避免速率限制）
- 数据缓存（提高效率）
- 分页处理（大数据集）

参考文档:
- 03-高级功能与最佳实践（第17、21部分）
- 04-快速参考手册（性能优化提示）
```

---

## 📊 端点功能对照表

| 研究方向 | 主要端点 | 次要端点 | 文档位置 |
|---------|---------|---------|---------|
| **光电材料** | Summary<br>Electronic Structure<br>Dielectric | Surface Properties | 01-第7-9部分 |
| **催化剂** | Summary<br>Surface Properties<br>Electronic Structure | Magnetism | 02-第11-12部分 |
| **结构材料** | Summary<br>Elasticity<br>Thermo | Phonon | 01-第10部分<br>02-第14-15部分 |
| **磁性材料** | Summary<br>Magnetism<br>Electronic Structure | - | 02-第11部分 |
| **能源材料** | Summary<br>Electronic Structure<br>Thermo | Phonon | 01-第7-8部分<br>02-第15部分 |
| **压电材料** | Summary<br>Piezoelectric<br>Elasticity | - | 02-第13部分 |

---

## 🔧 开发工具包

### 必备Python库
```python
# 核心库
import requests          # API请求
import pandas as pd      # 数据处理
import matplotlib.pyplot as plt  # 可视化
import numpy as np       # 数值计算

# 可选库
import seaborn as sns    # 高级可视化
import openpyxl          # Excel导出
import pickle            # 数据缓存
```

### API认证配置
```python
# config.py
API_KEY = "你的API密匙"
BASE_URL = "https://api.materialsproject.org"
HEADERS = {"X-API-KEY": API_KEY}
```

### 最小工作示例
```python
import requests

API_KEY = "8Fv89Xd3xCyJxw9oyc2srbKbHBqA9MGK"
BASE_URL = "https://api.materialsproject.org"
headers = {"X-API-KEY": API_KEY}

# 查询TiO2
url = f"{BASE_URL}/materials/summary/"
params = {
    "formula": "TiO2",
    "_fields": "material_id,formula_pretty,band_gap"
}

response = requests.get(url, headers=headers, params=params)
data = response.json()

for material in data["data"]:
    print(f"{material['formula_pretty']}: {material['band_gap']} eV")
```

---

## 📖 学习路径建议

### 初级（1-2周）
- [ ] 阅读01文档第1-6部分（API基础）
- [ ] 运行04文档中的最小示例
- [ ] 学习Summary端点（01-第7部分）
- [ ] 完成练习：按化学式搜索10个材料

### 中级（2-4周）
- [ ] 学习Electronic Structure端点（01-第8部分）
- [ ] 学习Optical和Elasticity端点（01-第9-10部分）
- [ ] 掌握批量查询技术（03-第17部分）
- [ ] 完成项目：筛选50个半导体材料并可视化

### 高级（1-2个月）
- [ ] 学习所有高级端点（02文档）
- [ ] 掌握性能优化技巧（03-第21部分）
- [ ] 学习完整工作流（03-第23部分）
- [ ] 完成项目：实现特定应用的材料筛选系统

---

## 💡 常用代码模板速查

### 模板1: 基础查询
```python
def search_materials(formula):
    url = f"{BASE_URL}/materials/summary/"
    params = {"formula": formula, "_fields": "material_id,formula_pretty"}
    response = requests.get(url, headers=headers, params=params)
    return response.json()["data"]
```
**位置**: 04文档-代码片段#1

### 模板2: 带隙筛选
```python
def screen_by_bandgap(min_gap, max_gap):
    url = f"{BASE_URL}/materials/summary/"
    params = {
        "band_gap_min": min_gap,
        "band_gap_max": max_gap,
        "is_stable": True,
        "_fields": "material_id,formula_pretty,band_gap"
    }
    response = requests.get(url, headers=headers, params=params)
    return response.json()["data"]
```
**位置**: 04文档-代码片段#3

### 模板3: 批量查询
```python
def batch_query(material_ids):
    url = f"{BASE_URL}/materials/summary/"
    params = {
        "material_ids": ",".join(material_ids),
        "_fields": "material_id,formula_pretty,band_gap"
    }
    response = requests.get(url, headers=headers, params=params)
    return response.json()["data"]
```
**位置**: 04文档-代码片段#5

### 模板4: 数据导出
```python
def export_to_excel(materials, filename="output.xlsx"):
    import pandas as pd
    df = pd.DataFrame(materials)
    df.to_excel(filename, index=False)
```
**位置**: 04文档-代码片段#11

---

## 🚀 快速跳转

### 基础操作
- [API认证配置](01-API完整使用指南.md#2-api认证) → 01文档第2部分
- [第一个查询](04-快速参考手册.md#快速开始) → 04文档
- [错误处理](01-API完整使用指南.md#5-错误处理) → 01文档第5部分

### 端点文档
- [Summary端点](01-API完整使用指南.md#7-summary端点) → 01文档第7部分
- [Electronic Structure](01-API完整使用指南.md#8-电子结构端点) → 01文档第8部分
- [Optical Properties](01-API完整使用指南.md#9-光学性质端点) → 01文档第9部分
- [Magnetism](02-高级端点详解.md#11-磁性性质) → 02文档第11部分
- [Surface Properties](02-高级端点详解.md#12-表面性质) → 02文档第12部分

### 实用工具
- [代码片段库](04-快速参考手册.md#代码片段库) → 04文档
- [批量查询](03-高级功能与最佳实践.md#17-批量查询和数据导出) → 03文档第17部分
- [数据可视化](04-快速参考手册.md#数据可视化) → 04文档
- [性能优化](03-高级功能与最佳实践.md#21-性能优化最佳实践) → 03文档第21部分

### 应用案例
- [半导体筛选](04-快速参考手册.md#6-半导体材料筛选) → 04文档代码片段#6
- [催化剂筛选](04-快速参考手册.md#7-催化剂材料筛选) → 04文档代码片段#7
- [光伏材料完整流程](03-高级功能与最佳实践.md#231-光伏材料筛选完整流程) → 03文档第23部分
- [永磁材料筛选](02-高级端点详解.md#114-应用永磁材料筛选) → 02文档第11部分

---

## 🔗 外部资源

### Materials Project官方
- 主网站: https://materialsproject.org/
- API文档: https://api.materialsproject.org/docs
- 用户指南: https://docs.materialsproject.org/
- GitHub: https://github.com/materialsproject

### Python客户端
```bash
pip install mp-api
```
官方文档: https://github.com/materialsproject/api

### 社区支持
- 论坛: https://matsci.org/materials-project
- 邮件: feedback@materialsproject.org

### 学术论文
Jain, A. et al. "Commentary: The Materials Project: A materials genome approach to accelerating materials innovation." *APL Materials* **1**, 011002 (2013).  
DOI: [10.1063/1.4812323](https://doi.org/10.1063/1.4812323)

---

## 📌 更新记录

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| v1.0 | 2025年10月6日 | 初始版本，包含5个主要文档 |

---

## ⚠️ 重要提示

1. **API密匙安全**: 不要在公开代码中暴露API密匙
2. **速率限制**: 请求间隔至少0.3秒，避免被封禁
3. **数据引用**: 使用数据请引用Materials Project相关论文
4. **版本更新**: API可能更新，定期查看官方文档

---

## 📞 技术支持

遇到问题？请按以下顺序寻求帮助：

1. **查阅本文档** - 99%的常见问题已覆盖
2. **查看FAQ** - 04文档中的常见问题部分
3. **访问官方文档** - https://docs.materialsproject.org/
4. **社区论坛** - https://matsci.org/materials-project
5. **官方支持** - feedback@materialsproject.org

---

**Happy Material Discovery! 🔬✨**

---

*本文档由 Luffy.Solution 编写维护*  
*最后更新: 2025年10月6日*
