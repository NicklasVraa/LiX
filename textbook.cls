\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{textbook}[For academic textbooks]

% Intercept class options.
\newcommand{\numColumns}{1}
\DeclareOption{twocolumn}{
    \renewcommand{\numColumns}{2}
    \PassOptionsToClass{\CurrentOption}{report}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[all]{lix}
\RequirePackage{parskip, setspace, silence, titlesec, titletoc, titling}

\WarningsOff*
\newcommand{\use}[1]{\usepackage{#1}}

% SIZE, MARGINS: ---------------------------------------------------------------
\geometry{letterpaper, top=28mm, bottom=28mm, left=20mm, right=20mm}
\setlength{\columnsep}{5mm}

% COVER: -----------------------------------------------------------------------
\setlength{\droptitle}{-110mm}%

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

% HEADER AND FOOTER: -----------------------------------------------------------
\setlength{\headsep}{5mm}%
\pagestyle{fancy}%
\renewcommand{\headrulewidth}{0pt}%
\renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}%
\fancyhead[L]{%
    \small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark%
}
\fancyhead[R]{%
    \small\scshape\color{darkgray} Page \thepage\ of \pageref{LastPage}%
}
\fancyfoot{}%


% HEADINGS: --------------------------------------------------------------------
\setcounter{secnumdepth}{4}% Levels of heading that will be numbered.
\renewcommand*{\@seccntformat}[1]{% Add dot after number.
    \csname the#1\endcsname.\hspace{0.5em}%
}
\titlespacing{\chapter}{-1pt}{-45pt}{4pt}
\titlespacing\numberless{0pt}{14pt}{4pt}
\titlespacing\section{0pt}{14pt}{4pt}
\titlespacing\subsection{0pt}{14pt}{4pt}
\titlespacing\subsubsection{0pt}{14pt}{4pt}
\titleformat*{\section}{\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat*{\paragraph}{\bfseries\scshape}
\titleformat{\chapter}[display]{%
    \normalsize%
}{% Prefix.
    \hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter%
    \hfill Page \thepage\ of \pageref{LastPage}
}{% Vertical space between.
    \ifnum\numColumns=1%
        -9pt%
    \else
        -4pt%
    \fi
}{% Chapter name.
    \thispagestyle{empty}\huge\bfseries\scshape%
}

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
            \oldtitle{\Huge\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\Huge\textbf{\textsc{\theTitle}}\\[0.4ex]%
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
    \addFrontCover
    \addBackCover

    \@ifundefined{theTitle}{}{%
        \maketitle%
    }

    \addVersoPage
}
