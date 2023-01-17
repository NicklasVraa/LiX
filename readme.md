# LaTeX Class Abstractions
This is a collection of classes, which simplify the user's interaction with the basic LaTeX-classes by abstracting much of the functionality into higher-level functions with intuitive syntax, much like Markdown, which speeds up writing and allows one to focus on the contents, rather than the typesetting.

**Motivation**: \
While LaTeX is the indisputable king for typesetting academic papers, it does have a steep learning curve and is very syntax-heavy. To ease the burden of typesetting and bring the focus back on the content, the syntax should be as light as possible - hence this humble project.

**Classes**:
- `Paper` is for typesetting academic research papers and university assignments. It abstracts the article class.
- `Tome` is for typesetting academic litterature, like textbooks and dissertations. It abstracts the report class.
- `Novel` is for typesetting fiction, like novels or a short-stories. It abstracts the book class.


**Overview**:
1. [Examples](#examples) - What your finished result might look like.
   - [Paper](#paper) - Research papers and university assignments.
   - [Tome](#tome) - Textbooks and dissertations.
   - [Novel](#novel) - Novels or a short-stories.
2. [Syntax](#syntax) - How to use the classes.
   - [Metadata](#metadata) - Covers, title, subtitle, author, licensing, isbn, etc.
   - [Heading](#heading) - The various levels of headings.
   - [Formatting](#formatting) - Embolden and italicize text, etc.
   - [Codeblocks](#codeblocks) - How to define blocks of code.
   - [Math](#math) - How to define math blocks.
   - [Lists](#lists) - How to define various types of lists.
   - [Tables](#tables) - How to create various types of tables.
   - [Figures](#figures) - How to place external figures, like images or svg's.
   - [Referencing](#referencing) - Internally reference, cite and link.
3. [Installation](#installation) - Notes on using the classes locally or in Overleaf.
4. [Plans](#plans) - What's next?

---
## 1. Examples <a name="examples"></a>

### The `Paper` Class <a name="paper"></a>
This class strives to pack as much information as possible, into a visually coherent environment, while adhering to the standards of academic research papers, like having references, citations and captions. Below is an example, which also acts as a manual. Access the full document [here](paper_example.pdf).
| Source                             | Build (Two-column)             |
|------------------------------------|--------------------------------|
| ![p1](screenshots/src_paper_1.png) | ![p1](screenshots/paper_1.png) |
| ![p1](screenshots/src_paper_2.png) | ![p1](screenshots/paper_2.png) |

---
### The `Tome` Class <a name="tome"></a>
This class is intended to typeset a large amount of academic content to be printed in book form. As with the paper class, it focuses on visual coherence, while adhering to the standards of academic printing, like having a cover-, title- and metadata page, references, citations and captions. Below is an example, which also acts as a manual. Access the full document [here](tome_example.pdf).
| Source                             | Build (One-column)           |
|------------------------------------|------------------------------|
| ![p1](screenshots/src_tome_1.png) | ![p1](screenshots/tome_1.png) |
| ![p1](screenshots/src_tome_2.png) | ![p1](screenshots/tome_2.png) |

---
### The `Novel` Class <a name="novel"></a>
This class is meant for typesetting fiction with the intent to print. This class also supply cover-, title- and metadata pages using very simple commands. Access the full document [here](novel_example.pdf).
| Source                             | Build                          |
|------------------------------------|--------------------------------|
| ![p1](screenshots/src_novel_1.png) | ![p1](screenshots/novel_1.png) |

---
## 2. Syntax <a name="syntax"></a>
This is an overview of the commands, which are available in the abstracted classes.

### Metadata <a name="metadata"></a>
Think of these commands as initializing constants, most of which are optional. These will be used throughout the document in the appropriate places. Currently, there are 8 available constants:
```latex
\lang{your_language}               % Optional. Defaults to English.
\cover{path/to/your/cover.pdf}     % Optional.
\title{This is your Title}         % Always mandatory.
\subtitle{And your Subtitle}       % Optional.
\author{Name Lastname}             % Only mandatory if license is also used.
\date{01/01/2023}                  % Optional.
\license{Type}{modifiers}{version} % Optional. E.g \license{CC}{by-nc-sa}{3.0}.
\isbn{978-0201529838}              % Optional.
```
The values of these may be used anywhere in the document using `\theCover`, `theTitle`, etc. The commands `\cover`, `\license`, and `\isbn` are for `tome` and `novel` classes only. To make the titlepage and a page with licensing and other metadata, use:
```latex
\begin{document}
\metadata % Usually inserted right after \begin{document}.
...
\end{document}
```

### Heading <a name="heading"></a>
Top-level headings will act like chapters in tomes and novels.
```latex
\H{...}   % Unnumbered heading.
\h{...}   % Numbered heading. Level one.
\hh{...}  % Numbered heading. Level two.
\hhh{...} % Numbered heading. Level three.
% etc...
```

### Formatting <a name="formatting"></a>
These command names were chosen to ensure that the readability of the source code is minimally affected.
```latex
\b{...} % Bold text.
\i{...} % Italic text.
\u{...} % Underline text.
\s{...} % Strikeout.
\c{...} % Inline code.
\m{...} % Inline math. Equivalent to $...$
```

### Codeblocks <a name="codeblocks"></a>
Codeblocks will be subtly highlighted according to the given language.
```latex
\begin{code}{label}{language}{caption}
... % Code, as is (verbatim).
\end{code}
```

### Math <a name="math"></a>
The label is required and the math block will be numbered.
```latex
\begin{math}{label}
... % Regular LaTeX math syntax.
\end{math}
```

### Lists <a name="lists"></a>
The formatting of these lists have been greatly simplified. It is of course possible to nest lists.
```latex
\begin{bullets} % Always a dot, regardless of nesting.
    \item ...
\end{bullets}

\begin{numbers} % Arabic numbering (1, 2, 3...)
    \item ...
\end{numbers}
```

### Tables <a name="tables"></a>
There are three types. These three tables will cover 90% of your table-needs, but you have access to the full power of the tabularray package for more complicated tables. The `&` symbol separates items and `\\` separates rows.
```latex
\cols{label}{caption}{ % The first row acts as the header.
    ...
}
\rows{label}{caption}{ % The first column acts as the header.
    ...
}
\grid{label}{caption}{ % Both the first row and column act as headers.
    ...
}
```

### Figures <a name="figures"></a>
This command will take care of placing your figure correctly and it file-format agnostic i.e. it works the same for both regular images and vector graphics.
```latex
\fig[scale]{label}{caption}{path} % Scale is optional.
```

### Referencing <a name="referencing"></a>
Reference your figures, tables, math, codeblocks, etc., using the labels, you provided. Cite external sources from your bibliography. Link to external sources.
```latex
\r{label}              % Reference figures, tables, etc., with a lowercase name.
\R{label}              % Uppercase equivalent of \r.
\cite{your_source}     % As defined in your bibliography file.
\url{label text}{link} % E.g. {this website}{https://www.somewebsite.com}
\bib{path/to/refs}     % Without the '.bib' extension.
```

---
## 3. Installation <a name="installation"></a>
All classes work out-of-the-box with [Overleaf](https://www.overleaf.com). Simply include the appropriate `.cls` file in your project folder.

If you are working locally, you need to have all package dependencies installed. Check up on the [svg](https://ctan.org/pkg/svg?lang=en) package, which has non-latex dependencies. If you have svg's included in your document, the compiler has to be run with the argument: `--shell-escape`.

---
## 4. Plans <a name="plans"></a>
- Simplify the way lists are defined.
- Add placement argument to `\cover` command for title, subtitle, etc.
- Add command: `\size{papersize}{orientation}`
- Add command: `\margins{top}{bot}{left}{right}`
