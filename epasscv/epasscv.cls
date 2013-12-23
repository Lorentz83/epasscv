\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epasscv}[2012/11/01 Unofficial LaTeX implementation of Europass CV]

%% Copyright (C) 2012 Lorenzo Bossi
%% This file is part of epasscv
%% For the detail of the license read the file LICENSE that is provided
%% with this package or download it at
%% https://github.com/Lorentz83/epasscv

\DeclareOption{10pt}{
  \PassOptionsToClass{\CurrentOption}{article}
}
\DeclareOption{a4paper}{
  \PassOptionsToClass{\CurrentOption}{article}
}

\newcommand{\cvfullLanguageVAR}{}
\newcommand{\cvcurrentlanguageVAR}{}


\DeclareOption{english}{
  \renewcommand{\cvfullLanguageVAR}{english}
}

\DeclareOption{italian}{
  \renewcommand{\cvfullLanguageVAR}{italian}
}

%\cvcurrentlanguage{it} % babel \languagename

\ExecuteOptions{english}


\ProcessOptions\relax



\RequirePackage{l18n/epasscv-english} % default language
\RequirePackage{l18n/epasscv-\cvfullLanguageVAR} % localized text

\newcommand{\cvloadlanguage}[2][]{
  \renewcommand{\cvfullLanguageVAR}{#2}
  \RequirePackage{l18n/epasscv-\cvfullLanguageVAR} % localized text
  \ifthenelse{\equal{#1}{babel}}{
    \RequirePackage[\cvfullLanguageVAR]{babel}
  }{}  
}

\LoadClass{article}

\RequirePackage{url}
\RequirePackage{etoolbox}            % if then else replacement
\RequirePackage[hidelinks]{hyperref} % provide \texorpdfstring for the date
\RequirePackage{xparse}              % \NewDocumentEnvironment command
\RequirePackage{calc}

%%%%%%%%%%%%%%%%%%%%% Support vars and commands %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\cvoptional}[3]{%
  \ifthenelse{\equal{#1}{}}{}{#2#1#3}
}
\newcommand{\cvoptionalUrl}[3]{%
  \ifthenelse{\equal{#1}{}}{}{#2\url{#1}#3}
}


\newcommand{\myCVvar}[1]{%
  \expandafter\newcommand\csname #1VAR\endcsname{%
    \ClassError {epasscv} {missing #1 definition} {add the command}%
  }%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\renewcommand\csname #1VAR\endcsname{##1}%
  }%
}

\newcommand{\myCVOptVar}[1]{%
  \expandafter\newcommand\csname #1VAR\endcsname{%
    \@empty
  }%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\renewcommand\csname #1VAR\endcsname{##1}%
  }%
}

\myCVvar{cvname}
\myCVOptVar{cvpicture}


%%%%%%%%%%%%%%%%%%%%%%%%%%% custom layout %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[margin=3cm,top=3.5cm,bottom=3.5cm]{geometry}

\RequirePackage[explicit]{titlesec}   %custom titles

\newdimen\cvtitlewidth
\setlength{\cvtitlewidth}{4.8cm}
\newdimen\cvtitlespace
\setlength{\cvtitlespace}{1pc}

\titleformat{\section}[leftmargin]
{\vspace{.8ex}\large\scshape\sffamily\filleft}
{}{0pt}{#1}[\titlerule\\]
\titlespacing{\section}{\cvtitlewidth}{1.5ex plus .1ex minus .2ex}{\cvtitlespace}

\titleformat{\subsection}[leftmargin]{\large\scshape\sffamily\filleft}{}{0pt}{#1}
\titlespacing{\subsection}{\cvtitlewidth}{1.5ex plus .1ex minus .2ex}{\cvtitlespace}

\titleformat{\subsubsection}[leftmargin]{\filleft}{}{0pt}{#1}
\titlespacing{\subsubsection}{\cvtitlewidth}{0pt}{\cvtitlespace}

\setlength{\parindent}{0cm} % no indent
\setlength{\parskip}{.5\baselineskip} % space before paragraph

\RequirePackage{lastpage}
\RequirePackage{fancyhdr}

\pagestyle{fancy}
%\renewcommand{\headrulewidth}{0pt} % no header line
\fancyfoot{}  %clear
\fancyfoot[C]{\footnotesize Page \thepage\ of \pageref{LastPage}}
\fancyhead[L]{Europass}
\fancyhead[C]{Curriculum Vitae}
\fancyhead[R]{\cvnameVAR}

\setlength\textwidth{\textwidth - \cvtitlewidth} %reduce text width
\setlength{\hoffset}{\cvtitlewidth} %make space for the beginning of the title 
\fancyhfoffset[L]{\cvtitlewidth} % align the header to the title

%%%%%%%%%%%% LOCALIZATION 

\let\DEFsection\section
\renewcommand{\section}[2][\cvcurrentlanguageVAR]{%
  \ifthenelse{\equal{#1}{\cvcurrentlanguageVAR}}
  {\DEFsection{#2}}{}%
}

\let\DEFsubsection\subsection
\renewcommand{\subsection}[2][\cvcurrentlanguageVAR]{%
  \ifthenelse{\equal{#1}{\cvcurrentlanguageVAR}}
  {\DEFsubsection{#2}}{}%
}

\let\DEFsubsubsection\subsubsection
\renewcommand{\subsubsection}[2][\cvcurrentlanguageVAR]{%
  \ifthenelse{\equal{#1}{\cvcurrentlanguageVAR}}
  {\DEFsubsubsection{#2}}{}%
}

\newcommand{\only}[2][\cvcurrentlanguageVAR]{%
  \ifthenelse{\equal{#1}{\cvcurrentlanguageVAR}}
  {#2}{}%
}





%%%%%%%%%%%%%%%%%%%%%%%%%% date formatting %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[\cvfullLanguageVAR]{isodate}
\newcommand{\printd}[1]{%
\ifnum\pdfstrcmp{#1}{}=\z@\expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi
  {Current}{\texorpdfstring{\printdate{#1}}{}}% \texorpdfstring workaround for hyperref
}

%%%%%%%%%%%%%%%%%%%%%%%%%%% personal info %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{textpos} % position the image

\newenvironment{personalinfo}{
  \subsection{\cvpersonalinfoT} {\large \hfill \cvnameVAR \hfill }\vspace{1ex}
  
  \setlength{\parskip}{1pt}

  \begin{textblock*}{\cvtitlewidth}(-\cvtitlewidth - \cvtitlespace,\baselineskip)
    \raggedleft
    \cvpictureVAR
  \end{textblock*}
  
}{}

\newcommand{\cvaddress}[1]{\cvaddressicon~#1}

\newenvironment{cvphones}{\par}{\par}
\newcommand{\cvhome}[1]{\mbox{\cvphonehomeicon~\texttt{#1}}}
\newcommand{\cvmobile}[1]{\mbox{\cvphonemobileicon~\texttt{#1}}}
\newcommand{\cvwork}[1]{\mbox{\cvphoneworkicon~\texttt{#1}}}
\newcommand{\cvfax}[1]{\mbox{\cvphonefaxicon~\texttt{#1}}}

\newcommand{\cvemail}[1]{\cvemailicon~\url{#1}}

\newenvironment{cvinstantmessages}{\par}{\par}
\newcommand{\cvexpandimicon}[1]{%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \csname #1icon\endcsname~\texttt{##1}%
  }%
}
\cvexpandimicon{cvhangout}
\cvexpandimicon{cvskype}

\newenvironment{cvwebsites}{\par}{\par}
\newcommand{\cvexpandwebicon}[1]{%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \csname #1icon\endcsname~\url{##1}\par
  }%
}
\cvexpandwebicon{cvfacebook}
\cvexpandwebicon{cvgoogleplus}
\cvexpandwebicon{cvlinkedin}
\cvexpandwebicon{cvtwitter}
\cvexpandwebicon{cvwebsite}
\cvexpandwebicon{cvwordpress}

\newcommand{\cvnationality}[1]{\cvnationalityT: #1}
\newcommand{\cvdateofbirth}[1]{\cvdateofbirthT: \printd{#1}}
\newcommand{\cvgender}[1]{\cvgenderT:  #1}

%%%%%%%%%%%%%%%%%%%%%%%%%%% cv application %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{cvapplication}[1]{\subsection{#1}}{\par}

\newenvironment{cvpreferredjob}{\begin{cvapplication}{\cvpreferredjobT}}{\end{cvapplication}}
\newenvironment{cvjobapplied}{\begin{cvapplication}{\cvjobappliedT}}{\end{cvapplication}}
\newenvironment{cvposition}{\begin{cvapplication}{\cvpositionT}}{\end{cvapplication}}
\newenvironment{cvstudiesapplied}{\begin{cvapplication}{\cvstudiesappliedT}}{\end{cvapplication}}
\newenvironment{cvpersonalstat}{\begin{cvapplication}{\cvpersonalstatT}}{\end{cvapplication}}


%%%%%%%%%%%%%%%%%%%%%%% cv work and education %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{timespan}[2]{\subsubsection{\printd{#1} \\ \printd{#2}}}{\par}

%%%%%%%%%%%%%%%%%%%%%%%%% cv work experience %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\myCVOptVar{sector}
\newenvironment{occupation}[1]{{\large #1}\par}{\par}
\NewDocumentEnvironment{company}{O{}}{}{\\\cvoptionalUrl{#1}{}{\\}}
\newcommand{\businessOrSector}[1]{\businessOrSectorT~#1\\}

%%%%%%%%%%%%%%%%%%%%%%%%%%%% cv education %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{education}[2]{{\large #1} \hfill {\footnotesize #2}\par}{\par}
\NewDocumentEnvironment{institute}{O{}}{}{\\\cvoptionalUrl{#1}{}{\\}}

\newcommand{\thesis}[2]{Thesis title: ``#1''\\Degree: #2}

%%%%%%%%%%%%%%%%%%%%% cv skills and competences %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{tabularx}
\newcommand{\cvmothertongue}[1]{
  \subsubsection{\cvmothertongueT}
  #1
}

\newenvironment{cvotherlanguages}
{%
  {%
    \subsubsection{\cvotherlanguagesT}
    \cvlanguagesdefinedT\footnote{\cvlanguagesdefinedURL}
    \vspace{\parskip}
  }

  \setlength{\parskip}{0pt}
  \begin{tabularx}{\textwidth}{ >{\centering}X>{\centering}X|>{\centering}X>{\centering}X|>{\centering\arraybackslash}X }
      \multicolumn{2}{c}{Understanding} 
     & \multicolumn{2}{c}{Speaking}
     & \\
     \cvListeningT & \cvReadingT  & \cvInteractionT & \cvProductionT & \cvWritingT \\
     \hline
  \end{tabularx}%
}
{

\small
\cvlanguageslevelsT
}

\newcommand{\cvlanguage}[6]{%
  \subsubsection{#1}%
  \begin{tabularx}{\textwidth}{ >{\centering}X>{\centering}X|>{\centering}X>{\centering}X|>{\centering\arraybackslash}X }
     #2 & #3 & #4 & #5 & #6  
  \end{tabularx}%
}




\newcommand{\publication}[3]{%
  #1:\\
  \emph{#2}\\
  #3
}


