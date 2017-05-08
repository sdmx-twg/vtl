grammar Vtl;
import VtlTokens;

start: (statement? EOL)* statement? EOF;

/* Assignment */
statement: varID ASSIGN expr;

/* Conditional */
expr: exprOr															# exprOrExpr 
| IF exprOr THEN exprOr (ELSEIF exprOr THEN exprOr)* (ELSE exprOr)*		# exprIfExpr
| validationExpr #exprValidationExpr
;

/* Logical OR */
exprOr: exprAnd ( op=(OR|XOR) exprAnd )*;

/* Logical AND */
exprAnd: exprEq ( AND exprEq)*;

/* Equality, inequality */
exprEq: exprExists (op=( '='|'<>') exprExists )*;

/* Matching */
exprExists: exprComp (op=(EXISTS_IN | EXISTS_IN_ALL | NOT_EXISTS_IN | NOT_EXISTS_IN_ALL) exprComp)*;

/* Comparison, range */

exprComp: 
		exprAdd exprCompExt*;
		


exprCompExt: 
		(NOT)? IN setExpr #exprCompSet
		| opComp=('>'|'<'|'<='|'>=') exprAdd #exprCompComp
		| (NOT)? BETWEEN exprAdd AND exprAdd #exprCompBetween
		;	

/* Addition, subtraction */
exprAdd: exprMultiply (opAdd=('++'|'--'|'+'|'-') exprMultiply)*;

/* Multiplication, division */
exprMultiply:exprFactor (opMult=('**'|'//'|'*'|'/') exprFactor)*;

/* Unary plus, unary minus, not */
exprFactor: (opUnary=('+'|'-'|NOT)? exprMember)*;

/* Membership and clauses */
exprMember : exprAtom ('[' datasetClause ']')*(MEMBERSHIP componentID)?
			|exprAtom ('[' datasetClause ']')*(MEMBERSHIP_ALT componentID)?;

/* Rulesets Definition */

defMapping
  :
  defineMapping rulesetID '(' conditionClause? mapTo mapFrom ')' IS ruleClauseMapping endMappingRuleset
  ;

conditionClause
  :
  CONDITION '(' IDENTIFIER IDENTIFIER (',' IDENTIFIER IDENTIFIER)* ')'
  ;

mapTo
  :
  MAP_TO '(' IDENTIFIER IDENTIFIER ')'
  ;

mapFrom
  :
  MAP_FROM '(' IDENTIFIER IDENTIFIER ')'
  ;

ruleClauseMapping
  :
  (ruleItemMapping ';')+
  ;

ruleItemMapping
  :
  (IDENTIFIER ':')? ( WHEN expr THEN )? IDENTIFIER STRING_CONSTANT '=' IDENTIFIER STRING_CONSTANT
  ;

defHierarchical
  :
  defineHierarchicalRuleset rulesetID '(' hierRuleSignature ')' IS ruleClauseHierarchical endHierarchicalRuleset
  ;

ruleClauseHierarchical
  :
  ruleItemHierarchical (';' ruleItemHierarchical)*
  ;

ruleItemHierarchical
  :
  (IDENTIFIER ':')? ( WHEN expr THEN )? codeItemRelation (erCode)? (erLevel)?
  ;

hierRuleSignature
  :
  (antecedentItem)? codeItemRelationSignature
  ;

antecedentItem
  :
  ANTECEDENTVARIABLES rulesetSignature
  ;

codeItemRelationSignature
  :
  VARIABLE varID
  | VALUEDOMAIN valueDomainID
  ;

codeItemRelation
  :
  codeItemRef opComp=('='|'>'|'<'|'>='|'<=') codeItemRelationClause (codeItemRelationClause)*
  ;

codeItemRelationClause
  :
  (opAdd=('+'|'-'))? codeItemRef
  ;

codeItemRef
  :
  IDENTIFIER (FROM TIME)? (TO TIME)?
  ;

