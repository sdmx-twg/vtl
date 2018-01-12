grammar Vtl;
import VtlTokens;

start: (statement? EOL)* statement? EOF;

/* Assignment */
statement: varID ASSIGN expr;

/* Conditional */
expr: exprOr															# exprOrExpr 
| IF exprOr THEN exprOr ELSE exprOr		# exprIfExpr
| validationExpr #exprValidationExpr
;

/* Logical OR */
exprOr: exprAnd ( op=(OR|XOR) exprAnd )*;

/* Logical AND */
exprAnd: exprEq ( AND exprEq)*;

/* Equality, inequality */
exprEq: exprExists (op=( '='|'<>') exprExists )*;

/* Matching */
exprExists: exprComp (((NOT)? EXISTS_IN)  exprComp (ALL)? )*;

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
/* CURRENTLY UNDER REVIEW
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
*/

/* Artefacts Definition */
defDataset
  :
  DEFINE DATASET persistentDatasetID '(' (STRING_CONSTANT)? (IS_COLLECTED)? IDENTIFIER | dataStructureClause ')'
  ; 

defDataStructure
  :
  defineDataStructure IDENTIFIER '(' ( STRING_CONSTANT )? dataStructureClause
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
  DEFINE VARIABLE varID
  ;

defValueDomainSubset
  :
  defineValueDomainSubset valueDomainID '(' (STRING_CONSTANT ',' BOOLEAN_CONSTANT)?
  valueDomainID dimensionTypeClause ')'
  ;

defValueDomain
  :
  defineValueDomain valueDomainID '(' STRING_CONSTANT ',' BOOLEAN_CONSTANT ',' valueFormat ',' dataTypeRestrictionClause ',' codeListClause2 ')'
  ;  
  
defFunction
  :
  DEFINE OPERATOR operatorID '(' argList ')' RETURNS dimensionType AS expr
  ;  
  
callFunction
  :
  operatorID '(' constant (',' constant)* ')'
  ;  

dimensionTypeClause
  :
  dimensionType (codeListClause | dataTypeRestrictionClause)
  ;
 
codeListClause
  :
  LIST '(' (RECORD '(''{''@' IDENTIFIER AS IDENTIFIER ';' ('#' constant AS constant ';')?'}'')')*')'
  ; 
  
codeListClause2
  :
  CODELIST IDENTIFIER '(' codeItemDefinition (codeItemDefinition)*')'
  ;
  
 codeItemDefinition
  :
  '('IDENTIFIER ',' STRING_CONSTANT (',' DATEFORMAT ',' DATEFORMAT)? ')'
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
  | LEN '(' expr ')'												# lenAtom
  | TRIM '(' expr ')'												# trimAtom
  | LTRIM '(' expr ')'												# ltrimAtom
  | RTRIM '(' expr ')'												# rtrimAtom
  | UCASE '(' expr ')'												# ucaseAtom
  | LCASE '(' expr ')'												# lcaseAtom
  | SUBSTR '(' expr ',' expr (',' expr)? ')'						# substrAtom
  | INSTR '(' expr ',' expr ( ',' expr)? (',' expr)? ')'			# instrAtom
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
  | (NOT)? IN '(' expr ',' expr ')'									# notInAtom
  | ISNULL '(' expr ')'												# isNullAtom
  | NVL '(' expr ',' expr ')'									# nvlAtom
  | MOD '(' expr ',' expr ')'										# modAtom
  | ALL '(' expr ')'												# allAtom
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

/* list, component list, argList, valueDomainList */
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
  GET '(' persistentDatasetID (',' persistentDatasetID)* (',' keepClause)? (',' filterClause)? (',' aggregategetClause)? ')'
  ;

/* put */
putExpr
  : 
  PUT_SYMBOL '(' expr ',' persistentDatasetID ')'
  ;

/* eval */
evalExpr
  : 
  EVAL '(' STRING_CONSTANT (',' STRING_CONSTANT)* (',' ref)* ',' persistentDatasetID ')'
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
  joinKeyword '(' joinClause (joinBody)? ')'
  ;

joinClause
  :
  expr (AS IDENTIFIER (',' expr (AS IDENTIFIER))*)? (USING componentID (',' componentID)*)?
  ;

joinBody
  :
  clause (clause)* 
  ;

clause
  :
  joinCalcClause
  | joinDropClause
  | joinKeepClause
  | joinFilterClause
  | joinRenameClause
  | joinApplyClause
  ;

joinCalcClause
  :
  roleID? joinCalcClauseItem (',' joinCalcClauseItem)*
  ;

joinCalcClauseItem
  :
  componentID ':=' expr
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
  RENAME componentID TO componentID (',' componentID TO componentID)*?
  ;
  
joinApplyClause
  :
  APPLY expr
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
  varID TO STRING_CONSTANT (',' varID TO STRING_CONSTANT)* 
  ;

aggrFunction
  :
  SUM '(' (INCLUDE_NULLS)? expr ')'
  | AVG '(' (INCLUDE_NULLS)? expr ')'
  | COUNT '(' (INCLUDE_NULLS)? expr ')'
  | MEDIAN '(' (INCLUDE_NULLS)? expr ')'
  | MIN '(' (INCLUDE_NULLS)? expr ')'
  | MAX '(' (INCLUDE_NULLS)? expr ')'
  | RANK '(' (INCLUDE_NULLS)? expr ')'
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

calcClauseItem
  :
  (roleID)? calcExpr ':=' calcExpr
  ;

calcExpr
  :
  aggrFunction '(' expr ')'
  | expr
  ;

dropClause
  :
  DROP '[' dropClauseItem (',' dropClauseItem)* ']'
  ;

dropClauseItem
  :
  varID
  ;

keepClause
  :
  KEEP '[' keepClauseItem (',' keepClauseItem)* ']'
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
  | UNION '(' setExpr (',' setExpr)+ ')'		
  | SYMDIFF '(' setExpr ',' setExpr ')'
  | SETDIFF '(' setExpr ',' setExpr ')'
  | INTERSECT '(' setExpr ',' setExpr ')'
 /* | TRANSCODE '(' componentID ',' expr ',' mapItemClause|rulesetID ')'  #CURRENTLY UNDER REVIEW */
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

/* pivot/unpivot expressions */

unpivotExpr
:
persistentDatasetID '[' varID ',' varID TO pivotList ']'
;

pivotExpr
 :
 persistentDatasetID '[' PIVOT pivotList TO varID ',' varID ']'
 ;

pivotList
  :
  '(' constant (',' constant)* ')'
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
  |viralAttribute
  ;
  
 viralAttribute
  : 
  VIRAL ATTRIBUTE
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
  
 operatorID
  :
  IDENTIFIER
  ;
  
 joinKeyword
  :
  INNER_JOIN
  |LEFT_JOIN
  |FULL_JOIN
  |CROSS_JOIN
  ;

constant
  :
  INTEGER_CONSTANT
  | FLOAT_CONSTANT
  | BOOLEAN_CONSTANT
  | STRING_CONSTANT
  | NULL_CONSTANT
  ;
  
  valueFormat
  :
  STRING
  | INTEGER
  | FLOAT
  | BOOLEAN
  | DATE
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
   
 defineValueDomain
   :
   DEFINE VALUE_DOMAIN
   ;  
   
 defineValueDomainSubset
   :
   DEFINE VALUE_DOMAIN_SUBSET
   ;  
   
 defineDataStructure
   :
   DEFINE DATA STRUCTURE
   ; 
