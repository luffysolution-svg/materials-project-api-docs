# Materials Project API 官方文档

> Materials Project API 完整使用指南 v1.0  
> 作者: Luffy.Solution  
> 更新日期: 2025年10月6日

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Documentation](https://img.shields.io/badge/docs-latest-brightgreen.svg)](https://github.com/luffysolution-svg/materials-project-api-docs)

---

## 📖 简介

这是一套完整的 **Materials Project API** 中文使用指南，涵盖从基础入门到高级应用的所有内容。无论您是材料科学研究者、数据科学家还是软件开发者，都能在这里找到所需的API使用方法和最佳实践。

### 🎯 Materials Project 简介

[Materials Project](https://materialsproject.org/) 是全球最大的材料数据库之一，包含超过 140,000 种材料的计算数据。通过其强大的 RESTful API，您可以：

- 🔍 搜索和筛选材料
- 📊 获取材料的电子、光学、力学等性质
- 🧪 分析材料的稳定性和相图
- 🔬 设计新型功能材料

---

## 📚 文档结构

本文档集包含 **5个核心文档**，总计约 **200KB** 的详细内容：

### 1. 📘 API完整使用指南
**文件**: `01-API完整使用指南.md` | [PDF版本](01-API完整使用指南.pdf)

从零开始学习 Materials Project API：
- ✅ API基础知识（认证、请求、响应）
- ✅ 4个核心端点详解（Summary、Electronic Structure、Optical、Elasticity）
- ✅ 完整代码示例和可视化方法

**适合**: 初学者到中级用户

---

### 2. 📕 高级端点详解
**文件**: `02-高级端点详解.md` | [PDF版本](02-高级端点详解.pdf)

深入学习专业端点：
- 🧲 Magnetism（磁性性质）- 永磁材料筛选
- 🔬 Surface Properties（表面性质）- 催化剂设计
- ⚡ Piezoelectric、Phonon、Thermodynamics

**适合**: 中级到高级用户

---

### 3. 📗 高级功能与最佳实践
**文件**: `03-高级功能与最佳实践.md` | [PDF版本](03-高级功能与最佳实践.pdf)

掌握高级技巧：
- 🔎 复合条件搜索和结构相似性查询
- 📦 批量查询和分页处理
- ⚡ 性能优化（缓存、并发）
- 🎯 完整工作流示例（光伏材料筛选）

**适合**: 高级用户和系统开发者

---

### 4. 📙 快速参考手册
**文件**: `04-快速参考手册.md` | [PDF版本](04-快速参考手册.pdf)

开发必备速查：
- 📋 7个端点速查表
- 💻 12个即用代码片段
- ❓ 10个常见问题FAQ
- 🔧 单位转换表和晶系速查

**适合**: 所有用户（速查工具）

---

### 5. 🗂️ 文档导航索引
**文件**: `README.md`

完整的导航系统，包含：
- 🎯 根据需求快速定位文档
- 🛠️ 开发工具包配置
- 📖 分阶段学习路径
- 🔗 外部资源链接

---

## 🚀 快速开始

### 前置要求
- Python 3.7+
- Materials Project API 密钥（[免费注册](https://materialsproject.org/api)）

### 最小示例

```python
import requests

API_KEY = "你的API密匙"
BASE_URL = "https://api.materialsproject.org"
headers = {"X-API-KEY": API_KEY}

# 查询 TiO2 的带隙
url = f"{BASE_URL}/materials/summary/"
params = {"formula": "TiO2", "_fields": "material_id,formula_pretty,band_gap"}

response = requests.get(url, headers=headers, params=params)
data = response.json()

for material in data["data"]:
    print(f"{material['formula_pretty']}: {material['band_gap']} eV")
```

### 安装依赖

```bash
pip install requests pandas matplotlib seaborn openpyxl
```

---

## 📊 文档统计

| 指标 | 数量 |
|------|------|
| 总页数 | ~200页 |
| 代码示例 | 60+ |
| 端点覆盖 | 9个主要端点 |
| 应用案例 | 10+ |
| 可视化函数 | 15+ |

---

## 🎓 学习路径

### 🟢 初级（1-2周）
```
📚 01-API完整使用指南（第1-6部分）
↓
💻 运行快速参考手册中的示例
↓
📖 学习 Summary 端点
↓
✅ 完成：按化学式搜索材料
```

### 🟡 中级（2-4周）
```
📚 01-API完整使用指南（第7-10部分）
↓
📊 学习数据可视化方法
↓
🔄 掌握批量查询技术
↓
✅ 完成：半导体材料筛选项目
```

### 🔴 高级（1-2个月）
```
📚 02-高级端点详解（全部）
↓
⚡ 03-高级功能与最佳实践
↓
🎯 实现完整工作流
↓
✅ 完成：专业材料筛选系统
```

---

## 🔧 核心功能

### 材料搜索
```python
# 按化学式搜索
params = {"formula": "TiO2"}

# 按元素组合搜索
params = {"elements": "Ti,O", "nelements": 2}

# 按带隙范围搜索
params = {"band_gap_min": 1.5, "band_gap_max": 3.0}
```

### 性质查询
```python
# 电子结构
url = f"{BASE_URL}/materials/electronic_structure/"

# 光学性质
url = f"{BASE_URL}/materials/dielectric/"

# 力学性质
url = f"{BASE_URL}/materials/elasticity/"
```

### 批量处理
```python
# 批量查询多个材料
params = {"material_ids": "mp-149,mp-30,mp-2534"}
```

---

## 📖 主要端点一览

| 端点 | 功能 | 数据量 | 推荐度 |
|------|------|--------|--------|
| `/materials/summary/` | 基础信息 | ~140,000 | ⭐⭐⭐⭐⭐ |
| `/materials/electronic_structure/` | 电子结构 | ~86,000 | ⭐⭐⭐⭐⭐ |
| `/materials/dielectric/` | 光学性质 | ~8,000 | ⭐⭐⭐⭐ |
| `/materials/elasticity/` | 力学性质 | ~15,000 | ⭐⭐⭐⭐ |
| `/materials/magnetism/` | 磁性性质 | ~50,000 | ⭐⭐⭐⭐ |
| `/materials/surface_properties/` | 表面性质 | ~100,000 | ⭐⭐⭐⭐⭐ |
| `/materials/thermo/` | 热力学 | ~140,000 | ⭐⭐⭐⭐⭐ |

---

## 🎯 应用场景

### 半导体材料研究
- 带隙筛选
- CBM/VBM能级对齐
- 光吸收分析

→ **参考**: 01文档第7-9部分 + 04文档代码片段#6

### 催化剂设计
- 表面能分析
- 功函数计算
- d带中心理论

→ **参考**: 02文档第12部分 + 04文档代码片段#7

### 结构材料
- 弹性模量
- 硬度预测
- 稳定性分析

→ **参考**: 01文档第10部分 + 02文档第15部分

---

## 💡 示例项目

### 1. 光伏材料筛选
```python
# 筛选条件：
# - 带隙 1.0-2.2 eV
# - 稳定相
# - 高光吸收

# 完整代码见：03文档第23部分
```

### 2. 永磁材料发现
```python
# 筛选条件：
# - 铁磁性
# - 高磁化强度
# - 含稀土元素

# 完整代码见：02文档第11.4部分
```

### 3. 催化剂活性预测
```python
# 基于：
# - 表面能
# - 功函数
# - 带隙

# 完整代码见：02文档第12.4部分
```

---

## 🛠️ 工具与资源

### Python客户端
```bash
pip install mp-api
```

官方客户端: https://github.com/materialsproject/api

### 相关资源
- 🌐 [Materials Project 官网](https://materialsproject.org/)
- 📖 [API 交互式文档](https://api.materialsproject.org/docs)
- 💬 [社区论坛](https://matsci.org/materials-project)
- 📧 [技术支持](mailto:feedback@materialsproject.org)

### 学术引用
```bibtex
@article{jain2013commentary,
  title={Commentary: The Materials Project: A materials genome approach to accelerating materials innovation},
  author={Jain, Anubhav and Ong, Shyue Ping and Hautier, Geoffroy and Chen, Wei and Richards, William Davidson and Dacek, Stephen and Cholia, Shreyas and Gunter, Dan and Skinner, David and Ceder, Gerbrand and others},
  journal={APL materials},
  volume={1},
  number={1},
  year={2013},
  publisher={AIP Publishing}
}
```

---

## 📝 使用许可

本文档集采用 [MIT License](LICENSE) 开源协议。

### 免责声明
- 本文档为第三方编写的使用指南，非 Materials Project 官方文档
- Materials Project 数据使用需遵守其[服务条款](https://materialsproject.org/terms)
- 使用 API 获取的数据请引用相关学术论文

---

## 🤝 贡献指南

欢迎贡献！如果您发现错误或有改进建议：

1. 🐛 提交 [Issue](https://github.com/luffysolution-svg/materials-project-api-docs/issues)
2. 🔧 提交 Pull Request
3. 📧 发送邮件至 luffysolution@gmail.com

### 贡献者
- **Luffy.Solution** - *初始创建* - 2025年10月6日

---

## ⭐ Star History

如果这个项目对您有帮助，请给个 Star ⭐！

---

## 📧 联系方式

- **作者**: Luffy.Solution
- **邮箱**: luffysolution@gmail.com
- **GitHub**: [@luffysolution-svg](https://github.com/luffysolution-svg)

---

## 📌 版本历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| v1.0 | 2025年10月6日 | 初始发布，包含5个核心文档 |

---

**Happy Material Discovery! 🔬✨**

*让材料发现变得更简单*