defDatapoint
  :
  defineDatapointRuleset rulesetID '(' rulesetSignature ')' IS ruleClauseDatapoint endDatapointRuleset
  ;

ruleClauseDatapoint
  :
  ruleItemDatapoint (';' ruleItemDatapoint)*
  ;

ruleItemDatapoint
  :
  (IDENTIFIER ':')? ( WHEN expr THEN )? expr (erCode)? (erLevel)?
  ;
  
rulesetSignature
  :
  varSignature (',' varSignature)*
  ;

varSignature
  :
  varID (AS STRING_CONSTANT)?
  ;  

/* Artefacts Definition */
defDataset
  :
  DEFINE_DATASET persistentDatasetID '(' (STRING_CONSTANT)? (IS_COLLECTED)? IDENTIFIER | dataStructureClause ')'
  ; 

defDataStructure
  :
  DEFINE_DATA_STRUCTURE IDENTIFIER '(' ( STRING_CONSTANT )? dataStructureClause
  ;

dataStructureClause
  :
  (dimensionType | valueDomainID dataStructureItem ';')+ ')'
  ; 
  									 
dataStructureItem
  :
  '(' IDENTIFIER roleID ')'
  ;

defVariable
  :
  DEFINE_VARIABLE varID
  ;

defValueDomainSubset
  :
  DEFINE_VALUE_DOMAIN_SUBSET valueDomainID '(' (STRING_CONSTANT ',' BOOLEAN_CONSTANT)?
  valueDomainID dimensionTypeClause ')'
  ;

defValueDomain
  :
  DEFINE_VALUE_DOMAIN valueDomainID '(' (STRING_CONSTANT ',' BOOLEAN_CONSTANT)? dimensionTypeClause ')'
  ;  
  
defFunction
  :
  CREATE_FUNCTION functionID '(' argList ')' RETURNS dimensionType AS expr
  ;  

dimensionTypeClause
  :
  dimensionType (codeListClause | dataTypeRestrictionClause)
  ;
  
codeListClause
  :
  LIST '(' (RECORD '(' '{' '@' IDENTIFIER AS IDENTIFIER ';' 
  ('#' constant AS constant ';')? '}' ')' )* ')'
  ;

dataTypeRestrictionClause
  :
  RESTRICT restrictClause
  ;

restrictClause
  :
  dateClause
  | stringClause
  | numberClause
  ;
  
numberClause
  :
  BETWEEN INTEGER_CONSTANT AND INTEGER_CONSTANT
  | COMPARISON_OP INTEGER_CONSTANT
  ;

stringClause
  : 
  MAX_LENGTH INTEGER_CONSTANT
  | REGEXP STRING_CONSTANT
  ;
  
dateClause
  :
  YYYY
  | MM
  | DD
  | YYYY '-' MM
  | COMPARISON_OP YYYY '-' MM '-' DD
  ;

