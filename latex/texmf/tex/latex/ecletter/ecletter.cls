\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecletter}[2015/10/20 EC (Eurolook-based) Article Class]

% Declare Options

\DeclareOption{10pt}{
	\PassOptionsToClass{\CurrentOption}{letter}
}

\DeclareOption{11pt}{
	\PassOptionsToClass{\CurrentOption}{letter}
}

\DeclareOption{12pt}{
	\PassOptionsToClass{\CurrentOption}{letter}
}

\DeclareOption{twosides}{
	\PassOptionsToClass{\CurrentOption}{letter}
}

\DeclareOption{oneside}{
	\PassOptionsToClass{\CurrentOption}{letter}
}

\DeclareOption{times}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{libertine}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{charter}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{palatino}{'
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{kpfonts}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{droidmono}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{inconsolata}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{notoc}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{user}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{nouser}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{official}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}

\DeclareOption{unofficial}{
	\PassOptionsToPackage{\CurrentOption}{eclook}
}


\DeclareOption*{
  \ClassWarning{ecletter}{Unknown option '\CurrentOption'}
}

\ExecuteOptions{12pt,times}

\ProcessOptions\relax

\LoadClass[a4paper]{letter}

\RequirePackage[margin=2.5cm]{geometry}

\RequirePackage[defmemo]{eclook}

\endinput
