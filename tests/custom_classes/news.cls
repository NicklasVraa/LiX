% AUTHOR: Nicklas Vraa
% Documentation: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{news}[2023/02/10 For newspapers]

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
\RequirePackage[code, configs, figures, formats, header, headings, lists, math, meta, refs, tables, titlepage, toc]{lix}
\RequirePackage{setspace, silence, times, titlesec, titletoc, titling, yfonts}

\WarningsOff*
\setlength\parindent{0pt}

% FONT OVERRIDES: --------------------------------------------------------------
\bibfont{\footnotesize}
\authorfont{\normalsize}

% SIZE, MARGINS: ---------------------------------------------------------------
\ifnum\numColumns=1
    \geometry{a3paper, top=20mm, left=14mm, right=14mm, bottom=20mm}
    \setlength{\droptitle}{-3.8em}
    \setlength{\columnsep}{5mm}
\fi

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

% LAYOUT: ----------------------------------------------------------------------
\AddToHook{begindocument/end}{%
    \oldtitle{}
    \oldauthor{}
    \olddate{}
    \addMetadata
}
