\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{plutothesis}[2017/05/23 0.0.0 Harbin Institute of Technology Thesis Template]
\ProvidesClass{thuthesis}

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=pluto,
  prefix=pluto@,
  setkeys=\kvsetkeys}
\newif\ifpluto@bachelor % 定义一个布尔变量
\newif\ifpluto@master
\newif\ifpluto@doctor
\newif\ifpluto@postdoctor
\define@key{pluto}{type}{%
  \pluto@bachelorfalse %默认都是false
  \pluto@masterfalse
  \pluto@doctorfalse
  \pluto@postdoctorfalse
  \expandafter\csname pluto@#1true\endcsname} %含有选项的设为true

%%手动载入字体选项，为了兼容更多的系统
\newif\ifpluto@winxp
\define@key{pluto}{os}{%
  \pluto@winxpfalse
  \expandafter\csname pluto@#1true\endcsname}

\def\pluto@deprecated@type@option{%
  \kvsetkeys{pluto}{type=\CurrentOption} % for compatability.
  \ClassError{plutothesis}{Option '\CurrentOption' is deprecated, \MessageBreak
                         please use 'type=\CurrentOption' instead}{}}
\DeclareVoidOption{bachelor}{\pluto@deprecated@type@option}
\DeclareVoidOption{master}{\pluto@deprecated@type@option}
\DeclareVoidOption{doctor}{\pluto@deprecated@type@option}
\DeclareVoidOption{postdoctor}{\pluto@deprecated@type@option}
\DeclareBoolOption{secret}
\DeclareBoolOption{arialtoc}
\DeclareBoolOption{arialtitle}
\DeclareBoolOption{raggedbottom}
\DeclareBoolOption{pifootnote}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\kvsetkeys{pluto}{%
  raggedbottom,
  arialtitle}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}

\LoadClass[cs4size,openany,twoside,UTF8,normalindentfirst,nofonts]{ctexbook}

\ifpluto@bachelor\relax\else
  \ifpluto@master\relax\else
    \ifpluto@doctor\relax\else
      \ifpluto@postdoctor\relax\else
        \ClassError{plutothesis}%
                   {Please specify thesis type in option: \MessageBreak
                    type=[bachelor | master | doctor | postdoctor]}{}
      \fi
    \fi
  \fi
\fi

\RequirePackage{etoolbox}
\RequirePackage{ifxetex}
\RequirePackage{xparse}

\RequirePackage{xeCJK}
\RequirePackage{tabularx}
\RequirePackage{graphicx}
\RequirePackage[a4paper,text={150true mm,224true mm},top=35.5true mm,left=30true mm,head=5true mm,headsep=2.5true mm,foot=8.5true mm]{geometry}
\RequirePackage{titlesec}               % 控制标题的宏包
\RequirePackage{titletoc}                   % 控制目录的宏包
\RequirePackage{fancyhdr}                   % fancyhdr宏包 页眉和页脚的相关定义
\RequirePackage{color}          % 支持彩色
\RequirePackage{amsmath}        % AMSLaTeX宏包 用来排出更加漂亮的公式
\RequirePackage{amssymb}
\RequirePackage[below]{placeins}%允许上一个section的浮动图形出现在下一个section的开始部分,还提供\FloatBarrier命令,使所有未处理的浮动图形立即被处理
\RequirePackage{flafter}       % 使得所有浮动体不能被放置在其浮动环境之前，以免浮动体在引述它的文本之前出现.
\RequirePackage{multirow}       %使用Multirow宏包，使得表格可以合并多个row格
\RequirePackage{booktabs}       % 表格，横的粗线；\specialrule{1pt}{0pt}{0pt}
\RequirePackage{longtable}      %支持跨页的表格。
\RequirePackage[hang]{subfigure}%支持子图 %centerlast 设置最后一行是否居中
\RequirePackage[subfigure]{ccaption} %支持双语标题
\RequirePackage[sort&compress,numbers]{natbib}% 支持引用缩写的宏包
\RequirePackage{enumitem}       %使用enumitem宏包,改变列表项的格式
\RequirePackage{calc}           %长度可以用+ - * / 进行计算
\RequirePackage{fontspec}
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}% 定理类环境宏包，其中 amsmath 选项用来兼容 AMS LaTeX 的宏包

% 生成有书签的pdf及其开关, 该宏包应放在所有宏包的最后, 宏包之间有冲突
\RequirePackage[xetex,
            bookmarksnumbered=true,
            bookmarksopen=true,
            colorlinks=false,
            pdfborder={0 0 1},
            citecolor=blue,
            linkcolor=red,
            anchorcolor=green,
            urlcolor=blue,
            breaklinks=true,
            naturalnames  %与algorithm2e宏包协调
            ]{hyperref}

