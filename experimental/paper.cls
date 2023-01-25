\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paper}[For academic research papers]

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
\RequirePackage{base, code, figs, list, math, meta, tabs} % Collections.
\RequirePackage{parskip, setspace, silence, titlesec, titletoc, titling}

\WarningsOff*
\newcommand{\use}[1]{\usepackage{#1}}
\renewcommand{\abstract}{\textbf{\textsc{Abstract}}}


% SIZE, MARGINS: ---------------------------------------------------------------
\ifnum\numColumns=1
    \geometry{a4paper, top=28mm, left=34mm, right=34mm, bottom=36mm}
    \setlength{\droptitle}{-3.8em}
\else\ifnum\numColumns=2
    \geometry{a4paper, top=22mm, left=26mm, right=26mm, bottom=32mm}
    \setlength{\columnsep}{5mm}
    \setlength{\droptitle}{-2.8em}
\fi\fi

% TABLE OF CONTENTS: -----------------------------------------------------------
\titlecontents{section}[0em]{}{%
    \thecontentslabel.\hspace*{0.5em}}{}{%
    \titlerule*[0.5pc]{.}\contentspage%
}
\titlecontents{subsection}[0em]{%
    \hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{%
    \titlerule*[0.5pc]{.}\contentspage%
}
\titlecontents{subsubsection}[0em]{%
    \hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{%
    \titlerule*[0.5pc]{.}\contentspage%
}

% HEADINGS: --------------------------------------------------------------------
\setcounter{secnumdepth}{3}% Levels of heading that will be numbered.
\renewcommand*{\@seccntformat}[1]{% Add dot after number.
    \csname the#1\endcsname.\hspace{0.5em}%
}
\titlespacing\numberless{0pt}{14pt}{4pt}
\titlespacing\section{0pt}{14pt}{4pt}
\titlespacing\subsection{0pt}{14pt}{4pt}
\titlespacing\subsubsection{0pt}{14pt}{4pt}
\titleformat*{\section}{\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat*{\paragraph}{\bfseries\scshape}

% CAPTIONS: --------------------------------------------------------------------
\captionsetup{
    format=plain, labelfont=bf, font=scriptsize,
    justification=raggedright, singlelinecheck=false
}

% REFERENCES: ------------------------------------------------------------------
\bibliographystyle{unsrt} % Sort by order of appearance.

% LAYOUT: ----------------------------------------------------------------------
\AddToHook{begindocument/end}{%
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
        \oldauthor{\normalsize{\theAuthor}}%
    }
    \@ifundefined{theDate}{%
        \olddate{}%
    }{%
        \olddate{\normalsize{\theDate}}%
    }

    \@ifundefined{theTitle}{}{%
        \maketitle%
    }
}