/* Functions */
exprAtom
  :
  ROUND '(' expr ',' INTEGER_CONSTANT ')'							# roundAtom
  | CEIL '(' expr ')'												# ceilAtom
  | FLOOR '(' expr ')'												# floorAtom
  | MIN '(' expr ')'												# minAtom
  | MAX '(' expr ')'												# maxAtom
  | ABS '(' expr ')'												# minAtom
  | EXP '(' expr ')'												# expAtom
  | LN '(' expr ')'													# lnAtom
  | LOG '(' expr ',' logBase ')'									# logAtom
  | TRUNC '(' expr ',' INTEGER_CONSTANT ')'							# lnAtom
  | POWER '(' expr ',' exponent ')'									# powerAtom
  | SQRT '(' expr ')'												# sqrtAtom
  | NROOT '(' expr ',' INTEGER_CONSTANT ')'							# nrootAtom
  | LEN '(' expr ')'												# lenAtom
  | TRIM '(' expr ')'												# trimAtom
  | LTRIM '(' expr ')'												# ltrimAtom
  | RTRIM '(' expr ')'												# rtrimAtom
  | UCASE '(' expr ')'												# ucaseAtom
  | LCASE '(' expr ')'												# lcaseAtom
  | SUBSTR '(' expr ',' expr (',' expr)? ')'						# substrAtom
  | INSTR '(' expr ',' expr ( ',' expr)? (',' expr)? ')'			# instrAtom
  | DATE_FROM_STRING '(' expr ',' DATE_FORMAT ')'					# date_from_stringAtom
  | STRING_FROM_DATE '(' DATE_FORMAT ',' expr ')'					# string_from_dateAtom
  | REPLACE '(' expr ',' expr ( ',' expr)? ')'						# replaceAtom
  | INDEXOF '(' expr ',' STRING_CONSTANT ')'						# indexofAtom
  | MISSING '(' expr ')'											# missingAtom
  | CHARSET_MATCH '(' expr ',' IDENTIFIER ',' STRING_CONSTANT (',' ALL)? ')'	# charsetMatchAtom
  | CODELIST_MATCH '(' expr ',' setExpr (',' ALL)? ')'				# codelistMatchAtom
  | CHARLENGTH '(' expr ')'											# charLengthAtom
  | TYPE '(' expr ')' '=' STRING_CONSTANT							# typeAtom
  | INTERSECT '(' expr ',' expr ')'									# intersectAtom
  | UNION '(' expr ',' expr ')'										# unionAtom
  | DIFF '(' expr ',' expr ')'										# diffAtom
  | NOT_IN '(' expr ',' expr ')'									# notInAtom
  | ISNULL '(' expr ')'												# isNullAtom
  | NVL '(' expr ',' constant ')'									# nvlAtom
  | MOD '(' expr ',' expr ')'										# modAtom
  | LISTSUM '(' expr (',' expr)? ')'								# listsumAtom
  | ALL '(' expr ')'												# allAtom
  | ANY '(' expr ')'												# anyAtom
  | UNIQUE '(' expr ')'												# uniqueAtom
  | FUNC_DEP '(' expr ',' expr ',' expr ')'							# func_depAtom
  | EXTRACT '(' expr ',' STRING_CONSTANT ')'						# extractAtom
  | CURRENT_DATE '(' ')'										    # currentDateAtom
  | getExpr															# getExprAtom
  | ref																# refAtom
  | putExpr															# putExprAtom
  | evalExpr														# evalExprAtom
  | mergeExpr														# mergeExprAtom
  | hierarchyExpr													# hierarchyExprAtom
  | FLOW_TO_STOCK '(' expr ')'										# flowToStockAtom
  | STOCK_TO_FLOW '(' expr ')'										# stockToFlowAtom
  ;

/* alterDataset */
alterExpr
  :
  ALTER_DATASET '(' expr (componentList)? (ALL)? ')'
  ;

/* Parentheses */
ref: '(' exprOr ')'													# parenthesisExprRef
  | varID															# varIdRef
  | constant														# constantRef
  | list															# listRef
  ; 

/* list, component list, dedupList, argList, valueDomainList */
list:
	'[' (constant (',' constant)*)? ']'; 	

listofCompList
  :
  componentList (',' componentList)*
  ;

componentList
  :
  ','? constant (',' constant)*
  ;						
  
dedupList
  :
  constant '*' constant (',' constant '*' constant)*
  ;  

argList
  : arg (',' arg)* 
  ;

arg
  :
  IDENTIFIER (AS dimensionType)? (ASSIGN constant)?
  ;
  
valueDomainList
  :
  dimensionType (',' dimensionType)*
  ;

/* get */
getExpr
  : 
  GET '(' persistentDatasetID (',' persistentDatasetID)* (',' keepClause)? (',' dedupClause)? (',' filterClause)? (',' aggregategetClause)? ')'
  ;

/* put */
putExpr
  : 
  PUT '(' expr ',' persistentDatasetID ')'
  ;

/* eval */
evalExpr
  : 
  EVAL '(' STRING_CONSTANT (',' ref)* ',' persistentDatasetID ')'
  ;

