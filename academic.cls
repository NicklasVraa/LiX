% Desc: Custom LaTeX document-class for academic papers.
% Auth: Nicklas Vraa.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academic}[2022/12/12 Nicklas Vraa's custom LaTeX class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}

% Package Imports:

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[nottoc]{tocbibind}
    \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, fancyhdr, float, geometry, graphicx, hyperref, ifthen, inconsolata, lastpage, listings, microtype, parskip, setspace, silence, siunitx, svg, tabularray, titlesec, titletoc, titling, ulem}

% Package configs:

    \WarningsOff* % Ignore all warnings.

    % Whitespace adjustments.
    \geometry{a4paper, top=30mm, left=26mm, right=26mm, bottom=34mm}
    \setlength{\columnsep}{5mm}
    \setlength{\droptitle}{-4.5em}
    \titlespacing\numberless{0pt}{14pt}{4pt}
    \titlespacing\section{0pt}{14pt}{4pt}
    \titlespacing\subsection{0pt}{14pt}{4pt}
    \titlespacing\subsubsection{0pt}{14pt}{4pt}
    \renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}

    % Section heading styling.
    \titleformat*{\section}{\bfseries\scshape}
    \titleformat*{\subsection}{\bfseries\scshape}
    \titleformat*{\subsubsection}{\bfseries\scshape}
    \titleformat*{\paragraph}{\bfseries\scshape}
    \titleformat*{\subparagraph}{\bfseries\scshape}

    % ToC adjustments.
    \titlecontents{section}[0em]{}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsection}[0em]{\hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsubsection}[0em]{\hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}

    % Caption styling.
    \DeclareCaptionFormat{myformat}{\fontsize{8}{9}\selectfont#1#2#3}
    \captionsetup{format=plain, labelfont=bf, font=scriptsize, justification=raggedright, singlelinecheck=false}

    % Links- and references styling.
    \hypersetup{hidelinks}
    \setcounter{secnumdepth}{3}
    \normalem
    \renewcommand{\lstlistingname}{Snippet}
    \providecommand*{\lstlistingautorefname}{snippet}

    % Setting bibliography to sort by order of appearance.
    \bibliographystyle{unsrt}

    % Code styling.
    \lstdefinestyle{inline}{
        basicstyle=\ttfamily\footnotesize, breaklines=true
    }
    \lstdefinestyle{block}{
        basicstyle=\ttfamily\footnotesize,
        commentstyle=\color[rgb]{0.5,0.5,0.5},
        postbreak=\mbox{\hspace{-2.5em}\textcolor{gray}{$\hookrightarrow$}\space\space},
        breaklines=true, numbers=left, numberstyle=\tiny, numbersep=7pt, showspaces=false, tabsize=4,xleftmargin=14pt
    }

    % Header, footer, page numbers, etc.
    \fancypagestyle{firstpage}{\fancyhf{}\fancyfoot[C]{\thepage\ of \pageref{LastPage}}\renewcommand{\headrulewidth}{0pt}} % No line on first page, but display current and total page number.
    \fancypagestyle{allpages}{\fancyhf{}\fancyfoot[C]{\thepage\ of \pageref{LastPage}}\renewcommand{\headrulewidth}{0.1pt}} % Reduce thickness of line.
    \pagestyle{allpages}

    % Lists styling.
    \newlist{bullets}{itemize}{10}
    \setlist[bullets,1]{leftmargin=6mm}
    \setlist[bullets]{leftmargin=*,label=$\vcenter{\hbox{\tiny$\bullet$}}$,labelindent=\parindent}
    \newlist{numbers}{enumerate}{10}
    \setlist[numbers,1]{leftmargin=6mm}
    \setlist[numbers]{leftmargin=*,label*=\arabic*.,labelindent=\parindent}

% Custom user commands:

    % Links and references.
    \newcommand{\toc}{\tableofcontents}
    \newcommand{\bib}[1]{\bibliography{#1}}
    \renewcommand{\url}[2]{\href{#2}{#1}}
    \renewcommand{\r}[1]{\renewcommand\lstlistingautorefname{snippet}\renewcommand\figureautorefname{figure}\renewcommand\equationautorefname{equation}\renewcommand\tableautorefname{table}\renewcommand\sectionautorefname{section}\renewcommand\subsectionautorefname{section}\renewcommand\subsubsectionautorefname{section}\renewcommand\paragraphautorefname{section}\renewcommand\subparagraphautorefname{section}\autoref{#1}} % Lowercase ref names.
    \newcommand{\R}[1]{\renewcommand\lstlistingautorefname{Snippet}\renewcommand\figureautorefname{Figure}\renewcommand\equationautorefname{Equation}\renewcommand\tableautorefname{Table}\renewcommand\sectionautorefname{Section}\renewcommand\subsectionautorefname{Section}\renewcommand\subsubsectionautorefname{Section}\renewcommand\paragraphautorefname{Section}\renewcommand\subparagraphautorefname{Section}\autoref{#1}} % Uppercase ref names.

    % Academic paper elements.
    \newcommand{\header}[3]{\lhead{#1}\chead{#2}\rhead{#3}}
    \newcommand{\titles}[2]{\title{\textbf{\textsc{#1}}\\[0.8ex] \large\scshape #2}}
    \newcommand{\authors}[1]{\author{\normalsize{#1}}}
    \newcommand{\byline}[1]{\author{\normalsize{#1}} \date{}} % Either this alone, or both \authors and \date.
    \renewcommand{\abstract}[1]{\textbf{\textsc{Abstract}}: #1}
    \newcommand{\h}[2][\DefaultOpt]{\def\DefaultOpt{#2}\section[#1]{#2}\label{#2}}
    \newcommand{\hh}[2][\DefaultOpt]{\def\DefaultOpt{#2}\subsection[#1]{#2}\label{#2}}
    \newcommand{\hhh}[2][\DefaultOpt]{\def\DefaultOpt{#2}\subsubsection[#1]{#2}\label{#2}}
    \newcommand{\hhhh}[2][\DefaultOpt]{\def\DefaultOpt{#2}\paragraph[#1]{#2}\label{#2}}
    \newcommand{\hhhhh}[2][\DefaultOpt]{\def\DefaultOpt{#2}\subparagraph[#1]{#2}\label{#2}}
    \renewcommand{\H}[1]{\section*{#1}\label{#1}\addcontentsline{toc}{section}{#1}} % Non-numbered heading.

    % Math shortcuts.
    \newcommand{\mean}[1]{\overline{}}
    \newcommand{\pfrac}[2]{\left( \frac{#1}{#2} \right)}
    \renewcommand{\Re}{\mathbb{R}} % Real set.
    \renewcommand{\Im}{\mathbb{I}} % Imaginary set.
    \newcommand{\N}{\mathbb{N}} % Natural set.
    \newcommand{\Z}{\mathbb{Z}} % Integer set.
    \newcommand{\Q}{\mathbb{Q}} % Rational set.
    \newcommand{\C}{\mathbb{C}} % Complex set.
    \renewcommand{\epsilon}{\varepsilon}

    % Adding to existing commands.
    \NewCommandCopy{\olddate}{\date}
    \renewcommand{\date}[1]{\olddate{\vspace{0.2em}\normalsize{#1}}} % Reduce vertical space before date.
    \NewCommandCopy{\oldhref}{\href}
    \renewcommand{\href}[2]{\uline{\oldhref{#1}{#2}}} % Add underline to urls.
    \newcommand{\front}{\maketitle\thispagestyle{firstpage}}

    % Inline formatting.
    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.
    \renewcommand{\u}[1]{\uline{#1}} % Underline.
    \newcommand{\m}[1]{$#1$} % Inline math.
    \RenewDocumentCommand{\c}{v}{\lstinline[style=inline]{#1}}
    \newcommand{\s}[1]{\sout{#1}} % Strikethrough.

% Custom environment commands:

    % Figures.
    \def\maxwidth#1{\ifdim\Gin@nat@width>#1 #1\else\Gin@nat@width\fi}
    \newcommand{\fig}[3]{ % One command for vectors and images.
        \begin{figure}[h!] \centering\filename@parse{#1}\ifthenelse{\equal{\filename@ext}{svg}}{\sbox0{\includesvg[width=0.99\columnwidth]{#1}}}{\sbox0{\includegraphics[width=\maxwidth{0.99\columnwidth}]{#1}}}\begin{minipage}{\wd0}\usebox0\caption{#3}\label{#2}\end{minipage}\end{figure}
    }

    % Tables.
    \newcommand{\cols}[3]{
        \begin{table}[h!]\centering\sbox0{\begin{tblr}{hline{1,2,Z} = {0.1pt,solid}, rowsep = {1pt}, hspan = even}#3\end{tblr}}\begin{minipage}{\wd0}\usebox0\caption{#2}\label{#1}\end{minipage}\end{table}
    }
    \newcommand{\rows}[3]{
        \begin{table}[h!]\centering\sbox0{\begin{tblr}{hline{1,Z} = {0.1pt,solid}, vline{2} = {0.1pt,solid}, rowsep = {1pt}, hspan = even}#3\end{tblr}}\begin{minipage}{\wd0}\usebox0\caption{#2}\label{#1}\end{minipage}\end{table}
    }
    \newcommand{\grid}[3]{
        \begin{table}[h!]\centering\sbox0{\begin{tblr}{hline{1,2,Z} = {0.1pt,solid}, vline{2} = {0.1pt,solid}, rowsep = {1pt}, hspan = even}#3\end{tblr}}\begin{minipage}{\wd0}\usebox0\caption{#2}\label{#1}\end{minipage}\end{table}
    }

    % Equations.
    \renewenvironment{math}[1]{\begin{equation}\label{#1}}{\end{equation}}

    % Code blocks.
    \lstnewenvironment{code}[3]{\newcommand{\append}{\captionof{lstlisting}{#3}\label{#1}}\begin{center}\noindent\rule{\columnwidth}{0.1pt}\end{center}\vspace{-1mm}\lstset{language=#2,style=block}}{\vspace{-5mm}\begin{center}\noindent\rule{\columnwidth}{0.1pt}\end{center}\append\vspace{0.8em}}
