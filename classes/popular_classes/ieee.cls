% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ieee}[2023/02/10 For IEEE journals and transactions]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[twocolumn]{article}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[basics, code, figures, formatting, header, headings, lists, math, metadata, refs, size, tables]{lix}
\RequirePackage{times}

% OVERRIDES: -------------------------------------------------------------------
\bibfont{\footnotesize}
\usecompacttoc
\geometry{a4paper, top=21mm, left=17mm, right=17mm, bottom=21mm}
\setlength{\columnsep}{4mm}
\setlength{\droptitle}{-3em}
\fancyhfoffset[O]{0pt}
\setcounter{secnumdepth}{3}% Levels of heading that will be numbered.
\titlespacing\numberless{0pt}{10pt}{3pt}
\titlespacing\section{0pt}{10pt}{3pt}
\titlespacing\subsection{0pt}{10pt}{3pt}
\titlespacing\subsubsection{\parindent}{10pt}{0.5em}
\titleformat{\section}{\centering\scshape}{\Roman{section}.}{0.5em}{}
\titleformat{\subsection}{\itshape}{\Alph{subsection}.}{0.5em}{}
\titleformat{\subsubsection}[runin]{\itshape}{\arabic{subsection})}{0.5em}{}[:]

% HEADER AND FOOTER: -----------------------------------------------------------
\fancypagestyle{plain}{% First page.
    \renewcommand{\headrulewidth}{0pt}%
    \@ifundefined{theLeftHeader}{
        \fancyhead[L]{}
    }{%
        \fancyhead[L]{\scriptsize\MakeUppercase\theLeftHeader}%
    }
    \fancyhead[R]{\scriptsize\thepage}%
    \@ifundefined{theIdnum}{
        \fancyfoot{}%
    }{
        \fancyfoot[C]{\footnotesize\theIdnum\ \copyright\ \the\year\ IEEE}%
    }
}
\fancypagestyle{fancy}{%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhead[L]{\scriptsize\MakeUppercase\theLeftHeader}%
    \fancyhead[R]{\scriptsize\thepage}%
    \fancyfoot{}%
}
\pagestyle{fancy}

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
    \@ifundefined{theTitle}{}{%
        \oldtitle{\huge\theTitle}%
    }
    \@ifundefined{theAuthor}{%
        \oldauthor{}%
    }{%
        \oldauthor{\theAuthor}%
    }
    \@ifundefined{theDate}{%
        \olddate{}%
    }{%
        \olddate{\normalsize{\theDate}}%
    }
    \@ifundefined{theTitle}{}{%
        \maketitle%
    }
    \@ifundefined{theAbstract}{}{%
        {\small\bfseries\textit{Abstract---}\theAbstract%
        \@ifundefined{theKeywords}{}{%
            \\[0.5em] \indent\textit{Index Terms---}\theKeywords.
        }
        }\vspace{0.5em}
    }
    \addMetadata
}
