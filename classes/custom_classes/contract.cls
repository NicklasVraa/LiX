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
\RequirePackage{setspace, silence, titlesec, titletoc, titling}
\RequirePackage{times}

\WarningsOff*
\setlength\parindent{0pt}
\renewcommand\maketitlehookc{\vspace{-2ex}}

% HEADER: ----------------------------------------------------------------------
\fancypagestyle{plain}{% First page.
    \renewcommand{\headrulewidth}{0pt}%
    \@ifundefined{theLeftHeader}{
        \fancyhead[L]{}
    }{%
        \fancyhead[L]{\scriptsize\theLeftHeader}%
    }
    \fancyhead[R]{\scriptsize Page \thepage\ of \pageref{LastPage}}%
    \@ifundefined{theIdnum}{
        \fancyfoot{}%
    }{
        \fancyfoot[C]{\footnotesize\theIdnum}%
    }
}
\fancypagestyle{fancy}{%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhead[L]{\scriptsize\theLeftHeader}%
    \fancyhead[R]{\scriptsize Page \thepage\ of \pageref{LastPage}}%
    \fancyfoot{}%
}
\pagestyle{fancy}

% SIZE, MARGINS: ---------------------------------------------------------------
\geometry{a4paper, top=30mm, left=24mm, right=24mm, bottom=24mm}
\setlength{\columnsep}{4mm}
\setlength{\droptitle}{-5em}
\fancyhfoffset[O]{0pt}

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
\titleformat{\section}{\bfseries\scshape}{?? \arabic{section}.}{0.5em}{}
\titleformat*{\subsection}{\scshape}
\titleformat*{\subsubsection}{\scshape}
\titleformat*{\paragraph}{\scshape}

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
    \@ifundefined{theTitle}{}{%

        \@ifundefined{theSubtitle}{%
            \oldtitle{\raggedright\Large\scshape\theTitle}%
        }{%
            \oldtitle{\raggedright\Large\scshape\theTitle\\[0.4ex]%
            \normalsize\scshape\theSubtitle}%
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
        \olddate{\raggedright\normalsize{\theDate}}%
    }

    \@ifundefined{theTitle}{}{%
        \maketitle%
    }

    \addMetadata
}
