%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% thesis.cls
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% template parameters import

\input{thesis.clo}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% class options

\DeclareOption{a4paper}{
	\def\@pgdim@paperheight	{297mm}
	\def\@pgdim@paperwidth	{210mm}
}
\DeclareOption{letterpaper}{
	\def\@pgdim@paperheight	{11in}
	\def\@pgdim@paperwidth	{8.5in}
}
\DeclareOption{10pt}{\@font@xpt}
\DeclareOption{11pt}{\@font@xipt}
\DeclareOption{12pt}{\@font@xiipt}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{openright}{\def\@clearpage{\cleardoublepage}}
\DeclareOption{openany}{\def\@clearpage{\clearpage}}

\ExecuteOptions{a4paper,10pt,oneside,openright}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page dimensions

\setlength		\hoffset		{ 0pt							}
\setlength		\voffset		{ 0pt							}
\setlength		\oddsidemargin	{ \@pgdim@textmargin			}
\setlength		\evensidemargin	{ \@pgdim@textmargin			}
\setlength		\topmargin		{ \@pgdim@textmargin			}
\setlength		\headsep		{ \@pgdim@headerseparation		}
\setlength		\headheight		{ \@pgdim@headerheight			}
\setlength		\footskip		{ \@pgdim@headerseparation		}
\setlength		\marginparwidth	{ \@pgdim@marginnotewidth		}
\setlength		\marginparsep	{ \@pgdim@marginnoteseparation	}
\setlength		\textwidth		{ \@pgdim@paperwidth			}
\setlength		\textheight		{ \@pgdim@paperheight			}
\setlength		\paperwidth		{ \@pgdim@paperwidth			}
\setlength		\paperheight	{ \@pgdim@paperheight			}
\addtolength	\oddsidemargin	{-1in							}
\addtolength	\evensidemargin	{-1in							}
\addtolength	\topmargin		{-1in							}
\addtolength	\topmargin		{-\@pgdim@headerseparation		}
\addtolength	\topmargin		{-\@pgdim@headerheight			}
\addtolength	\textwidth		{-\@pgdim@textmargin			}
\addtolength	\textwidth		{-\@pgdim@textmargin			}
\addtolength	\textheight		{-\@pgdim@textmargin			}
\addtolength	\textheight		{-\@pgdim@textmargin			}
\addtolength	\footskip		{ \@pgdim@headerheight			}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% page decorations

