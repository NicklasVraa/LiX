% DESC: LaTeX document-class abstraction for academic books.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{lix}[2022/12/12 Nicklas Vraa's custom LaTeX class for fiction]

    % Defaults without options given.
    \newcommand{\theClass}{paper}
    \newcommand{\theBase}{article}
    \newcommand{\numColumns}{1}

    % Set base class.
    \DeclareOption{article}{
        \renewcommand{\theClass}{paper}
        \renewcommand{\theBase}{article}
    }
    \DeclareOption{report}{
        \renewcommand{\theClass}{tome}
        \renewcommand{\theBase}{report}
    }
    \DeclareOption{book}{
        \renewcommand{\theClass}{novel}
        \renewcommand{\theBase}{book}
    }

    % Intercept class options.
    \DeclareOption{twocolumn}{
        \renewcommand{\numColumns}{2}
        \PassOptionsToClass{\CurrentOption}{\theBase}
    }

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{\theBase}}
    \ProcessOptions\relax
    \LoadClass{\theBase}

% PACKAGES: --------------------------------------------------------------------

    % Conditionally import packages, based on the chosen style.
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[nottoc]{tocbibind}
    \RequirePackage{fancyhdr, float, geometry, graphicx, hyperref, lastpage, microtype, setspace, silence, svg, titlesec, titletoc, titling, ulem, xcolor, xparse}

    \ifnum\pdfstrcmp{\theClass}{paper}=0%
        \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, inconsolata, listings, parskip, siunitx, tabularray}

    \else\ifnum\pdfstrcmp{\theClass}{tome}=0%
        \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, inconsolata, listings, numspell, parskip, siunitx, tabularray}

    \else\ifnum\pdfstrcmp{\theClass}{novel}=0%
        \RequirePackage[indent]{parskip}
        \RequirePackage{ebgaramond, numspell}

    \fi\fi\fi

