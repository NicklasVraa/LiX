% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{news}[2023/02/10 For newspapers]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt]{book}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[basics, figures, formatting, header, headings, metadata, periodical, publish, size]{lix}
\RequirePackage{times, yfonts}

% OVERRIDES: -------------------------------------------------------------------
\authorfont{\normalsize}
\setlength\parindent{0pt}
\geometry{a3paper, top=22mm, left=14mm, right=14mm, bottom=18mm}
\setlength{\droptitle}{-3.8em}
\setlength{\columnsep}{5mm}
\setcounter{secnumdepth}{0}% Levels of heading that will be numbered.
\titlespacing{\numberless}{0pt}{14pt}{4pt}
\titlespacing{\section}{0pt}{14pt}{4pt}
\titlespacing{\subsection}{0pt}{14pt}{4pt}
\titlespacing{\subsubsection}{0pt}{14pt}{4pt}
\titleformat*{\section}{\Large\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat*{\paragraph}{\bfseries\scshape}
\RenewDocumentCommand{\h}{m}{\section{#1}\label{#1}}
\RenewDocumentCommand{\hh}{m}{\subsection{#1}\label{#1}}
\RenewDocumentCommand{\hhh}{m}{\hh{#1}}
\RenewDocumentCommand{\hhhh}{m}{\hh{#1}}

% HEADER AND FOOTER: -----------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{{\footnotesize\textbf{\theDate}}}
\fancyhead[LE,RO]{\textgoth{\theTitle} -- {\footnotesize\textbf{Vol. \theVolume}}}
\fancyhead[RE]{{\footnotesize\textbf{International}} -- \textbf{\thepage}}
\fancyhead[LO]{{\textbf{\thepage} -- \footnotesize\textbf{International}}}
\renewcommand{\headrule}{\vspace*{-2.5mm}\hspace*{-0.5mm}\noindent{\scriptsize\dotfill\hspace*{-0.5mm}}}

\fancypagestyle{front}{%
    \fancyhf{}
    \fancyhead[C]{{\footnotesize\textbf{\theDate}}}
    \fancyhead[L]{{\footnotesize\textbf{Vol. \theVolume\ -- No. \theIssue\ --\ \theLocation}}}
    \fancyhead[R]{{\footnotesize\textbf{\theCost}}}
}
\thispagestyle{front}

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
    \oldtitle{}
    \begin{figure}[H]%
        \begin{minipage}[H]{0.20\columnwidth}%
            \centering{\small\textit{"\theSubtitle"}}
        \end{minipage}%
        \begin{minipage}[H]{0.6\columnwidth}%
            \begin{center}\scalebox{2}{\Huge\textgoth{\theTitle}}\end{center}
        \end{minipage}%
        \begin{minipage}[H]{0.20\columnwidth}%
            \centering{\small\textit{Editorial Board: \\ \theAuthor}}
        \end{minipage}%
    \end{figure}
    \vspace*{-7.5mm}
    \vspace*{-1mm}\hspace*{-0.5mm}\noindent{\scriptsize\dotfill\hspace*{-0.5mm}}
    \oldauthor{}
    \olddate{}
    \addMetadata
    \begin{multicols}{4}
}{
    \end{multicols}
}

% CONTENTS: --------------------------------------------------------------------
\newrobustcmd{\tocdepth}[1]{%
    \IfStrEq{#1}{h}{\setcounter{tocdepth}{1}}
        {\IfStrEq{#1}{hh}{\setcounter{tocdepth}{2}}
            {\IfStrEq{#1}{hhh}{\setcounter{tocdepth}{3}}}%
                {\IfStrEq{#1}{hhhh}{\setcounter{tocdepth}{4}}{\setcounter{tocdepth}{2}}}}%
}

\renewcommand{\usecompacttoc}{
    \titlecontents{section}[0em]{}{%
        \small\bfseries\thecontentslabel.\hspace*{0.5em}}{\bfseries}{%
        \titlerule*[0.5pc]{.}\contentspage%
    }
    \titlecontents{subsection}[0em]{%
        \small\hspace*{0.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{%
        \titlerule*[0.5pc]{.}\contentspage%
    }
    \titlecontents{subsubsection}[0em]{%
        \small\hspace*{1.6em}}{\thecontentslabel.\hspace*{0.5em}}{}{%
        \titlerule*[0.5pc]{.}\contentspage%
    }
    \titlecontents{paragraph}[0em]{%
        \small\hspace*{2.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{%
        \titlerule*[0.5pc]{.}\contentspage%
    }
}

\@ifundefined{chapter}{}{
    \makeatletter%
        \renewcommand\tableofcontents{%
            \usecompacttoc
            \h{\contentsname}%
            \@starttoc{toc}%
            \protect\thispagestyle{front}%
            }
    \makeatother%
}

