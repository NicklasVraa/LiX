% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{novel}[2023/02/10 For works of fiction]

% Intercept class options.
\newcommand{\numColumns}{1}
\DeclareOption{twocolumn}{
    \renewcommand{\numColumns}{2}
    \PassOptionsToClass{\CurrentOption}{book}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt,oneside]{book}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[basics, cover, figures, lists, formatting, header, headings, isbn, license, metadata, publish, ornaments, refs, size]{lix}
\RequirePackage[lining]{ebgaramond}
\RequirePackage{setspace, silence, titlesec, titletoc, titling}

\WarningsOff*

% FONT OVERRIDES: --------------------------------------------------------------
\authorfont{\normalsize}
\RenewDocumentCommand{\l}{mg}{
    \lettrine[nindent=2.4pt, findent=-1.5pt, loversize=0.25]{#1}{\IfValueTF{#2}{#2}{}}
}

% SIZE, MARGINS: ---------------------------------------------------------------
\geometry{letterpaper, top=36mm, bottom=40mm, left=40mm, right=40mm}

% COVER: -----------------------------------------------------------------------
\setlength{\droptitle}{-110mm}%

% HEADINGS: --------------------------------------------------------------------
\setcounter{secnumdepth}{1}% Levels of heading that will be numbered.
\titlespacing{\chapter}{-1pt}{-45pt}{10pt}
\titlespacing\numberless{0pt}{14pt}{4pt}
\titlespacing\section{0pt}{14pt}{4pt}
\titlespacing\subsection{0pt}{14pt}{4pt}
\titlespacing\subsubsection{0pt}{14pt}{4pt}
\titleformat*{\section}{\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat{\chapter}[display]{%
    \normalsize%
}{% Prefix.
    \centering\hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter%
}{% Vertical space between.
    -9pt%
}{% Chapter name.
    \centering\LARGE\bfseries\scshape%
}

% PAGESTYLES: ------------------------------------------------------------------
\setlength{\headsep}{3mm}%
\pagestyle{fancy}%
\renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}%
\fancyhead[L]{}%
\fancyhead[C]{\small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark}%
\fancyhead[R]{}%
\fancyfoot[C]{\small\scshape\thepage}%
\renewcommand{\headrulewidth}{0pt}%

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
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
        \oldauthor{\theAuthor}%
    }
    \@ifundefined{theDate}{%
        \olddate{}%
    }{%
        \olddate{\normalsize{\theDate}}%
    }
    \addMetadata

    \addFrontCover
    \addBackCover

    \ifnum\printOnCover=1
        \@ifundefined{theTitle}{}{%
            \maketitle%
        }
    \else
        \mbox{}\pagestyle{empty}\newpage%
    \fi

    \addFormalPage
    \addCorners
    \addBorders
    \addEpigraph
    \pagestyle{fancy}
}