% INITIAL SETUP: ---------------------------------------------------------------

    \WarningsOff* % Ignore all warnings.

    % Save original commands, that will be redefined.
    \NewCommandCopy{\oldtitle}{\title}%
    \NewCommandCopy{\oldauthor}{\author}%
    \NewCommandCopy{\olddate}{\date}%

    % Global settings.
    \setlength{\columnsep}{5mm}%
    \hypersetup{hidelinks}% Remove box around links.
    \normalem % Allow italized and underlined text.

    % PAGE STYLES: -------------------------------------------------------------

        \ifnum\pdfstrcmp{\theClass}{paper}=0%
            \setlength{\droptitle}{-5em}%

        \else\ifnum\pdfstrcmp{\theClass}{tome}=0%
            \setlength{\headsep}{5mm}%
            \pagestyle{fancy}%
            \renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}%
            \fancyhead[L]{\small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark}%
            \fancyhead[R]{\small\scshape\color{darkgray} Page \thepage\ of \pageref{LastPage}}%
            \fancyfoot[C]{}%
            \renewcommand{\headrulewidth}{0pt}%

            \fancypagestyle{firstPageOfChapter}{%
                \fancyhead[L]{}%
                \fancyhead[R]{\small\scshape\color{darkgray} Page \thepage\ of \pageref{LastPage}}%
                \fancyfoot[C]{}%
                \renewcommand{\headrulewidth}{0pt}%
            }
            \fancypagestyle{metadataPage}{%
                \fancyhead{}\fancyfoot{}%
                \renewcommand{\headrulewidth}{0pt}%
            }

        \else\ifnum\pdfstrcmp{\theClass}{novel}=0%
            \setlength{\headsep}{5mm}%
            \pagestyle{fancy}%
            \renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}%
            \fancyhead[L]{}%
            \fancyhead[C]{\small\scshape\color{darkgray} \chaptername\ \thechapter\ --\ \leftmark}%
            \fancyhead[R]{}%
            \fancyfoot[C]{\large\scshape\thepage}%
            \renewcommand{\headrulewidth}{0pt}%

            \fancypagestyle{firstPageOfChapter}{%
                \fancyhead{}%
                \renewcommand{\headrulewidth}{0pt}%
            }
            \fancypagestyle{metadataPage}{%
                \fancyhead{}\fancyfoot{}%
                \renewcommand{\headrulewidth}{0pt}%
            }

        \fi\fi\fi

    % TABLE OF CONTENTS: -------------------------------------------------------

        \titlecontents{section}[0em]{}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
        \titlecontents{subsection}[0em]{\hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
        \titlecontents{subsubsection}[0em]{\hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}

        \ifnum\pdfstrcmp{\theClass}{paper}=0%
            \newcommand{\toc}{\tableofcontents}

        \else\ifnum\pdfstrcmp{\theClass}{tome}=0%
            \newcommand{\toc}{%
                \tableofcontents%
                \thispagestyle{metadataPage}%
            }

        \else\ifnum\pdfstrcmp{\theClass}{novel}=0%
            \newcommand{\toc}{%
                \tableofcontents%
                \thispagestyle{metadataPage}%
            }

        \fi\fi\fi

    % HEADINGS: ----------------------------------------------------------------

        % Add '.' after number to numbered headings.
        \renewcommand*{\@seccntformat}[1]{%
            \csname the#1\endcsname.\hspace{0.5em}%
        }

        \setcounter{secnumdepth}{4} % Levels of heading that will be numbered.

        % Set formatting of headings.
        \titleformat*{\section}{\bfseries\scshape}
        \titleformat*{\subsection}{\bfseries\scshape}
        \titleformat*{\subsubsection}{\bfseries\scshape}
        \titleformat*{\paragraph}{\bfseries\scshape}
        \titleformat*{\subparagraph}{\bfseries\scshape}

        % Adjust spacing between heading and text.
        \titlespacing{\chapter}{-1pt}{-45pt}{4pt}
        \titlespacing\numberless{0pt}{14pt}{4pt}
        \titlespacing\section{0pt}{14pt}{4pt}
        \titlespacing\subsection{0pt}{14pt}{4pt}
        \titlespacing\subsubsection{0pt}{14pt}{4pt}

        \ifnum\pdfstrcmp{\theClass}{paper}=0%
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

            \renewcommand{\abstract}{\textbf{\textsc{Abstract}: }}

        \else\ifnum\pdfstrcmp{\theClass}{tome}=0%
            \titleformat{\chapter}[display]{%
                \normalsize%
            }{% Prefix.
                \hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter%
            }{% Vertical space between.
                \ifnum\numColumns=1%
                    -9pt%
                \else
                    -4pt%
                \fi
            }{% Chapter name.
                \LARGE\bfseries\scshape%
            }

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

        \else\ifnum\pdfstrcmp{\theClass}{novel}=0%
            \titleformat{\chapter}[display]{%
                \normalsize%
            }{% Prefix.
                \centering\hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter%
            }{% Vertical space between.
                -9pt%
            }{% Chapter name.
                \centering\LARGE\bfseries\scshape%
            }

            \NewDocumentCommand{\h}{sm}{%
                \IfBooleanTF{#1}{%
                    \chapter*{#2}\label{#2}%
                    \addcontentsline{toc}{chapter}{#2}%
                }{%
                    \chapter{#2}\label{#2}%
                }
                \thispagestyle{firstPageOfChapter}%
            }

            \newcommand{\abstract}{\textbf{\textsc{Abstract}}}

        \fi\fi\fi

% INTERFACE COMMANDS: ----------------------------------------------------------

    % \title{string}.
    \renewcommand{\title}[1]{%
        \newcommand{\theTitle}{#1}%
    }

    % \author{string}.
    \renewcommand{\author}[1]{%
        \newcommand{\theAuthor}{#1}%
    }

    % \date{string}.
    \renewcommand{\date}[1]{%
        \newcommand{\theDate}{#1}%
    }

    % \subtitle{string}.
    \NewDocumentCommand{\subtitle}{m}{%
        \newcommand{\theSubtitle}{#1}%
    }

    % \header{left:string}{right:string}{center:string}.
    \NewDocumentCommand{\header}{mgg}{% Arguments 2,3 are optional.
        \newcommand{\theLeftHeader}{#1}%
        \IfValueT{#2}{%
            \newcommand{\theCenterHeader}{#2}%
        }
        \IfValueT{#3}{%
            \newcommand{\theRightHeader}{#3}%
        }
    }

    % \lang{string}.
    \NewDocumentCommand{\lang}{m}{%
        \usepackage[#1]{babel}%
        \newcommand{\theLanguage}{#1}%
    }

    % \cover{front:path}{back:path}.
    \NewDocumentCommand{\cover}{mg}{% Argument 2 is optional.
        \usepackage{eso-pic}%
        \newcommand{\theFront}{#1}%
        \IfValueT{#2}{%
            \newcommand{\theBack}{#2}%
        }
    }

    % \license{type:string}{modifier:string}{version:float}.
    \NewDocumentCommand{\license}{mmm}{%
        \usepackage[type={#1},modifier={#2},version={#3}]{doclicense}%
    }

    % \isbn{integer}.
    \NewDocumentCommand{\isbn}{m}{%
        \usepackage{GS1}%
        \GSSetup{ocrb=true,module_height=5ex}%
        \newcommand{\theIsbn}{#1}%
    }

    % \size{size:string}{orientation:string}.
    \NewDocumentCommand{\size}{mg}{% Argument 2 is optional.
        \newcommand{\theSize}{#1}%
        \IfValueT{#2}{%
            \newcommand{\theOrientation}{#2}%
        }
    }

    % \margins{top:length}{left:length}{right:length}{bottom:length}
    \NewDocumentCommand{\margins}{mggg}{% Arguments 2,3,4 are optional.
        \newcommand{\theTopMargin}{#1}%
        \IfValueTF{#2}{%
            \newcommand{\theLeftMargin}{#2}%
        }{%
            \newcommand{\theLeftMargin}{#1}%
        }
        \IfValueTF{#3}{%
            \newcommand{\theRightMargin}{#3}%
        }{%
            \newcommand{\theRightMargin}{#1}%
        }
        \IfValueTF{#4}{%
            \newcommand{\theBottomMargin}{#3}%
        }{%
            \newcommand{\theBottomMargin}{#1}%
        }
    }

    % \note{string}.
    \NewDocumentCommand{\note}{m}{%
        \newcommand{\theNote}{#1}%
    }

    % \publisher{string}.
    \NewDocumentCommand{\publisher}{m}{%
        \newcommand{\thePublisher}{#1}%
    }

    % \edition{string}{integer}.
    \NewDocumentCommand{\edition}{mm}{
        \newcommand{\theEdition}{#1}%
        \newcommand{\theYear}{#2}%
    }

    % \dedicate{dedicatee:string}{messege:string}.
    \NewDocumentCommand{\dedicate}{mm}{%
        \newcommand{\theDedicatee}{#1}%
        \newcommand{\theMessage}{#2}%
    }

    % \thank{string}.
    \NewDocumentCommand{\thank}{m}{%
        \newcommand{\theThankyou}{#1}%
    }

    % \blurb{string}.
    \NewDocumentCommand{\blurb}{m}{%
        \newcommand{\theBlurb}{#1}%
    }

% APPLY CONSTANTS: -------------------------------------------------------------

    % Call \metadata automatically, when beginning document.
    \AddToHook{begindocument/end}{%

        % Title.
        \@ifundefined{theTitle}{%
            \oldtitle{Placeholder Title}%
        }{%
            \oldtitle{\theTitle}%
        }

        % Subtitle.
        \@ifundefined{theSubtitle}{%
            \oldtitle{\huge\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\huge\textbf{\textsc{\theTitle}}\\[0.4ex] \Large\scshape \theSubtitle}%
        }

        % Author.
        \@ifundefined{theAuthor}{%
            \oldauthor{}%
        }{%
            \oldauthor{\theAuthor}%
        }

        % Date.
        \@ifundefined{theDate}{%
            \olddate{}%
        }{%
            \olddate{\normalsize{\theDate}}%
        }

        % Cover.
        \@ifundefined{theFront}{}{%
            \ifnum\pdfstrcmp{\theClass}{paper}=0%
                % Not defined for article.
            \else
                \AddToShipoutPicture*{%
                    \put(0,0){%
                        \parbox[b][\paperheight]{\paperwidth}{%
                            \vfill\centering%
                            \includegraphics[width=\paperwidth,height=\paperheight]{\theFront}%
                            \vfill%
                        }%
                    }%
                }%
            \fi
        }
        % Check if blurb was given.
        \@ifundefined{theBlurb}{}{%
            \ifnum\pdfstrcmp{\theClass}{paper}=0%
                % Not defined for article.
            \else
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
                    \end{minipage}%
                    \par\vspace{5mm}%
                    \begin{minipage}{0.8\linewidth}%
                        \Large{\theBlurb}%
                    \end{minipage}%

                    % Check if ISBN was given.
                    \@ifpackageloaded{GS1}{%
                        \par\vspace*{\fill}%
                        \begin{minipage}{0.8\linewidth}%
                            \hfill%
                            \colorbox{white}{%
                                \expandafter\EANBarcode\expandafter{\theIsbn}%
                            }%
                        \end{minipage}%
                    }{}
                }
            \fi
        }

        \maketitle%

        \ifnum\pdfstrcmp{\theClass}{paper}=0%
            % Not defined for article.
        \else
            \thispagestyle{metadataPage}%
            {\clearpage\raggedright\footnotesize%

                % Dedicate.
                \begin{minipage}{0.6\linewidth}
                    \@ifundefined{theDedicatee}{}{%
                        {\large{\textit{To \theDedicatee}}\par%
                        \vspace{3mm}%
                        \normalsize{\textit{\theMessage.}}}%
                    }
                \end{minipage}

                \null\vfill%

                \begin{minipage}{0.6\linewidth}

                    % Note.
                    \@ifundefined{theNote}{}{%
                        \textbf{Author's Note}: \theNote%
                        \vspace{8mm}%
                    }

                    % Publisher.
                    \@ifundefined{thePublisher}{}{%
                        \textbf{Publisher}: \thePublisher\par%
                    }

                    % Edition.
                    \@ifundefined{theEdition}{}{%
                        \Ordnumspell{\theEdition} edition, published in \theYear.\par%
                    }

                    % Thank.
                    \@ifundefined{theThankyou}{}{%
                        \theThankyou.\par%
                    }

                    % License.
                    \@ifpackageloaded{doclicense}{%
                        \vspace{8mm}%
                        \textbf{Copyright} 2022--\the\year\ \theAuthor\par%
                        \doclicenseLongText \par%
                        \vspace{1mm}%
                        \doclicenseIcon%
                    }{}
                \end{minipage}

                % ISBN.
                \@ifpackageloaded{GS1}{%
                    \vspace{8mm}%
                    ISBN: \theIsbn \hspace{2mm} \par\vspace{1mm}%
                    \expandafter\EANBarcode\expandafter{\theIsbn}%
                }{}
            }%
            \newpage%
        \fi
    }

% CODE: ------------------------------------------------------------------------

    \@ifpackageloaded{listings}{%

        \lstdefinestyle{inline}{% Inline styling.
            basicstyle=\ttfamily\small, breaklines=true%
        }

        \lstdefinestyle{block}{% Block styling.
            basicstyle=\ttfamily\footnotesize,
            commentstyle=\color[rgb]{0.5,0.5,0.5},
            postbreak=\mbox{\hspace{-2.5em}\textcolor{gray}{$\hookrightarrow$}\space\space},
            breaklines=true,
            numbers=left,
            numberstyle=\tiny,
            numbersep=7pt,
            showspaces=false,
            tabsize=4,
            xleftmargin=14pt%
        }

        \RenewDocumentCommand{\c}{v}{%
            \lstinline[style=inline]{#1}%
        }

        % Custom code environment.
        \lstnewenvironment{code}[3]{%
            \newcommand{\append}{\captionof{lstlisting}{#3}\label{#1}}%
            \begin{center}%
                \noindent\rule{\columnwidth}{0.1pt}%
            \end{center}%
            \vspace{-1mm}%
            \lstset{language=#2,style=block}%
        }{%
            \vspace{-5mm}%
            \begin{center}%
                \noindent\rule{\columnwidth}{0.1pt}%
            \end{center}%
            \append\vspace{0.8em}%
        }

        % Add reference category for code blocks.
        \renewcommand{\lstlistingname}{Snippet}
        \providecommand*{\lstlistingautorefname}{snippet}
    }{}

% MATHEMATICS: -----------------------------------------------------------------

        % Shortcuts.
        \newcommand{\mean}[1]{\overline{#1}}
        \renewcommand{\Re}{\mathbb{R}} % Real set.
        \renewcommand{\Im}{\mathbb{I}} % Imaginary set.
        \newcommand{\N}{\mathbb{N}}    % Natural set.
        \newcommand{\Z}{\mathbb{Z}}    % Integer set.
        \newcommand{\Q}{\mathbb{Q}}    % Rational set.
        \newcommand{\C}{\mathbb{C}}    % Complex set.
        \renewcommand{\epsilon}{\varepsilon}

        % Custom math environment.
        \renewenvironment{math}[1]{
            \begin{equation}\label{#1}
        }{
            \end{equation}
        }

% LISTS: -----------------------------------------------------------------------

    \@ifpackageloaded{enumitem}{%

        % Create new list-type based on 'itemize'.
        \newlist{bullets}{itemize}{10}
        \setlist[bullets,1]{leftmargin=6mm}
        \setlist[bullets]{%
            leftmargin=*,
            label=$\vcenter{\hbox{\tiny$\bullet$}}$,
            labelindent=\parindent%
        }

        % Create new list-type based on 'enumerate'.
        \newlist{numbers}{enumerate}{10}
        \setlist[numbers,1]{leftmargin=6mm}
        \setlist[numbers]{%
            leftmargin=*,
            label*=\arabic*.,
            labelindent=\parindent%
        }
    }{}

% FIGURES: ---------------------------------------------------------------------

    \@ifpackageloaded{graphicx}{%

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
    }{}

% TABLES: ----------------------------------------------------------------------

    \@ifpackageloaded{tabularray}{%

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
    }{}

% CAPTIONS: --------------------------------------------------------------------

    \@ifpackageloaded{caption}{%

        % Set formatting of caption text.
        \DeclareCaptionFormat{myformat}{\fontsize{8}{9}\selectfont#1#2#3}
        \captionsetup{
            format=plain,
            labelfont=bf,
            font=scriptsize,
            justification=raggedright,
            singlelinecheck=false
        }
    }{}

% REFERENCES: ------------------------------------------------------------------

    \@ifpackageloaded{cite}{%

        % Add underline to urls.
        \renewcommand{\url}[2]{\uline{\href{#2}{#1}}}

        % Lowercase reference names.
        \renewcommand{\r}[1]{\renewcommand\lstlistingautorefname{snippet}\renewcommand\figureautorefname{figure}\renewcommand\equationautorefname{equation}\renewcommand\tableautorefname{table}\renewcommand\sectionautorefname{section}\renewcommand\subsectionautorefname{section}\renewcommand\subsubsectionautorefname{section}\renewcommand\paragraphautorefname{section}\renewcommand\subparagraphautorefname{section}\autoref{#1}}

        % Uppercase reference names.
        \newcommand{\R}[1]{\renewcommand\lstlistingautorefname{Snippet}\renewcommand\figureautorefname{Figure}\renewcommand\equationautorefname{Equation}\renewcommand\tableautorefname{Table}\renewcommand\sectionautorefname{Section}\renewcommand\subsectionautorefname{Section}\renewcommand\subsubsectionautorefname{Section}\renewcommand\paragraphautorefname{Section}\renewcommand\subparagraphautorefname{Section}\autoref{#1}}

        \bibliographystyle{unsrt} % Sort by order of appearance.
        \newcommand{\bib}[1]{\bibliography{#1}} % Shortcut.
    }{}

% ADDITIONAL: ------------------------------------------------------------------

    % Inline formatting.
    \renewcommand{\b}[1]{\textbf{#1}} % Bold.
    \renewcommand{\i}[1]{\textit{#1}} % Italic.
    \renewcommand{\u}[1]{\uline{#1}} % Underline.
    \newcommand{\m}[1]{$#1$} % Inline math.
    \newcommand{\s}[1]{\sout{#1}} % Strikethrough.

    \newcommand{\add}[1]{\input{#1}}
