% DESC: LaTeX document-class abstraction for academic papers.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{paper}[2022/12/12 Nicklas Vraa's custom LaTeX class]

    % Intercept base-class options.
    \newcommand{\onecol}{true}
    \DeclareOption{twocolumn}{
        \renewcommand{\onecol}{false}
        \PassOptionsToClass{\CurrentOption}{article}
    }

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
    \ProcessOptions\relax
    \LoadClass{article}

% PACKAGES: --------------------------------------------------------------------

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[nottoc]{tocbibind}
    \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, fancyhdr, float, geometry, graphicx, hyperref, inconsolata, lastpage, listings, microtype, parskip, setspace, silence, siunitx, svg, tabularray, titlesec, titletoc, titling, ulem, xcolor}

    \WarningsOff* % Ignore all warnings.

% COLUMN-COUNT-SPECIFIC: -------------------------------------------------------

    % Adjust margins, title placement and 1st level heading formatting.
    \ifnum\pdfstrcmp{\onecol}{true}=0
        \geometry{a4paper, top=28mm, left=34mm, right=34mm, bottom=36mm}
        \setlength{\droptitle}{-3.8em}
    \else
        \geometry{a4paper, top=22mm, left=26mm, right=26mm, bottom=32mm}
        \setlength{\columnsep}{5mm}
        \setlength{\droptitle}{-2.8em}
    \fi

% PAGESTYLES, HEADER & FOOTER: -------------------------------------------------

    \fancypagestyle{firstpage}{%
        \fancyhf{}
        \fancyfoot[C]{\thepage\ of \pageref{LastPage}}
        \renewcommand{\headrulewidth}{0pt}
    }
    \fancypagestyle{withoutheader}{%
        \fancyhf{}
        \fancyfoot[C]{\thepage\ of \pageref{LastPage}}
        \renewcommand{\headrulewidth}{0.0pt}
    }
    \fancypagestyle{withheader}{%
        \fancyhf{}
        \fancyfoot[C]{\thepage\ of \pageref{LastPage}}
        \renewcommand{\headrulewidth}{0.1pt}
    }
    \pagestyle{withoutheader}

    % If header is included, adjust margins and title placement.
    \newcommand{\header}[3]{%
        \ifnum\pdfstrcmp{\onecol}{true}=0 % If one-column.
            \geometry{a4paper, top=32mm, left=34mm, right=34mm, bottom=36mm}
        \else % Else if two-column.
            \geometry{a4paper, top=30mm, left=26mm, right=26mm, bottom=32mm}
        \fi
        \setlength{\droptitle}{-5em}
        \pagestyle{withheader}
        \lhead{#1}\chead{#2}\rhead{#3}
    }

% METADATA: --------------------------------------------------------------------

    % Redefine commands, but save original prefixed with 'old'.
    \NewCommandCopy{\oldtitle}{\title}
    \renewcommand{\title}[1]{%
        \newcommand{\theTitle}{#1}%
    }

    \newcommand{\subtitle}[1]{%
        \newcommand{\theSubtitle}{#1}%
    }

    \NewCommandCopy{\oldauthor}{\author}
    \renewcommand{\author}[1]{%
        \newcommand{\theAuthor}{#1}
    }

    \NewCommandCopy{\olddate}{\date}
    \renewcommand{\date}[1]{%
        \newcommand{\theDate}{#1}
    }

    % Compile and print frontmatter. Handles undefined.
    \newcommand{\metadata}{%

        % Check if subtitle was given.
        \@ifundefined{theSubtitle}{%
            \oldtitle{\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\textbf{\textsc{\theTitle}}\\[0.8ex] \large\scshape \theSubtitle}%
        }

        % Check if author was given.
        \@ifundefined{theAuthor}{%
            \oldauthor{}%
        }{%
            \oldauthor{\normalsize{\theAuthor}}%
        }

        % Check if date was given.
        \@ifundefined{theDate}{%
            \olddate{}%
        }{%
            \olddate{\normalsize{\theDate}}%
        }

        \maketitle
    }

    % Call \metadata automatically, when beginning document.
    \AddToHook{begindocument/end}{%
        \metadata%
    }

% ABSTRACT: --------------------------------------------------------------------

    \renewcommand{\abstract}{\textbf{\textsc{Abstract}}}

% TABLE OF CONTENTS: -----------------------------------------------------------

    % Adjust indentation and formatting of entries.
    \titlecontents{section}[0em]{}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsection}[0em]{\hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
    \titlecontents{subsubsection}[0em]{\hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}

    \newcommand{\toc}{\tableofcontents} % Shortcut.

% FORMATTING: ------------------------------------------------------------------

    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.
    \renewcommand{\u}[1]{\uline{#1}} % Underline.
    \newcommand{\m}[1]{$#1$} % Inline math.
    \newcommand{\s}[1]{\sout{#1}} % Strikethrough.

% HEADINGS: --------------------------------------------------------------------

    % Adjust spacing between heading and text.
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
    \setcounter{secnumdepth}{3}

    % Shortcuts for headings.
    \NewDocumentCommand{\h}{sm}{%
        \IfBooleanTF{#1}{%
            \section*{#2}\label{#2}%
            \addcontentsline{toc}{section}{#2}%
        }{%
            \section{#2}\label{#2}%
        }
    }
    \NewDocumentCommand{\hh}{sm}{%
        \IfBooleanTF{#1}{%
            \subsection*{#2}\label{#2}%
            \addcontentsline{toc}{subsection}{#2}%
        }{%
            \subsection{#2}\label{#2}%
        }
    }
    \NewDocumentCommand{\hhh}{sm}{%
        \IfBooleanTF{#1}{%
            \subsubsection*{#2}\label{#2}%
            \addcontentsline{toc}{subsubsection}{#2}%
        }{%
            \subsubsection{#2}\label{#2}%
        }
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

% REFERENCES: ------------------------------------------------------------------

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

% BIBLIOGRAPHY: ----------------------------------------------------------------

    \bibliographystyle{unsrt} % Sort by order of appearance.
    \newcommand{\bib}[1]{\bibliography{#1}} % Shortcut.

% ADDITIONAL: ------------------------------------------------------------------

    \newcommand{\add}[1]{%
        \input{#1}%
    }
