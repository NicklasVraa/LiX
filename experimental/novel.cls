\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{novel}[For works of fiction]

% Intercept class options.
\newcommand{\numColumns}{1}
\DeclareOption{twocolumn}{
    \renewcommand{\numColumns}{2}
    \PassOptionsToClass{\CurrentOption}{book}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt,oneside]{book}

% SETUP: -----------------------------------------------------------------------
\RequirePackage{base, meta, front} % Collections.
\RequirePackage[indent]{parskip}
\RequirePackage{ebgaramond, setspace, silence, titlesec, titletoc, titling}

\WarningsOff*
\newcommand{\use}[1]{\usepackage{#1}}

% SIZE, MARGINS: ---------------------------------------------------------------
\geometry{letterpaper, top=36mm, bottom=40mm, left=40mm, right=40mm}

% COVER: -----------------------------------------------------------------------
\setlength{\droptitle}{-110mm}%

% HEADINGS: --------------------------------------------------------------------
\setcounter{secnumdepth}{1}% Levels of heading that will be numbered.
\titlespacing{\chapter}{-1pt}{-45pt}{10pt}
\titlespacing\numberless{0pt}{14pt}{4pt}
\titlespacing\section{0pt}{14pt}{4pt}
\titlespacing\subsection{0pt}{14pt}{4pt}
\titlespacing\subsubsection{0pt}{14pt}{4pt}
\titleformat*{\section}{\bfseries\scshape}
\titleformat*{\subsection}{\bfseries\scshape}
\titleformat*{\subsubsection}{\bfseries\scshape}
\titleformat{\chapter}[display]{%
    \normalsize%
}{% Prefix.
    \centering\hspace{1pt}\small\scshape\color{darkgray}\chaptertitlename \ \thechapter%
}{% Vertical space between.
    -9pt%
}{% Chapter name.
    \centering\LARGE\bfseries\scshape%
}

% PAGESTYLES: ------------------------------------------------------------------
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

% LAYOUT: ----------------------------------------------------------------------
\AddToHook{begindocument/end}{%
    \@ifundefined{theTitle}{}{%
        \@ifundefined{theSubtitle}{%
            \oldtitle{\Huge\textbf{\textsc{\theTitle}}}%
        }{%
            \oldtitle{\Huge\textbf{\textsc{\theTitle}}\\[0.4ex]%
            \large\scshape\theSubtitle}%
        }
    }
    \@ifundefined{theAuthor}{%
        \oldauthor{}%
    }{%
        \oldauthor{\normalsize{\theAuthor}}%
    }
    \@ifundefined{theDate}{%
        \olddate{}%
    }{%
        \olddate{\normalsize{\theDate}}%
    }
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
    \@ifundefined{theBlurb}{}{%
        \AtEndDocument{%
            \newpage\thispagestyle{metadataPage}%
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

            \begin{minipage}{0.9\linewidth}%
                \Large{\theBlurb}%
            \end{minipage}%

            \@ifundefined{theIsbn}{}{%
                \par\vspace*{\fill}%
                \begin{minipage}{0.9\linewidth}%
                    \hfill%
                    \colorbox{white}{%
                        \expandafter\EANBarcode\expandafter{\theIsbn}%
                    }%
                \end{minipage}%
            }
        }
    }

    \@ifundefined{theTitle}{}{%
        \maketitle%
    }

    \thispagestyle{metadataPage}{%
        \clearpage\raggedright\footnotesize%
        \begin{minipage}{0.6\linewidth}
            \@ifundefined{theDedicatee}{}{%
                {\large{\textit{To \theDedicatee}}\par%
                \vspace{3mm}%
                \normalsize{\textit{\theMessage.}}}%
            }
        \end{minipage}

        \null\vfill%

        \begin{minipage}{0.6\linewidth}
            \@ifundefined{theNote}{}{%
                \textbf{Author's Note}: \theNote%
                \vspace{8mm}\par%
            }
            \@ifundefined{thePublisher}{}{%
                \textbf{Publisher}: \thePublisher\par%
            }
            \@ifundefined{theEdition}{}{%
                \Ordnumspell{\theEdition} edition, published in \theYear.\par%
            }
            \@ifundefined{theThankyou}{}{%
                \theThankyou.\par%
            }
            \@ifpackageloaded{doclicense}{%
                \vspace{8mm}%
                \textbf{Copyright} 2022--\the\year\ \theAuthor\par%
                \doclicenseLongText \par%
                \vspace{1mm}%
                \doclicenseIcon%
                \par%
            }{}
        \end{minipage}

        \@ifundefined{theIsbn}{}{%
            \vspace{8mm}%
            ISBN: \theIsbn \hspace{2mm} \par\vspace{1mm}%
            \expandafter\EANBarcode\expandafter{\theIsbn}%
        }
    }%
    \newpage%
}
