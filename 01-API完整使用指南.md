# Materials Project API - 完整使用指南

**版本**: v2023  
**文档日期**: 2025年10月6日  
**API基础URL**: https://api.materialsproject.org  
**官方文档**: https://api.materialsproject.org/docs

---

## 📚 目录

### 第一部分：基础知识
1. [API概述](#1-api概述)
2. [认证与访问](#2-认证与访问)
3. [基本请求结构](#3-基本请求结构)
4. [响应格式](#4-响应格式)
5. [错误处理](#5-错误处理)
6. [速率限制](#6-速率限制)

### 第二部分：数据端点详解
7. [材料概要信息 Summary](#7-材料概要信息-summary)
8. [电子结构 Electronic Structure](#8-电子结构-electronic-structure)
9. [光学性质 Dielectric](#9-光学性质-dielectric)
10. [弹性力学 Elasticity](#10-弹性力学-elasticity)
11. [磁性 Magnetism](#11-磁性-magnetism)
12. [表面性质 Surface Properties](#12-表面性质-surface-properties)
13. [压电性质 Piezoelectric](#13-压电性质-piezoelectric)
14. [声子 Phonon](#14-声子-phonon)
15. [热力学 Thermodynamics](#15-热力学-thermodynamics)

### 第三部分：高级功能
16. [搜索与过滤](#16-搜索与过滤)
17. [分页与排序](#17-分页与排序)
18. [批量查询](#18-批量查询)
19. [相图查询](#19-相图查询)
20. [合成信息](#20-合成信息)

### 第四部分：实践应用
21. [半导体材料筛选](#21-半导体材料筛选)
22. [催化剂材料设计](#22-催化剂材料设计)
23. [电池材料研究](#23-电池材料研究)
24. [磁性材料分析](#24-磁性材料分析)

### 第五部分：最佳实践
25. [性能优化](#25-性能优化)
26. [数据缓存](#26-数据缓存)
27. [错误处理策略](#27-错误处理策略)
28. [Python客户端使用](#28-python客户端使用)

---

## 第一部分：基础知识

### 1. API概述

Materials Project 是一个基于高通量密度泛函理论(DFT)计算的材料数据库，包含超过140,000种材料的性质数据。

**数据库规模**:
- 材料总数: ~140,000+
- 电子结构数据: ~140,000
- 光学数据: ~15,000
- 弹性数据: ~13,000
- 磁性数据: ~50,000
- 表面性质: ~100,000

**计算方法**:
- DFT框架: VASP (Vienna Ab initio Simulation Package)
- 交换关联泛函: GGA-PBE, GGA+U
- 赝势: PAW (Projector Augmented Wave)

**数据更新频率**: 持续更新

---

### 2. 认证与访问

#### 2.1 获取API密钥

1. 访问 https://materialsproject.org/
2. 注册账号（免费）
3. 登录后进入 Dashboard
4. 在 API 部分生成密钥

**示例密钥格式**: `YOUR_API_KEY_HERE` (替换为您的真实API密钥)

> ⚠️ **安全提示**: 请勿在公开文档或代码中暴露真实的API密钥！

#### 2.2 使用API密钥

**方式1: Header认证**（推荐）
```python
headers = {
    "X-API-KEY": "your_api_key_here",
    "accept": "application/json"
}
response = requests.get(url, headers=headers)
```

**方式2: 查询参数**
```python
params = {
    "API_KEY": "your_api_key_here"
}
response = requests.get(url, params=params)
```

#### 2.3 测试连接

```python
import requests

API_KEY = "your_api_key_here"
BASE_URL = "https://api.materialsproject.org"

headers = {"X-API-KEY": API_KEY}
url = f"{BASE_URL}/materials/summary/"
params = {"formula": "Si", "_limit": 1}

response = requests.get(url, headers=headers, params=params)
print(response.status_code)  # 应该返回 200
```

---

### 3. 基本请求结构

#### 3.1 URL结构

```
https://api.materialsproject.org/{endpoint}/{path}?{parameters}
```

**组成部分**:
- `endpoint`: 数据类型（如 materials, reactions, molecules）
- `path`: 子路径（如 summary, electronic_structure）
- `parameters`: 查询参数

#### 3.2 常用参数

| 参数 | 说明 | 示例 |
|------|------|------|
| `material_ids` | 材料ID列表 | `mp-149,mp-672` |
| `formula` | 化学式 | `TiO2` |
| `chemsys` | 化学体系 | `Ti-O` |
| `elements` | 包含的元素 | `Ti,O` |
| `_limit` | 返回数量限制 | `100` |
| `_skip` | 跳过数量 | `0` |
| `_fields` | 返回字段 | `material_id,band_gap` |
| `_sort_fields` | 排序字段 | `band_gap` |
| `_ascending` | 升序/降序 | `true` |

#### 3.3 请求示例

```python
# 示例1: 根据化学式查询
url = f"{BASE_URL}/materials/summary/"
params = {
    "formula": "TiO2",
    "_fields": "material_id,formula_pretty,band_gap",
    "_limit": 5
}

# 示例2: 根据材料ID查询
url = f"{BASE_URL}/materials/electronic_structure/"
params = {
    "material_ids": "mp-149",
    "_fields": "material_id,band_gap,cbm,vbm"
}

# 示例3: 根据元素查询
url = f"{BASE_URL}/materials/summary/"
params = {
    "elements": "Ti,O",
    "nelements": 2,  # 恰好2种元素
    "_limit": 10
}
```

---

### 4. 响应格式

#### 4.1 标准响应结构

```json
{
  "data": [
    {
      "material_id": "mp-149",
      "formula_pretty": "Si",
      "band_gap": 0.6133,
      ...
    }
  ],
  "meta": {
    "total_doc": 1,
    "max_limit": 1000,
    "default_fields": ["material_id", "formula_pretty"],
    "api_version": "0.37.4"
  }
}
```

**字段说明**:
- `data`: 结果数据数组
- `meta`: 元数据信息
  - `total_doc`: 总文档数
  - `max_limit`: 最大限制
  - `api_version`: API版本

#### 4.2 处理响应

```python
response = requests.get(url, headers=headers, params=params)

if response.status_code == 200:
    data = response.json()
    
    # 获取结果
    results = data.get("data", [])
    
    # 获取元数据
    meta = data.get("meta", {})
    total = meta.get("total_doc", 0)
    
    print(f"找到 {total} 个结果")
    
    for item in results:
        print(f"Material ID: {item['material_id']}")
        print(f"Formula: {item.get('formula_pretty', 'N/A')}")
else:
    print(f"错误: {response.status_code}")
    print(response.text)
```

---

### 5. 错误处理

#### 5.1 常见HTTP状态码

| 状态码 | 说明 | 原因 |
|--------|------|------|
| 200 | 成功 | 请求成功 |
| 400 | 错误请求 | 参数错误 |
| 401 | 未授权 | API密钥无效 |
| 404 | 未找到 | 端点或资源不存在 |
| 429 | 请求过多 | 超出速率限制 |
| 500 | 服务器错误 | 服务器内部错误 |

#### 5.2 错误响应格式

```json
{
  "detail": "错误描述信息"
}
```

#### 5.3 错误处理代码

```python
import time
from requests.exceptions import RequestException

def safe_request(url, headers, params, max_retries=3):
    """
    带重试的安全请求
    """
    for attempt in range(max_retries):
        try:
            response = requests.get(
                url, 
                headers=headers, 
                params=params,
                timeout=30
            )
            
            if response.status_code == 200:
                return response.json()
            elif response.status_code == 429:
                # 速率限制，等待后重试
                wait_time = 2 ** attempt  # 指数退避
                print(f"速率限制，等待 {wait_time} 秒...")
                time.sleep(wait_time)
            elif response.status_code == 404:
                print("资源不存在")
                return None
            else:
                print(f"错误 {response.status_code}: {response.text}")
                return None
                
        except RequestException as e:
            print(f"请求异常: {e}")
            if attempt < max_retries - 1:
                time.sleep(2 ** attempt)
            else:
                return None
    
    return None
```

---

### 6. 速率限制

#### 6.1 限制说明

Materials Project API 有以下速率限制：

- **标准账户**: 
  - ~1000 请求/小时
  - ~5 并发请求
  
- **学术账户** (申请后):
  - 更高的请求限制
  - 优先访问权

#### 6.2 避免速率限制

**策略1: 请求间隔**
```python
import time

def batch_query(material_ids, delay=0.5):
    """
    批量查询，带延迟
    """
    results = []
    for material_id in material_ids:
        result = query_material(material_id)
        results.append(result)
        time.sleep(delay)  # 延迟0.5秒
    return results
```

**策略2: 批量请求**
```python
# 不推荐: 多次单独请求
for material_id in ["mp-1", "mp-2", "mp-3"]:
    query_material(material_id)

# 推荐: 批量请求
material_ids = "mp-1,mp-2,mp-3"
query_materials(material_ids)
```

**策略3: 字段选择**
```python
# 不推荐: 获取所有字段
params = {}

# 推荐: 只获取需要的字段
params = {
    "_fields": "material_id,band_gap,density"
}
```

---

## 第二部分：数据端点详解

### 7. 材料概要信息 (Summary)

#### 7.1 端点信息

**URL**: `/materials/summary/`  
**用途**: 获取材料的基础信息和常用属性  
**数据覆盖**: ~140,000 材料

#### 7.2 可用字段

**基础信息**:
```python
"material_id"              # 材料ID
"formula_pretty"           # 标准化学式
"elements"                 # 元素列表
"nelements"                # 元素数量
"nsites"                   # 原子位点数
"composition"              # 详细成分
"composition_reduced"      # 简化成分
"chemsys"                  # 化学体系
```

**结构信息**:
```python
"volume"                   # 体积 (Å³)
"density"                  # 密度 (g/cm³)
"density_atomic"           # 原子密度
"symmetry"                 # 对称性信息
  - "crystal_system"       # 晶系
  - "symbol"               # 空间群符号
  - "number"               # 空间群编号
  - "point_group"          # 点群
```

**电子性质**:
```python
"band_gap"                 # 带隙 (eV)
"is_gap_direct"            # 是否直接带隙
"is_metal"                 # 是否金属
"efermi"                   # 费米能级 (eV)
```

**稳定性**:
```python
"is_stable"                # 是否稳定
"energy_above_hull"        # 能量高于凸包 (eV/atom)
"formation_energy_per_atom" # 形成能 (eV/atom)
"energy_per_atom"          # 每原子能量 (eV)
"equilibrium_reaction_energy_per_atom"  # 平衡反应能
"decomposes_to"            # 分解产物
```

**表面性质**:
```python
"surface_anisotropy"       # 表面各向异性
"shape_factor"             # 形状因子
"weighted_surface_energy"  # 加权表面能 (J/m²)
"weighted_work_function"   # 加权功函数 (eV)
```

**其他**:
```python
"theoretical"              # 是否理论计算
"database_IDs"             # 其他数据库ID
  - "icsd_ids"             # ICSD数据库ID
  - "cod_ids"              # COD数据库ID
"has_props"                # 拥有的性质列表
"last_updated"             # 最后更新时间
```

#### 7.3 查询示例

**示例1: 基础查询**
```python
url = f"{BASE_URL}/materials/summary/"
params = {
    "formula": "TiO2",
    "_fields": "material_id,formula_pretty,band_gap,density,symmetry",
    "_limit": 5
}

response = requests.get(url, headers=headers, params=params)
data = response.json()

for item in data["data"]:
    print(f"ID: {item['material_id']}")
    print(f"Formula: {item['formula_pretty']}")
    print(f"Band Gap: {item.get('band_gap', 'N/A')} eV")
    print(f"Density: {item.get('density', 'N/A')} g/cm³")
    symmetry = item.get('symmetry', {})
    print(f"Crystal System: {symmetry.get('crystal_system', 'N/A')}")
    print("-" * 50)
```

**示例2: 过滤稳定相**
```python
params = {
    "formula": "TiO2",
    "is_stable": True,
    "_fields": "material_id,formula_pretty,band_gap,energy_above_hull"
}
```

**示例3: 化学体系查询**
```python
params = {
    "chemsys": "Ti-O",      # Ti和O的所有组合
    "is_stable": True,
    "nelements": 2,         # 恰好2种元素
    "_sort_fields": "formation_energy_per_atom",
    "_limit": 10
}
```

#### 7.4 实用函数

```python
def get_material_summary(formula, stable_only=True):
    """
    获取材料概要信息
    """
    url = f"{BASE_URL}/materials/summary/"
    params = {
        "formula": formula,
        "_fields": "material_id,formula_pretty,band_gap,density," + \
                   "is_stable,energy_above_hull,symmetry",
        "_limit": 10
    }
    
    if stable_only:
        params["is_stable"] = True
    
    response = requests.get(url, headers=headers, params=params, timeout=30)
    
    if response.status_code == 200:
        data = response.json()
        return data.get("data", [])
    else:
        print(f"错误: {response.status_code}")
        return []

# 使用示例
materials = get_material_summary("TiO2", stable_only=True)
for mat in materials:
    print(f"{mat['formula_pretty']} ({mat['material_id']}): " +
          f"带隙 {mat.get('band_gap', 'N/A')} eV")
```

---

### 8. 电子结构 (Electronic Structure)

#### 8.1 端点信息

**URL**: `/materials/electronic_structure/`  
**用途**: 获取详细的电子结构信息  
**数据覆盖**: ~140,000 材料

#### 8.2 可用字段

**基础电子性质**:
```python
"material_id"              # 材料ID
"band_gap"                 # 带隙 (eV)
"cbm"                      # 导带最小值 (eV)
"vbm"                      # 价带最大值 (eV)
"efermi"                   # 费米能级 (eV)
"is_gap_direct"            # 是否直接带隙
"is_metal"                 # 是否金属
"magnetic_ordering"        # 磁序
```

**态密度 (DOS)**:
```python
"dos"                      # 完整态密度对象
  - "energies"             # 能量点列表
  - "densities"            # 态密度值
  - "pdos"                 # 投影态密度
"dos_energy_up"            # 自旋向上能量
"dos_energy_down"          # 自旋向下能量
```

**能带结构**:
```python
"bandstructure"            # 能带结构对象
  - "kpoints"              # k点路径
  - "bands"                # 能带数据
  - "is_spin_polarized"    # 是否自旋极化
"band_gap_direct"          # 直接带隙位置
```

继续创建完整指南...

<function_calls>
<invoke name="create_file">
<parameter name="content"># Materials Project API - 数据端点详解 (续)

## 8. 电子结构 (Electronic Structure) - 续

#### 8.3 查询示例

**示例1: 获取基础能带信息**
```python
url = f"{BASE_URL}/materials/electronic_structure/"
params = {
    "material_ids": "mp-149",  # 硅
    "_fields": "material_id,band_gap,cbm,vbm,efermi,is_gap_direct"
}

response = requests.get(url, headers=headers, params=params)
data = response.json()["data"][0]

print(f"材料: {data['material_id']}")
print(f"带隙: {data['band_gap']} eV")
print(f"导带底 (CBM): {data['cbm']} eV")
print(f"价带顶 (VBM): {data['vbm']} eV")
print(f"费米能级: {data['efermi']} eV")
print(f"直接带隙: {'是' if data['is_gap_direct'] else '否'}")
```

**示例2: 获取态密度数据**
```python
params = {
    "material_ids": "mp-149",
    "_fields": "material_id,dos"
}

response = requests.get(url, headers=headers, params=params)
data = response.json()["data"][0]

dos = data.get("dos", {})
if dos:
    energies = dos.get("energies", [])
    densities = dos.get("densities", {})
    
    print(f"能量点数: {len(energies)}")
    print(f"DOS数据: {densities.keys()}")
```

#### 8.4 DOS数据处理与可视化

```python
import matplotlib.pyplot as plt
import numpy as np

def plot_dos(material_id):
    """
    绘制态密度图
    """
    url = f"{BASE_URL}/materials/electronic_structure/"
    params = {
        "material_ids": material_id,
        "_fields": "material_id,dos,efermi"
    }
    
    response = requests.get(url, headers=headers, params=params)
    data = response.json()["data"][0]
    
    dos = data.get("dos", {})
    efermi = data.get("efermi", 0)
    
    if not dos:
        print("无DOS数据")
        return
    
    energies = np.array(dos["energies"]) - efermi  # 相对费米能级
    total_dos = np.array(dos["densities"]["total"])
    
    plt.figure(figsize=(10, 6))
    plt.plot(energies, total_dos, 'b-', linewidth=2)
    plt.axvline(x=0, color='r', linestyle='--', label='Fermi Level')
    plt.xlabel('E - E_F (eV)', fontsize=12)
    plt.ylabel('DOS (states/eV)', fontsize=12)
    plt.title(f'Density of States: {material_id}', fontsize=14)
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(f'DOS_{material_id}.png', dpi=300)
    plt.show()

# 使用示例
plot_dos("mp-149")
```

---

## 9. 光学性质 (Dielectric)

#### 9.1 端点信息

**URL**: `/materials/dielectric/`  
**用途**: 获取介电常数、折射率、光学吸收等性质  
**数据覆盖**: ~15,000 材料  
**重要性**: ⭐⭐⭐⭐⭐ 对半导体、光电材料特别重要

#### 9.2 可用字段

**介电性质**:
```python
"material_id"              # 材料ID
"e_total"                  # 总介电常数 (静态)
"e_electronic"             # 电子贡献的介电常数
"e_ionic"                  # 离子贡献的介电常数
"n"                        # 折射率 (光学频率)
"e_ij_max"                 # 最大介电张量分量
```

**频率依赖性质**:
```python
"dielectric"               # 完整介电函数对象
  - "real"                 # 实部 (ε₁)
  - "imag"                 # 虚部 (ε₂)
  - "energy"               # 能量/频率范围
```

**光学性质**:
```python
"refractive_index"         # 折射率 vs 频率
"absorption_coefficient"   # 吸收系数 (cm⁻¹)
"reflectivity"             # 反射率
"optical_conductivity"     # 光学电导率
"loss_function"            # 损耗函数 (-Im[1/ε])
```

**多晶平均值**:
```python
"poly_total"               # 多晶总介电常数
"poly_electronic"          # 多晶电子介电常数
"poly_ionic"               # 多晶离子介电常数
```

**铁电性**:
```python
"pot_ferroelectric"        # 是否潜在铁电材料
```

#### 9.3 查询示例

**示例1: 获取基础光学参数**
```python
url = f"{BASE_URL}/materials/dielectric/"
params = {
    "material_ids": "mp-672",  # CdS
    "_fields": "material_id,n,e_total,e_electronic,e_ionic"
}

response = requests.get(url, headers=headers, params=params)
if response.status_code == 200:
    data = response.json()["data"][0]
    
    print(f"材料: {data['material_id']}")
    print(f"折射率: {data.get('n', 'N/A')}")
    print(f"总介电常数: {data.get('e_total', 'N/A')}")
    print(f"电子介电常数: {data.get('e_electronic', 'N/A')}")
    print(f"离子介电常数: {data.get('e_ionic', 'N/A')}")
```

**示例2: 获取吸收光谱数据**
```python
params = {
    "material_ids": "mp-672",
    "_fields": "material_id,dielectric"
}

response = requests.get(url, headers=headers, params=params)
data = response.json()["data"][0]

dielectric = data.get("dielectric", {})
if dielectric:
    energy = dielectric.get("energy", [])
    epsilon_real = dielectric.get("real", [])
    epsilon_imag = dielectric.get("imag", [])
    
    # 吸收系数 α = (2ω/c) * Im[√ε]
    # 或直接使用ε₂
    print(f"能量范围: {min(energy)} - {max(energy)} eV")
    print(f"数据点数: {len(energy)}")
```

#### 9.4 光学性质可视化

```python
def plot_optical_properties(material_id):
    """
    绘制光学性质图
    """
    url = f"{BASE_URL}/materials/dielectric/"
    params = {
        "material_ids": material_id,
        "_fields": "material_id,dielectric"
    }
    
    response = requests.get(url, headers=headers, params=params)
    if response.status_code != 200:
        print("无光学数据")
        return
    
    data = response.json()["data"][0]
    dielectric = data.get("dielectric", {})
    
    if not dielectric:
        return
    
    energy = np.array(dielectric["energy"])
    epsilon_real = np.array(dielectric["real"])
    epsilon_imag = np.array(dielectric["imag"])
    
    # 计算折射率和消光系数
    # n + ik = √ε
    n = np.sqrt((epsilon_real + np.sqrt(epsilon_real**2 + epsilon_imag**2))/2)
    k = np.sqrt((-epsilon_real + np.sqrt(epsilon_real**2 + epsilon_imag**2))/2)
    
    # 吸收系数 α = 4πk/λ = 2ωk/c
    alpha = 4 * np.pi * k / (1.24 / energy) * 1e7  # cm⁻¹
    
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))
    
    # 介电函数
    axes[0, 0].plot(energy, epsilon_real, 'b-', label='ε₁ (real)')
    axes[0, 0].plot(energy, epsilon_imag, 'r-', label='ε₂ (imag)')
    axes[0, 0].set_xlabel('Energy (eV)')
    axes[0, 0].set_ylabel('Dielectric Function')
    axes[0, 0].set_title('Dielectric Function')
    axes[0, 0].legend()
    axes[0, 0].grid(True, alpha=0.3)
    
    # 折射率
    axes[0, 1].plot(energy, n, 'g-', linewidth=2)
    axes[0, 1].set_xlabel('Energy (eV)')
    axes[0, 1].set_ylabel('Refractive Index (n)')
    axes[0, 1].set_title('Refractive Index')
    axes[0, 1].grid(True, alpha=0.3)
    
    # 消光系数
    axes[1, 0].plot(energy, k, 'm-', linewidth=2)
    axes[1, 0].set_xlabel('Energy (eV)')
    axes[1, 0].set_ylabel('Extinction Coefficient (k)')
    axes[1, 0].set_title('Extinction Coefficient')
    axes[1, 0].grid(True, alpha=0.3)
    
    # 吸收系数
    axes[1, 1].plot(energy, alpha, 'c-', linewidth=2)
    axes[1, 1].set_xlabel('Energy (eV)')
    axes[1, 1].set_ylabel('Absorption Coefficient (cm⁻¹)')
    axes[1, 1].set_title('Absorption Coefficient')
    axes[1, 1].set_yscale('log')
    axes[1, 1].grid(True, alpha=0.3)
    
    plt.suptitle(f'Optical Properties: {material_id}', fontsize=16)
    plt.tight_layout()
    plt.savefig(f'Optical_{material_id}.png', dpi=300)
    plt.show()

# 使用示例
plot_optical_properties("mp-672")  # CdS
```

#### 9.5 应用：光伏材料筛选

```python
def screen_photovoltaic_materials():
    """
    筛选潜在的光伏材料
    标准: 
    - 带隙 1.0-1.8 eV (最优 ~1.4 eV Shockley-Queisser)
    - 稳定相
    - 高吸收系数
    """
    url_summary = f"{BASE_URL}/materials/summary/"
    params = {
        "band_gap_min": 1.0,
        "band_gap_max": 1.8,
        "is_stable": True,
        "nelements_max": 3,
        "_fields": "material_id,formula_pretty,band_gap",
        "_limit": 50,
        "_sort_fields": "band_gap"
    }
    
    response = requests.get(url_summary, headers=headers, params=params)
    candidates = response.json()["data"]
    
    print(f"找到 {len(candidates)} 个候选材料\n")
    
    results = []
    for mat in candidates:
        material_id = mat["material_id"]
        
        # 检查是否有光学数据
        url_optical = f"{BASE_URL}/materials/dielectric/"
        optical_params = {
            "material_ids": material_id,
            "_fields": "material_id,n,e_total"
        }
        
        opt_response = requests.get(url_optical, headers=headers, 
                                   params=optical_params)
        
        if opt_response.status_code == 200:
            opt_data = opt_response.json()["data"]
            if opt_data:
                n = opt_data[0].get("n")
                results.append({
                    "material_id": material_id,
                    "formula": mat["formula_pretty"],
                    "band_gap": mat["band_gap"],
                    "refractive_index": n
                })
        
        time.sleep(0.5)  # 避免速率限制
    
    # 排序并输出
    results.sort(key=lambda x: abs(x["band_gap"] - 1.4))  # 接近最优带隙
    
    print("前10个候选光伏材料:")
    print("-" * 70)
    for i, mat in enumerate(results[:10], 1):
        print(f"{i}. {mat['formula']:<15} (ID: {mat['material_id']:<12}) "
              f"带隙: {mat['band_gap']:.2f} eV, "
              f"折射率: {mat.get('refractive_index', 'N/A')}")
    
    return results
```

---

## 10. 弹性力学 (Elasticity)

#### 10.1 端点信息

**URL**: `/materials/elasticity/`  
**用途**: 获取弹性张量、模量等力学性质  
**数据覆盖**: ~13,000 材料  
**重要性**: ⭐⭐⭐⭐ 对结构材料、涂层重要

#### 10.2 可用字段

**弹性张量**:
```python
"material_id"              # 材料ID
"elastic_tensor"           # 弹性张量 (Voigt表示，6x6矩阵)
"elastic_tensor_original"  # 原始弹性张量
"compliance_tensor"        # 柔顺张量 (弹性张量的逆)
```

**弹性模量**:
```python
"k_voigt"                  # Voigt体积模量 (GPa)
"k_reuss"                  # Reuss体积模量 (GPa)
"k_vrh"                    # VRH体积模量 (GPa) - 推荐使用
"g_voigt"                  # Voigt剪切模量 (GPa)
"g_reuss"                  # Reuss剪切模量 (GPa)
"g_vrh"                    # VRH剪切模量 (GPa) - 推荐使用
"bulk_modulus"             # 体积模量 (别名)
"shear_modulus"            # 剪切模量 (别名)
```

**工程性质**:
```python
"universal_anisotropy"     # 各向异性因子
"homogeneous_poisson"      # 均匀泊松比
"youngs_modulus"           # 杨氏模量 (GPa)
"poisson_ratio"            # 泊松比
```

**说明**:
- Voigt: 上界估计（假设均匀应变）
- Reuss: 下界估计（假设均匀应力）
- VRH: Voigt-Reuss-Hill平均，通常最接近实验值

#### 10.3 查询示例

**示例1: 获取基础弹性性质**
```python
url = f"{BASE_URL}/materials/elasticity/"
params = {
    "material_ids": "mp-149",  # 硅
    "_fields": "material_id,k_vrh,g_vrh,universal_anisotropy,homogeneous_poisson"
}

response = requests.get(url, headers=headers, params=params)
if response.status_code == 200:
    data = response.json()["data"][0]
    
    print(f"材料: {data['material_id']}")
    print(f"体积模量 (K_VRH): {data['k_vrh']:.2f} GPa")
    print(f"剪切模量 (G_VRH): {data['g_vrh']:.2f} GPa")
    print(f"各向异性: {data['universal_anisotropy']:.2f}")
    print(f"泊松比: {data['homogeneous_poisson']:.3f}")
```

**示例2: 计算派生性质**
```python
def calculate_mechanical_properties(k_vrh, g_vrh):
    """
    从体积模量和剪切模量计算其他力学性质
    """
    # 杨氏模量: E = 9KG / (3K + G)
    E = (9 * k_vrh * g_vrh) / (3 * k_vrh + g_vrh)
    
    # 泊松比: ν = (3K - 2G) / (6K + 2G)
    nu = (3 * k_vrh - 2 * g_vrh) / (6 * k_vrh + 2 * g_vrh)
    
    # 纵波速度: v_l = √((K + 4G/3)/ρ)
    # 横波速度: v_t = √(G/ρ)
    
    # 维氏硬度 (经验公式，Tian 2012)
    if g_vrh > 0:
        HV = 0.92 * k_vrh**0.708 * g_vrh**0.708
    else:
        HV = 0
    
    # Pugh比 (延展性指标)
    pugh_ratio = k_vrh / g_vrh
    # > 1.75: 延展性好
    # < 1.75: 脆性材料
    
    return {
        "youngs_modulus": E,
        "poisson_ratio": nu,
        "vickers_hardness": HV,
        "pugh_ratio": pugh_ratio,
        "ductile": pugh_ratio > 1.75
    }

# 使用示例
k = 100  # GPa
g = 50   # GPa
props = calculate_mechanical_properties(k, g)
print(f"杨氏模量: {props['youngs_modulus']:.2f} GPa")
print(f"泊松比: {props['poisson_ratio']:.3f}")
print(f"维氏硬度: {props['vickers_hardness']:.2f} GPa")
print(f"Pugh比: {props['pugh_ratio']:.2f}")
print(f"材料类型: {'延展性' if props['ductile'] else '脆性'}")
```

#### 10.4 应用：硬质涂层材料筛选

```python
def screen_hard_coating_materials():
    """
    筛选硬质涂层材料
    标准:
    - 高剪切模量 (G > 100 GPa)
    - 高体积模量 (K > 200 GPa)
    - 低各向异性 (< 1.5)
    """
    url = f"{BASE_URL}/materials/elasticity/"
    params = {
        "g_vrh_min": 100,
        "k_vrh_min": 200,
        "_fields": "material_id,k_vrh,g_vrh,universal_anisotropy",
        "_limit": 100,
        "_sort_fields": "g_vrh",
        "_ascending": False  # 降序
    }
    
    response = requests.get(url, headers=headers, params=params)
    candidates = response.json()["data"]
    
    # 过滤低各向异性材料
    results = [mat for mat in candidates 
               if mat.get('universal_anisotropy', 999) < 1.5]
    
    print(f"找到 {len(results)} 个候选硬质涂层材料\n")
    print("前10个候选材料:")
    print("-" * 80)
    
    for i, mat in enumerate(results[:10], 1):
        k = mat['k_vrh']
        g = mat['g_vrh']
        props = calculate_mechanical_properties(k, g)
        
        print(f"{i}. {mat['material_id']:<12}")
        print(f"   K: {k:.1f} GPa, G: {g:.1f} GPa, "
              f"各向异性: {mat.get('universal_anisotropy', 'N/A'):.2f}")
        print(f"   维氏硬度(估算): {props['vickers_hardness']:.1f} GPa")
        print()
    
    return results
```

---

本文档将继续创建更多章节...
