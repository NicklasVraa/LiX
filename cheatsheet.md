# LiX Cheatsheet
An overview of all the commands that are available through LiX. Read about each command in the [readme](readme.md).

## Standard commands
```latex
\documentclass{someclass} % article, book, report, paper, textbook, novel, novella, ieee.
\usepackage[one,or,more,bundles]{lix} %code, configs, cover, figures, formats, header, headings, lists, math, meta, refs, tables, titlepage, toc, verso.
```

## Formatting commands
```latex
\b{...}    % (b)old text.
\c{...}    % (c)ode inline.
\i{...}    % (i)talic text.
\l{...}    % (l)arge letter (Lettrine).
\m{...}    % (m)ath inline.
\s{...}    % (s)trikeout.
\u{...}    % (u)nderline.

\h{...}    % Level one heading.
\hh{...}   % Level two heading.
\hhh{...}  % Level three heading.
\hhhh{...} % Level four heading.
```

## Custom one-line commands
```latex
\abstract  {your summary}                        % The location and style is set by the class.
\add       {file.tex}                            % Alias to input{}.
\authors   {first}{second}{...}{sixth}           % Line break is done using \\.
\bib       {path/to/file}{style}                 % Styles: abbrv, acm, alpha, apalike, ieeetr, plain, siam, unsrt.
\blurb     {flavor-text}                         % Printed on the back cover of a book-type class.
\cover     {path/to/front.pdf}{path/to/back.pdf} % Has to be pdf.
\date      {February 07, 2023}                   % Can of course take \today as input.
\dedicate  {dedicatee}{message}                  % The location and style is set by the class.
\edition   {number}{year}                        % E.g. \edition{1}{2023}.
\fig       {label}{scale}{path}{caption}         % Scale [0;1].
\header    {left}{center}{right}                 % Location and style is set by the class.
\isbn      {code}                                % Will automatically add a barcode.
\lang      {english}                             % Calls babel to handle proper splitting of words.
\license   {type}{modifiers}{version}{holder}    % E.g \license{CC}{by-nc-sa}{3.0}. Holder is optional.
\margins   {top}{bot}{left}{right}               % Alternatively: {all}, {topbot}{leftright}, {top}{bot}{leftright}.
\note      {...}                                 % Location and style is set by the class.
\publisher {...}                                 % Location and style is set by the class.
\size      {standard}{orientation}               % E.g. \size{a4}{portrait}.
\subtitle  {...}                                 % Location and style is set by the class.
\thank     {...}                                 % Location and style is set by the class.
\title     {...}                                 % Location and style is set by the class.
\url       {text}{website}                       % Style is set by the class.
\use       {pkg1, pkg2, ..., pkgN}               % Alias to usepackage{}.
```

## Custom multi-line commands
Should be indented by four spaces for readability. Mandatory for `\code`.
```latex
\code{label}{language}{ % Caption is optional. For no highlighting, use `text` as language.
...
}{caption}

\cols{n}{ % Will split its content into n balanced columns. E.g. horizontally align figs.
...
}

\items{ % Use items*{} for bullet points.
¤ Something.
¤ Another thing.
}

\math{label}{ % Standard LaTeX math.
...
}

\tabs{label}{type}{ % Caption is optional. Types are 'cols', 'rows' and 'grid'.
...
}{caption}
```
