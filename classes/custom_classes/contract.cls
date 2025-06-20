% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{contract}[2023/02/10 For formal contracts]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt]{article}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[basics, formatting, header, headings, lists, metadata, sign, size, tables]{lix}
\RequirePackage{times}

% OVERRIDES: -------------------------------------------------------------------
\setlength\parindent{0pt}
\renewcommand\maketitlehookc{\vspace{-2ex}}
\usecompacttoc
\geometry{a4paper, top=28mm, left=20mm, right=20mm, bottom=20mm}
\setlength{\columnsep}{4mm}
\setlength{\droptitle}{-5em}
\fancyhfoffset[O]{0pt}
\setcounter{secnumdepth}{3}% Levels of heading that will be numbered.
\titlespacing{\numberless}{0pt}{14pt}{4pt}
\titlespacing{\section}{0pt}{14pt}{4pt}
\titlespacing{\subsection}{0pt}{14pt}{4pt}
\titlespacing{\subsubsection}{0pt}{14pt}{4pt}
\titleformat{\section}{\bfseries\scshape}{§ \arabic{section}.}{0.5em}{}
\titleformat*{\subsection}{\scshape}
\titleformat*{\subsubsection}{\scshape}
\titleformat*{\paragraph}{\scshape}
\renewcommand*{\@seccntformat}[1]{% Add dot after number.
    \csname the#1\endcsname.\hspace{0.5em}%
}

% HEADER AND FOOTER: -----------------------------------------------------------
\fancypagestyle{plain}{% First page.
    \renewcommand{\headrulewidth}{0pt}%
    \@ifundefined{theLeftHeader}{
        \fancyhead[L]{}
    }{%
        \fancyhead[L]{\scriptsize\theLeftHeader}%
    }
    \fancyhead[R]{\scriptsize Page \thepage\ of \pageref{LastPage}}%
    \fancyfoot{}%
}
\fancypagestyle{fancy}{%
    \renewcommand{\headrulewidth}{0pt}%
    \@ifundefined{theLeftHeader}{
        \fancyhead[L]{}
    }{%
        \fancyhead[L]{\scriptsize\theLeftHeader}%
    }
    \fancyhead[R]{\scriptsize Page \thepage\ of \pageref{LastPage}}%
    \fancyfoot{}%
}

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
    \@ifundefined{theTitle}{}{%
        \@ifundefined{theSubtitle}{%
            \oldtitle{\raggedright\Large\scshape\textbf{\theTitle}}%
        }{%
            \oldtitle{\raggedright\Large\scshape\textbf{\theTitle}\\[0.4ex]%
            \normalsize\scshape\theSubtitle}%
        }
    }
    \@ifundefined{theAuthor}{%
        \oldauthor{}%
    }{%
        \oldauthor{\theAuthor}%
    }
    \@ifundefined{theDate}{%
        \olddate{\vspace{-8ex}}%
    }{%
        \olddate{\raggedright\normalsize{\theDate}}%
    }
    \@ifundefined{theTitle}{}{%
        \maketitle%
    }
    \addMetadata
}
