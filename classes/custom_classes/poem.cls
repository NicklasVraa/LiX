% Auth: Nicklas Vraa
% Docs: https://github.com/NicklasVraa/LiX
% ------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{poem}[2023/02/10 For academic research papers]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article}

% SETUP: -----------------------------------------------------------------------
\RequirePackage[basics, formatting, header, headings, metadata, ornaments, size]{lix}
\RequirePackage{miama}

% OVERRIDES: -------------------------------------------------------------------
\setlength\parindent{0pt}
\authorfont{\scriptsize}
\RenewDocumentCommand{\l}{mg}{
    \lettrine[lines=1, loversize=-0.3, lraise=-0.1, findent=-2pt]{#1}{\IfValueTF{#2}{#2}{}}
}

% SIZE, MARGINS: ---------------------------------------------------------------
\geometry{a5paper, top=40mm, left=35mm, right=35mm, bottom=35mm}
\setlength{\droptitle}{-5em}

\fancypagestyle{plain}{%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhead[C]{%
        \fmmfamily\scriptsize\theAuthor\ %
        \@ifundefined{theDate}{}{%
            - \theDate%
        }
    }%
    \fancyfoot{}%
}

% LAYOUT: ----------------------------------------------------------------------
\wrap{%
    \fmmfamily
    \@ifundefined{theTitle}{}{%
        \oldtitle{\Large\textbf{\theTitle}\vspace*{-12.5ex}}%
    }
    \oldauthor{}%
    \olddate{}%

    \@ifundefined{theTitle}{}{%
        \maketitle%
    }
    \addMetadata
    \addCorners
    \addBorders
    \centering
}
