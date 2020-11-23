# Obsidian to LaTex

A tool to create academic reports straight from [Obsidian notes](https://obsidian.md). The parser translated from Obsidian markdown to LaTex and it only requires some structure in the way you write your notes/essays.

## Using the parser
If you prefer an example, checkout the `example/` directory.
 
**The project settings file**

A `.json` file that contains a specification the translation jobs from markdown to LaTex and other settings. The file has the following structure:
```
{
    "jobs" : [
        {
            "input" : "directory/of the input/note_essay1.md",
            "output": "directory/of the output/note_essay1.tex"
        },
        {
            "input" : "directory/of the input/note_essay2.md",
            "output": "directory/of the output/note_essay2.tex"
        },
    ],
    "settings" : {
        "latex_local_images_dir" : "Figures/"
    }
}
```
The `jobs` are the pairs of markdown -> Latex files. The parser reads all the input files first and scans them for headers. Then it translates them to LaTex and saves them into the output files. The input files are accessed with read-only and therefore they are safe from modification. The content of the output files is instead erased and replaced with the translation.

The settings:
- `latex_local_images_dir`: The sub-directory of the figures within the LaTex project. That is, relative to the root folder where the LaTex compiler is run.

Currently there are no more settings.

**Writing in Obsidian**

The `obsidian.css` is contains a theme optimized for academic research in Obsidian (I'll work out an explanation elsewhere soon). Just activate community themes on Obsidian and drop this file in the vault. Some day I'll try to include it with the community themes.  

**Running the parser**

On your terminal, just type
    
    > python main.py "path/to/config.json"

Some summary will be printed on the screen, including if there are undefined labels.

## Markdown syntax for the parser
**Bold, italics and highlights**

Just as you normally would

**Headers**

First, second and third-level headers work as usual and translate to chapter, section and subsection in LaTex. Fourth-level headers have been repurposed to block comments (see next). Deeper levels are currently not handled and will parse as normal text.

**Block comments**

Four-level headers (`#### `) are interpreted as comments and macros for the parser. They are not translated to LaTex. The Obsidian theme that comes with this repository makes them small and faded, and in preview mode they are hidden unless hovered over with the mouse. You can use them to indicate the topic of a paragraph, for instance.

**Citations**

Citations must have the format `` `jordan1973` `` or `[[jordan1973]]`. It is important that they contain a year between 1800 and 2000+, and that there are no other characters other than letters or numbers. For instance, `` `john-ann1993` `` might not parse correctly.

If multiple citations are needed, separate them with comma and/or space. That is, `` `jordan1973`, [[marione1998]], [[james2017]]`` will produce the LaTex code `\cite{jordan1973, marione1998, james2017}`.

**References in document**

Refer to figures and equations with the notation `` `fig:aircraft_wing` `` and `` `eq:aircraft_lift` ``. These will be translated to `\autoref{fig:aircraft_wing}` and `\autoref{eq:aircraft_lift}` in LaTex.

**References to sections and other documents**

You can use the Obsidian notation `[[doc_name#header title]]` or `[[#header title]]`. If the document is within the list of translation jobs it will be referenced. The parser creates a label in LaTex for every header, so a reference becomes `\autoref{sec:header_title__doc_name}`. If a reference is not found (e.g. it points to a file not included in the list of translation jobs), it will be highlighted instead (i.e. replaced in LaTex with `\hl{doc_name#header title}`) so you can easily see it and make corrections.

**Equations**

An equation block must not be inline, for instance:
```
The above discussion leads to the following equation:
$$
y = \frac{1}{x}
$$
```
will be translated to
```
The above discussion leads to the following equation:
\begin{equation}
y = \frac{1}{x}
\end{equation}
```
Labeling equations is possible with the following notation:
```
The above discussion leads to `eq:inverse_relation`:
#### eq:inverse_relation
$$
y = \frac{1}{x}
$$
```
which will translate to 
```
The above discussion leads to \autoref{eq:inverse_relation}:
\begin{equation}
\label{eq:inverse_relation}
y = \frac{1}{x}
\end{equation}
```
If an equation is referenced in text but the label is not defined it will be notified in the terminal output. It will also be detected by the latex compiler later, of course.

**Figures**

Figures require a command that tells the parser which file to use in the latex project and optionally the width of the figure (otherwise, the default is `0.5\linewidth`). The notation is the following in markdown:
```
#### Latex figure: graph_of_inverse.png w=0.7
`fig:inverse_plot`: Here you write the caption
![[fig_file_in_obsidian.png]]
```
which is translated to 
```
\begin{figure}[H]
	\centering
	\includegraphics[width=0.7\linewidth]{imgs_dir/graph_of_inverse.png}
	\caption{Here you write the caption}
	\label{fig:inverse_plot}
\end{figure}
```
It is important that the command and the caption follow the syntax above, otherwise the parser will not detect them. Notice that the images in obsidian are ignored by the parser. The parameter `imgs_dir/` is the directory of the images within you latex project and must be specified in the config file alongside the translation jobs.

**Tables**

Tables are currently not parsed. If detected by the parser, they will be commented in latex.

**Footnotes**

You can use footnotes as you would normally in Obsidian and they will be parsed to `\footnote{}` commands in LaTex.

**Block quotes**

Block quotes in obsidian translate to text within `\begin{blockquote}` and `\end{blockquote}` in LaTex (make sure the package is loaded).

**Scratch pad section**

Between the header and the text, there must be a line separator `---`. Anything before the line separator will be skipped. For instance:
```
# Title of the essay

some comments/notes/etc
This text will not be parsed to LaTex

---
The text below the horizontal line is parsed to LaTex 
```
Line separators are always ignored, but the first one is important to separate the scratch text from the translated text.