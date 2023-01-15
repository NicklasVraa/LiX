# LaTeX Class Abstractions
This will eventually be a collection of classes, which simplify the user's interaction with the basic LaTeX-classes by abstracting much of the functionality into higher-level functions with intuitive syntax, much like Markdown, which speeds up writing and allows one to focus on the contents, rather than the typesetting.

**Motivation** \
While LaTeX is the indisputable king for typesetting academic papers, it does have a steep learning curve and is very syntax-heavy. To ease the burden of typesetting and bring the focus back on the content, the syntax should be as light as possible - hence this humble project.

**Classes**
- `Paper` is for typesetting an academic research paper or longer university assignment. It abstracts the `article` class.
- `Tome` is for typesetting an academic piece of litterature, like a textbook or a dissertation. It abstracts on the `report` class.
- `Novel` is for typesetting fiction, like a novel or a short-story.


## The `Paper` Class
This class strives to pack as much information as possible, into a visually coherent environment, while adhering to the standards of academic research papers, like having references and captions. Below is an example, which also acts as a manual. Access the generated pdf's here: [One-column](compiled_pdfs/paper_onecolumn_example.pdf) and [two-column](compiled_pdfs/paper_twocolumn_example.pdf).
| Source                | Two-column            | One-column            |
|-----------------------|-----------------------|-----------------------|
| ![p1](resources/for_readme/s1.png) | ![p1](resources/for_readme/p1.png) | ![o1](resources/for_readme/o1.png) |
| ![p1](resources/for_readme/s2.png) | ![p1](resources/for_readme/p2.png) | ![o2](resources/for_readme/o2.png) |
| ![p1](resources/for_readme/s3.png) | ![p1](resources/for_readme/p3.png) | ![o3](resources/for_readme/o3.png) |
|                       |                       | Pages 4 to 6...       |


## The `Tome` Class
Work-in-progress. See the [example](compiled_pdfs/tome_example.pdf).


## The `Novel` Class
Work-in-progress. See the [example](compiled_pdfs/novel_example.pdf).


## Installation
All classes work out-of-the-box with [Overleaf](https://www.overleaf.com). Simply include the `.cls` file in your project folder.

If you are working locally, you need to have all package dependencies installed. Check up on the [svg](https://ctan.org/pkg/svg?lang=en) package, which has non-latex dependencies. If you have svg's included in your document, the compiler has to be run with the argument: `--shell-escape`.


## Plans
- Simplify the way lists are defined.


## Changelog
Paper:
- Replaced `minted` with `listings` to remove dependency on Pygmentize.
- Added optional scaling argument to `\fig`.
- Increased margins for onecolumn-layout.
- Automatically adjust margins and title placement, if `\header` is called.
- Removed dependency on `ifthen` package.
