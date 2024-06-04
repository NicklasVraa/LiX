% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2023/02/10 For longer reports]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt, titlepage]{article}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[algorithms, basics, code, figures, formatting, headings, license, lists, math, metadata, publish, refs, size, tables]{lix}

% OVERRIDES: -------------------------------------------------------------------
\setlength\parindent{0pt}
\bibfont{\footnotesize}
\authorfont{\normalsize}
\counterwithin{equation}{section}
\counterwithin{figure}{section}
\counterwithin{table}{section}
\AtBeginDocument{\counterwithin{lstlisting}{section}}
\usecompacttoc
\renewcommand{\toc}{\tableofcontents\newpage}
\geometry{a4paper, top=38mm, left=32mm, right=32mm, bottom=32mm}
\setcounter{secnumdepth}{3}% Levels of heading that will be numbered.
\titlespacing{\numberless}{0pt}{14pt}{4pt}
\titlespacing{\section}{0pt}{14pt}{4pt}
\titlespacing{\subsection}{0pt}{14pt}{4pt}
\titlespacing{\subsubsection}{0pt}{14pt}{4pt}
\titleformat*{\section}{\LARGE\bfseries\scshape}
\titleformat*{\subsection}{\Large\bfseries\scshape}
\titleformat*{\subsubsection}{\large\bfseries\scshape}
\titleformat*{\paragraph}{\bfseries\scshape}
\AddToHook{cmd/section/before}{\clearpage}
\addheadingseparator{line}

\widowpenalties 1 10000 % Avoid splitting paragraphs.
\raggedbottom % Avoid stretching page content.

% PAGESTYLES: ------------------------------------------------------------------
\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhead{}
    \fancyfoot{}
}
\fancypagestyle{fancy}{%
    \renewcommand{\headrulewidth}{0pt}%
    \@ifundefined{theLeftHeader}{
        \fancyhead[L]{\scriptsize\scshape\theTitle}%
    }{
        \fancyhead[L]{\scriptsize\scshape\theLeftHeader}
    }
    \fancyhead[R]{\scriptsize\thepage\ of \pageref{LastPage}}%
    \fancyfoot{}
}

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
    \@ifundefined{theTitle}{}{%
        \@ifundefined{theSubtitle}{%
            \oldtitle{\Huge\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\LARGE\textbf{\textsc{\theTitle}}\\[1ex]%
            \large\scshape\theSubtitle}%
        }
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
        \maketitle\newpage\pagestyle{fancy}
    }
    \@ifundefined{theAbstract}{}{%
        \section*{Abstract} \theAbstract\newpage%
    }
    \addMetadata
    \addFormalPage\stepcounter{page}
}
