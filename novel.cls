% DESC: LaTeX document-class abstraction for academic books.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{novel}[2022/12/12 Nicklas Vraa's custom LaTeX class for fiction]

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
    \ProcessOptions\relax
    \LoadClass[12pt,oneside,onecolumn]{book}

% PACKAGES: --------------------------------------------------------------------

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[indent]{parskip}
    \RequirePackage{cite, ebgaramond, enumitem, fancyhdr, float, geometry, graphicx, hyperref, microtype, numspell, setspace, silence, svg, titlesec, titling, xcolor, xparse}

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
    \NewDocumentCommand{\cover}{mg}{
        \usepackage{eso-pic}
        \newcommand{\theFront}{#1}
        \IfValueT{#2}{
            \newcommand{\theBack}{#1}%
        }
    }

    \newcommand{\subtitle}[1]{%
        \newcommand{\theSubtitle}{#1}%
    }

    \newcommand{\lang}[1]{
        \usepackage[#1]{babel}
        \newcommand{\theLanguage}{#1}
    }

    \newcommand{\license}[3]{
        \usepackage[%
            type={#1},modifier={#2},version={#3}%
        ]{doclicense}%
    }

    \newcommand{\isbn}[1]{
        \usepackage{GS1}%
        \GSSetup{ocrb=true,module_height=5ex}%
        \newcommand{\theIsbn}{#1}%
    }

    \newcommand{\size}[2]{
        \newcommand{\theSize}{#1}
        \newcommand{\theOrientation}{#2}
        \geometry{paper= #1paper, #2}
    }

    \newcommand{\margins}[4]{
        \geometry{top=#1, bottom=#2, left=#3, right=#4}
        \fancyhfoffset[E,O]{0pt}
        \setlength{\headsep}{5mm}
    }

    \newcommand{\note}[1]{
        \newcommand{\theNote}{#1}
    }

    \newcommand{\publisher}[1]{
        \newcommand{\thePublisher}{#1}
    }

    \newcommand{\edition}[2]{
        \newcommand{\theEdition}{#1}
        \newcommand{\theYear}{#2}
    }

    \newcommand{\dedicate}[2]{
        \newcommand{\theDedicatee}{#1}
        \newcommand{\theMessage}{#2}
    }

    \newcommand{\thank}[1]{
        \newcommand{\theThankyou}{#1}
    }

    \newcommand{\blurb}[1]{
        \newcommand{\theBlurb}{#1}
    }

    % Compile and print frontmatter. Handles undefined values.
    \newcommand{\metadata}{%

        % Check if cover was given.
        \@ifundefined{theFront}{}{%
            \AddToShipoutPicture*{%
                \put(0,0){%
                    \parbox[b][\paperheight]{\paperwidth}{%
                        \vfill\centering%
                        \includegraphics[width=\paperwidth,height=\paperheight]{\theFront}%
                        \vfill%
                    }%
                }%
            }%
        }
        % Check if blurb was given.
        \@ifundefined{theBlurb}{}{%
            \AtEndDocument{%
                \newpage%
                \thispagestyle{metadataPage}%
                \@ifundefined{theBack}{}{%
                    \AddToShipoutPicture*{%
                        \put(0,0){%
                            \parbox[b][\paperheight]{\paperwidth}{%
                                \vfill\centering%
                                \includegraphics[width=\paperwidth,height=\paperheight]{\theBack}%
                                \vfill%
                            }%
                        }%
                    }%
                }
                \centering
                \begin{minipage}{0.8\linewidth}%
                    \centering%
                    \Large{\textbf{\theTitle}}%
                \end{minipage}
                \par\vspace{5mm}
                \begin{minipage}{0.8\linewidth}%
                    \Large{\theBlurb}%
                \end{minipage}

                % Check if ISBN was given.
                \@ifpackageloaded{GS1}{%
                    \par\vspace*{\fill}%
                    \begin{minipage}{0.8\linewidth}%
                        \hfill%
                        \colorbox{white}{%
                            \expandafter\EANBarcode\expandafter{\theIsbn}%
                        }%
                    \end{minipage}
                }{}
            }
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
        {\clearpage\raggedright\footnotesize%

            % Check if dedication was given.
            \begin{minipage}{0.6\linewidth}
                \@ifundefined{theDedicatee}{}{%
                    {\large{\textit{To \theDedicatee}}\par%
                    \vspace{3mm}%
                    \normalsize{\textit{\theMessage.}}}%
                }
            \end{minipage}

            \null\vfill%

            \begin{minipage}{0.6\linewidth}

                % Check if a note was given.
                \@ifundefined{theNote}{}{%
                    \textbf{Author's Note}: \theNote%
                    \vspace{8mm}%
                }

                % Check if publisher was given.
                \@ifundefined{thePublisher}{}{%
                    \textbf{Publisher}: \thePublisher\par%
                }

                % Check if edition was given.
                \@ifundefined{theEdition}{}{%
                    \Ordnumspell{\theEdition} edition, published in \theYear.\par%
                }

                % Check if thank you was given.
                \@ifundefined{theThankyou}{}{%
                    \theThankyou.\par%
                }

                % Check if license was given.
                \@ifpackageloaded{doclicense}{%
                    \vspace{8mm}%
                    \textbf{Copyright} 2022--\the\year\ \theAuthor\par%
                    \doclicenseLongText \par%
                    \vspace{1mm}%
                    \doclicenseIcon%
                }{}
            \end{minipage}

            % Check if ISBN was given.
            \@ifpackageloaded{GS1}{%
                \vspace{8mm}%
                ISBN: \theIsbn \hspace{2mm} \par\vspace{1mm}%
                \expandafter\EANBarcode\expandafter{\theIsbn}%
            }{}
        }
    }

    % Call \metadata automatically, when beginning document.
    \AddToHook{begindocument/end}{%
        \metadata%
    }

% FORMATTING: ------------------------------------------------------------------

    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.

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
    \setcounter{secnumdepth}{3}

    % Shortcuts for headings.
    \NewDocumentCommand{\h}{sm}{%
        \IfBooleanTF{#1}{%
            \chapter*{#2}\label{#2}%
            \addcontentsline{toc}{chapter}{#2}%
        }{%
            \chapter{#2}\label{#2}%
        }
        \thispagestyle{firstPageOfChapter}%
    }
    \NewDocumentCommand{\hh}{sm}{%
        \IfBooleanTF{#1}{%
            \section*{#2}\label{#2}%
            \addcontentsline{toc}{section}{#2}%
        }{%
            \section{#2}\label{#2}%
        }
    }
    \NewDocumentCommand{\hhh}{sm}{%
        \IfBooleanTF{#1}{%
            \subsection*{#2}\label{#2}%
            \addcontentsline{toc}{subsection}{#2}%
        }{%
            \subsection{#2}\label{#2}%
        }
    }
    \NewDocumentCommand{\hhhh}{sm}{%
        \IfBooleanTF{#1}{%
            \subsubsection*{#2}\label{#2}%
            \addcontentsline{toc}{subsubsection}{#2}%
        }{%
            \subsubsection{#2}\label{#2}%
        }
    }

% Images: ---------------------------------------------------------------------

    \def\maxwidth#1{\ifdim\Gin@nat@width>#1 #1\else\Gin@nat@width\fi}
    \NewDocumentCommand{\fig}{mG{1}}{ % Dor vectors and images.

        \begin{figure}[h!]
            \centering
            \filename@parse{#1}
            \ifnum\pdfstrcmp{\filename@ext}{svg}=0%
                \includesvg[width=#2\columnwidth]{#1}%
            \else%
                \includegraphics[width=\maxwidth{#2\columnwidth}]{#1}%
            \fi%
        \end{figure}
    }

% REFERENCES: ------------------------------------------------------------------

    \hypersetup{hidelinks} % Remove box around links.

% ADDITIONAL: ------------------------------------------------------------------

    \newcommand{\add}[1]{%
        \input{#1}%
    }
