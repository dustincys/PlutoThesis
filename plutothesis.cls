\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{plutothesis}[2017/05/23 0.0.0 Harbin Institute of Technology Thesis Template]

%%%{{{ Package
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
\DeclareBoolOption{glue}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\kvsetkeys{pluto}{%
  raggedbottom,
  arialtitle}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}

\ifpluto@bachelor
\PassOptionsToClass{oneside}{book}
\fi
\ifpluto@master
\PassOptionsToClass{oneside}{book}
\fi
\ifpluto@doctor
\PassOptionsToClass{twoside}{book}
\fi

\PassOptionsToPackage{AutoFakeBold=2}{xeCJK}

\LoadClass[zihao=-4,openany,UTF8,scheme=plain]{ctexbook}

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

\RequirePackage{etoolbox}% 提供常用命令的包
\RequirePackage{ifxetex}% 检验引擎是不是xetex

\ifxetex
\else
        \ClassError{plutothesis}%
                   {Please use: \MessageBreak
                    xelatex}{}
\fi

\RequirePackage{xparse}


\RequirePackage{amsmath}        % AMSLaTeX宏包 用来排出更加漂亮的公式

\RequirePackage[defaultsups]{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{courier}

\RequirePackage{graphicx}
%\RequirePackage[labelformat=simple]{subcaption} 比subfigure 更好？
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage{enumitem}       %使用enumitem宏包,改变列表项的格式

\RequirePackage{environ}
\ifpluto@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
\ifpluto@pifootnote
  \RequirePackage{pifont}
\fi

\RequirePackage{CJKfntef} % 汉字加点，分散对齐功能
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}% 定理类环境宏包，其中 amsmath 选项用来兼容 AMS LaTeX 的宏包
%\RequirePackage{array}
\RequirePackage{longtable}      %支持跨页的表格。
\RequirePackage{booktabs}       % 表格，横的粗线；\specialrule{1pt}{0pt}{0pt}
\RequirePackage[sort&compress,numbers]{natbib}% 支持引用缩写的宏包

\RequirePackage{hyperref}
\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi
\hypersetup{%
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  colorlinks=false,
  plainpages=false,
  pdfborder=0 0 0}
\urlstyle{same}
\RequirePackage[showframe]{geometry}
\geometry{
  a4paper, % 210 * 297mm
  hcentering,
  ignoreall,
nomarginpar}
\ifpluto@bachelor
\geometry{
  left=32mm,
  headheight=5mm,
  headsep=5mm,
  textheight=220mm,
  bottom=37mm,
footskip=17mm}
\else
\geometry{%根据PlutoThesis 原版定义而来
  text={150true mm,224true mm},
  top=35.5true mm,
  left=30true mm,
  head=5true mm,
  headsep=2.5true mm,
  foot=8.5true mm
}
\fi
\RequirePackage{layout}

\RequirePackage{fancyhdr}                   % fancyhdr宏包 页眉和页脚的相关定义
\let\pluto@cleardoublepage\cleardoublepage
\newcommand{\pluto@clearemptydoublepage}{%
  \clearpage{\pagestyle{pluto@empty}\pluto@cleardoublepage}
}
\let\cleardoublepage\pluto@clearemptydoublepage

\renewcommand\frontmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{pluto@empty}
}

\renewcommand\mainmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \ifpluto@bachelor\pagestyle{pluto@plain}\else\pagestyle{pluto@headings}\fi
}

\renewcommand\backmatter{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue}

\RequirePackage{tabularx}
\RequirePackage{titletoc}                   % 控制目录的宏包
\RequirePackage{color}          % 支持彩色
\RequirePackage{amssymb}
\RequirePackage[below]{placeins}%允许上一个section的浮动图形出现在下一个section的开始部分,还提供\FloatBarrier命令,使所有未处理的浮动图形立即被处理
\RequirePackage{flafter}       % 使得所有浮动体不能被放置在其浮动环境之前，以免浮动体在引述它的文本之前出现.
\RequirePackage{multirow}       %使用Multirow宏包，使得表格可以合并多个row格
\RequirePackage[hang]{subfigure}%支持子图 %centerlast 设置最后一行是否居中
\RequirePackage[subfigure]{ccaption} %支持双语标题
\RequirePackage{calc}           %长度可以用+ - * / 进行计算


\RequirePackage[boxed,linesnumbered,algochapter]{algorithm2e}  % 算法的宏包，注意宏包兼容性，先后顺序为float、hyperref、algorithm(2e)，否则无法生成算法列表
\RequirePackage{xltxtra}
\RequirePackage{listings}
\lstset{
%basicstyle=\small\ttfamily,
columns=flexible,
breaklines=true
}


%%%}}}

