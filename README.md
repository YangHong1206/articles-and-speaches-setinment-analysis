# 🔍 文本情感显微镜 |  Speech and articles Emotion and sentiment Analyzer  
**基于段落动态分割的NRC情感分析工具**  
→ [在线Demo] | [API文档] | [政策分析案例库] ←  

---

## 🌟 项目价值：从数据迷雾到决策洞察  
**传统工具瓶颈**：  
❌ 单一情感标签（如"正面"）无法解析复杂演讲和文章中的 **矛盾情绪共存现象**  
❌ 静态全局分析忽视 **关键段落的情绪爆发点**（如危机声明中的恐惧峰值）  

**我们的突破**：  
✅ **动态段落追踪**：基于你的需求自由分割文本（1-10句/段），捕捉情绪演变细节  
✅ **冲突情绪解构**：识别同一段落中的对抗性情绪（如段落7：愤怒6.2 + 信任4.5）  
✅ **政策影响评估**：通过情绪波动指数预判读者接受度  

![trump_speech](https://github.com/user-attachments/assets/d21a940d-50df-4e44-8a34-e3854c447eb5)

  
*▲ 应用案例：川普25年就职演讲分析（段落=6句/段）*  
- **​​开篇震慑**：愤怒（anger）主导​​：首段愤怒值达 ​​7.5峰值​​，关键词推测为 "腐败"、"衰落"，通过制造危机感建立变革合法性。信任（trust）同步启动​​：首段信任值 ​​5.0​​，配合 "我们人民"、"复兴" 等词，形成 ​​“破旧立新”框架​​。  
- **中间段信任锚点**：信任均匀分布​​（均值4.5-5.0），高频词可能为 "历史"、"承诺"、"强大"，塑造可靠领袖形象。
​​恐惧（fear）精准插入​​：段落8恐惧值 ​​3.8​​，可能关联移民或经济威胁论述，但迅速被信任值回升对冲。
- **终章希望引爆**：​​期待（anticipation）登顶​​：段落14达 ​​7.5​​，关键词如 "重建"、"胜利"，激活集体行动意愿。
​​喜悦（joy）集中爆发​​：末段喜悦值 ​​6.2​​，配合 "伟大"、"骄傲"，完成情绪收束。

- **冲突情绪操控：数据揭示的暗线**
- ​​愤怒与信任的共生​​：首段愤怒（7.5）与信任（5.0）双高，体现 ​​“敌人-救世主”二元叙事​​（腐败旧势力 vs 人民自救）。
- 厌恶（disgust）的战术性使用​​：段落3、7出现分散厌恶值（2.5-3.0），可能用于贬低对手（如 "失败政策"），但避免过度引发反感。

---

## 🛠️ 技术亮点：透明、可解释、合规  

### 1. 政策分析师友好设计  
![sentences_paragraph](https://github.com/user-attachments/assets/956f0028-eadb-47bc-b7a5-9e9540ea4042)
```r
# 动态段落分割（用户可调参数）
sliderInput("n_sentences_paragraph", "Set Sentences per Paragraph", 1, 10, 6)
```
- **灵活适应场景**：  
  | 段落长度 | 适用场景                  |  
  |----------|-------------------------|  
  | 1句/段   | 短声明/口号精准分析       |  
  | 6句/段   | 议会辩论段落情绪追踪      |  
  | 10句/段  | 白皮书长章节宏观趋势分析  |  

### 2. 企业级部署保障  
- **GDPR合规**：数据本地处理，审计日志自动加密  
--

## 📊 应用场景：从数据到决策  

### 场景1：政策演讲优化  
1. 上传草案 → 识别高恐惧段落 → 修改敏感措辞  
2. 对比修改前后情绪曲线 → 量化公众情绪改善率  

### 场景2：跨党派策略分析  
```csv
# 输入样例（多文件批量处理）
partyA_manifesto.csv, partyB_speech.txt, partyC_policy.docx
```
- **可视化对比**：  
  ![多文档情绪对比图]  
  *不同政党在 "医疗改革" 议题中的情绪倾向差异*  

---

## 🚀 快速开始  
### 步骤1：安装  
```r
# 方案A：Shiny本地运行（开发模式）
install.packages(c("shiny", "tidytext", "textdata"))
shiny::runGitHub("your_repo")


### 步骤2：核心操作演示  
1. 粘贴演讲文本 → 设置段落长度（默认6句）  
2. 下载Excel报告（含段落级情绪热力图）  
3. 点击图表峰值查看触发词 → 导出PDF决策简报  

---

## 📜 文档与合规   
- [技术白皮书]：情绪算法可解释性证明  
- [政策分析案例]：2019-2023议会辩论情绪年鉴  

---

## 开发者承诺  
> "我们坚信：**情绪数据应是透明的、可追溯的、服务于公共利益的**"  
> —— 通过开源代码践行这一使命  






# 🔍 政治文本情感显微镜 | Policy Text Emotion Profiler  
**基于动态段落分割的NRC情感分析系统 | NRC Sentiment Analysis with Dynamic Segmentation**  

---

## 🌟 为什么选择这个工具？ | Why Choose This Tool?  
### 中文版  
**传统工具瓶颈**：  
❌ 单一情感标签无法解析复杂演讲和文章中的 **矛盾情绪共存现象**  
❌ 静态全局分析忽视 **关键段落的情绪爆发点**（如危机声明中的恐惧峰值）  

**核心创新**：  
✅ **动态段落追踪**：自由分割文本（1-10句/段），捕捉情绪演变细节  
✅ **冲突情绪解构**：识别同一段落中的对抗性情绪（如段落7：愤怒6.2 + 信任4.5）  

---

### English Version
**Limitations of Traditional Tools**:  
❌ Single emotion labels fail to **detect mixed feelings** in speeches and articles  
❌ Fixed-length analysis misses **critical emotional spikes** (e.g. fear surge in crisis statements)  

**Key Innovations**:  
✅ **Dynamic Paragraph Tracking**: Split text flexibly (1-10 sentences/para) to reveal emotional shifts  
✅ **Conflicting Emotion Detection**: Identify opposing feelings in the same paragraph (e.g. Para7: Anger 6.2 + Trust 4.5)  

![情感分布案例 | Case Study]

---

## 🛠️ 技术亮点 | Technical Features  
### 中文版  
```r
# 动态段落分割（用户可调参数）  
sliderInput("n_sentences_paragraph", "设置每段句子数", 1, 10, 6)
```  
**应用场景适配**：  
| 段落长度 | 适用场景                  |  
|----------|-------------------------|  
| 1句/段   | 短声明/口号精准分析       |  
| 6句/段   | 议会辩论段落情绪追踪      |  

---

### English Version
```r
# Dynamic paragraph control  
sliderInput("n_sentences_paragraph", "Sentences per Paragraph", 1, 10, 6)
```  
**Scenario Adaptability**:  
| Paragraph Length | Best For                   |  
|------------------|---------------------------|  
| 1 sentence       | Short slogans/statements  |  
| 6 sentences      | Parliamentary debates     |  

---

## 📊 快速开始 | Quick Start  
### 中文版  
```bash
# Docker一键部署（推荐生产环境）  
docker run -p 3838:3838 yourname/policy-emotion:latest
```  
**三步分析法**：  
1. 上传文档 → 2. 调整段落长度 → 3. 下载PDF报告  

---

### English Version (IELTS 6.5+)  
```bash
# One-click Docker deployment  
docker run -p 3838:3838 yourname/policy-emotion:latest
```  
**3-Step Analysis**:  
1. Upload files → 2. Adjust paragraph length → 3. Export PDF reports  

---

## ⚠️ 注意事项 | Critical Notes  
1. **术语一致性**：英文版保留专业术语原文（如NRC, GDPR）  
2. **文化差异处理**：将"议会"统一译为"Parliament"而非"Congress"  
3. **可访问性**：添加`alt text`描述所有图表（满足WCAG 2.1标准）  
```mark