\usepackage[boxed,linesnumbered,algochapter]{algorithm2e}  % 算法的宏包，注意宏包兼容性，先后顺序为float、hyperref、algorithm(2e)，否则无法生成算法列表 
\usepackage{xltxtra}
\usepackage{listings}
\lstset{
%basicstyle=\small\ttfamily,
columns=flexible,
breaklines=true
}

\defaultfontfeatures{Mapping=tex-text}
\xeCJKsetemboldenfactor{1}%只对随后定义的CJK字体有效
\setCJKfamilyfont{hei}{SimHei}
\xeCJKsetemboldenfactor{4}
\setCJKfamilyfont{song}{SimSun}
\xeCJKsetemboldenfactor{1}
\setCJKfamilyfont{fs}{FangSong}
\setCJKfamilyfont{kai}{KaiTi}
\setCJKfamilyfont{li}{LiSu}
\setCJKfamilyfont{xw}{STXinwei}
\setCJKmainfont{SimSun}
\setCJKsansfont{SimHei}
\setmainfont{Times New Roman}
\setsansfont{Arial}
\newcommand*{\hei}{\CJKfamily{hei}}% 黑体   (Windows自带simhei.ttf)
\newcommand*{\song}{\CJKfamily{song}}    % 宋体   (Windows自带simsun.ttf)
\newcommand*{\fs}{\CJKfamily{fs}}        % 仿宋体 (Windows自带simfs.ttf)
\newcommand*{\kaishu}{\CJKfamily{kai}}      % 楷体   (Windows自带simkai.ttf)
\newcommand*{\li}{\CJKfamily{li}}        % 隶书   (Windows自带simli.ttf)
\newcommand*{\xw}{\CJKfamily{xw}}        % 隶书   (Windows自带simli.ttf)
\newfontfamily\arial{Arial}
\newfontfamily\timesnewroman{Times New Roman}


\newcommand{\yihao}{\fontsize{26pt}{26pt}\selectfont}       % 一号, 1.倍行距
\newcommand{\xiaoyi}{\fontsize{24pt}{24pt}\selectfont}      % 小一, 1.倍行距
\newcommand{\erhao}{\fontsize{22pt}{1.25\baselineskip}\selectfont}       % 二号, 1.倍行距
\newcommand{\xiaoer}{\fontsize{18pt}{18pt}\selectfont}      % 小二, 单倍行距
\newcommand{\sanhao}{\fontsize{16pt}{16pt}\selectfont}      % 三号, 1.倍行距
\newcommand{\xiaosan}{\fontsize{15pt}{15pt}\selectfont}     % 小三, 1.倍行距
\newcommand{\sihao}{\fontsize{14pt}{14pt}\selectfont}       % 四号, 1.0倍行距
\newcommand{\xiaosi}{\fontsize{12pt}{12pt}\selectfont}      % 小四, 1.倍行距
\newcommand{\wuhao}{\fontsize{10.5pt}{10.5pt}\selectfont}   % 五号, 单倍行距
\newcommand{\xiaowu}{\fontsize{9pt}{9pt}\selectfont}        % 小五, 单倍行距



%避免宏包 hyperref 和 arydshln 不兼容带来的目录链接失效的问题。
\def\temp{\relax}
\let\temp\addcontentsline
\gdef\addcontentsline{\phantomsection\temp}

\makeatletter
\gdef\hitempty{}