/* concatenation */
concatExpr
  :
  expr CONCAT expr
  ;

/* timeshift */
timeShiftExpr
  :
  TIMESHIFT '(' expr ',' componentID ',' TIME_UNIT ',' INTEGER_CONSTANT ')'
  ;

/* fill time series */
timeSeriesExpr
  :
  FILL_TIME_SERIES '(' expr ',' FREQUENCY (',' STRING_CONSTANT)? (',' TIME_FORMAT)? ')'
  ;

/* check */
validationExpr
  : CHECK '(' exprOr (',' THRESHOLD '(' constant ')')? (',' NOT_VALID|VALID|ALL)? (',' MEASURES | CONDITION )?
  (',' IMBALANCE '(' exprOr ')')? (',' erCode)? (',' erLevel )? ')'
  ;

validationDatapoint
  :
  CHECK '(' persistentDatasetID ',' rulesetID (',' NOT_VALID|VALID|ALL)? (',' CONDITION|MEASURES)? ')'
  ;
  
validationHierarchical
  :
  CHECK '(' persistentDatasetID ',' rulesetID (',' THRESHOLD '(' INTEGER_CONSTANT ')' )? 
  (',' NOT_VALID|VALID|ALL)? (',' MEASURES|CONDITION)? ')'
  ;
  
validationValueDoman
  :
  CHECK_VALUE_DOMAIN_SUBSET '(' expr ',' componentList | (listofCompList '(' (componentList)+')' ',' valueDomainList)? ',' IDENTIFIER ')'
  ;

erCode
  :
  ERRORCODE '(' STRING_CONSTANT ')'
  ;
  
erLevel
  :
  ERRORLEVEL '(' constant ')'
  ;

/* merge */
mergeExpr
  : 
  MERGE '(' expr AS? STRING_CONSTANT (',' expr AS? STRING_CONSTANT)+ ',' ON '(' expr ')' ',' RETURN 
  '(' (expr AS? STRING_CONSTANT) (',' expr AS? STRING_CONSTANT)+ ')' ')'
  ;

/* hierarchy */
hierarchyExpr
  : 
  HIERARCHY '(' expr ',' IDENTIFIER ','
  ( STRING_CONSTANT | (mappingExpr (',' mappingExpr)* AS STRING_CONSTANT)) ',' BOOLEAN_CONSTANT (',' aggrParam)? ')'
  ;

mappingExpr
  :
  '(' constant ',' INTEGER_CONSTANT ','
  ('+' | '-')')' TO constant
  ;

aggrParam
  :
  'sum'
  | 'prod'
  ;

/* Clauses. */
datasetClause
  :
  RENAME renameClause
  | aggrClause
  | filterClause
  | calcClause
  | attrCalcClause
  | keepClause
  | dropClause
  | compareClause
  ;

anFunctionClause
  :
  anFunction OVER '(' (partitionByClause)? (orderByClause)? (windowingClause)? ')'
  ;  

partitionByClause
  :
  PARTITION BY IDENTIFIER (',' IDENTIFIER)+
  ;
  
orderByClause
  :
  ORDER BY componentID (',' componentID)+ (ASC|DESC)?
  ;
  
windowingClause
  :
  ROWS|RANGE betweenRowsClauseItem AND betweenRowsClauseItem
  ;
  
betweenRowsClauseItem
  :
  INTEGER_CONSTANT PRECEDING
  | INTEGER_CONSTANT FOLLOWING
  | CURRENT_ROW
  | UNBOUNDED_PRECEDING 
  | UNBOUNDED_FOLLOWING
  ;   

/* Join Expressions*/

joinExpr
  :
  ('[' joinClause ']')? joinBody?
  ;

joinClause
  :
  (INNER|OUTER|CROSS)? (expr (',' expr)*)? ON IDENTIFIER (',' IDENTIFIER)*?
  ;

joinBody
  :
  '{' clause (',' clause)* '}'
  ;

