% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2023/02/10 For longer reports]

% Intercept class options.
\newcommand{\numColumns}{1}
\DeclareOption{twocolumn}{
    \renewcommand{\numColumns}{2}
    \PassOptionsToClass{\CurrentOption}{article}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[algorithms, basics, code, figures, formatting, headings, lists, math, metadata, refs, size, tables]{lix}

% OVERRIDES: -------------------------------------------------------------------
\setlength\parindent{0pt}
\bibfont{\footnotesize}
\authorfont{\normalsize}
\usecompacttoc
\renewcommand{\toc}{\tableofcontents\newpage}
\ifnum\numColumns=1
    \geometry{a4paper, top=32mm, left=28mm, right=28mm, bottom=28mm}
    \setlength{\droptitle}{-3.8em}
\else\ifnum\numColumns=2
    \geometry{a4paper, top=26mm, left=24mm, right=24mm, bottom=30mm}
    \setlength{\columnsep}{5mm}
    \setlength{\droptitle}{-2.8em}
\fi\fi
\setcounter{secnumdepth}{4}% Levels of heading that will be numbered.
\titlespacing{\numberless}{0pt}{14pt}{4pt}
\titlespacing{\section}{0pt}{14pt}{4pt}
\titlespacing{\subsection}{0pt}{14pt}{4pt}
\titlespacing{\subsubsection}{0pt}{14pt}{4pt}
\titleformat*{\section}{\LARGE\bfseries}
\titleformat*{\subsection}{\Large\bfseries}
\titleformat*{\subsubsection}{\large\bfseries}
\titleformat*{\paragraph}{\bfseries}
\AddToHook{cmd/section/before}{\clearpage}
\renewcommand*{\@seccntformat}[1]{% Add dot after number.
    \csname the#1\endcsname.\hspace{0.5em}%
}

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
            \oldtitle{\LARGE\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\LARGE\textbf{\textsc{\theTitle}}\\[0.4ex]%
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
}