%重新定义BiChapter命令，可实现标题手动换行，但不影响目录
\def\BiChapter{\relax\@ifnextchar [{\@BiChapter}{\@@BiChapter}}
\def\@BiChapter[#1]#2#3{\chapter[#1]{#2}
    \addcontentsline{toe}{chapter}{\bfseries \xiaosi Chapter \thechapter\hspace{0.5em} #3}}
\def\@@BiChapter#1#2{\chapter{#1}
    \addcontentsline{toe}{chapter}{\bfseries \xiaosi Chapter \thechapter\hspace{0.5em}{\boldmath #2}}}

\newcommand{\BiSection}[2]
{   \section{#1}
    \addcontentsline{toe}{section}{\protect\numberline{\csname thesection\endcsname}#2}
}

\newcommand{\BiSubsection}[2]
{    \subsection{#1}
    \addcontentsline{toe}{subsection}{\protect\numberline{\csname thesubsection\endcsname}#2}
}

\newcommand{\BiSubsubsection}[2]
{    \subsubsection{#1}
    \addcontentsline{toe}{subsubsection}{\protect\numberline{\csname thesubsubsection\endcsname}#2}
}

\newcommand{\BiAppendixChapter}[2] % 该附录命令适用于发表文章，简历等
{\phantomsection
\markboth{#1}{#1}
\addcontentsline{toc}{chapter}{\xiaosi #1}
\addcontentsline{toe}{chapter}{\bfseries \xiaosi #2}  \chapter*{#1}
}

\newcommand{\BiAppChapter}[2]    % 该附录命令适用于有章节的完整附录
{\phantomsection
 \chapter{#1}
 \addcontentsline{toe}{chapter}{\bfseries \xiaosi Appendix \thechapter~~#2}
}

\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}%使图编号为 7-1 的格式 %\protect{~}
\renewcommand{\thesubfigure}{\alph{subfigure})}%使子图编号为 a)的格式
\renewcommand{\p@subfigure}{\thefigure~} %使子图引用为 7-1 a) 的格式，母图编号和子图编号之间用~加一个空格
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}%使表编号为 7-1 的格式
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}%使公式编号为 7-1 的格式

\newcommand{\algoenname}{Algo.} %算法英文标题
\newfloatlist[chapter]{algoen}{aen}{\listalgoenname}{\algoenname}
\newfixedcaption{\algoencaption}{algoen}
\renewcommand{\thealgoen}{\thechapter-\arabic{algocf}}
\renewcommand{\@cftmakeaentitle}{\chapter*{\listalgoenname\@mkboth{\bfseries\listalgoenname}{\bfseries\listalgoenname}}}

\renewcommand{\algorithmcfname}{算法}
\setlength\AlCapSkip{1.2ex}
\SetAlgoSkip{1pt}
\renewcommand{\algocf@captiontext}[2]{\wuhao#1\algocf@typo ~ \AlCapFnt{}#2} % text of caption
\expandafter\ifx\csname algocf@within\endcsname\relax% if \algocf@within doesn't exist
\renewcommand\thealgocf{\@arabic\c@algocf} % and the way it is printed
\else%                                    else
\renewcommand\thealgocf{\csname the\algocf@within\endcsname-\@arabic\c@algocf}
\fi
\renewcommand{\algocf@makecaption}[2]{%中英文双标题一定多于一行，因此去掉单行时的判断，并将\parbox中标题设置为居中
  \addtolength{\hsize}{\algomargin}%
  \sbox\@tempboxa{\algocf@captiontext{#1}{#2}}%
    \hskip .5\algomargin%
    \parbox[t]{\hsize}{\centering\algocf@captiontext{#1}{#2}}%
  \addtolength{\hsize}{-\algomargin}%
}
\newcommand{\AlgoBiCaption}[2]{%直接取出自定义的中英文标题条目加入到真正的\caption 中
   \caption[#1]{\protect\setlength{\baselineskip}{1.5em}#1 \protect \\ Algo. \thealgocf~~ #2} % \algoencaption{#2}
   \addcontentsline{aen}{algoen}{\protect\numberline{\thealgoen}{#2}}
   }

\makeatother

%定义 学科 学位
\def \xuekeEngineering {Engineering}
\def \xuekeScience {Science}
\def \xuekeManagement {Management}
\def \xuekeArts {Arts}
\def \xuekePhilosophy {Philosophy}
\def \xuekeEconomics {Economics}
\def \xuekeLaws {Laws}
\def \xuekeEducation {Education}
\def \xuekeHistory {History}


\ifx \xueke \xuekeEngineering
\newcommand{\cxueke}{工学}
\newcommand{\exueke}{Engineering}
\fi

\ifx \xueke \xuekeScience
\newcommand{\cxueke}{理学}
\newcommand{\exueke}{Science}
\fi

\ifx \xueke \xuekeManagement
\newcommand{\cxueke}{管理学}
\newcommand{\exueke}{Management}
\fi

\ifx \xueke \xuekeArts
\newcommand{\cxueke}{文学}
\newcommand{\exueke}{Arts}
\fi

\ifx \xueke \xuekePhilosophy
\newcommand{\cxueke}{哲学}
\newcommand{\exueke}{Philosophy}
\fi

\ifx \xueke \xuekeEconomics
\newcommand{\cxueke}{经济学}
\newcommand{\exueke}{Economics}
\fi

\ifx \xueke \xuekeLaws
\newcommand{\cxueke}{法学}
\newcommand{\exueke}{Laws}
\fi

\ifx \xueke \xuekeEducation
\newcommand{\cxueke}{教育学}
\newcommand{\exueke}{Education}
\fi

\ifx \xueke \xuekeHistory
\newcommand{\cxueke}{历史学}
\newcommand{\exueke}{History}
\fi
