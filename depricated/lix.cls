% PAGE STYLES: ---------------------------------------------------------

    \ifnum\pdfstrcmp{\theClass}{paper}=0%
        \setlength{\droptitle}{-3em}%

    \else\ifnum\pdfstrcmp{\theClass}{tome}=0%
        \setlength{\droptitle}{-120mm}%
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

% CUSTOM DOCUMENT COMMANDS: ----------------------------------------------------

    \renewcommand{\abstract}{\textbf{\textsc{Abstract}: }}
    \newcommand{\abstract}{\textbf{\textsc{Abstract}}}

% CUSTOM STYLING: --------------------------------------------------------------

    \ifnum\custom=1

        \setlength{\columnsep}{5mm}%
        \hypersetup{hidelinks}% Remove box around links.
        \normalem % Allow italized and underlined text.

        % TABLE OF CONTENTS: ---------------------------------------------------

        \titlecontents{section}[0em]{}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
        \titlecontents{subsection}[0em]{\hspace*{1.4em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}
        \titlecontents{subsubsection}[0em]{\hspace*{2.8em}}{\thecontentslabel.\hspace*{0.5em}}{}{\titlerule*[0.5pc]{.}\contentspage}

        \ifnum\pdfstrcmp{\theClass}{tome}=0%
            \renewcommand{\toc}{%
                \tableofcontents%
                \thispagestyle{metadataPage}%
            }

        \else\ifnum\pdfstrcmp{\theClass}{novel}=0%
            \renewcommand{\toc}{%
                \tableofcontents%
                \thispagestyle{metadataPage}%
            }

        \fi\fi

        % HEADINGS: ------------------------------------------------------------

        % Add dot after number to numbered headings.
        \renewcommand*{\@seccntformat}[1]{%
            \csname the#1\endcsname.\hspace{0.5em}%
        }

        % Levels of heading that will be numbered.
        \setcounter{secnumdepth}{4}

        % Adjust spacing between heading and text.
        \titlespacing{\chapter}{-1pt}{-45pt}{4pt}
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

        \ifnum\pdfstrcmp{\theClass}{tome}=0%
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

        \fi\fi
    \fi

% STYLE INTERFACE: -------------------------------------------------------------

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

% APPLY CONSTANTS: -------------------------------------------------------------

    % Call \metadata automatically, when beginning document.
    \AddToHook{begindocument/end}{%

        % Title.
        \@ifundefined{theTitle}{}{%

            \ifnum\pdfstrcmp{\theClass}{paper}=0
                \newcommand{\theStyledTitle}{\huge\textbf{\textsc{\theTitle}}}

            \else\ifnum\pdfstrcmp{\theClass}{tome}=0
                \newcommand{\theStyledTitle}{\Huge\textbf{\textsc{\theTitle}}}

            \else\ifnum\pdfstrcmp{\theClass}{novel}=0
                \newcommand{\theStyledTitle}{\huge\textbf{\textsc{\theTitle}}}

            \else
                \newcommand{\theStyledTitle}{\theTitle}

            \fi\fi\fi

            % Subtitle.
            \@ifundefined{theSubtitle}{%
                \oldtitle{\theStyledTitle}%
            }{%
                \oldtitle{\theStyledTitle\\[0.4ex]%
                \Large\scshape\theSubtitle}%
            }
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

        \@ifundefined{theTitle}{}{%
            \maketitle%
        }

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
