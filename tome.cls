% DESC: LaTeX document-class abstraction for academic books.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{tome}[2022/12/12 Nicklas Vraa's custom LaTeX class]

    % Intercept base-class options.
    \newcommand{\onecol}{true}
    \DeclareOption{twocolumn}{
        \renewcommand{\onecol}{false}
        \PassOptionsToClass{\CurrentOption}{report}
    }

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
    \ProcessOptions\relax
    \LoadClass[oneside]{report}

% PACKAGES: --------------------------------------------------------------------

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[nottoc]{tocbibind}
    \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, fancyhdr, float, geometry, graphicx, hyperref, inconsolata, lastpage, listings, microtype, numspell, parskip, setspace, silence, siunitx, svg, tabularray, titlesec, titletoc, titling, ulem, xcolor}

    \WarningsOff* % Ignore all warnings.

% WHITESPACE: ------------------------------------------------------------------

    \geometry{letterpaper, top=40mm, left=34mm, right=34mm, bottom=34mm}

% HEADER & FOOTER: -------------------------------------------------------------

    \setlength{\headsep}{5mm}
    \pagestyle{fancy}
    \renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}
    \fancyhead[L]{\small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark}
    \fancyhead[R]{\small\scshape\color{darkgray} Page \thepage\ of \pageref{LastPage}}
    \fancyfoot[C]{}
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

    % Compile and print frontmatter. Handles undefined values.
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

% TABLE OF CONTENTS: -----------------------------------------------------------

    % Adjust indentation and formatting of entries.
    \titlecontents{section}[0em]{}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsection}[0em]{\hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsubsection}[0em]{\hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}

    \newcommand{\toc}{%
        \tableofcontents\thispagestyle{firstPageOfChapter}%
    }