%%%{{{ Font
% 1bp = 1.00374pt
% 1mm = 2.84526pt
%按照窝工之要求, 行距在3mm～4mm之间，换算之后为20.50398～23.33863bp
% 换算公式为：
%((3 * 2.84526) / (12 * 1.00374) + 1) * 12 bp
%((4 * 2.84526) / (12 * 1.00374) + 1) * 12 bp
%所以改为默认21bp
%注意，原PlutoThesis 的1.67倍行距，是20.04bp, 小于规定最小值0.46398bp
%这里设置为glue， 可能会不美观
%或者直接设置为21bp更好。
%此处应该给出一个设置选项

\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{\ifpluto@glue 20.50398bp \@plus 2.83465bp \@minus 0bp\else 21bp\fi}%
  \abovedisplayskip=4pt
  \abovedisplayshortskip=4pt
  \belowdisplayskip=\abovedisplayskip
  \belowdisplayshortskip=\abovedisplayshortskip}

\predisplaypenalty=0  %公式之前可以换页，公式出现在页面顶部

\def\pluto@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}

\pluto@def@fontsize{chuhao}{42bp}
\pluto@def@fontsize{xiaochu}{36bp}
\pluto@def@fontsize{yihao}{26bp}
\pluto@def@fontsize{xiaoyi}{24bp}
\pluto@def@fontsize{erhao}{22bp}
\pluto@def@fontsize{xiaoer}{18bp}
\pluto@def@fontsize{sanhao}{16bp}
\pluto@def@fontsize{xiaosan}{15bp}
\pluto@def@fontsize{sihao}{14bp}
\pluto@def@fontsize{banxiaosi}{13bp}
\pluto@def@fontsize{xiaosi}{12bp}
\pluto@def@fontsize{dawu}{11bp}
\pluto@def@fontsize{wuhao}{10.5bp}
\pluto@def@fontsize{xiaowu}{9bp}
\pluto@def@fontsize{liuhao}{7.5bp}
\pluto@def@fontsize{xiaoliu}{6.5bp}
\pluto@def@fontsize{qihao}{5.5bp}
\pluto@def@fontsize{bahao}{5bp}
%%%}}}