\def\ps@headings{
	\def\@evenhead{\@pgdec@leftheader}
	\def\@oddhead{\@pgdec@rightheader}
	\def\@evenfoot{\@pgdec@leftfooter}
	\def\@oddfoot{\@pgdec@rightfooter}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% document structure

\newif\if@docstruc@inopening\@docstruc@inopeningfalse
\newif\if@docstruc@infront\@docstruc@infrontfalse
\newif\if@docstruc@inmain\@docstruc@inmainfalse
\newif\if@docstruc@inback\@docstruc@inbackfalse

\newif\if@docstruc@openingnext\@docstruc@openingnexttrue
\newif\if@docstruc@frontnext\@docstruc@frontnextfalse
\newif\if@docstruc@mainnext\@docstruc@mainnextfalse
\newif\if@docstruc@backnext\@docstruc@backnextfalse

\def\opening{
	\if@docstruc@openingnext
		\@docstruc@openingnextfalse
		\@docstruc@frontnexttrue
		\@docstruc@inopeningtrue
		\@clearpage
		\pagestyle{empty}
		\pagenumbering{gobble}
	\else
		\ClassError{thesis}{incorrect place to invoke `\string\opening'}{}
	\fi
}
\def\front{
	\if@docstruc@frontnext
		\@docstruc@frontnextfalse
		\@docstruc@mainnexttrue
		\@docstruc@inopeningfalse
		\@docstruc@infronttrue
		\@clearpage
		\pagestyle{headings}
		\pagenumbering{roman}
		\@docstruc@init
	\else
		\ClassError{thesis}{incorrect place to invoke `\string\front'}{}
	\fi
}
\def\main{
	\if@docstruc@mainnext
		\@docstruc@mainnextfalse
		\@docstruc@backnexttrue
		\@docstruc@infrontfalse
		\@docstruc@inmaintrue
		\@clearpage
		\pagenumbering{arabic}
		\@docstruc@init
	\else
		\ClassError{thesis}{incorrect place to invoke `\string\main'}{}
	\fi
}
\def\back{
	\if@docstruc@backnext
		\@docstruc@backnextfalse
		\@docstruc@inmainfalse
		\@docstruc@inbacktrue
		\@clearpage
		\@docstruc@init
	\else
		\ClassError{thesis}{incorrect place to invoke `\string\back'}{}
	\fi
}

\newif\if@docstruc@inappendix\@docstruc@inappendixfalse
\def\appendix{
	\if@docstruc@inmain
		\if@docstruc@inappendix
			\ClassError{thesis}{`\string\appendix' allowed only once}{}
		\else
			\@docstruc@inappendixtrue
			\@docstruc@init
		\fi
	\else
		\ClassError{thesis}{`\string\appendix' allowed only in main portion}{}
	\fi
}

\newcounter{@docstruc@secdepth}

\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]

\def\thechapter{\if@docstruc@inappendix\@Alph\c@chapter\else\@arabic\c@chapter\fi}
\def\thesection{\thechapter.\@arabic\c@section}
\def\thesubsection{\thesection.\@arabic\c@subsection}
\def\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}

\def\@docstruc@chaptersecdepth{1}
\def\@docstruc@sectionsecdepth{2}
\def\@docstruc@subsectionsecdepth{3}
\def\@docstruc@subsubsectionsecdepth{4}

\def\@docstruc@init{
	\@clearpage
	\setcounter{chapter}{0}
	\setcounter{@docstruc@secdepth}{0}
}

\def\chapter#1{
	\stepcounter{@docstruc@secdepth}
	\ifnum\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
		\ClassError{thesis}{document sectioning depth not enough to invoke `\string\chapter'}{}
	\fi
	\setcounter{@docstruc@secdepth}{\@docstruc@chaptersecdepth}
	\if@docstruc@inmain
		\@docstruc@chapternumbered{#1}
	\else
		\if@docstruc@infront
			\@docstruc@chapternumberless{#1}
		\else
			\if@docstruc@inback
				\@docstruc@chapternumberless{#1}
			\else
				\ClassError{thesis}{`\string\chapter' allowed only in front, main, and back portions}{}
			\fi
		\fi
	\fi
}
\def\@docstruc@chapternumberless#1{
	\@clearpage
	\thispagestyle{plain}
	\global\@topnum 0
	\ifdefined\phantomsection
		\phantomsection
	\fi
	\addtocontents{toc}{\protect\addvspace{\@docstruc@chapternumberlesstocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@chapternumberlesslofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@chapternumberlesslotskip}}
	\addcontentsline{toc}{chapter}{\protect\numberline{}#1}
	\begingroup
		\@docstruc@makechapternumberless{#1}
	\endgroup
}
\def\@docstruc@chapternumbered#1{
	\@clearpage
	\thispagestyle{plain}
	\global\@topnum 0
	\refstepcounter{chapter}
	\addtocontents{toc}{\protect\addvspace{\@docstruc@chapternumberedtocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@chapternumberedlofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@chapternumberedlotskip}}
	\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}
	\begingroup
		\@docstruc@makechapternumbered{#1}
	\endgroup
}

\def\section#1{
	\stepcounter{@docstruc@secdepth}
	\ifnum\c@@docstruc@secdepth<\@docstruc@sectionsecdepth
		\ClassError{thesis}{document sectioning depth not enough to invoke `\string\section'}{}
	\fi
	\setcounter{@docstruc@secdepth}{\@docstruc@sectionsecdepth}
	\if@docstruc@inmain
		\@docstruc@sectionnumbered{#1}
	\else
		\if@docstruc@infront
			\@docstruc@sectionnumberless{#1}
		\else
			\if@docstruc@inback
				\@docstruc@sectionnumberless{#1}
			\else
				\ClassError{thesis}{`\string\section' only allowed in front, main, and back portions}{}
			\fi
		\fi
	\fi
}
\def\@docstruc@sectionnumberless#1{
	\ifdefined\phantomsection
		\phantomsection
	\fi
	\addtocontents{toc}{\protect\addvspace{\@docstruc@sectionnumberlesstocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@sectionnumberlesslofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@sectionnumberlesslotskip}}
	\addcontentsline{toc}{section}{\protect\numberline{}#1}
	\begingroup
		\@docstruc@makesectionnumberless{#1}
	\endgroup
}
\def\@docstruc@sectionnumbered#1{
	\refstepcounter{section}
	\addtocontents{toc}{\protect\addvspace{\@docstruc@sectionnumberedtocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@sectionnumberedlofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@sectionnumberedlotskip}}
	\addcontentsline{toc}{section}{\protect\numberline{\thesection}#1}
	\begingroup
		\@docstruc@makesectionnumbered{#1}
	\endgroup
}

\def\subsection#1{
	\stepcounter{@docstruc@secdepth}
	\ifnum\c@@docstruc@secdepth<\@docstruc@subsectionsecdepth
		\ClassError{thesis}{document sectioning depth not enough to invoke `\string\subsection'}{}
	\fi
	\setcounter{@docstruc@secdepth}{\@docstruc@subsectionsecdepth}
	\if@docstruc@inmain
		\@docstruc@subsectionnumbered{#1}
	\else
		\if@docstruc@infront
			\@docstruc@subsectionnumberless{#1}
		\else
			\if@docstruc@inback
				\@docstruc@subsectionnumberless{#1}
			\else
				\ClassError{thesis}{`\string\subsection' only allowed in front, main, and back portions}{}
			\fi
		\fi
	\fi
}
\def\@docstruc@subsectionnumberless#1{
	\ifdefined\phantomsection
		\phantomsection
	\fi
	\addtocontents{toc}{\protect\addvspace{\@docstruc@subsectionnumberlesstocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@subsectionnumberlesslofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@subsectionnumberlesslotskip}}
	\addcontentsline{toc}{subsection}{\protect\numberline{}#1}
	\begingroup
		\@docstruc@makesubsectionnumberless{#1}
	\endgroup
}
\def\@docstruc@subsectionnumbered#1{
	\refstepcounter{subsection}
	\addtocontents{toc}{\protect\addvspace{\@docstruc@subsectionnumberedtocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@subsectionnumberedlofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@subsectionnumberedlotskip}}
	\addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection}#1}
	\begingroup
		\@docstruc@makesubsectionnumbered{#1}
	\endgroup
}

\def\subsubsection#1{
	\stepcounter{@docstruc@secdepth}
	\ifnum\c@@docstruc@secdepth<\@docstruc@subsubsectionsecdepth
		\ClassError{thesis}{document sectioning depth not enough to invoke `\string\subsubsection'}{}
	\fi
	\setcounter{@docstruc@secdepth}{\@docstruc@subsubsectionsecdepth}
	\if@docstruc@inmain
		\@docstruc@subsubsectionnumbered{#1}
	\else
		\if@docstruc@infront
			\@docstruc@subsubsectionnumberless{#1}
		\else
			\if@docstruc@inback
				\@docstruc@subsubsectionnumberless{#1}
			\else
				\ClassError{thesis}{`\string\subsubsection' only allowed in front, main, and back portions}{}
			\fi
		\fi
	\fi
}
\def\@docstruc@subsubsectionnumberless#1{
	\ifdefined\phantomsection
		\phantomsection
	\fi
	\addtocontents{toc}{\protect\addvspace{\@docstruc@subsubsectionnumberlesstocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@subsubsectionnumberlesslofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@subsubsectionnumberlesslotskip}}
	\addcontentsline{toc}{subsubsection}{\protect\numberline{}#1}
	\begingroup
		\@docstruc@makesubsubsectionnumberless{#1}
	\endgroup
}
\def\@docstruc@subsubsectionnumbered#1{
	\refstepcounter{subsubsection}
	\addtocontents{toc}{\protect\addvspace{\@docstruc@subsubsectionnumberedtocskip}}
	\addtocontents{lof}{\protect\addvspace{\@docstruc@subsubsectionnumberedlofskip}}
	\addtocontents{lot}{\protect\addvspace{\@docstruc@subsubsectionnumberedlotskip}}
	\addcontentsline{toc}{subsubsection}{\protect\numberline{\thesubsubsection}#1}
	\begingroup
		\@docstruc@makesubsubsectionnumbered{#1}
	\endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% title page

\def\title#1		{\def\@titlpg@title			{#1}}
\def\purpose#1		{\def\@titlpg@purpose		{#1}}
\def\degree#1		{\def\@titlpg@degree		{#1}}
\def\subject#1		{\def\@titlpg@subject		{#1}}
\def\author#1		{\def\@titlpg@author		{#1}}
\def\authoraffil#1	{\def\@titlpg@authoraffil	{#1}}
\def\mentor#1		{\def\@titlpg@mentor		{#1}}
\def\mentoraffil#1	{\def\@titlpg@mentoraffil	{#1}}
\def\logo#1			{\def\@titlpg@logo			{#1}}

\def\maketitle{
	\if@docstruc@inopening
		\begingroup
			\@titlpg@create
				{\@titlpg@title			}
				{\@titlpg@purpose		}
				{\@titlpg@degree		}
				{\@titlpg@subject		}
				{\@titlpg@author		}
				{\@titlpg@authoraffil	}
				{\@titlpg@mentor		}
				{\@titlpg@mentoraffil	}
				{\@titlpg@logo			}
		\endgroup
		\@clearpage
	\else
		\ClassError{thesis}{`\string\maketitle' allowed only in opening portion}{}
	\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% document contents

\def\l@chapter#1#2{
	\setlength\@tempdima{\@doccnts@chapternumberwidth}
	\begingroup
		\leftskip\@doccnts@chapterindent
		\advance\leftskip\@doccnts@chapternumberwidth
		\rightskip\@doccnts@chapterpagenumberwidth
		\hskip -\@doccnts@chapternumberwidth
		{\@doccnts@chapterentryfont#1}
		\rightskip 0pt
		{\@doccnts@chapterfillerfont\quad\cleaders\hbox to \@doccnts@chapterfillerwidth{\@doccnts@chapterfiller}\hfill}
		{\@doccnts@chapterpagenumberfont\hbox to \@doccnts@chapterpagenumberwidth{\hfill#2}}
		\par
	\endgroup
}

\def\l@section#1#2{
	\setlength\@tempdima{\@doccnts@sectionnumberwidth}
	\begingroup
		\leftskip\@doccnts@sectionindent
		\advance\leftskip\@doccnts@sectionnumberwidth
		\rightskip\@doccnts@sectionpagenumberwidth
		\hskip -\@doccnts@sectionnumberwidth
		{\@doccnts@sectionentryfont#1}
		\rightskip 0pt
		{\@doccnts@sectionfillerfont\quad\cleaders\hbox to \@doccnts@sectionfillerwidth{\@doccnts@sectionfiller}\hfill}
		{\@doccnts@sectionpagenumberfont\hbox to \@doccnts@sectionpagenumberwidth{\hfill#2}}
		\par
	\endgroup
}

\def\l@subsection#1#2{
	\setlength\@tempdima{\@doccnts@subsectionnumberwidth}
	\begingroup
		\leftskip\@doccnts@subsectionindent
		\advance\leftskip\@doccnts@subsectionnumberwidth
		\rightskip\@doccnts@subsectionpagenumberwidth
		\hskip -\@doccnts@subsectionnumberwidth
		{\@doccnts@subsectionentryfont#1}
		\rightskip 0pt
		{\@doccnts@subsectionfillerfont\quad\cleaders\hbox to \@doccnts@subsectionfillerwidth{\@doccnts@subsectionfiller}\hfill}
		{\@doccnts@subsectionpagenumberfont\hbox to \@doccnts@subsectionpagenumberwidth{\hfill#2}}
		\par
	\endgroup
}

\def\l@subsubsection#1#2{
	\setlength\@tempdima{\@doccnts@subsubsectionnumberwidth}
	\begingroup
		\leftskip\@doccnts@subsubsectionindent
		\advance\leftskip\@doccnts@subsubsectionnumberwidth
		\rightskip\@doccnts@subsubsectionpagenumberwidth
		\hskip -\@doccnts@subsubsectionnumberwidth
		{\@doccnts@subsubsectionentryfont#1}
		\rightskip 0pt
		{\@doccnts@subsubsectionfillerfont\quad\cleaders\hbox to \@doccnts@subsubsectionfillerwidth{\@doccnts@subsubsectionfiller}\hfill}
		{\@doccnts@subsubsectionpagenumberfont\hbox to \@doccnts@subsubsectionpagenumberwidth{\hfill#2}}
		\par
	\endgroup
}

\def\l@figure#1#2{
	\setlength\@tempdima{\@doccnts@figurenumberwidth}
	\begingroup
		\leftskip\@doccnts@figureindent
		\advance\leftskip\@doccnts@figurenumberwidth
		\rightskip\@doccnts@figurepagenumberwidth
		\hskip -\@doccnts@figurenumberwidth
		{\@doccnts@figureentryfont#1}
		\rightskip 0pt
		{\@doccnts@figurefillerfont\quad\cleaders\hbox to \@doccnts@figurefillerwidth{\@doccnts@figurefiller}\hfill}
		{\@doccnts@figurepagenumberfont\hbox to \@doccnts@figurepagenumberwidth{\hfill#2}}
		\par
	\endgroup
}

\def\l@table#1#2{
	\setlength\@tempdima{\@doccnts@tablenumberwidth}
	\begingroup
		\leftskip\@doccnts@tableindent
		\advance\leftskip\@doccnts@tablenumberwidth
		\rightskip\@doccnts@tablepagenumberwidth
		\hskip -\@doccnts@tablenumberwidth
		{\@doccnts@tableentryfont#1}
		\rightskip 0pt
		{\@doccnts@tablefillerfont\quad\cleaders\hbox to \@doccnts@tablefillerwidth{\@doccnts@tablefiller}\hfill}
		{\@doccnts@tablepagenumberfont\hbox to \@doccnts@tablepagenumberwidth{\hfill#2}}
		\par
	\endgroup
}

\def\generatetoc{\@starttoc{toc}}
\def\generatelof{\@starttoc{lof}}
\def\generatelot{\@starttoc{lot}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figures and tables

\setlength\tabcolsep{\@figtab@columnseparation}
\setlength\arrayrulewidth{\@figtab@rulewidth}
\setlength\doublerulesep{\@figtab@doubleruleseparation}

\long\def\@makecaption#1#2{
	\vskip\@figtab@captionaboveskip
	\begingroup
		\leftskip\@figtab@captionmargin
		\rightskip\@figtab@captionmargin
		{\@figtab@captionheadformat#1:}\ {\@figtab@captionbodyformat#2}
		\par
	\endgroup
	\vskip\@figtab@captionbelowskip
}

\newcounter{figure}[chapter]
\def\thefigure{\thechapter.\@arabic\c@figure}
\def\ext@figure{lof}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\fnum@figure{\@figtab@figurelabeltext\ \thefigure}
\newenvironment{figure}[1][]
	{
		\def\@figtab@argument{#1}
		\if@docstruc@inmain
			\ifnum\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{figure}' allowed within chapters}{}
			\else
				\ifx\@figtab@argument\@empty
					\@float{figure}
				\else
					\@float{figure}[#1]
				\fi
			\fi
		\else
			\ClassError{thesis}{`\string\begin{figure}' allowed only in main portion}{}
		\fi
	}
	{\end@float}

\newcounter{table}[chapter]
\def\thetable{\thechapter.\@arabic\c@table}
\def\ext@table{lot}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\fnum@table{\@figtab@tablelabeltext\ \thetable}
\newenvironment{table}[1][]
	{
		\def\@figtab@argument{#1}
		\if@docstruc@inmain
			\ifnum\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{table}' allowed only in main portion}{}
			\else
				\ifx\@figtab@argument\@empty
					\@float{table}
				\else
					\@float{table}[#1]
				\fi
			\fi
		\else
			\ClassError{thesis}{`\string\begin{table}' allowed only in main portion}{}
		\fi
	}
	{\end@float}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lists and enumerations

\setlength\topsep{\@lstenum@aboveseparation}
\setlength\parsep{\@lstenum@paragraphseparation}
\setlength\itemsep{\@lstenum@itemseparation}
\setlength\labelwidth{\@lstenum@labelwidth}
\setlength\labelsep{\@lstenum@labelseparation}
\setlength\listparindent{0pt}
\setlength\itemindent{0pt}
\setlength\rightmargin{0pt}
\setlength\leftmargin{\@lstenum@labelmargin}
\addtolength\leftmargin{\@lstenum@labelwidth}
\addtolength\leftmargin{\@lstenum@labelseparation}

\newenvironment{description}[1][\@lstenum@labelwidth]
	{
		\begin{list}
			{\hfill}
			{
				\setlength\labelwidth{#1}
				\setlength\leftmargin{#1}
				\addtolength\leftmargin{\@lstenum@labelmargin}
				\addtolength\leftmargin{\@lstenum@labelseparation}
				\let\makelabel\@lstenum@makedescriptionlabel
			}
	}
	{\end{list}}
\def\@lstenum@makedescriptionlabel#1{#1\hfill}

\newcounter{@lstenum@listingdepth}
\newenvironment{listing}[1][\@lstenum@labelwidth]
	{
		\stepcounter{@lstenum@listingdepth}
		\ifnum\c@@lstenum@listingdepth>4
			\ClassError{thesis}{`listing' depth too high to run `\string\begin{listing}'}{}
		\fi
		\ifnum\c@@lstenum@listingdepth=1
			\begin{list}
				{\@lstenum@listinglabeli\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makelistinglabel
				}
		\fi
		\ifnum\c@@lstenum@listingdepth=2
			\begin{list}
				{\@lstenum@listinglabelii\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makelistinglabel
				}
		\fi
		\ifnum\c@@lstenum@listingdepth=3
			\begin{list}
				{\@lstenum@listinglabeliii\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makelistinglabel
				}
		\fi
		\ifnum\c@@lstenum@listingdepth=4
			\begin{list}
				{\@lstenum@listinglabeliv\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makelistinglabel
				}
		\fi
	}
	{
		\end{list}
		\addtocounter{@lstenum@listingdepth}{-1}
	}
\def\@lstenum@makelistinglabel#1{#1\hfill}

\newcounter{@lstenum@enumerationi}
\newcounter{@lstenum@enumerationii}
\newcounter{@lstenum@enumerationiii}
\newcounter{@lstenum@enumerationiv}

\newcounter{@lstenum@enumerationdepth}
\newenvironment{enumeration}[1][\@lstenum@labelwidth]
	{
		\stepcounter{@lstenum@enumerationdepth}
		\ifnum\c@@lstenum@enumerationdepth>4
			\ClassError{thesis}{`enumeration' depth too high to run `\string\begin{enumeration}'}{}
		\fi
		\ifnum\c@@lstenum@enumerationdepth=1
			\setcounter{@lstenum@enumerationi}{0}
			\begin{list}
				{\stepcounter{@lstenum@enumerationi}\@lstenum@enumerationlabeli{\c@@lstenum@enumerationi}\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makeenumerationlabel
				}
		\fi
		\ifnum\c@@lstenum@enumerationdepth=2
			\setcounter{@lstenum@enumerationii}{0}
			\begin{list}
				{\stepcounter{@lstenum@enumerationii}\@lstenum@enumerationlabelii{\c@@lstenum@enumerationii}\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makeenumerationlabel
				}
		\fi
		\ifnum\c@@lstenum@enumerationdepth=3
			\setcounter{@lstenum@enumerationiii}{0}
			\begin{list}
				{\stepcounter{@lstenum@enumerationiii}\@lstenum@enumerationlabeliii{\c@@lstenum@enumerationiii}\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makeenumerationlabel
				}
		\fi
		\ifnum\c@@lstenum@enumerationdepth=4
			\setcounter{@lstenum@enumerationiv}{0}
			\begin{list}
				{\stepcounter{@lstenum@enumerationiv}\@lstenum@enumerationlabeliv{\c@@lstenum@enumerationiv}\hfill}
				{
					\setlength\labelwidth{#1}
					\setlength\leftmargin{#1}
					\addtolength\leftmargin{\@lstenum@labelmargin}
					\addtolength\leftmargin{\@lstenum@labelseparation}
					\let\makelabel\@lstenum@makeenumerationlabel
				}
		\fi
	}
	{
		\end{list}
		\addtocounter{@lstenum@enumerationdepth}{-1}
	}
\def\@lstenum@makeenumerationlabel#1{#1\hfill}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% technical blocks

\def\newblock#1[#2,#3,#4]{
	\newif\if@techblk@numbered\@techblk@numberedfalse
	\newif\if@techblk@unnumbered\@techblk@unnumberedfalse
	\newif\if@techblk@emphasized\@techblk@emphasizedfalse
	\newif\if@techblk@unemphasized\@techblk@unemphasizedfalse
	\newif\if@techblk@terminated\@techblk@terminatedfalse
	\newif\if@techblk@unterminated\@techblk@unterminatedfalse
	\def\@techblk@numberedoption{num}
	\def\@techblk@unnumberedoption{nonum}
	\def\@techblk@emphasizedoption{emph}
	\def\@techblk@unemphasizedoption{noemph}
	\def\@techblk@terminatedoption{term}
	\def\@techblk@unterminatedoption{noterm}
	\def\@techblk@option{#2}
	\ifx\@techblk@option\@techblk@numberedoption\@techblk@numberedtrue\fi
	\ifx\@techblk@option\@techblk@unnumberedoption\@techblk@unnumberedtrue\fi
	\ifx\@techblk@option\@techblk@emphasizedoption\@techblk@emphasizedtrue\fi
	\ifx\@techblk@option\@techblk@unemphasizedoption\@techblk@unemphasizedtrue\fi
	\ifx\@techblk@option\@techblk@terminatedoption\@techblk@terminatedtrue\fi
	\ifx\@techblk@option\@techblk@unterminatedoption\@techblk@unterminatedtrue\fi
	\def\@techblk@option{#3}
	\ifx\@techblk@option\@techblk@numberedoption\@techblk@numberedtrue\fi
	\ifx\@techblk@option\@techblk@unnumberedoption\@techblk@unnumberedtrue\fi
	\ifx\@techblk@option\@techblk@emphasizedoption\@techblk@emphasizedtrue\fi
	\ifx\@techblk@option\@techblk@unemphasizedoption\@techblk@unemphasizedtrue\fi
	\ifx\@techblk@option\@techblk@terminatedoption\@techblk@terminatedtrue\fi
	\ifx\@techblk@option\@techblk@unterminatedoption\@techblk@unterminatedtrue\fi
	\def\@techblk@option{#4}
	\ifx\@techblk@option\@techblk@numberedoption\@techblk@numberedtrue\fi
	\ifx\@techblk@option\@techblk@unnumberedoption\@techblk@unnumberedtrue\fi
	\ifx\@techblk@option\@techblk@emphasizedoption\@techblk@emphasizedtrue\fi
	\ifx\@techblk@option\@techblk@unemphasizedoption\@techblk@unemphasizedtrue\fi
	\ifx\@techblk@option\@techblk@terminatedoption\@techblk@terminatedtrue\fi
	\ifx\@techblk@option\@techblk@unterminatedoption\@techblk@unterminatedtrue\fi
	\if@techblk@numbered
		\if@techblk@unnumbered
			\ClassError{thesis}{neither of the options `\@techblk@numberedoption' or `\@techblk@unnumberedoption' were passed to `\string\newtechblk'}{}
		\fi
	\else
		\if@techblk@unnumbered
		\else
			\ClassError{thesis}{neither of the options `\@techblk@numberedoption' or `\@techblk@unnumberedoption' were passed to `\string\newtechblk'}{}
		\fi
	\fi
	\if@techblk@emphasized
		\if@techblk@unemphasized
			\ClassError{thesis}{neither of the options `\@techblk@emphasizedoption' or `\@techblk@unemphasizedoption' were passed to `\string\newtechblk'}{}
		\fi
	\else
		\if@techblk@unemphasized
		\else
			\ClassError{thesis}{neither of the options `\@techblk@emphasizedoption' or `\@techblk@unemphasizedoption' were passed to `\string\newtechblk'}{}
		\fi
	\fi
	\if@techblk@terminated
		\if@techblk@unterminated
			\ClassError{thesis}{neither of the options `\@techblk@terminatedoption' or `\@techblk@unterminatedoption' were passed to `\string\newtechblk'}{}
		\fi
	\else
		\if@techblk@unterminated
		\else
			\ClassError{thesis}{neither of the options `\@techblk@terminatedoption' or `\@techblk@unterminatedoption' were passed to `\string\newtechblk'}{}
		\fi
	\fi
	\if@techblk@numbered
		\if@techblk@emphasized
			\if@techblk@terminated
				\@techblk@newtechblk@numbered@emphasized@terminated{#1}
			\else
				\@techblk@newtechblk@numbered@emphasized@unterminated{#1}
			\fi
		\else
			\if@techblk@terminated
				\@techblk@newtechblk@numbered@unemphasized@terminated{#1}
			\else
				\@techblk@newtechblk@numbered@unemphasized@unterminated{#1}
			\fi
		\fi
	\else
		\if@techblk@emphasized
			\if@techblk@terminated
				\@techblk@newtechblk@unnumbered@emphasized@terminated{#1}
			\else
				\@techblk@newtechblk@unnumbered@emphasized@unterminated{#1}
			\fi
		\else
			\if@techblk@terminated
				\@techblk@newtechblk@unnumbered@unemphasized@terminated{#1}
			\else
				\@techblk@newtechblk@unnumbered@unemphasized@unterminated{#1}
			\fi
		\fi
	\fi
}
\def\@techblk@newtechblk@numbered@emphasized@terminated#1{
	\newcounter{#1}[chapter]
	\expandafter\def\csname the#1\endcsname{\thechapter.\@arabic\csname c@#1\endcsname}
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\refstepcounter{#1}
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1\ \csname the#1\endcsname\ \ 
			\endgroup
			\begingroup
				\@techblk@emphasizedbodyfont
		}
		{
			\hfill\@techblk@terminationmark
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@numbered@emphasized@unterminated#1{
	\newcounter{#1}[chapter]
	\expandafter\def\csname the#1\endcsname{\thechapter.\@arabic\csname c@#1\endcsname}
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\refstepcounter{#1}
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1\ \csname the#1\endcsname\ \ 
			\endgroup
			\begingroup
				\@techblk@emphasizedbodyfont
		}
		{
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@numbered@unemphasized@terminated#1{
	\newcounter{#1}[chapter]
	\expandafter\def\csname the#1\endcsname{\thechapter.\@arabic\csname c@#1\endcsname}
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\refstepcounter{#1}
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1\ \csname the#1\endcsname\ \ 
			\endgroup
			\begingroup
				\@techblk@normalbodyfont
		}
		{
			\hfill\@techblk@terminationmark
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@numbered@unemphasized@unterminated#1{
	\newcounter{#1}[chapter]
	\expandafter\def\csname the#1\endcsname{\thechapter.\@arabic\csname c@#1\endcsname}
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\refstepcounter{#1}
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1\ \csname the#1\endcsname\ \ 
			\endgroup
			\begingroup
				\@techblk@normalbodyfont
		}
		{
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@unnumbered@emphasized@terminated#1{
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1:\ \ 
			\endgroup
			\begingroup
				\@techblk@emphasizedbodyfont
		}
		{
			\hfill\@techblk@terminationmark
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@unnumbered@emphasized@unterminated#1{
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1:\ \ 
			\endgroup
			\begingroup
				\@techblk@emphasizedbodyfont
		}
		{
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@unnumbered@unemphasized@terminated#1{
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1:\ \ 
			\endgroup
			\begingroup
				\@techblk@normalbodyfont
		}
		{
			\hfill\@techblk@terminationmark
			\endgroup
			\par
		}
}
\def\@techblk@newtechblk@unnumbered@unemphasized@unterminated#1{
	\newenvironment{#1}
		{
			\if\c@@docstruc@secdepth<\@docstruc@chaptersecdepth
				\ClassError{thesis}{`\string\begin{#1}' allowed only within chapters}{}
			\fi
			\par
			\begingroup
				\@techblk@headfont
				\MakeUppercase#1:\ \ 
			\endgroup
			\begingroup
				\@techblk@normalbodyfont
		}
		{
			\endgroup
			\par
		}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% equations

\@addtoreset{equation}{chapter}
\def\theequation{\thechapter.\@arabic\c@equation}
