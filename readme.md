<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [哈　尔　滨　工　业　大　学](#哈　尔　滨　工　业　大　学)
- [PlutoThesis硕博士学位论文XeLaTeX模版](#plutothesis硕博士学位论文xelatex模版)
  - [模板介绍](#版本介绍)
    - [关于版本](#关于版本)
    - [关于字体](#关于字体)
    - [关于查重](#关于查重)
    - [关于编译](#关于编译)
    - [关于维护者以及捐赠](#关于维护者以及捐赠)
  - [这个网站的使用说明](#这个网站的使用说明)
    - [对于开发者](#对于开发者)
    - [对于使用者](#对于使用者)
  - [FAQ](#faq)
    - [为什么要添加XeLaTeX？](#为什么要添加xelatex？)
    - [为什么原版本不支持XeLaTeX了？](#为什么原版本不支持xelatex了？)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

#哈　尔　滨　工　业　大　学  
#PlutoThesis硕博士学位论文XeLaTeX模版

##模板介绍
###关于版本

该版本是基于PlutoThesis 2013版本（google code [项目](https://code.google.com/p/plutothesis/downloads/lis://code.google.com/p/plutothesis/downloads/list)中只有2012版本）的基础上添加XeLaTeX支持而来.

在“学术桥-LaTeX交流群（群号：38872389）”中留下2013年谭广军毕业版本，是按照日期命名的版本号（也许是因为谷歌代码登陆不了？O\(∩\_∩\)O哈哈~）。
所以为了纪念谭大师兄所做的卓越贡献，所有版本均以时间命名。

### 关于字体

XeLaTeX的字体缺省为winfonts，定义在如下文件（Linux）:

	/usr/share/texlive/texmf-dist/tex/latex/ctex/fontset/ctex-xecjk-winfonts.def

默认有宋、黑、楷、仿宋四种字体。
Linux由于没有winfonts，首先需要安装Windows字体，然后再手动载入载体以免出现如“找不到[SIMKAI.TTF]"之类。

总而言之，如果是win7或以后的高版本Windows系统，系统默认就设置好了字体。
如果Windows XP替换KaiTi为KaiTi\_GB2312，FangSong为FangSong\_GB2312。
如果是Linux或Mac需要手动设置字体，大致过程如下：
一共分3步：

1.	在导言documentclass中加入nofonts选项，关闭默认载入字体选项
2.	在导言中自己载入字体
3.	定义一下默认的衬线和非衬线字体

模板中就是手动载入的字体。

### 关于查重

根据郭大侠（HIT郭靖）的所提的意见和修改方法，添加了完美的可复制支持。
且郭大侠亲自证实可以使用pdf查重！

> 这意味着什么？  
> 这意味着word死忠可以哭晕在厕所了……

使用版本管理毕业论文的刀客，可以优雅地欣赏如下两个场景了：

word死忠的文件夹模式一：

		毕业论文第1章.doc 
		毕业论文第2章.doc 
		毕业论文第3章.doc 
		毕业论文第4章.doc 
		毕业论文第5章.doc 
		毕业论文完整版.doc 
		毕业论文完整版改.doc 
		毕业论文完整版再改.doc 
		毕业论文完整版再再改.doc 
		毕业论文完整版再也不改.doc 
		毕业论文完整版再也不再改.doc 
		毕业论文完整版死都不改.doc 
		毕业论文完整版不死还得改.doc 
		……

word死忠的文件夹模式二：

		毕业论文第1章.doc 
		毕业论文第2章.doc 
		毕业论文第3章.doc 
		毕业论文第4章.doc 
		毕业论文第5章.doc 
		毕业论文完整版20150701.doc 
		毕业论文完整版20150702.doc 
		毕业论文完整版20150703.doc 
		毕业论文完整版20150704.doc 
		毕业论文完整版20150705.doc 
		……


### 关于编译

#### 那些莫名其妙的编译提示错误……

有些HIT刀客（Doctor）行走江湖过惯了快意恩仇的生活，眼里不揉沙子。
把模板一点不动地在本地运行一下，发现了提示错误，于是有的刀客转身奔向敌营Word，有的刀客发冲冠一怒开山立派，自立门户。

其实这不是错误……

因为LaTeX最初设计用来排版英文，所以对于中文在基因上先天不足，唯有靠后天补营养。
当bibTeX使用模板中的哈工大参考文献样式bst文件来排版参考文献时，会弹出错误提示，这个错误提示不是真正意义的错误。
为什么呢？因为我们的目的已经达到了，已经生成好了bbl文件。
于是这个尴尬的局面出现了：如果采用如下方法在Makefile文件里面将bibTeX错误提示屏蔽掉，

	bibtex main || true

那么这也会屏蔽bib文件中真正的格式错误。
所以到底屏不屏蔽，还是留给各位刀客自己决定吧。

#### 那种完美的中文引用样式……

要么上标，要么下标，综述是不是枯燥又无聊！
所以一定有一种[中文引用样式](http://yanshuo.name/cn/2015/06/latex/)会使综述的时间逻辑（年份）和空间逻辑（该文献在文章最后哪一个部分）都很清晰，且含有主语（作者名）。
用这样的引用样式写出的文献综述是不是很文学范？

使用方法：正文中的引用方式是`\citeayu`；
编译方法是：

	make -f MakefileAYU


#### 没有明确要求的格式

即不在[规范](http://hitgs.hit.edu.cn/aa/fd/c3425a109309/page.htm "规范")中明确说明的论文格式，[主要包括](http://yanshuo.name/cn/2015/10/equation/)：标点符号中西混用、公式乱排，以及脚注格式、封皮格式、目录、算法混乱。

其中，算法排版在江湖上主要有如下几个门派类别：

- 框图型

![box](http://ww4.sinaimg.cn/large/61dccbaajw1ezef1pwl6nj20ko08xdgp.jpg "box")

江湖门派：

	社会计算

导言中：

	\usepackage[boxed,linesnumbered,algochapter]{algorithm2e}

正文中：

	\begin{algorithm}
	 \AlgoBiCaption{这是一个简短的算法中文图题}{This is the English caption of the algorithm}
	\KwIn{training samples, {$(d_i, d_j)_q$; $\mathbf{q}_i, \mathbf{q}_j \in C$,
	$q\in \mathbf{Q}$} }
	\KwOut{parameter setting $\lambda^T$}%

	\For{$t$=1 to $T$}
	{
	    $\lambda^{t+1}_n = \lambda^t_n + \eta (f_n(q, c, d_i) - f_n(q, c, d_j))$
	 }
	\end{algorithm}


- 线条型

![ruled](http://ww1.sinaimg.cn/mw690/61dccbaajw1ezef1vhqddj20kk083754.jpg "ruled")

江湖门派：

	自然语言

导言中：

	\usepackage[algoruled,linesnumbered,algochapter]{algorithm2e}

正文中：

	\begin{algorithm}
	 \AlgoBiCaption{这是一个简短的算法中文图题}{This is the English caption of the algorithm}
	\KwIn{training samples, {$(d_i, d_j)_q$; $\mathbf{q}_i, \mathbf{q}_j \in C$,
	$q\in \mathbf{Q}$} }
	\KwOut{parameter setting $\lambda^T$}%

	\For{$t$=1 to $T$}
	{
	    $\lambda^{t+1}_n = \lambda^t_n + \eta (f_n(q, c, d_i) - f_n(q, c, d_j))$
	 }
	\end{algorithm}

- 类似表格型

![table](http://ww3.sinaimg.cn/mw690/61dccbaajw1ezef1v1xamj20lj09p758.jpg "table")

江湖门派：

	生物信息、网络安全

导言中：

	\usepackage[plainruled,linesnumbered,algochapter]{algorithm2e}

正文中：

	\foocaption{\textbf{Function}: Sampling}
	\begin{algorithm}
	 \AlgoBiCaption{这是一个简短的算法中文图题}{This is the English caption of the algorithm}
	\KwIn{training samples, {$(d_i, d_j)_q$; $\mathbf{q}_i, \mathbf{q}_j \in C$,
	$q\in \mathbf{Q}$} }
	\KwOut{parameter setting $\lambda^T$}%

	\For{$t$=1 to $T$}
	{
	    $\lambda^{t+1}_n = \lambda^t_n + \eta (f_n(q, c, d_i) - f_n(q, c, d_j))$
	 }
	\end{algorithm}

### 关于维护者以及捐赠

由于维护者（就是本书呆）已成为高龄不毕业博士，课题繁忙，实在无空余时间无偿解决一些用户要求（例如后文介绍的算法格式各实验室要求不一致）。

另外，各位刀客和大侠如要解囊相助，请微信扫码～～

![二维码](http://ww3.sinaimg.cn/large/61dccbaajw1f11ag3tq66j20he0nn75l.jpg "二维码")

## 这个网站的使用说明

### 对于开发者

当前master分支为临时可用的XeLaTeX模板。
kiss分支是用来逐渐实现PlutoThesis又傻又简单(Keep It Stupid & Simple, KISS)的伟大又宏伟目标而设。
有感兴趣加入共同开发和维护的同学可以加合作者。

### 对于使用者

1. XeLaTeX 版本的项目地址（可在此下载最新版本）

> [https://github.com/dustincys/PlutoThesis](https://github.com/dustincys/PlutoThesis)

2. 稳定版本的发布地址（可在此下载稳定的版本）

> [https://github.com/dustincys/PlutoThesis/releases](https://github.com/dustincys/PlutoThesis/releases)

3. PlutoThesis硕博士开题报告XeLaTeX模板在这里

> [https://github.com/dustincys/PlutoThesisProposal](https://github.com/dustincys/PlutoThesisProposal)

4. 该模板目录结构和各自文件大致功能

		├── appendix （论文后面的附表，这里需要编写）
		│   ├── acknowledgements.tex
		│   ├── appa.tex
		│   ├── authorization.tex
		│   ├── publications.tex
		│   └── resume.tex
		├── body （论文的正文部分，正文写在这里需要编写）
		│   ├── conclusion.tex
		│   ├── equations.tex
		│   ├── figures.tex
		│   ├── introduction.tex
		│   ├── others.tex
		│   ├── simpleequation.tex
		│   ├── simplefigure.tex
		│   ├── simplereference.tex
		│   ├── simpletable.tex
		│   └── tables.tex
		├── clean.bat （用于清理编译过程中的中间文件，使目录干净点）
		├── cover.tex （这是论文中封面，摘要部分，这里需要编写）
		├── figures （存放论文的图片的文件夹）
		│   ├── golfer.eps
		│   ├── latex.eps
		│   ├── list.eps
		│   ├── pdf.eps
		│   └── word.eps
		├── GBT7714-2005NLang-HIT.bst （参考文献样式文件）
		├── main.pdf （最终生成的论文）
		├── main.tex （论文的主文件，有需要的时候要适当修改调整这个文件）
		├── Makefile （自动编译文件，这个文件里面定义了编译方式）
		├── MakefileAYU （自动编译文件，这个文件里面定义了编译方式）
		├── readme.md
		├── reference.bib （用于存放参考文献，BibTeX格式，需要编写） 
		├── setup （论文的设置部分）
		│   ├── Definition.tex
		│   ├── format.tex
		│   ├── package.tex
		│   └── type.tex
		├── tex.snippets （是snippet 模板，用来给vim编辑器用）
		├── XeLaTeX支持说明(第１章开始).pdf
		└── 模板更新记录.txt
	
## FAQ
### 为什么要添加XeLaTeX？

XeLaTeX对中文的支持非常完美，要不怎么叫做“邪恶LaTeX”呢？
其实主要就是因为对字体的支持，目前主流的LaTeX使用字体的方法有两种：

1. 基于CJK, 用LaTeX或pdfLaTeX编译。
2. 基于xeCJK，用XeLaTeX编译。

第一种方式繁琐，逐渐被xeCJK替代。
另外说，XeLaTeX对图片格式，标题汉化什么的支持更好。

### 为什么原版本不支持XeLaTeX了？

时过境迁，沧海桑田。  
Google code项目已经停滞2年，也许诸位先驱都已毕业?  
当年诸位先驱开发模班的时代是CJK的时代，而如今CJK逐渐被xeCJK所取代， 当年的命令作废的作废，冲突的冲突。  
新版本的texlive无法编译陈旧的源文件了。

## 附

- [论文排版乱象杂谈](http://yanshuo.name/cn/2015/10/equation/)

