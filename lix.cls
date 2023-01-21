% DESC: LaTeX document-class abstraction for academic books.
% AUTH: Nicklas Vraa.

% CLASS CONFIGURATION: ---------------------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{lix}[2022/12/12 Nicklas Vraa's custom LaTeX class for fiction]

    \newcommand{\theClass}{paper}
    \newcommand{\theBase}{article}

    \DeclareOption{paper}{
        \renewcommand{\theClass}{paper}
        \renewcommand{\theBase}{article}
    }
    \DeclareOption{tome}{
        \renewcommand{\theClass}{tome}
        \renewcommand{\theBase}{report}
    }
    \DeclareOption{novel}{
        \renewcommand{\theClass}{novel}
        \renewcommand{\theBase}{book}
    }

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{\theBase}}
    \ProcessOptions\relax
    \LoadClass{\theBase}

% PACKAGES: --------------------------------------------------------------------
% Conditionally import packages, based on the chosen style.

    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[indent]{parskip}
    \RequirePackage{float, geometry, graphicx, lastpage, microtype, parskip, setspace, silence, svg, titlesec, titletoc, titling, tocbibind, xcolor, xparse}

    \ifnum\pdfstrcmp{\theClass}{paper}=0%
        \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, fancyhdr, hyperref, inconsolata, listings, siunitx, tabularray, ulem}

    \else\ifnum\pdfstrcmp{\theClass}{tome}=0%
        \RequirePackage{amsfonts, amsmath, amssymb, caption, cite, enumitem, esint, fancyhdr, hyperref, inconsolata, listings, numspell, siunitx, tabularray, ulem}

    \else\ifnum\pdfstrcmp{\theClass}{novel}=0%
        \RequirePackage{ebgaramond}

    \fi\fi\fi

% INITIAL SETUP: ---------------------------------------------------------------

    \WarningsOff* % Ignore all warnings.

    % Save original commands, that will be redefined.
    \NewCommandCopy{\oldtitle}{\title}%
    \NewCommandCopy{\oldauthor}{\author}%
    \NewCommandCopy{\olddate}{\date}%

% DEFAULTS: --------------------------------------------------------------------



% SETUP COMMANDS: --------------------------------------------------------------
% These serve to set document constants, which are implemented with \newcommand.

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

    % \columns{integer}.
    \NewDocumentCommand{\columns}{m}{%
        \newcommand{\theColumns}{#1}%
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

        \maketitle%
    }
