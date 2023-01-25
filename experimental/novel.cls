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
