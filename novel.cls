% DESC: LaTeX document-class abstraction for academic books.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{novel}[2022/12/12 Nicklas Vraa's custom LaTeX class]

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
    \ProcessOptions\relax
    \LoadClass[12pt,oneside]{book}

% PACKAGES: --------------------------------------------------------------------

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[indent]{parskip}
    \RequirePackage{cite, ebgaramond, enumitem, fancyhdr, float, geometry, graphicx, hyperref, microtype, setspace, silence, svg, titlesec, titling, xcolor}

    \WarningsOff* % Ignore all warnings.

% WHITESPACE: ------------------------------------------------------------------

    \geometry{letterpaper, top=40mm, left=40mm, right=40mm, bottom=40mm}

% HEADER & FOOTER: -------------------------------------------------------------

    \setlength{\headsep}{5mm}
    \pagestyle{fancy}
    \renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}
    \fancyhead[L]{}
    \fancyhead[C]{\small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark}
    \fancyhead[R]{}
    \fancyfoot[C]{\large\scshape\color{darkgray}\thepage}
    \renewcommand{\headrulewidth}{0pt}

    % Specifically for pages containing the chapter heading.
    \fancypagestyle{firstPageOfChapter}{%
        \fancyhead{}%
        \renewcommand{\headrulewidth}{0pt}%
    }

% FRONTMATTER: -----------------------------------------------------------------

    % Reduce vertical space before date.
    \NewCommandCopy{\olddate}{\date}
    \renewcommand{\date}[1]{%
        \olddate{\vspace{0.2em}\normalsize{#1}}%
    }

    % Title, subtitle, authors and byline commands.
    \newcommand{\titles}[2]{%
        \title{\textbf{\textsc{#1}}\\[0.8ex] \large\scshape #2}%
    }

    \newcommand{\authors}[1]{%
        \author{#1}%
    }

    % Either this alone, or both \authors and \date.
    \newcommand{\byline}[1]{%
        \author{#1} \date{}%
    }

    % Shortcut.
    \newcommand{\frontpage}{\maketitle}

% FORMATTING: ------------------------------------------------------------------

    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.
    \newcommand{\s}[1]{\sout{#1}}     % Strikethrough.

% HEADINGS: --------------------------------------------------------------------

    \titleformat{\chapter}[display]{%
        \normalsize%
    }{% Prefix.
        \centering\hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter%
    }{% Vertical space between.
        -9pt%
    }{% Chapter name.
        \centering\LARGE\bfseries\scshape%
    }

    % Adjust spacing between heading and text.
    \titlespacing{\chapter}{-1pt}{-44pt}{10pt}

    % Add '.' after number to numbered headings.
    \renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}

    % Set lowest level of heading that will be numbered.
    \setcounter{secnumdepth}{4}

    % Shortcuts for headings.
    \newcommand{\h}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\chapter[#1]{#2}\label{#2}%
        \thispagestyle{firstPageOfChapter}
    }

    % Non-numbered heading shortcut.
    \renewcommand{\H}[1]{%
        \chapter*{#1}\label{#1}\addcontentsline{toc}{chapter}{#1}%
        \thispagestyle{firstPageOfChapter}
    }

% FIGURES: ---------------------------------------------------------------------

    \def\maxwidth#1{\ifdim\Gin@nat@width>#1 #1\else\Gin@nat@width\fi}
    \newcommand{\fig}[2][1]{ % One command for vectors and images.
        \begin{figure}[h!]
            \centering
            \filename@parse{#2}
            \ifnum\pdfstrcmp{\filename@ext}{svg}=0%
                \includesvg[width=#1\columnwidth]{#2}%
            \else%
                \includegraphics[width=\maxwidth{#1\columnwidth}]{#2}%
            \fi%
        \end{figure}
    }

% REFERENCES: -------------------------------------------------------------

    \hypersetup{hidelinks} % Remove box around links.