clause
  :
  joinCalcClause
  | joinDropClause
  | joinKeepClause
  | joinFilterClause
  | joinRenameClause
  | joinUnfoldClause
  | joinFoldClause
  ;

joinCalcClause
  :
  roleID? componentID '=' expr
  ;

joinDropClause
  :
  DROP (dropClauseItem (',' dropClauseItem)*)?
  ;

joinKeepClause
  :
  KEEP (keepClauseItem (',' keepClauseItem)*)?
  ;

joinFilterClause
  :
  FILTER expr|rulesetID
  ;

joinRenameClause
  :
  RENAME componentID TO componentID (',' componentID TO componentID)?
  ;

joinUnfoldClause
  :
  UNFOLD componentID ',' IDENTIFIER TO IDENTIFIER (',' IDENTIFIER)?
  ;

joinFoldClause
  :
  FOLD IDENTIFIER (',' IDENTIFIER)? TO IDENTIFIER ',' IDENTIFIER
  ;

/* Analytic Functions*/
anFunction
  :
  FIRST_VALUE '(' expr ')'
  | LAG_LEAD '(' expr ',' INTEGER_CONSTANT ',' INTEGER_CONSTANT ')'
  | LAST_VALUE '(' expr ')'
  | NTILE '(' expr ')'
  | PERCENT_RANK '(' expr ')'
  | RANK '(' expr ')'
  | RATIO_TO_REPORT '(' expr ')'
  ;

aggregategetClause
  :
  AGGREGATE '(' aggrFunction '(' expr ')' (',' aggrFunction '(' expr ')')* ')'
  ;

aggregateClause
  :
  aggrFunctionClause (',' aggrFunctionClause)*
  ;

aggrFunctionClause
  :
  aggrFunction ( GROUP_BY|ALONG '(' IDENTIFIER (',' IDENTIFIER)+ ')' )?
  ;

dedupClause
  :
  DEDUP '(' dedupList? ')'
  ;

getFiltersClause
  :
    getFilterClause (',' getFilterClause)*
 ;

getFilterClause
  :
    (FILTER? expr)
  ;

aggrClause : AGGREGATE aggregateClause;

filterClause
  :
  FILTER expr 
  ;

renameClause
  :
  varID AS STRING_CONSTANT (ROLE roleID)? (',' varID AS STRING_CONSTANT (ROLE roleID)?)* 
  ;

aggrFunction
  :
  SUM '(' (INCLUDE_NULLS)? expr ')'
  | AVG '(' (INCLUDE_NULLS)? expr ')'
  | CORR '(' (INCLUDE_NULLS)? expr expr ')'
  | COVAR_POP '(' (INCLUDE_NULLS)? expr expr ')'
  | COVAR_SAMP '(' (INCLUDE_NULLS)? expr expr ')'
  | COUNT '(' (INCLUDE_NULLS)? expr ')'
  | MEDIAN '(' (INCLUDE_NULLS)? expr ')'
  | MIN '(' (INCLUDE_NULLS)? expr ')'
  | MAX '(' (INCLUDE_NULLS)? expr ')'
  | PERCENTILE_CONT '(' (INCLUDE_NULLS)? expr constant ')' ORDER BY expr (ASC|DESC)?
  | PERCENTILE_DISC '(' (INCLUDE_NULLS)? expr constant ')' ORDER BY expr (ASC|DESC)?
  | RANK '(' (INCLUDE_NULLS)? expr ')'
  | REGR_SLOPE '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_INTERCEPT '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_COUNT '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_R2 '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_AVGX '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_AVGY '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_SXX '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_SYY '(' (INCLUDE_NULLS)? expr expr ')'
  | REGR_SXY '(' (INCLUDE_NULLS)? expr expr ')'
  | STDDEV_POP '(' (INCLUDE_NULLS)? expr ')'
  | STDDEV '(' (INCLUDE_NULLS)? expr ')'
  | VAR_POP '(' (INCLUDE_NULLS)? expr ')'
  | VAR_SAMP '(' (INCLUDE_NULLS)? expr ')'
  | VARIANCE '(' (INCLUDE_NULLS)? expr ')'
  ;