% FORMATTING: ------------------------------------------------------------------

    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.
    \renewcommand{\u}[1]{\uline{#1}}  % Underline.
    \newcommand{\m}[1]{$#1$}          % Inline math.
    \newcommand{\s}[1]{\sout{#1}}     % Strikethrough.

% HEADINGS: --------------------------------------------------------------------

    \titleformat{\chapter}[display]{%
        \normalsize%
    }{% Prefix.
        \hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter \hfill Page \thepage\ of \pageref{LastPage}%
    }{% Vertical space between.
        \ifnum\pdfstrcmp{\onecol}{true}=0%
            -9pt%
        \else
            -4pt%
        \fi
    }{% Chapter name.
        \LARGE\bfseries\scshape%
    }

    % Adjust spacing between heading and text.
    \titlespacing{\chapter}{-1pt}{-44pt}{4pt}
    \titlespacing\numberless{0pt}{14pt}{4pt}
    \titlespacing\section{0pt}{14pt}{4pt}
    \titlespacing\subsection{0pt}{14pt}{4pt}
    \titlespacing\subsubsection{0pt}{14pt}{4pt}

    % Set formatting of headings.
    \titleformat*{\section}{\bfseries\scshape}
    \titleformat*{\subsection}{\bfseries\scshape}
    \titleformat*{\subsubsection}{\bfseries\scshape}
    \titleformat*{\paragraph}{\bfseries\scshape}
    \titleformat*{\subparagraph}{\bfseries\scshape}

    % Add '.' after number to numbered headings.
    \renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}

    % Set lowest level of heading that will be numbered.
    \setcounter{secnumdepth}{4}

    % Shortcuts for headings.
    \newcommand{\h}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\chapter[#1]{#2}\label{#2}%
        \thispagestyle{firstPageOfChapter}
    }
    \newcommand{\hh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\section[#1]{#2}\label{#2}%
    }
    \newcommand{\hhh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\subsection[#1]{#2}\label{#2}%
    }
    \newcommand{\hhhh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\subsubsection[#1]{#2}\label{#2}%
    }
    \newcommand{\hhhhh}[2][\DefaultOpt]{%
        \def\DefaultOpt{#2}\paragraph[#1]{#2}\label{#2}%
    }

    % Non-numbered heading shortcut.
    \renewcommand{\H}[1]{%
        \chapter*{#1}\label{#1}\addcontentsline{toc}{chapter}{#1}%
        \thispagestyle{firstPageOfChapter}
    }

% CODE: ------------------------------------------------------------------------

    \lstdefinestyle{inline}{ % Inline styling.
        basicstyle=\ttfamily\small, breaklines=true
    }
    \lstdefinestyle{block}{ % Block styling.
        basicstyle=\ttfamily\footnotesize,
        commentstyle=\color[rgb]{0.5,0.5,0.5},
        postbreak=\mbox{\hspace{-2.5em}\textcolor{gray}{$\hookrightarrow$}\space\space},
        breaklines=true,
        numbers=left,
        numberstyle=\tiny,
        numbersep=7pt,
        showspaces=false,
        tabsize=4,
        xleftmargin=14pt
    }
    \RenewDocumentCommand{\c}{v}{%
        \lstinline[style=inline]{#1}%
    } % Shortcut.

    % Custom code environment.
    \lstnewenvironment{code}[3]{
        \newcommand{\append}{\captionof{lstlisting}{#3}\label{#1}}
        \begin{center}\noindent\rule{\columnwidth}{0.1pt}\end{center}\vspace{-1mm}
        \lstset{language=#2,style=block}
    }{
        \vspace{-5mm}
        \begin{center}\noindent\rule{\columnwidth}{0.1pt}\end{center}
        \append\vspace{0.8em}
    }

% MATHEMATICS: -----------------------------------------------------------------

    % Shortcuts.
    \newcommand{\mean}[1]{\overline{#1}}
    \newcommand{\pfrac}[2]{\left( \frac{#1}{#2} \right)}
    \renewcommand{\Re}{\mathbb{R}} % Real set.
    \renewcommand{\Im}{\mathbb{I}} % Imaginary set.
    \newcommand{\N}{\mathbb{N}} % Natural set.
    \newcommand{\Z}{\mathbb{Z}} % Integer set.
    \newcommand{\Q}{\mathbb{Q}} % Rational set.
    \newcommand{\C}{\mathbb{C}} % Complex set.
    \renewcommand{\epsilon}{\varepsilon}

    % Custom math environment.
    \renewenvironment{math}[1]{
        \begin{equation}\label{#1}
    }{
        \end{equation}
    }

% LISTS: -----------------------------------------------------------------------

    % Create new list-type based on 'itemize'.
    \newlist{bullets}{itemize}{10}
    \setlist[bullets,1]{leftmargin=6mm}
    \setlist[bullets]{leftmargin=*,label=$\vcenter{\hbox{\tiny$\bullet$}}$,labelindent=\parindent}

    % Create new list-type based on 'enumerate'.
    \newlist{numbers}{enumerate}{10}
    \setlist[numbers,1]{leftmargin=6mm}
    \setlist[numbers]{leftmargin=*,label*=\arabic*.,labelindent=\parindent}

% FIGURES: ---------------------------------------------------------------------

    \def\maxwidth#1{\ifdim\Gin@nat@width>#1 #1\else\Gin@nat@width\fi}
    \newcommand{\fig}[4][1]{ % One command for vectors and images.
        \begin{figure}[h!]
            \centering
            \filename@parse{#4}
            \ifnum\pdfstrcmp{\filename@ext}{svg}=0%
                \sbox0{\includesvg[width=#1\columnwidth]{#4}}%
            \else%
                \sbox0{\includegraphics[width=\maxwidth{#1\columnwidth}]{#4}}%
            \fi%
            \begin{minipage}{\wd0}\usebox0\caption{#3}\label{#2}\end{minipage}
        \end{figure}
    }

% TABLES: ----------------------------------------------------------------------

    \newcommand{\cols}[3]{ % Column-based table.
        \begin{table}[h!]
            \centering
            \sbox0{%
                \begin{tblr}{
                    hline{1,2,Z} = {0.1pt,solid},
                    rowsep = {1pt},
                    hspan = even}%
                    #3
                \end{tblr}}
            \begin{minipage}{\wd0}
                \usebox0\caption{#2}\label{#1}
            \end{minipage}
        \end{table}
    }
    \newcommand{\rows}[3]{ % Row-based table.
        \begin{table}[h!]
            \centering
            \sbox0{%
                \begin{tblr}{
                    hline{1,Z} = {0.1pt,solid},
                    vline{2} = {0.1pt,solid},
                    rowsep = {1pt},
                    hspan = even}%
                    #3
                \end{tblr}}
            \begin{minipage}{\wd0}
                \usebox0\caption{#2}\label{#1}
            \end{minipage}
        \end{table}
    }
    \newcommand{\grid}[3]{ % Grid-based table.
        \begin{table}[h!]
            \centering
            \sbox0{%
                \begin{tblr}{
                    hline{1,2,Z} = {0.1pt,solid},
                    vline{2} = {0.1pt,solid},
                    rowsep = {1pt},
                    hspan = even}%
                    #3
                \end{tblr}}
            \begin{minipage}{\wd0}
                \usebox0\caption{#2}\label{#1}
            \end{minipage}
        \end{table}
    }

% CAPTIONS: --------------------------------------------------------------------

    % Set formatting of caption text.
    \DeclareCaptionFormat{myformat}{\fontsize{8}{9}\selectfont#1#2#3}
    \captionsetup{
        format=plain,
        labelfont=bf,
        font=scriptsize,
        justification=raggedright,
        singlelinecheck=false
    }

% REFERENCES: -------------------------------------------------------------

    \hypersetup{hidelinks} % Remove box around links.
    \normalem % Allow italized and underlined text.

    % Add reference category for code blocks.
    \renewcommand{\lstlistingname}{Snippet}
    \providecommand*{\lstlistingautorefname}{snippet}

    % Add underline to urls.
    \renewcommand{\url}[2]{\uline{\href{#2}{#1}}}

    % Lowercase reference names.
    \renewcommand{\r}[1]{\renewcommand\lstlistingautorefname{snippet}\renewcommand\figureautorefname{figure}\renewcommand\equationautorefname{equation}\renewcommand\tableautorefname{table}\renewcommand\sectionautorefname{section}\renewcommand\subsectionautorefname{section}\renewcommand\subsubsectionautorefname{section}\renewcommand\paragraphautorefname{section}\renewcommand\subparagraphautorefname{section}\autoref{#1}}

    % Uppercase reference names.
    \newcommand{\R}[1]{\renewcommand\lstlistingautorefname{Snippet}\renewcommand\figureautorefname{Figure}\renewcommand\equationautorefname{Equation}\renewcommand\tableautorefname{Table}\renewcommand\sectionautorefname{Section}\renewcommand\subsectionautorefname{Section}\renewcommand\subsubsectionautorefname{Section}\renewcommand\paragraphautorefname{Section}\renewcommand\subparagraphautorefname{Section}\autoref{#1}}

% BIBLIOGRAPHY: -----------------------------------------------------------

    \bibliographystyle{unsrt} % Sort by order of appearance.
    \newcommand{\bib}[1]{\bibliography{#1}} % Shortcut.
