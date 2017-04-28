\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecarticle}[2015/10/20 EC (Eurolook-based) Article Class]

% Declare Options

% Article class options
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentlyrentOption}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{article}}

% Font options for eclook
\DeclareOption{times}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{libertine}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{charter}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{palatino}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{kpfonts}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{droidmono}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{inconsolata}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{notoc}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{user}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{nouser}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{official}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{unofficial}{\PassOptionsToPackage{\CurrentOption}{eclook}}
\DeclareOption{compact}{\PassOptionsToPackage{\CurrentOption}{eclook}}

\DeclareOption*{
  \ClassWarning{ecarticle}{Unknown option '\CurrentOption'}
}

\ExecuteOptions{11pt,times}

\ProcessOptions\relax

\LoadClass[a4paper]{article}

\RequirePackage[article]{eclook}

\endinput
