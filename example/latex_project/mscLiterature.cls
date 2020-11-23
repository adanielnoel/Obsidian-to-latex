%%-----------------------------------------------------------------------------
%% Master of Science Literature style file
%% Delft Center for Systems and Control
%% Delft University of Technology
%%
%% This thesis style is distributed freely. 
%% Please be so kind to report errors and possible improvements to the authors
%% 
%%        P.S.C. Heuberger
%%        p.s.c.heuberger@tudelft.nl
%%
%%-----------------------------------------------------------------------------
%% Adapted from:
%%
%% Delft University of Technology Control and Simulation MSc thesis
%% http://www.cs.lr.tudelft.nl/
%%
%%        C. DeWagter, Msc.
%%        C. Borst, MSc.
%%-----------------------------------------------------------------------------
%% First adaptation for DCSC
%%
%%        M. Burger
%%        S.D. Snorradottir
%%-----------------------------------------------------------------------------
%% Update information:
%% October 24, 2011 (Peter Heuberger)
%%     -corrected width of "bies" from 610 to 595 (line 1194) 
%%
%% January 7, 2011 (Peter Heuberger)
%%     - improved command for black title box on cover  (line 1214)
%% August 18, 2010 (Peter Heuberger)
%%     -changed a minor typoo in the introduction text
%% June 9, 2010 (Peter Heuberger)
%%     added info on (re)newcommand
%%     added package relsize
%% April 9. 2010 (Peter Heuberger)
%%   Adapted for Linux: 
%%   - Changed alle references to Stylestuff into STYLESTUFF
%%   - Renamed directory Stylestuff into STYLESTUFF
%% March 25, 2010 (Peter Heuberger)
%%   - Acronyms are no longer displayed in small capitals
%%     removed 'smaller' from \RequirePackage[printonlyused,smaller]{acronym}
%% March 16, 2010 (Peter Heuberger)
%%  -emptied \mscProgram and \mscDepartment
%%   these are filled in the tex file!
%%  - in def of Backgroundpicture
%%    replaced     \centering\includegraphics{#1}
%%    by \centering\includegraphics[width=\paperwidth,height=\paperheight]{#1}
%%
%%
%% October 20, 2009 (Peter Heuberger)
%%  - changed Delft Centre for....  in Delft Center for...
%%  - empty mscProgram changed to Systems and Control
%%  - mscDepartment{Systems and Control}: added Delft Center for
%%
%% May 12, 2009 (Steven Mulder)
%%  - Updated cover page to match new TU huisstijl
%%  - Added option 'nosignatures' to turn off signature page
%%  - Fixed warnings due to deprecated options and packages
%%  - Fixed bad boxes in titlepages
%%  - Added package lmodern for slightly better fonts
%%  - Added hyperref pdf bookmarks for titlepages, TOC, ...
%%
%% January 15, 2009 (P.S.C. Heuberger)
%%  - Added option mscProgram
%%
%% January 9, 2009  (P.S.C. Heuberger)
%%  - Removed background picture option for titlepage
%%  - Added option for Third Party Logo and text on Copyright Page 
%%  - Added option for Title Page picture
%%  - Include example eps files for Title Page picture / Third Party logo
%%
%% December 11, 2008 (P.S.C. Heuberger)
%%  - Improved Logo picture on title page  (DCSC/TUDelft)
%%  - Text "Delft Center for Systems and Control" changed to white
%%
%% June 12, 2008 (P.S.C. Heuberger)
%%  - Option  breaklinks=true added at hyperref package takes care of wrapping
%%    long lines in tables of contents etc.
%%-----------------------------------------------------------------------------
%%
%% based on LaTeX 'book.cls'
%%-----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{mscLiterature}[12/03/2007 Standard Systems and Control Literature Survey class]
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    MSc Thesis Definitions
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand*{\mscDepartment}[1]%
            {\def\mscdepartment{#1}}
\newcommand*{\mscProgram}[1]%
            {\def\mscprogram{#1}}
\newcommand*{\mscFaculty}[1]%
            {\def\mscfaculty{#1}}
\newcommand*{\mscName}[1]%
            {\def\mscname{#1}}
\newcommand*{\mscTitle}[1]%
            {\def\msctitle{#1}}
\newcommand*{\mscSubTitle}[1]%
            {\def\mscsubtitle{#1}}
\newcommand*{\mscDate}[1]%
            {\def\mscdate{#1}}
\newcommand*{\mscCoverPicture}[1]%
            {\def\msccoverpicture{#1}}
\newcommand*{\mscCoverLogo}[1]%
            {\def\msccoverlogo{#1}}
\newcommand*{\mscTitlePagePicture}[1]% added for compatibility
            {\def\msccoverpicture{#1}}
\newcommand*{\mscThirdPartyLogo}[1]%
            {\def\mscthirdpartylogo{#1}}
\newcommand*{\mscThirdPartyText}[1]%
            {\def\mscthirdpartytext{#1}}
\newcommand*{\mscReaderOne}[1]%
            {\def\mscreaderone{#1}}
\newcommand*{\mscReaderTwo}[1]%
            {\def\mscreadertwo{#1}}
\newcommand*{\mscReaderThree}[1]%
            {\def\mscreaderthree{#1}}
\newcommand*{\mscReaderFour}[1]%
            {\def\mscreaderfour{#1}}
\newcommand*{\mscKeyWords}[1]%
            {\def\msckeywords{#1}}

            % \mscSupervisor

\mscDepartment{}
\mscProgram{}
\mscFaculty{}
\mscName{}
\mscTitle{}
\mscSubTitle{}
\mscKeyWords{}
\mscDate{\today}
\mscCoverPicture{}
\mscTitlePagePicture{}
\mscThirdPartyLogo{}
\mscThirdPartyText{}
\mscReaderOne{}
\mscReaderTwo{}
\mscReaderThree{}
\mscReaderFour{}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    PAPER SIZE DEFINITIONS: cf STANDARD BOOK CLASS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
%
% custom boolean for turning the signatures page on/off
\newif\ifsigpage
\sigpagetrue
%
\newif\if@openright
\newif\if@mainmatter
\@mainmattertrue
\if@compatibility\else
    \DeclareOption{a4paper}{%
        \setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}%
  }
    \DeclareOption{landscape}{%
    \setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}%
    }
\fi
\if@compatibility
  \renewcommand\@ptsize{0}
\else
    \DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
    \DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
    \DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
    \DeclareOption{notitlepage}{\@titlepagefalse}
\fi
%
% custom option for turning the signature page on/off
\DeclareOption{signatures}{\sigpagetrue}
\DeclareOption{nosignatures}{\sigpagefalse}
%
\if@compatibility
    \@openrighttrue
\else
    \DeclareOption{openright}{\@openrighttrue}
    \DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
    \DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{a4paper,11pt,twoside,onecolumn,final,openright,signatures}
\ProcessOptions
\input{bk1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\frontmatter{%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \pagestyle{fancyplain}
    %
    \pdfbookmark[-1]{Front Matter}{frontmatter_anchor}
    %
    }
\newcommand\mainmatter{%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{fancyplain}
    %
    \pdfbookmark[-1]{Main Matter}{mainmatter_anchor}
    %
    }
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
    %
    \pdfbookmark[-1]{Back Matter}{backmatter_anchor}
    %
    }
\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \sffamily
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname\nobreakspace\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \sffamily
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
               \if@openright
                \null
                \thispagestyle{empty}%
                \newpage
               \fi
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{\numberline{}#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\sffamily\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\sffamily\large\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\sffamily\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\sffamily\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\sffamily\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Enumeration style
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Environments
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  TitlePages
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\if@compatibility
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Part, Chapter, Section, Subsection, ...
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
%    \thispagestyle{empty}
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}\pdfbookmark[0]{Table of Contents}{toc_anchor}}%
    %
    
    %
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \cleardoublepage
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries \sffamily #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries \sffamily
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\sffamily \@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\sffamily \@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\sffamily \@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\sffamily \@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\sffamily \@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename\pdfbookmark[0]{List of Figures}{lof_anchor}}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\sffamily \@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename\pdfbookmark[0]{List of Tables}{lot_anchor}}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
%      \@mkboth{\bibname}{\bibname}%
            \chaptermark{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty 'thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\phantomsection
               \addcontentsline{toc}{chapter}{\numberline{}Index}
               \if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\@makeschapterhead{\indexname}]%
                \chaptermark{\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 1cm
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
%\newcommand{\hyperpage}[1]{\dotfill\hyperpage{#1}}
\newcommand\@idxitem{\par\hangindent 40\p@ }
\newcommand\subitem{\@idxitem \hspace*{20\p@} }
\newcommand\subsubitem{\@idxitem \hspace*{30\p@} }
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Table of Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\oldstylenums{\number\day}, \oldstylenums{\number\year}}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{arabic}
% \if@twoside
% \else
% \raggedbottom
% \fi
% \if@twocolumn
%   \twocolumn
%   \sloppy
%   \flushbottom
% \else
  \onecolumn
% \fi
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  REQUIRED PACKAGES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\RequirePackage[T1]{fontenc}                            % T1 font encoding for PDFs
\RequirePackage{lmodern}                                % extended font definition
\RequirePackage{amsmath,amssymb,amsthm} % most important math stuff
\RequirePackage{a4wide}                                 % make better use of A4 paper
\RequirePackage{fancyhdr}                               % custom headers and footers
\RequirePackage{fncychap}                               % custom chapter titles
\RequirePackage{titlesec}
\RequirePackage{graphicx}                               % graphics
\RequirePackage{color}                                  % color
\RequirePackage{booktabs}                               % extra tabular commands
\RequirePackage[format=plain]{caption}  % improved caption format
\RequirePackage{nomencl}                                % cool nomenclature listing
\RequirePackage{makeidx}                                % create your index
\RequirePackage[printonlyused]{acronym}
\RequirePackage{ifthen}                                 % if-then commands (used in maketitle)
\RequirePackage{eso-pic}                                % picture in back/forground (used in cover)
\RequirePackage{relsize}                                % \textlarger, \textsmaller etc
\RequirePackage{pgfsys}                                 % Solves missing symbol error
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Set up Matlab and C++ Listings
%%  REQUIRES PACKAGE listings AND colortbl
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\RequirePackage{listings}%
\RequirePackage{xcolor}%
%
\definecolor{string}{rgb}{0.7,0.0,0.0}
\definecolor{comment}{rgb}{0.13,0.54,0.13}
\definecolor{keyword}{rgb}{0.0,0.0,1.0}
%
\lstloadlanguages{Matlab,C++}
\lstset{breaklines=true,%
                basicstyle=\small,%
                tabsize=2,%
        stringstyle=\ttfamily\color{string},%
        keywordstyle=\ttfamily\color{keyword},%
        identifierstyle=\ttfamily,%
        showstringspaces=false,%
        commentstyle=\ttfamily\color{comment},%             
                numbers=left,
                numberstyle=\scriptsize}
% EXTRA: \bfseries \underbar \ttfamily
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Font for captions
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\renewcommand{\captionfont}{\small\sffamily}
\renewcommand{\captionlabelfont}{\small\bfseries\sffamily}
\setlength{\captionmargin}{20pt}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Fancy chapters
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\makeatletter
  % see https://www.overleaf.com/learn/latex/sections_and_chapters
  \titlespacing
    {\chapter} % command
    {0pt} % left
    {-4ex} % before-sep
    {6ex} % after-sep
  \titleformat
    {\chapter} % command - the sectioning command to be redefined
    [frame] % shape - is sectioning paragraph shape; possible values are: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
    {\bfseries\Large\rm} % format -  is the format to be applied to the title, label, and text
    {\chaptername \ \thechapter} % label - specify sectioning label
    {2.5ex} % sep - horizontal separation between label and title body 
    {\huge\bfseries\centering} % before-code - code preceding the title body
    [] % after-code - code following the title body
\makeatother
%%
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Chapter with no numbers
%%  ORIGINAL: Clark and Christophe
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand{\nonumchap}[1]{%
        \cleardoublepage
    \phantomsection % Added by Martijn van de Giessen
    \pagestyle{fancyplain}
    \addcontentsline{toc}{chapter}{\numberline{}#1}
    \chapter*{#1}
    \chaptermark{#1}
    %
    % test:
    \lhead[\fancyplain{}{\small\textsf{\thepage}}]%
          {\fancyplain{}{\small\textsf{\rightmark}}}
        \rhead[\fancyplain{}{\small\textsf{\leftmark}}]%
          {\fancyplain{}{\small\textsf{\thepage}}}
        \cfoot{}
        \lfoot[\small\textsf{\mscname}]%
              {\small\textsf{Literature Survey}}
        \rfoot[\small\textsf{Literature Survey}]%
              {\small\textsf{\mscname}} 
}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Fancy headers
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\pagestyle{fancyplain}
\setlength{\headheight}{13.6pt} %add some space to headheight to eliminate LaTeX "Overfull \vbox..." warnings
\renewcommand{\chaptermark}[1]%
             {\markboth{#1}{}}
\renewcommand{\sectionmark}[1]%
             {\markright{\thesection\ #1}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\lhead[\fancyplain{}{\small\textsf{\thepage}}]%
      {\fancyplain{}{\small\textsf{\rightmark}}}
\rhead[\fancyplain{}{\small\textsf{\leftmark}}]%
      {\fancyplain{}{\small\textsf{\thepage}}}
\cfoot{}
\lfoot[\small\textsf{\mscname}]%
      {\small\textsf{Literature Survey}}
\rfoot[\small\textsf{Literature Survey}]%
      {\small\textsf{\mscname}} 
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Set up nomenclature listing
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\renewcommand{\nomname}{List of Symbols}
\setlength{\nomitemsep}{-0.5\parsep}
\newcommand{\abbrev}[2]%
           {#2 (#1)\nomenclature[a ]{#1}{\MakeUppercase#2}}
\newcommand{\lsymb}[2]%
           {#1\nomenclature[c ]{#1}{\MakeUppercase#2}}
\newcommand{\gsymb}[2]%
           {#1\nomenclature[b ]{#1}{\MakeUppercase#2}}
\newcommand{\subs}[2]%
           {\nomenclature[d ]{$ _{#1} $}{\MakeUppercase#2}}
\newcommand{\supers}[2]%
           {\nomenclature[e ]{$ ^{#1} $}{\MakeUppercase#2}}
\newcommand{\others}[2]%
           {\nomenclature[f ]{#1}{\MakeUppercase#2}}
\renewcommand{\nomgroup}[1]{%
  \ifthenelse{\equal{#1}{A}}{%
    \medskip\item[\large\textbf{\textsf{Abbreviations}}]\medskip}{%
    \ifthenelse{\equal{#1}{C}}{%    
%      \medskip\item[\large\textbf{\textsf{Latin Symbols}}]\medskip}{%
            \medskip}{%
      \ifthenelse{\equal{#1}{B}}{%
%        \medskip\item[\large\textbf{\textsf{Greek Symbols}}]\medskip}{%
                \medskip}{%
        \ifthenelse{\equal{#1}{D}}{%
%          \medskip\item[\large\textbf{\textsf{Subscripts}}]\medskip}{%
                    \medskip}{%
          \ifthenelse{\equal{#1}{E}}{%
%            \medskip\item[\large\textbf{\textsf{Superscripts}}]\medskip}{%
            \medskip}{%
              \ifthenelse{\equal{#1}{F}}{%
%                \medskip\item[\large\textbf{\textsf{Other}}]\medskip}
                \medskip}{%
                }%
   }}}}}}
\newcommand{\printnomencl}{%
  \phantomsection % Added by Martijn van de Giessen
    \addcontentsline{toc}{section}{\numberline{}\nomname}
%  \markboth{\nomname}{\nomname}
  \printnomenclature[0.8in]
}
\newcommand{\printacronyms}{%
  \phantomsection % Added by Martijn van de Giessen
    \addcontentsline{toc}{section}{\numberline{}List of Acronyms}
%  \markboth{\nomname}{\nomname}
    \section*{List of Acronyms}
}
%
\makeatletter
\renewcommand{\thenomenclature}{%
    \section*{\nomname}
    \if@intoc\addcontentsline{toc}{section}{\nomname}\fi%
  \nompreamble
  \list{}{%
    \labelwidth\nom@tempdim
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemsep\nomitemsep
    \let\makelabel\nomlabel}}
\makeatother
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Set up bibliography
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand{\printbib}[1]{%
\cleardoublepage%
\chaptermark{\bibname}
\phantomsection% Added by Martijn van de Giessen
\addcontentsline{toc}{chapter}{\numberline{}\bibname}%
\bibliography{#1}%
\cleardoublepage%
}
%%
%% Appendix
%%
\renewcommand{\appendix}{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
%  \gdef\@chapapp{\appendixname}%
%  \gdef\thechapter{\@Alph\c@chapter}
    \renewcommand{\chaptername}{\appendixname}
    \renewcommand{\thechapter}{\Alph{chapter}}
    %
    \pdfbookmark[-1]{Appendices}{apdx_anchor}
    %
    }

%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Title pages etc.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\makeatletter
\newcommand\BackgroundPicture[1]{%
    \setlength{\unitlength}{1pt}%
    \put(0,\strip@pt\paperheight){%
    \parbox[t][\paperheight]{\paperwidth}{%
    \vfill
    \centering\includegraphics[width=\paperwidth,height=\paperheight]{#1}
    \vfill
}}}
\newcommand\TuBies{%
  \setlength{\unitlength}{1pt}%
  \put(0,\strip@pt\paperheight){%
    \parbox[t][\paperheight]{\paperwidth}{%
        \vfill
%PH aangepast 24-10-2011
%            \begin{picture}(610,90)%
            \begin{picture}(595,90)%
                \linethickness{90pt}%
                \put(0,45){\color{white} \line(1,0){614}}%
                \linethickness{38pt}%
                \put(0,19){\color{cyan} \line(1,0){614}}%
                \linethickness{1pt}%
                \put(0,90){\color{black} \line(1,0){614}}%
                \put(0,14){\color{white} \line(1,0){614}}%
                \put(80,43){\includegraphics{\msccoverlogo}}%
                \put(352,45){\textsf{\mscdepartment}}%
            \end{picture}%
        }
    }
}
\makeatother
%------------------------------------------------------------------------------
\renewcommand{\maketitle}{%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Cover page with picture
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \begin{titlepage}
        \pagenumbering{Roman}
        %
        \pdfbookmark[0]{Cover Page}{cover_anchor}
        %
        \ifthenelse{ \equal{\msccoverpicture}{} }{}{
            \AddToShipoutPicture*{\BackgroundPicture{\msccoverpicture}}
        }
        \AddToShipoutPicture*{\TuBies}
        \setlength{\unitlength}{1cm}
        %
        % TITELBLOK EN OORMERK
        \setlength{\fboxsep}{0cm}
        \setlength{\unitlength}{\textwidth}
        \begin{picture}(1,0.45)%
            % black box for title and name
            \put(0,0){%
%PH 7-1-11 REPLACED NEXT LINE
%                \colorbox{black}{\makebox(1,.45){}}
                \colorbox[cmyk]{1,1,1,1}{\makebox(1,.45){}}
            }%
            % Title text (white)
            \put(0.05,0.40){%
                \begin{minipage}[t]{0.9\textwidth}%
                    \Huge{\fontfamily{pbk}\selectfont%
                    \setlength{\baselineskip}{1.3\baselineskip}%
                    \color{white}\raggedright\msctitle}%
                    
                    \vspace{2mm}%
                    \Large{\fontfamily{pbk}\selectfont%
                    \setlength{\baselineskip}{1.3\baselineskip}%
                    \color{white}\mscsubtitle}%
                \end{minipage}%
            }%
            % Author text (cyan)
            \put(0.05,0.05){%
                \parbox[b]{0.9\textwidth}{%
                    \Huge{\fontfamily{pbk}\selectfont%
                    \color{cyan}\mscname}%
                }%
            }%      
            % cyan `oormerk' box
            \put(-0.25,-0.45){%
                \colorbox{cyan}{\makebox(0.25,0.45){}}
            }%
            \put(-0.05,-0.42){%
                \rotatebox{90}{%
                    \Large{\textsf{\color{white} Literature Survey}}
                }%
            }%
        \end{picture}
    \end{titlepage}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Main title page
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \clearemptydoublepage
    \thispagestyle{empty}
    %
    \pdfbookmark[0]{Title Page}{title_anchor}
    %
    \begin{center}
        \Huge{\textbf{\textsf{\msctitle}}}\\[0.3cm]
        \Large{\textbf{\textsf{\mscsubtitle}}} \\[1cm]
        \Large{\textsc{Literature Survey}}\\[5cm]
%       \Large{For the degree of Master of Science in \mscprogram\ at Delft University of Technology}\\[5cm]
        \Large{\mscname}\\[0.8cm]
        \Large{\mscprogram}\\[0.8cm]
        \Large{\mscdate}\\[1cm]
        \Large{Supervised by:}\hspace{0.5cm}\parbox[t][][t]{0.3\linewidth}{\Large{\mscreaderone}}
    \end{center}
  \vspace*{\stretch{2}}
    \begin{center}
        Faculty of \mscfaculty\ \\ Delft University of Technology
    \end{center}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Copyright page
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     \newpage
%     \thispagestyle{empty}
    
%     \vspace*{0mm}
    
%     \vfill
    
%     \ifthenelse{ \equal{\mscthirdpartylogo}{} }{}{
%         \includegraphics[width=150pt]{\mscthirdpartylogo}
        
%     }
%     \ifthenelse{ \equal{\mscthirdpartytext}{} }{}{
% %       \vspace*{1cm}
%         \mscthirdpartytext
        
%     }
%     \vspace*{10mm}
%     \includegraphics{\msccoverlogo} \hfill \includegraphics[height=40pt]{STYLESTUFF/DCSC} \\
%     Copyright \copyright\ \mscdepartment \\
%     All rights reserved.
%     \cleardoublepage
%   \ifsigpage
%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       %% Signatures Page
%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       \thispagestyle{empty}
%       
%       %
%       \pdfbookmark[0]{Signatures}{readers_anchor}
%       %
%       \begin{center}
%           \large \textsc{Delft University of Technology}\\
%         \textsc{Department of} \\
%         \textsc{\mscdepartment}
%       \end{center}
%       
%       \vspace{1cm}
%       
%       \large
%       
%       \begin{center}
%           The undersigned hereby certify that they have read and recommend to the Faculty of \mscfaculty\ for acceptance a thesis entitled
%           
%           \textsc{\msctitle}
%       
%           by
%           
%           \textsc{\mscname} 
%           
%           in partial fulfillment of the requirements for the degree of 
%           
%           \textsc{Master of Science}.
%       \end{center}
%       
%       \vspace{4cm}
%       
%       \mbox{} \hfill Dated: \underline{ \mscdate }
%       
%       \vspace{1cm}
%       
%       \noindent
%       Supervisor:    \hfill \underline{ \hspace{7cm} }\\
%       \mbox{}        \hfill  \mscreaderone
%       
%       \vspace{1cm}
%       
%       Readers:       \hfill \underline{ \hspace{7cm} }\\
%       \mbox{}        \hfill  \mscreadertwo
%       
%       \ifthenelse{ \equal{\mscreaderthree}{} }{}{
%       
%           \vspace{1cm}
%           
%           \mbox{}        \hfill \underline{ \hspace{7cm} }\\
%           \mbox{}        \hfill \mscreaderthree}
%       
%       \ifthenelse{ \equal{\mscreaderfour}{} }{}{
%           
%           \vspace{1cm}
%           
%           \mbox{}        \hfill \underline{ \hspace{7cm} }\\
%           \mbox{}        \hfill \mscreaderfour}
%       \newpage\clearemptydoublepage%
%   \fi
    \pagenumbering{roman}
}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  TOC / LOF / LOT
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand{\toc}{
%    \thispagestyle{empty}
    \setlength{\baselineskip}{0.5\baselineskip}
    \tableofcontents\cleardoublepage
    \setlength{\baselineskip}{2\baselineskip}
}
\newcommand{\toclof}{
%    \thispagestyle{empty}
    \setlength{\baselineskip}{0.5\baselineskip}
    \tableofcontents\cleardoublepage
    \listoffigures\cleardoublepage
    \setlength{\baselineskip}{2\baselineskip}
}
\newcommand{\tocloflot}{
%    \thispagestyle{empty}
    \setlength{\baselineskip}{0.5\baselineskip}
    \tableofcontents\cleardoublepage
    \listoffigures\cleardoublepage
    \listoftables\cleardoublepage
    \setlength{\baselineskip}{2\baselineskip}
    \cleardoublepage
}
\setcounter{tocdepth}{2}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Set up HyperReference
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\RequirePackage{hyperref}
%
\pdfstringdefDisableCommands{\def\\#1{ #1}} % Removes \\ from \msctitle and other vars before setting them in the pdf metadata
\hypersetup{colorlinks=true,
            breaklinks=true,
            citecolor=black,
            urlcolor=blue,
            linkcolor=black,
            menucolor=blue,
            anchorcolor=red,
                        pdfstartview={XYZ null null 1},
            bookmarksnumbered=false,
            bookmarksopen=true,
            bookmarksopenlevel=0}
\newcommand{\setThesisInfo}{%
  \makenomenclature
  \makeindex
  \hypersetup{pdftitle=Literature Survey: \msctitle,
            pdfauthor=\mscname,
            pdfsubject=\mscsubtitle,
            pdfkeywords=\msckeywords}
}
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  MISCELLANEOUS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%
\newcommand{\clearemptydoublepage}%
           {\newpage{\pagestyle{empty}\cleardoublepage}}
%
\renewcommand{\Re}{\mathfrak{Re}}
\renewcommand{\Im}{\mathfrak{Im}}
%
\setlength{\parskip}{\medskipamount}
\setlength{\parindent}{0pt}
%
\newcommand{\matlab}{\textsc{Matlab}}
%
\newcommand{\eqnref}[1]{Eq.~(\ref{#1})}
\newcommand{\figref}[1]{Figure~\ref{#1}}
\newcommand{\tabref}[1]{Table~\ref{#1}}
\newcommand{\chapref}[1]{Chapter~\ref{#1}}
\newcommand{\secref}[1]{Section~\ref{#1}}
%
%\sloppy
\endinput
%%
%% End of file `mscLiterature.cls'.
