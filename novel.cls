% DESC: LaTeX document-class abstraction for academic books.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{novel}[2022/12/12 Nicklas Vraa's custom LaTeX class]

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
    \ProcessOptions\relax
    \LoadClass[12pt,oneside,onecolumn]{book}

% PACKAGES: --------------------------------------------------------------------

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[indent]{parskip}
    \RequirePackage{cite, ebgaramond, enumitem, fancyhdr, float, geometry, graphicx, hyperref, microtype, setspace, silence, svg, titlesec, titling, xcolor}

    \WarningsOff* % Ignore all warnings.

% WHITESPACE: ------------------------------------------------------------------

    \geometry{letterpaper, top=40mm, left=40mm, right=40mm, bottom=40mm}

% PAGESTYLES, HEADER & FOOTER: -------------------------------------------------

    \setlength{\headsep}{5mm}
    \pagestyle{fancy}
    \renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}
    \fancyhead[L]{}
    \fancyhead[C]{\small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark}
    \fancyhead[R]{}
    \fancyfoot[C]{\large\scshape\thepage}
    \renewcommand{\headrulewidth}{0pt}

    % Specifically for pages containing the chapter heading.
    \fancypagestyle{firstPageOfChapter}{%
        \fancyhead{}%
        \renewcommand{\headrulewidth}{0pt}%
    }

    % Specifically for metadata page.
    \fancypagestyle{metadataPage}{%
        \fancyhead{}%
        \fancyfoot{}%
        \renewcommand{\headrulewidth}{0pt}%
    }

% METADATA & COVER: ------------------------------------------------------------

    % Redefine commands, but save original prefixed with 'old'.
    \NewCommandCopy{\oldtitle}{\title}
    \renewcommand{\title}[1]{%
        \newcommand{\theTitle}{#1}%
    }

    \NewCommandCopy{\oldauthor}{\author}
    \renewcommand{\author}[1]{%
        \newcommand{\theAuthor}{#1}%
    }

    \NewCommandCopy{\olddate}{\date}
    \renewcommand{\date}[1]{%
        \newcommand{\theDate}{#1}%
    }

    % Define new metadata commands.
    \newcommand{\cover}[1]{%
        \usepackage{eso-pic}%
        \newcommand{\theCover}{#1}%
    }

    \newcommand{\subtitle}[1]{%
        \newcommand{\theSubtitle}{#1}%
    }

    \newcommand{\license}[3]{
        \usepackage[type={#1},modifier={#2},version={#3}]{doclicense}%
    }

    \newcommand{\isbn}[1]{
        \usepackage{GS1}%
        \GSSetup{ocrb=true,module_height=5ex}%
        \newcommand{\theIsbn}{#1}%
    }

    % Compile and print frontmatter. Handles undefined.
    \newcommand{\metadata}{%

        % Check if cover was given.
        \@ifundefined{theCover}{}{%
            \AddToShipoutPicture*{%
                \put(0,0){%
                    \parbox[b][\paperheight]{\paperwidth}{%
                        \vfill\centering%
                        \includegraphics[width=\paperwidth,height=\paperheight]{\theCover}%
                        \vfill%
                    }%
                }%
            }%
        }

        % Check if subtitle was given.
        \@ifundefined{theSubtitle}{%
            \oldtitle{\huge\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\huge\textbf{\textsc{\theTitle}}\\[0.4ex] \Large\scshape \theSubtitle}%
        }

        % Check if author was given.
        \@ifundefined{theAuthor}{%
            \oldauthor{}%
        }{%
            \oldauthor{\theAuthor}%
        }

        % Check if date was given.
        \@ifundefined{theDate}{%
            \olddate{}%
        }{%
            \olddate{\normalsize{\theDate}}%
        }

        \maketitle

        % Metadata page.
        \thispagestyle{metadataPage}%
        {\clearpage\null\vfill\raggedright\footnotesize%

            % Check if license was given.
            \@ifpackageloaded{doclicense}{%
                Copyright 2022--\the\year\ \theAuthor\par
                \doclicenseLongText \par%
                \doclicenseIcon%
            }{}

            % Check if ISBN was given.
            \@ifpackageloaded{GS1}{%
                \hfill ISBN: \theIsbn \hspace{2mm} \par\vspace{1mm}%
                \hfill\expandafter\EANBarcode\expandafter{\theIsbn}%
            }{}%
        }

    }

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
