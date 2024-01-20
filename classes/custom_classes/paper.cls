% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paper}[2023/02/10 For academic research papers]

% Intercept class options.
\newcommand{\numColumns}{1}
\DeclareOption{twocolumn}{
    \renewcommand{\numColumns}{2}
    \PassOptionsToClass{\CurrentOption}{article}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[algorithms, basics, code, figures, formatting, headings, lists, math, metadata, refs, size, tables]{lix}

% OVERRIDES: -------------------------------------------------------------------
\setlength\parindent{0pt}
\usecompacttoc
\bibfont{\footnotesize}
\authorfont{\normalsize}
\setcounter{secnumdepth}{3}% Levels of heading that will be numbered.
\titlespacing{\numberless}{0pt}{14pt}{4pt}
\titlespacing{\section}{0pt}{14pt}{4pt}
\titlespacing{\subsection}{0pt}{14pt}{4pt}
\titlespacing{\subsubsection}{0pt}{14pt}{4pt}
\titleformat*{\section}{\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat*{\paragraph}{\bfseries\scshape}
\renewcommand*{\@seccntformat}[1]{% Add dot after number.
    \csname the#1\endcsname.\hspace{0.5em}%
}
\ifnum\numColumns=1
    \geometry{a4paper, top=28mm, left=34mm, right=34mm, bottom=36mm}
    \setlength{\droptitle}{-3.8em}
\else\ifnum\numColumns=2
    \geometry{a4paper, top=20mm, left=24mm, right=24mm, bottom=30mm}
    \setlength{\columnsep}{5mm}
    \setlength{\droptitle}{-2.8em}
\fi\fi
\fancyhfoffset[O]{0pt}

% HEADER AND FOOTER: -----------------------------------------------------------
\fancypagestyle{plain}{% First page.
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhead{}%
    \fancyfoot[C]{{\thepage} of \pageref{LastPage}}%
}
\fancypagestyle{fancy}{%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhead{}%
    \fancyfoot[C]{{\thepage} of \pageref{LastPage}}%
}
\pagestyle{fancy}

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
        \maketitle%
    }
    \@ifundefined{theAbstract}{}{%
        \textbf{\textsc{Abstract:}} \theAbstract%
    }
    \addMetadata
}
