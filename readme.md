# LiX <!-- omit in toc -->
Lix is a package which bundles other packages and commands. These bundles may be specified when importing the LiX package, either in your own document-class, or directly in your main document, when using a predefined class. The goal of this package is to speed up writing your documents, but also to simplify the process of defining your own class.

**Motivation**: \
While LaTeX is the indisputable king for typesetting publishable documents, it does have a steep learning curve and is very syntax-heavy. To ease the burden of typesetting and bring the author's focus back on their content, the syntax should be as light as possible. Defining your own look-and-feel is even more inaccessible, if one is not familiar with basic programming -  hence this humble project, which attempts to address these issues.

Advantages:
- The source code of a document becomes as easy to read and understand as Markdown and is drastically shorter.
- The style of a document is completely separated from its content, and keeping a consistent style is simpler.
- Configuring your document is simpler, because you don't interface directly with individual packages, which may employ different syntax.
- Creating your own class, which implements a custom look-and-feel, is much easier.

Disadvantages:
- If one wants to change their document into a class that has not been defined using this package, there may be difficulties when compiling. To address this, I've recreated the `IEEEtran` class, as a reference for how to reimplement an existing look using LiX.
- You do not have the extreme fine-grained control over your custom class, as you would with pure LaTeX.

**Bundles**: \
A bundle has one purpose: To easily enable a certain aspect of a document, like having code blocks. In this case, when defining your own class, you simply specify `code` when importing `lix`.
The currently available bundles are (in alphabetical order):
```latex
code, configs, cover, figures, formats, header, headings, lists, math, meta, refs, tables, titlepage, toc, verso
```
Exactly what each bundle provides is specified in the [syntax ](#syntax-)-section.

---
## 1. Class Examples <a name="examples"></a>
Using this package, I've defined some custom classes, which are ready for use, as well as classes which mimic popular formats. Look at the source code for each class to see how easily they were defined.
|  |   |   |   |   |   |   |
| ----- | - | - | - | - | - | - |
| [Paper](tests/custom_classes/paper.cls) packs as much information as possible, while adhering to the standards of academic research papers. | ![p1](screenshots/paper/p1.png) | ![p2](screenshots/paper/p2.png) |
| [Novel](tests/custom_classes/novel.cls) is meant for fiction with the intent to print. This class supplies cover-, title- and metadata pages using very simple commands.| ![p1](screenshots/novel/p1.png) | ![p2](screenshots/novel/p2.png) | ![p4](screenshots/novel/p4.png) | ![p5](screenshots/novel/p5.png) | ![p6](screenshots/novel/p6.png) | ![p7](screenshots/novel/p7.png) |
| [Textbook](tests/custom_classes/textbook.cls) is intended for typesetting a large amount of academic content to be printed in book form. | ![p1](screenshots/textbook/p1.png) | ![p2](/screenshots/textbook/p2.png) | ![p4](screenshots/textbook/p4.png) | ![p5](screenshots/textbook/p5.png) | ![p6](screenshots/textbook/p6.png) | ![p7](screenshots/textbook/p7.png) |
| [IEEE](tests/popular_classes/ieee.cls) implements the IEEE journal and transactions template, but using LiX. | ![p1](screenshots/ieee/p1.png) | ![p2](screenshots/ieee/p2.png)


It is also possible to use the standard classes, like [article](tests/standard_classes/article_example.tex), [report](tests/standard_classes/report_example.tex) and [book](tests/standard_classes/book_example.tex), but still benefits from simplified syntax. Simply import the package and specify the `stdclass` option, along with any bundles, e.g.:
```latex
\documentclass{article}
\usepackage[stdclass, ...]{lix}
```
It is very simple to convert to another class, as they all share the exact same syntax.

---
## 2. LiX Syntax <a name="syntax"></a>
This is an overview of the commands, which are available when specifying a certain bundle (in alphabetical order). To those unfamilier with LaTeX, a command is always prefixed with a backslash `\`, mandatory input is enclosed in `{}` and optional input is enclosed in `[]`. Whitespace between a command and its input does not matter. Comments are always prefixed with a percentage symbol `%`.

Shortcuts: [Aliases ](#aliases-), [Code ](#code-), [Configs ](#configs-), [Cover ](#cover-), [Figures ](#figures-), [Formats ](#formats-), [Header ](#header-), [Heading ](#heading-), [Lists ](#lists-), [Math ](#math-), [Refs ](#refs-), [Tables ](#tables-), [Titlepage ](#titlepage-), [Toc ](#toc-), [Verso ](#verso-)

### Aliases <a name="aliases"></a>
These are always available, and are simply aliases, which are more intuitive for a new LaTeX-user.
```latex
\use{package1, package2, ...} % Import packages.
\add{path/to/file.tex} % Inserts the tex-code from the given file.
\url{label text}{link} % E.g. {this website}{https://www.somewebsite.com}
```

### Code <a name="code"></a>
Code blocks will be subtly highlighted according to the given language.
```latex
% Available with the 'code' option.
\code{label}{language}{
    % Your code.
}{caption}
```
Caption is optional. For no highlighting, set the language to `text`. Indent the code four spaces for best readability in the source file. These will be removed in the resulting pdf.

### Configs <a name="configs"></a>
For setting up the basic characteristics of your document.
```latex
% Available with the 'configs' option.
\lang    {language}
\size    {standard}{orientation}

\margins {top}{bot}{left}{right}
% Alternatively: {all}, {topbot}{leftright}, {top}{bot}{leftright}
```

For the `\size` command:
| ISO-A | ISO-B | ISO-C | ANSI | US | Orientation |
|-------|-------|-------|------|----|-------------|
| `a0` <br> `a1` <br> ... <br> `a6` | `b0` <br> `b1` <br> ... <br> `b6` | `c0` <br> `c1` <br> ... <br> `c6` | `ansia` <br> `ansib` <br> ... <br> `ansie` | `letter` <br> `executive` <br> `legal` | `portrait` <br> `landscape` |

E.g `\size{a4}{portrait}`.

### Cover <a name="cover"></a>
The front and back of a book.
```latex
% Available with the 'cover' option.
\cover{path/to/front.pdf}{path/to/back.pdf}
\blurb{Flavor text for the back}
```
`cover*` will **not** print the title, author, etc. on top of the cover. This is useful, if the cover already includes these.

### Figures <a name="figures"></a>
This command will take care of placing your figure correctly and it is file-format agnostic i.e. it works the same for both regular images and vector graphics.
```latex
\fig{label}{scale}{path}{caption}
```
Caption is optional.

### Formats <a name="formats"></a>
These command names were chosen to ensure that the readability of the source code is minimally affected.
```latex
\b{...} % Bold text.
\i{...} % Italic text.
\u{...} % Underline text.
\s{...} % Strikeout.
\c{...} % Inline code.
\m{...} % Inline math.
```

### Header <a name="header"></a>
The strip of text at the top of each page.
```latex
% Available with the 'header' option.
\header{left}{center}{right}
```

### Heading <a name="heading"></a>
Top-level headings will act like chapters in book-like classes, but as a section article-like classes. Headings will be numbered, unless a `*` is added to the command, e.g. `\h*{...}`.
```latex
\h{...}    % Level one.
\hh{...}   % Level two.
\hhh{...}  % Level three.
\hhhh{...} % Level four.
```
The regular commands, like `\chapter` and `section` can still be used along with their starred counterparts.

### Lists <a name="lists"></a>
The styling of these lists have been simplified. It is of course possible to nest lists.
```latex
\begin{bullets} % Always a dot, regardless of nesting.
    \item ...
\end{bullets}
```
```latex
\begin{numbers} % 1, 2, 3...
    \item ...
\end{numbers}
```

### Math <a name="math"></a>
The label is required and the math block will be numbered.
```latex
\math{label}{
    % Regular latex math.
}
```
Shortcut commmands in the math environment:
- `\mean{x}` $\rightarrow \overline{x}$
- `\Re` $\rightarrow \mathbb{R}$ (Real set)
- `\Im` $\rightarrow \mathbb{I}$ (Imaginary set)
- `\N` $\rightarrow \mathbb{N}$ (Natural set)
- `\Z` $\rightarrow \mathbb{Z}$ (Integer set)
- `\Q` $\rightarrow \mathbb{Q}$ (Rational set)
- `\C` $\rightarrow \mathbb{C}$ (Complex set)
- `\epsilon` $\rightarrow \varepsilon$ (varepsilon)

### Refs <a name="refs"></a>
Reference your figures, tables, math, codeblocks, etc., using the labels, you provided. Cite external sources from your bibliography. Link to external sources.
```latex
\r{label}          % Reference figures, tables, etc.
\R{label}          % Uppercase equivalent of \r.

\cite{your_source} % As defined in your bibliography file.

\bib{path/to/refs}{style}
% Without the '.bib' extension.
% Style is optional, default is in order of appearence.
```
Bibliography Styles:
```latex
abbrv, acm, alpha, apalike, ieeetr, plain, siam, unsrt
```

### Tables <a name="tables"></a>
There are three types. These three tables will cover 90% of your table-needs, but you have access to the full power of the tabularray package for more complicated tables. The `&` symbol separates items and `\\` separates rows.
```latex
\tabs{label}{type}{
    % Your table content.
}{caption}
```
Caption is optional.

Types:
- `cols`: Classic table, the top row acts as the header.
- `rows`: The left-most column acts as the header.
- `grid`: Both the top row and left-most column act as headers.

Formatting code for the table can also be given explicitly in the type field.

### Titlepage <a name="titlepage"></a>
Automatically imported, if `cover` option is specified.
```latex
% Available with the 'titlepage' option.
\title    {This is your Title}
\subtitle {And your Subtitle}
\author   {Name Lastname}
\date     {01/01/2023} % \today is also available.
\abstract {Summary of your findings}
```

### Toc <a name="toc"></a>
Print table of content, as is appropriate for your current document-class.
```latex
\toc
```

### Verso <a name="verso"></a>
The page after the front-cover of a book, which contains formal information.
```latex
% Available with the 'verso' option.
\license   {type}{modifiers}{version}
\isbn      {978-0201529838}
\edition   {123}{year}
\publisher {Your Publishing Company}
\dedicate  {dedicatee}{Messege}
\thank     {people or organisations}
\note      {Longer author's note}
```

For the `\license` command:
| Types | Modifiers | Versions |
|-------|-----------|----------|
| Creative Commons: `CC` | Attribution: `by` <br> ShareAlike: `sa` <br> NoDerivatives: `nd` <br> NonCommercial: `nc` <br> | Universal: `1.0` <br> Unported: `3.0` <br> International: `4.0` |

E.g `\license{CC}{by-nc-sa}{3.0}`.


---
## 3. Installation <a name="installation"></a>
The LiX package and all classes work out-of-the-box with [Overleaf](https://www.overleaf.com). Simply include `lix.sty` and the appropriate `.cls` file in your project folder.

If you are working locally, you need to have all package dependencies installed. Depending on which bundles are imported, LiX may import the following packages:
```latex
amsfonts, amsmath, amssymb, babel, caption, cite, doclicense, ebgaramond, enumitem, esint, eso-pic, fancyhdr, float, fontenc, geometry, graphicx, GS1, hyperref, inconsolata, inputenc, lastpage, listings, microtype, numspell, parskip, setspace, silence, siunitx, svg, tabularray, titlesec, titletoc, titling, tocbibind, ulem, xcolor, xparse
```
All of which are available through CTAN.

Check up on the [svg](https://ctan.org/pkg/svg?lang=en) package, which has non-latex dependencies. If you have svg's included in your document, the compiler has to be run with the argument: `--shell-escape`.

For VSCode, I recommend installing the [LaTeX Workshop](https://github.com/James-Yu/LaTeX-Workshop) extension, and adding this to your `settings.json`:
```json
"workbench.editorAssociations": {
    "*.pdf": "latex-workshop-pdf-hook"
},
"latex-workshop.latex.tools": [
    {
        "name": "latexmk",
        "command": "latexmk",
        "args": [
            "--shell-escape",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "-pdf",
            "-outdir=%OUTDIR%",
            "%DOC%"
        ]
    },
    {
        "name": "pdflatex",
        "command": "pdflatex",
        "args": [
            "--shell-escape",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "%DOC%"
        ]
    },
    {
        "name": "bibtex",
        "command": "bibtex",
        "args": [
            "%DOCFILE%"
        ]
    }
],
"latex-workshop.latex.autoBuild.run": "never",
"latex-workshop.latex.autoClean.run": "onBuilt",
```

---
## 4. Plans <a name="plans"></a>
In order of priority:
- [x] Add `\idnum` command to be used for things like IEEE publishing ID.
- [ ] Add more setter commands, like `\setbibfont{}`.
- [ ] Add support for multiple authors.
- [ ] Add option to generate qr-code to `\url` command.
- [ ] Use IfValueTF to implement arbitrarily positioned optional arguments for tables and figures.
- [ ] Change delimiter in tables from `&` to `|` and `\\` to newline.
