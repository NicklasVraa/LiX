% AUTHOR: Nicklas Vraa
% Documentation: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{news}[2023/02/10 For newspapers]

% Intercept class options.
\newcommand{\numColumns}{1}
\DeclareOption{twocolumn}{
    \renewcommand{\numColumns}{2}
    \PassOptionsToClass{\CurrentOption}{book}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt]{book}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[code, configs, figures, formats, header, headings, meta, refs, tables, titlepage]{lix}
\RequirePackage{setspace, silence, times, titlesec, titletoc, titling, yfonts}

\WarningsOff*
\setlength\parindent{0pt}

% FONT OVERRIDES: --------------------------------------------------------------
\bibfont{\footnotesize}
\authorfont{\normalsize}

% SIZE, MARGINS: ---------------------------------------------------------------
\ifnum\numColumns=1
    \geometry{a3paper, top=22mm, left=14mm, right=14mm, bottom=18mm}
    \setlength{\droptitle}{-3.8em}
    \setlength{\columnsep}{5mm}
\fi

% HEADINGS: --------------------------------------------------------------------
\setcounter{secnumdepth}{0}% Levels of heading that will be numbered.

\titlespacing\numberless{0pt}{14pt}{4pt}
\titlespacing\section{0pt}{14pt}{4pt}
\titlespacing\subsection{0pt}{14pt}{4pt}
\titlespacing\subsubsection{0pt}{14pt}{4pt}
\titleformat*{\section}{\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat*{\paragraph}{\bfseries\scshape}

\RenewDocumentCommand{\h}{m}{%
    \section{#1}\label{#1}%
}

% CAPTIONS: --------------------------------------------------------------------
\captionsetup{
    format=plain, labelfont=bf, font=scriptsize,
    justification=raggedright, singlelinecheck=false
}

% LAYOUT: ----------------------------------------------------------------------
\AddToHook{begindocument/end}{%
    \oldtitle{}

    \begin{center}\scalebox{2}{\Huge\textgoth{\theTitle}}\end{center}
    \vspace*{-1mm}\hspace*{-0.5mm}\noindent{\scriptsize\dotfill\hspace*{-0.5mm}}

    \oldauthor{}
    \olddate{}
    \addMetadata
}

% BYLINE: ----------------------------------------------------------------------
\NewDocumentCommand{\byline}{mmg}{
    \IfValueTF{#3}{%
        \begin{figure}[H]
            \begin{minipage}[H]{0.2\columnwidth}
                \vspace*{1.2mm}
                \includegraphics[width=\columnwidth]{#3}
            \end{minipage}%
            \quad
            \begin{minipage}[H]{0.55\columnwidth}
                #1 \\ {\footnotesize #2}
            \end{minipage}
            \vspace*{-5mm}
        \end{figure}
    }{
        #1 \\ {\footnotesize #2}
    }
}

% HEADERS: ---------------------------------------------------------------------
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{{\footnotesize\textbf{\today}}}
\fancyhead[LE,RO]{\textgoth{\theTitle} -- {\footnotesize\textbf{Vol. III}}}
\fancyhead[RE]{{\footnotesize\textbf{International}} -- \textbf{\thepage}}
\fancyhead[LO]{{\textbf{\thepage} -- \footnotesize\textbf{International}}}
\renewcommand{\headrule}{\vspace*{-2.5mm}\hspace*{-0.5mm}\noindent{\scriptsize\dotfill\hspace*{-0.5mm}}}