%%{{{ header footer
\fancypagestyle{pluto@empty}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{pluto@plain}{%
  \fancyhead{}
  \fancyfoot[C]{\xiaowu\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{pluto@headings}{%
  \fancyhf{}
  \ifpluto@doctor
  \fancyhead[CO]{\songti\xiaowu[0]\leftmark}
  \fancyhead[CE]{\songti\xiaowu[0]\pluto@cschoolname\pluto@cdegree\pluto@cthesisname}%
  \else
  \ifpluto@master
  \fancyhead[C]{\songti\xiaowu[0]\pluto@cschoolname\pluto@cdegree\pluto@cthesisname}
  \fi
  \ifpluto@bachelor
  \fancyhead[C]{\songti\xiaowu[0]\pluto@cschoolname\pluto@bachelor@cxuewei\pluto@bachelor@cthesisname}%
  \fi
  \fi
  \fancyfoot[C,C]{\xiaowu -~\thepage~-}
  % 此处可能和word模板不一致
  % 页眉中小五汉字，0行距时，占用9bt，页眉高度为14pt, 所以以下数字之和要保持等于14pt-9bt=4.96634pt
  % 根据PlutoThesis模板中rule宽度定义为2.25， 0.75， 保持粗线和细线之间的间距为细线宽度。
  % 如果页眉是多行的情况，rule向下溢出
  \renewcommand{\headrule}{
    \vskip 1.190132pt
    \hrule\@height2.276208pt\@width\headwidth
    \vskip 0.75pt
    \hrule\@height.75pt\@width\headwidth
  }
  \renewcommand{\footrulewidth}{0pt}
}

\AtBeginDocument{%
  \pagestyle{pluto@empty}
  \renewcommand{\chaptermark}[1]{\@mkboth{\CTEXthechapter\enspace#1}{}}}
%%%}}}

%%%{{{段落
\ctexset{%
  punct=quanjiao,
  space=auto,
  autoindent=true}
\setlist{nosep}
%%%}}}

%%%{{{脚注
\def\pluto@textcircled#1{%
  \ifnum\value{#1} >9
    \ClassError{plutothesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \ifpluto@pifootnote%
    \ding{\the\numexpr\value{#1}+171\relax}%
  \else%
    \textcircled{\xiaoliu\arabic{#1}}%
  \fi}
\renewcommand{\thefootnote}{\pluto@textcircled{footnote}}
\renewcommand{\thempfootnote}{\pluto@textcircled{mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\pluto@footnotesize\footnotesize
\renewcommand\footnotesize{\pluto@footnotesize\xiaowu[1.5]}
\footnotemargin1.5em\relax
\let\pluto@makefnmark\@makefnmark
\def\pluto@@makefnmark{\hbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\pluto@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\pluto@makefnmark}{}{}
%%%}}}

%%%{{{ 数学公式
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
%%%}}}

%%%{{{ Structure

%避免宏包 hyperref 和 arydshln 不兼容带来的目录链接失效的问题。
\def\temp{\relax}
\let\temp\addcontentsline
\gdef\addcontentsline{\phantomsection\temp}

\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}%使图编号为 7-1 的格式 %\protect{~}
\renewcommand{\thesubfigure}{\alph{subfigure})}%使子图编号为 a)的格式
\renewcommand{\p@subfigure}{\thefigure~} %使子图引用为 7-1 a) 的格式，母图编号和子图编号之间用~加一个空格
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}%使表编号为 7-1 的格式
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}%使公式编号为 7-1 的格式

\newcommand{\algoenname}{Algo.} %算法英文标题
\newfloatlist[chapter]{algoen}{aen}{\listalgoenname}{\algoenname}
\newfixedcaption{\algoencaption}{algoen}
\renewcommand{\thealgoen}{\thechapter-\arabic{algocf}}
\renewcommand{\@cftmakeaentitle}{\chapter*{\listalgoenname\@mkboth{\bfseries\listalgoenname}{\bfseries\listalgoenname}}
}

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

  %%%}}}

   %%%{{{ Key for options
% 使用key-value 设置封面选项
\def\pluto@def@term#1{%
  \define@key{pluto}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname pluto@#1\endcsname{##1}}
  \csname #1\endcsname{}}

\pluto@def@term{statesecrets} %密级
\pluto@def@term{natclassifiedindex}  %国内图书分类号
\pluto@def@term{internatclassifiedindex}  %国际图书分类号

\pluto@def@term{ctitle} %中文标题
\pluto@def@term{cxueke} %中文学科
\pluto@def@term{cauthor} %中文作者
\pluto@def@term{csupervisor} %中文导师
\pluto@def@term{cassosupervisor} %中文副导师
\pluto@def@term{ccosupervisor}%中文联合导师
\pluto@def@term{caffil}%中文院系
\pluto@def@term{csubject}%中文专业
\pluto@def@term{cdate}

\pluto@def@term{cstudentid}%
\pluto@def@term{ctitleone}%
\pluto@def@term{ctitletwo}%


\pluto@def@term{etitle} %英文标题
\pluto@def@term{exueke} %英文学科
\pluto@def@term{eauthor} %英文作者
\pluto@def@term{esupervisor} %英文导师
\pluto@def@term{eassosupervisor} %英文副导师
\pluto@def@term{ecosupervisor} %英文联合导师
\pluto@def@term{eaffil}
\pluto@def@term{esubject}
\pluto@def@term{edate}

% for the other degree
%\pluto@def@term{id}
%\pluto@def@term{udc}
%\pluto@def@term{catalognumber}
%\pluto@def@term{cfirstdiscipline}
%\pluto@def@term{cseconddiscipline}
%\pluto@def@term{postdoctordate}


\newcommand{\pluto@@cabstract}[1]{\long\gdef\pluto@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\pluto@@cabstract}{}
\newcommand{\pluto@@eabstract}[1]{\long\gdef\pluto@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\pluto@@eabstract}{}
\def\pluto@parse@keywords#1{
  \define@key{pluto}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname pluto@#1\endcsname{}
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname pluto@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname pluto@#1\endcsname{%
          \ignorespaces\csname pluto@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname pluto@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\pluto@parse@keywords{ckeywords}
\pluto@parse@keywords{ekeywords}

\def\plutosetup{\kvsetkeys{pluto}}
%%%}}}

\theoremstyle{plain}
\theorembodyfont{\songti\rmfamily}
\theoremheaderfont{\heiti\rmfamily}
\theoremsymbol{$\square$}
\setlength{\theorempreskipamount}{0pt}
\setlength{\theorempostskipamount}{-2pt}

\allowdisplaybreaks[4]
\setlength{\parindent}{2em}
\arraycolsep=1.6pt
\setcounter{secnumdepth}{4} \setcounter{tocdepth}{2}

\def\pluto@title@font{%
  \ifpluto@arialtitle\sffamily\else\heiti\fi}

\newcommand\pluto@chapter@titleformat[1]{%开启悬挂缩进选项
    \ifthenelse%
      {\equal{#1}{\eabstractcname}}%
      {\bfseries #1}%
      %实现章标题的居中加悬挂缩进，注意，此处一定是\CTEX@chaptername\CTEX@chapter@aftername, 否则是英文标题长度
      {\settowidth{\hangindent}{\CTEX@chaptername\CTEX@chapter@aftername}\hangafter=1#1}%
}

% 窝工规定章标题行间距要10mm
% 1bp = 1.00374pt
% 1mm = 2.84526pt
% 小二号字体 18bp
% 所以行间距倍数为 (10 × 2.84526) / (18 × 1.00374) = 1.57481，
% 以上没问题
% 按照窝工硕博论文规范的规定： 章标题要段前空一行，段后空0.8行 （最好是给距离mm, bp, 给出一行……）
% 这就有了歧义： 空这一行，是什么格式？是标题的格式么？那么
% 为18 * (1 + 0.57481) = 23.17329bp
% 按照word的操作习惯规定应该是空行格式为章标题格式
% 本科规范中的格式是1.25倍行距
% word中的1.25倍行距是单倍行距的1.25倍。单倍行距是的固定值是某一个大于字体磅数的正数，这个正数对于不同的字体不一样，有一定的随机性，且此处规定与后文中的10mm间距矛盾，
% 由于这个行距是某一个不固定值，且本科生规范中含有了与硕博规范中一样的弹性区间规定（章节标题间距是固定值），所以这里不用单独设置这个1.25倍行距了。

% 这个值默认是两行，即章节标题之后至少两行，才可以分页
% 确保每一个章节提款标题之后保留一行就可以分页。
% 这样确保剩余空白不过大，且不会出现标题出现在页底的情况
\renewcommand\@afterheading{%
  \@nobreaktrue
  \everypar{%
    \if@nobreak
      \@nobreakfalse
      \clubpenalty 1
      \if@afterindent \else
        {\setbox\z@\lastbox}%
      \fi
    \else
      \clubpenalty 1
      \everypar{}%
    \fi}}


\ctexset{%
  chapter={
    afterindent=true,
    pagestyle={pluto@headings},
    beforeskip={28.34658bp},%一个空行 1.57481 × 18
    afterskip={24.74658bp},%0.8应该不计算间距 0.8 × 18 + 0.57481×18
    aftername=\enspace,
    format={\centering\pluto@title@font\xiaoer[1.57481]},%\center 会影响之后全局
    nameformat=\relax,
    numberformat=\relax,
    titleformat=\pluto@chapter@titleformat,
    fixskip=true, % 添加这一行去除默认间距
  },
  section={
    afterindent=true,
    beforeskip={\ifpluto@glue 13.5bp \@plus 1.677267bp \@minus 1.157391bp \else 13.5bp \fi},%上下空0.5行
    afterskip={\ifpluto@glue 13.5bp \@plus 1.677267bp \@minus 1.157391bp  \else 13.5bp \fi},
    format={\pluto@title@font\ifpluto@glue\fontsize{15bp}{21bp \@plus 1.677267bp \@minus 1.157391bp}\else\fontsize{15bp}{21bp}\fi\selectfont},
    aftername=\enspace,
    fixskip=true,
    break={},
  },
  subsection={
    afterindent=true,
    beforeskip={\ifpluto@glue 11bp \@plus 1.842609bp \@minus 0.9920497bp \else 11bp \fi},
    afterskip={\ifpluto@glue 11bp \@plus 2.33863bp \@minus 0.49602bp \else 11bp \fi},
    format={\pluto@title@font\ifpluto@glue\fontsize{14bp}{18bp \@plus 1.842609bp \@minus 0.9920497bp}\else\fontsize{14bp}{18bp}\fi\selectfont},
    aftername=\enspace,
    fixskip=true,
    break={},
  },
  subsubsection={
    afterindent=true,
    beforeskip={\ifpluto@glue 8.50398bp \@plus 2.83465bp \@minus 0bp \else 9bp \fi},
    afterskip={\ifpluto@glue 8.50398bp \@plus 2.83465bp \@minus 0bp \else 9bp \fi},
    format={\pluto@title@font\normalsize},
    aftername=\enspace,
    fixskip=true,
    break={},
  },
  paragraph/afterindent=true,
  subparagraph/afterindent=true
}


\NewDocumentCommand{\pluto@appendix@chapter}{s m o}{%
  \IfBooleanTF{#1}%
  {
    \phantomsection
    \markboth{#2}{#2}
    \addcontentsline{toc}{chapter}{\xiaosi #2}
    \IfValueT{#3}{%
      \addcontentsline{toe}{chapter}{\bfseries \xiaosi #3}
    }
    \pluto@chapter*{#2}
  }
  {}
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

% s: 星号，表示在目录中出不出现序号
% m: 必须要有的选项，中文章节名称也即目录中名称，页眉中名称，书签中的名称
% o: 可选内容，没有就默认是正文章节，如果有，则是英文目录中显示的内容。
\let\pluto@chapter\chapter
\RenewDocumentCommand{\chapter}{s o m o}{%
  \if@openright\cleardoublepage\else\clearpage\fi\phantomsection%
  \IfBooleanTF{#1}%
  {%	if \chapter*
    \pluto@chapter*{#3}%
    \IfValueT{#4}{%
      \addcontentsline{toe}{chapter}{\bfseries #4}
    }
  }%
  {%	if \chapter
    \IfNoValueTF{#2}%
    {\pluto@chapter{#3}}%
    {\pluto@chapter[#2]{#3}}%
    \IfValueT{#4}{%
    \addcontentsline{toe}{chapter}{\bfseries\relax Chapter \thechapter\hspace{0.5em} #4}
    }
  }
}

\let\pluto@section\section
\RenewDocumentCommand\section{s o m o}{
  \IfBooleanTF{#1}%
  {%	if \section*
    \pluto@section*{#3}%
    \IfValueT{#4}{%
      \addcontentsline{toe}{section}{#4}
    }
  }%
  {%	if \section
    \IfNoValueTF{#2}%
    {\pluto@section{#3}}%
    {\pluto@section[#2]{#3}}%
    \IfValueT{#4}{%
    \addcontentsline{toe}{section}{\protect\numberline{\csname thesection\endcsname} #4}
    }
  }
}

\let\pluto@subsection\subsection
\RenewDocumentCommand\subsection{s o m o}{
  \IfBooleanTF{#1}%
  {%	if \subsection*
    \pluto@subsection*{#3}%
    \IfValueT{#4}{%
      \addcontentsline{toe}{subsection}{#4}
    }
  }%
  {%	if \subsection
    \IfNoValueTF{#2}%
    {\pluto@subsection{#3}}%
    {\pluto@subsection[#2]{#3}}%
    \IfValueT{#4}{%
    \addcontentsline{toe}{subsection}{\protect\numberline{\csname thesubsection\endcsname} #4}
    }
  }
}

\let\pluto@subsubsection\subsubsection
\RenewDocumentCommand\subsubsection{s o m o}{
  \IfBooleanTF{#1}%
  {%	if \subsubsection*
    \pluto@subsubsection*{#3}%
    \IfValueT{#4}{%
      \addcontentsline{toe}{subsubsection}{#4}
    }
  }%
  {%	if \subsubsection
    \IfNoValueTF{#2}%
    {\pluto@subsubsection{#3}}%
    {\pluto@subsubsection[#2]{#3}}%
    \IfValueT{#4}{%
    \addcontentsline{toe}{subsubsection}{\protect\numberline{\csname thesubsubsection\endcsname} #4}
    }
  }
}

\titlecontents{chapter}[3.8em]{\hspace{-3.8em}\heiti}{\thecontentslabel~~}{}{\titlerule*[4pt]{.}\contentspage}
\dottedcontents{section}[32pt]{}{21pt}{0.3pc}
\dottedcontents{subsection}[53pt]{}{30pt}{0.3pc}


% 按工大标准, 缩小目录中各级标题之间的缩进，使它们相隔一个字符距离，也就是12pt
\renewcommand*\l@chapter{\@dottedtocline{0}{0em}{5em}}%控制英文目录： 细点\@dottedtocline  粗点\@dottedtoclinebold
\renewcommand*\l@section{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{2.5em}}

% 调整罗列环境的布局
\setitemize{leftmargin=0em,itemsep=0em,partopsep=0em,parsep=0em,topsep=0em,itemindent=3em}
\setenumerate{leftmargin=0em,itemsep=0em,partopsep=0em,parsep=0em,topsep=0em,itemindent=3.5em}

\newcommand{\citeup}[1]{\textsuperscript{\cite{#1}}}

% 定制浮动图形和表格标题样式
\captionnamefont{\wuhao}
\captiontitlefont{\wuhao}
\captiondelim{~~}
%\captionstyle{\hang}
\hangcaption
\renewcommand{\subcapsize}{\wuhao}
\setlength{\abovecaptionskip}{0pt}
\setlength{\belowcaptionskip}{0pt}

% 自定义项目列表标签及格式 \begin{publist} 列表项 \end{publist}
\newcounter{pubctr} %自定义新计数器
\newenvironment{publist}{%%%%%定义新环境
\begin{list}{[\arabic{pubctr}]} %%标签格式
    {
     \usecounter{pubctr}
     \setlength{\leftmargin}{1.7em}     % 左边界 \leftmargin =\itemindent + \labelwidth + \labelsep
     \setlength{\itemindent}{0em}     % 标号缩进量
     \setlength{\labelsep}{0.5em}       % 标号和列表项之间的距离,默认0.5em
     \setlength{\rightmargin}{0em}    % 右边界
     \setlength{\topsep}{0ex}         % 列表到上下文的垂直距离
     \setlength{\parsep}{0ex}         % 段落间距
     \setlength{\itemsep}{0ex}        % 标签间距
     \setlength{\listparindent}{0pt} % 段落缩进量
    }}
{\end{list}}%%%%%


% 定义封面
\newlength{\pluto@title@width}
\newcommand{\pluto@put@title}[2][\pluto@title@width]{%
  \begin{CJKfilltwosides}[b]{#1}#2\end{CJKfilltwosides}}


\def\pluto@first@titlepage{%
  \ifpluto@bachelor\pluto@first@titlepage@bachelor\else\pluto@first@titlepage@other\fi}
\def\pluto@second@titlepage{%
  \ifpluto@bachelor\pluto@second@titlepage@bachelor\else\pluto@second@titlepage@other\fi}

\newcommand{\pluto@first@titlepage@bachelor}{
  \vspace*{0.8cm}
  \begin{center}
    \parbox[t][3.4cm][t]{\textwidth}{
  \begin{center}\erhao[0]\heiti\pluto@ctitle\end{center} }
    \parbox[t][9.4cm][t]{\textwidth}{
    \begin{center}\xiaoer[0]\songti{\bfseries \pluto@cauthor}\end{center}
  }
  \begin{center}
    \setlength{\pluto@title@width}{4em}
    \heiti\xiaosi
      \begin{tabular}{rc}
	{\pluto@put@title{\pluto@bachelor@caffiltitle}\pluto@title@csep} & \pluto@caffil\\[14pt]
	{\pluto@put@title{\pluto@bachelor@cstudentidtitle}\pluto@title@csep} & \pluto@cstudentid
    \end{tabular}
      \begin{tabular}{rc}
	{\pluto@put@title{\pluto@bachelor@cmajortitle}\pluto@title@csep} & \pluto@csubject\\[14pt]
	{\pluto@put@title{\pluto@bachelor@csupervisortitle}\pluto@title@csep} &  \pluto@csupervisor
      \end{tabular}
    \end{center}
    \vspace{3.0cm}
    {\xiaosi[0]\songti\textbf{\pluto@cdate}}
  \end{center}
}
\newcommand{\pluto@second@titlepage@bachelor}{
  \vspace*{0.6cm}
  \centering\includegraphics[scale=0.38]{logo.pdf}
  \vspace{1.5cm}
  \begin{center}
    \centering\includegraphics[scale=0.25]{bthesistitle.pdf}
    \vfill
    \parbox[t][14.2cm][b]{\textwidth}
    {\heiti\xiaosan
      \begin{center} \renewcommand{\arraystretch}{2.5} \heiti
	\setlength{\pluto@title@width}{5.5em}
	\begin{tabular}{l@{\ \  }c}

	  {\xiaoer  \pluto@put@title{\pluto@bachelor@cthesistitle}} & \underline{\makebox[6.1cm]{\xiaoer \pluto@ctitleone}}\\
								     &  \underline{\makebox[6.1cm]{\xiaoer \pluto@ctitletwo}}\\
									    & \\
	  {\pluto@put@title{\pluto@bachelor@cmajortitle}}                  & \underline{\makebox[6.1cm]{\pluto@csubject}}\\
	  {\pluto@put@title{\pluto@bachelor@cstudentidtitle}}                  & \underline{\makebox[6.1cm]{\pluto@cstudentid}}\\
	  {\pluto@put@title{\pluto@bachelor@cstudenttitle}}                  & \underline{\makebox[6.1cm]{\pluto@cauthor}}\\
	  {\pluto@put@title{\pluto@bachelor@csupervisortitle}} & \underline{\makebox[6.1cm]{\pluto@csupervisor}}\\
	  {\pluto@put@title{\pluto@cdatetitle}} & \underline{\makebox[6.1cm]{\pluto@cdate}}
	\end{tabular} \renewcommand{\arraystretch}{1}
      \end{center}
    }
  \end{center}
}
\newcommand{\pluto@first@titlepage@other}{
  % 封面一
  \vspace*{0.8cm}
  \begin{center}
  \begin{center}\xiaoyi[1]\songti\textbf{\pluto@cxuewei\pluto@cthesisname}\end{center}
    \vspace{1cm}
    \parbox[t][2.8cm][t]{\textwidth}{
  \begin{center}\erhao\heiti\pluto@ctitle\end{center} }
    \parbox[t][5.1cm][t]{\textwidth}{ %英文标题太长时可以采用\xiaoer
  \begin{center}\erhao\textbf{\MakeUppercase{\pluto@etitle}}\end{center} }
    \parbox[t][7.4cm][t]{\textwidth}{
  \begin{center}\xiaoer\songti\textbf{\pluto@cauthor}\end{center}}
    \parbox[t][1.4cm][t]{\textwidth}{
  \begin{center}\kaishu\xiaoer\textbf{\pluto@cschoolname}\end{center} }
    {\songti\xiaoer\textbf{\pluto@cdate}}
  \end{center}
}

%内封
\newcommand{\pluto@second@titlepage@other}{
  \begin{center}
    {\songti \xiaosi
      \begin{tabular}{@{}r@{：}l@{}}
	\pluto@natclassifiedindextitle & \pluto@natclassifiedindex\\
	\pluto@internatclassifiedindextitle & \pluto@internatclassifiedindex
    \end{tabular}}\hfill
    {\songti \xiaosi
      \begin{tabular}{@{}r@{：}l@{}}
	\pluto@schoolidtitle & \pluto@schoolid\\
	\pluto@secretlevel & \pluto@statesecrets
    \end{tabular}}
  \parbox[t][3.2cm][t]{\textwidth}{\begin{center} \end{center} }
    \parbox[t][2.4cm][t]{\textwidth}{\xiaoer
  \begin{center} {\songti \bfseries \pluto@cdegree \pluto@cthesisname }\end{center} }
    \parbox[t][5cm][t]{\textwidth}{\erhao
  \begin{center} {\heiti  \pluto@ctitle}\end{center} }
    \parbox[t][9.8cm][b]{\textwidth}
    {\sihao
      \setlength{\pluto@title@width}{6em}
      \begin{center} \renewcommand{\arraystretch}{1.62} \songti
	\begin{tabular}{l@{\pluto@title@csep}l}
	  {\heiti \pluto@put@title{\pluto@cauthortitle}}	&	\pluto@cauthor\\
	  {\heiti \pluto@put@title{\pluto@csupervisortitle}}	&	\pluto@csupervisor\\
        \ifx\pluto@cassosupervisor\@empty\else%
	  {\heiti \pluto@put@title{\pluto@cassosupervisortitle}}&	\pluto@cassosupervisor\\
        \fi
        \ifx\pluto@ccosupervisor\@empty\else%
	  {\heiti \pluto@put@title{\pluto@ccosupervisortitle}}	&	\pluto@ccosupervisor\\
        \fi
	  {\heiti \pluto@put@title{\pluto@cdegreetitle}}	&	\pluto@cdegree\\
	  {\heiti \pluto@put@title{\pluto@csubjecttitle}}	&	\pluto@csubject\\
	  {\heiti \pluto@put@title{\pluto@caffiltitle}}		&	\pluto@caffil\\
	  {\heiti \pluto@put@title{\pluto@cdatetitle}}		&	\pluto@cdate\\
	  {\heiti \pluto@put@title{\pluto@cschoolnametitle}}	&	\pluto@cschoolname
	\end{tabular} \renewcommand{\arraystretch}{1}
    \end{center} }
  \end{center}
}

% 英文封面

\newcommand{\pluto@engcover}{
  {
    \xiaosi\noindent Classified Index: \pluto@natclassifiedindex \\
  U.D.C:  \pluto@internatclassifiedindex }
  \begin{center}
  \parbox[t][1.6cm][t]{\textwidth}{\begin{center} \end{center} }
    \parbox[t][3.5cm][t]{\textwidth}{\xiaoer
  \begin{center} {  Dissertation for the {\pluto@exueweier} Degree in \pluto@exueke}\end{center} } %与中文保持一致，删除in {\pluto@exueke}

    \parbox[t][7cm][t]{\textwidth}{\erhao
  \begin{center} { \bfseries \pluto@etitle}\end{center} }

    %★★★★若信息内容不太长，不会引起信息内容分行时，使用tabular环境，否则使用下面的tabularx环境。
    {\sihao\renewcommand{\arraystretch}{1.3}
      \begin{tabular}{@{}l@{~}l@{}}
	\textbf{\pluto@eauthortitle\pluto@title@esep}		&	\pluto@eauthor\\
	\textbf{\pluto@esupervisortitle\pluto@title@esep}	&	\pluto@esupervisor\\
      \ifx\pluto@eassosupervisor\@empty\else%
	\textbf{\pluto@eassosupervisortitle\pluto@title@esep}	&	\pluto@eassosupervisor\\
      \fi
      \ifx\pluto@ecosupervisor\@empty\else%
	\textbf{\pluto@ecosupervisortitle\pluto@title@esep}	&	\pluto@ecosupervisor\\
      \fi
	\textbf{\pluto@edegreetitle\pluto@title@esep}		&	\pluto@edegree\\
	\textbf{\pluto@esubjecttitle\pluto@title@esep}		&	\pluto@esubject\\
	\textbf{\pluto@eaffiltitle\pluto@title@esep}		&	\pluto@eaffil\\
	\textbf{\pluto@edatetitle\pluto@title@esep}		&	\pluto@edate\\
	\textbf{\pluto@eschoolnametitle\pluto@title@esep}	&	\pluto@eschoolname
    \end{tabular}\renewcommand{\arraystretch}{1}}
  \end{center}
}

\def\makecover{
  \phantomsection
  \pdfbookmark[-1]{\pluto@ctitle}{ctitle}
  \xiaosi[1]%
  \begin{titlepage}
    \pluto@first@titlepage
    \cleardoublepage
    \pluto@second@titlepage
    \cleardoublepage
    \ifpluto@bachelor
    \relax
    \else
    \pluto@engcover
    \cleardoublepage
    \fi
  \end{titlepage}
  \normalsize
  \pluto@makeabstract}

\newbox\pluto@kw
\newcommand\pluto@put@keywords[2]{%
  \begingroup
    \setbox\pluto@kw=\hbox{#1}
    \ifpluto@bachelor\indent\else\noindent\hangindent\wd\pluto@kw\hangafter1\fi%
    \box\pluto@kw#2\par
  \endgroup}

\newcommand{\pluto@makeabstract}{%
  \ifpluto@doctor
  \cleardoublepage
  \pluto@appendix@chapter*{\cabstractcname}{\cabstractename}
  \else
  \clearpage
  \pluto@appendix@chapter*{\cabstractcname}
  \fi
  \pagestyle{pluto@headings}
  \pagenumbering{Roman}
  \pluto@cabstract
  \vskip12bp
  \pluto@put@keywords{\heiti\pluto@ckeywords@title}{\pluto@ckeywords}
  \ifpluto@doctor
  \pluto@appendix@chapter*{\eabstractcname}{\eabstractename}
  \else
  \pluto@appendix@chapter*{\eabstractcname}
  \fi
  \addtocontents{toc}{\vspace{\baselineskip}}
  \addtocontents{toe}{\vspace{\baselineskip}}
  \pluto@eabstract
  \vskip12bp
  \pluto@put@keywords{%
    \textbf{\ifpluto@bachelor Keywords:\else Key words:\fi\enskip}}{\pluto@ekeywords}}

\newenvironment{denotation}[1][2.5cm]{%
  \pluto@chapter*[]{\pluto@denotation@name} % no tocline
  \vskip-30bp\xiaosi[1.6]\begin{pluto@denotation}[labelwidth=#1]
}{%
  \end{pluto@denotation}
}
\newlist{pluto@denotation}{description}{1}
\setlist[pluto@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\NewDocumentEnvironment{acknowledgement}{o}{%
    \pluto@chapter*{\pluto@ackname}
  }
  {
    \ifpluto@postdoctor\relax\else%
      \IfNoValueTF{#1}{%
        \pluto@chapter*{\pluto@declarename}
        \par{\xiaosi\parindent2em\pluto@declaretext}\vskip2cm
        {\xiaosi\hfill\pluto@signature\pluto@underline[2.5cm]\relax%
         \pluto@backdate\pluto@underline[2.5cm]\relax}%
      }{%
        \includepdf[pagecommand={\thispagestyle{pluto@empty}%
          \phantomsection\addcontentsline{toc}{chapter}{\pluto@declarename}%
        }]{#1}%
      }%
    \fi
  }
\let\ack\acknowledgement
\let\endack\endacknowledgement
\def\pluto@starttoc#1{% #1: float type, prepend type name in \listof*** entry.
  \let\oldnumberline\numberline
  \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
  \@starttoc{\csname ext@#1\endcsname}
  \let\numberline\oldnumberline}
\def\pluto@listof#1{% #1: float type
  \@ifstar
    {\pluto@chapter*[]{\csname list#1name\endcsname}\pluto@starttoc{#1}}
    {\pluto@chapter*{\csname list#1name\endcsname}\pluto@starttoc{#1}}}
\renewcommand\listoffigures{\pluto@listof{figure}}
\renewcommand*\l@figure{\addvspace{6bp}\@dottedtocline{1}{0em}{4em}}
\renewcommand\listoftables{\pluto@listof{table}}
\let\l@table\l@figure
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\pluto@listof{equation}}
\let\l@equation\l@figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 英文目录格式
\def\@dotsep{0.75}           % 定义英文目录的点间距
\setlength\leftmargini {0pt}
\setlength\leftmarginii {0pt}
\setlength\leftmarginiii {0pt}
\setlength\leftmarginiv {0pt}
\setlength\leftmarginv {0pt}
\setlength\leftmarginvi {0pt}

\def\engcontentsname{\bfseries Contents}
\newcommand\tableofengcontents{
   \pdfbookmark[0]{Contents}{econtent}
     \@restonecolfalse
   \chapter*{\engcontentsname  %chapter*上移一行，避免在toc中出现。
       \@mkboth{%
          \engcontentsname}{\engcontentsname}}
   \@starttoc{toe}%
   \if@restonecol\twocolumn\fi
   }

\urlstyle{same}  %论文中引用的网址的字体默认与正文中字体不一致，这里修正为一致的。

\renewcommand\endtable{\vspace{-4mm}\end@float}

\AtEndOfClass{\input{plutothesis.cfg}}
\AtEndOfClass{\sloppy}
\endinput