calcClause
  :
  CALC calcClauseItem (',' calcClauseItem)*
  ;

attrCalcClause
  :
  ATTRCALC expr AS STRING_CONSTANT (VIRAL)? (',' expr	 AS STRING_CONSTANT (VIRAL)?)*
  ;

calcClauseItem
  :
  calcExpr AS STRING_CONSTANT (ROLE roleID (VIRAL)?)?
  ;

calcExpr
  :
  aggrFunction '(' expr ')'
  | expr
  ;

dropClause
  :
  DROP '(' dropClauseItem (',' dropClauseItem)* ')'
  ;

dropClauseItem
  :
  varID
  ;

keepClause
  :
  KEEP '(' keepClauseItem (',' keepClauseItem)* ')'
  ;

keepClauseItem
  :
  varID
  ;

compareClause
  :
  COMPARISON_OP constant
  ;

inBetweenClause
  :
  IN setExpr
  | BETWEEN constant AND constant
  | NOT IN setExpr
  | NOT BETWEEN constant AND constant
  ;

dimClause
  :
  | compareClause
  | inBetweenClause
  ;

/* Set expressions */
setExpr
  :
  '(' constant (','constant)* ')'
  | UNION '(' setExpr (',' setExpr)+ (',' DEDUP '(' expr ')' )? ')'		
  | SYMDIFF '(' setExpr ',' setExpr ')'
  | SETDIFF '(' setExpr ',' setExpr ')'
  | INTERSECT '(' setExpr ',' setExpr (',' DEDUP '(' expr ')' )? ')'
  | TRANSCODE '(' componentID ',' expr ',' mapItemClause|rulesetID ')'
  | AGGREGATE '(' expr ',' rulesetID (',' TOTAL|PARTIAL)? (',' returnAgg|returnAll)? ')'
  ;

/* subscript expression*/
subscriptExpr
  :
  persistentDatasetID '[' componentID '=' constant ( ',' componentID '=' constant)? ']' 
  ;

mapItemClause
  :
  persistentDatasetID (IDENTIFIER MAPS_FROM dimensionType)? (IDENTIFIER MAPS_TO dimensionType)?
  ;

/* aggregate sequences */
returnAgg
  :
  RETURN AGGREGATES
  ;
  
returnAll
  :
  RETURN ALL DATA POINTS
  ;

/* Role name*/
roleID
  :
  MEASURE
  |DIMENSION
  |ATTRIBUTE
  ;

/* Dimension Type */
dimensionType
  :
  DATE
  | STRING
  | NUMBER
  ;

/* Arithmetic */
logBase
  :
  INTEGER_CONSTANT
  ;

exponent
  :
  INTEGER_CONSTANT|FLOAT_CONSTANT
  ;

/* Variable, identifiers, constants */
persistentDatasetID
  : 
  STRING_CONSTANT
  ;

 rulesetID
  :
  IDENTIFIER
  ;

valueDomainID
  :
  IDENTIFIER
  ;

varID
  :
  IDENTIFIER
  ;
  
componentID
  :
  IDENTIFIER
  ;
  
 functionID
  :
  IDENTIFIER
  ;

constant
  :
  INTEGER_CONSTANT
  | FLOAT_CONSTANT
  | BOOLEAN_CONSTANT
  | STRING_CONSTANT
  | NULL_CONSTANT
  ;
  
 defineDatapointRuleset
  :
  DEFINE DATAPOINT RULESET
  ;
  
 defineHierarchicalRuleset
   :
   DEFINE HIERARCHICAL RULESET
   ;
   
 defineMapping
   :
   DEFINE MAPPING
   ;
   
 endDatapointRuleset
   :
   END DATAPOINT RULESET
   ;
   
 endHierarchicalRuleset
   :
   END HIERARCHICAL RULESET
   ;
   
 endMappingRuleset
   :
   END MAPPING RULESET
   ;
