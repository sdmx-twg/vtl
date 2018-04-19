grammar Vtl;
import VtlTokens;

start: (statement? EOL)* statement? EOF;

/* Assignment */
statement: (varID ASSIGN)? expr;

/* Conditional */

optionalExpr
 : expr | OPTIONAL
 ;

expr: exprOr															# exprOrExpr 
| IF exprOr THEN exprOr ELSE exprOr		# exprIfExpr
| validationExpr #exprValidationExpr
| defExpr #definitionExpressions
| aggrInvocation #standaloneAggregateFunction
| aggrInvocationCompExpr #componentExpressionwithAggrClause
| anFunctionClause #standaloneAnalyticFunction
| timeExpr #timeexpressions
| setExpr #setExpressions
| exprAtom #atomicExpression
;

timeExpr
 :timeSeriesExpr
 |periodExpr (opComp=('>'|'<'|'<='|'>='|'='|'<>') expr)?
 |timeShiftExpr
 |timeAggExpr
 |curDate
 ;



/* Logical OR */
exprOr: exprAnd ( op=(OR|XOR) exprAnd )*;

/* Logical AND */
exprAnd: exprEq ( AND exprEq)*;

/* Equality, inequality */
exprEq: exprExists (op=( '='|'<>') exprExists )*;

/* Matching */
exprExists: 
           exprComp (((NOT)? EXISTS_IN)  exprComp (ALL)? )*
		   | (NOT)? EXISTS_IN '(' expr ',' expr (',' retainType)? ')'
		   ;

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
exprMember : exprAtom ('[' (datasetClause|(expr ASSIGN expr)) ']')*(MEMBERSHIP componentID)?
			|exprAtom ('[' (datasetClause|(expr ASSIGN expr)) ']')*(MEMBERSHIP_ALT componentID)?										
			;

/* Rulesets Definition */       
    
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
  (IDENTIFIER ':')? codeItemRelation (erCode)? (erLevel)?
  ;
  
 hierRuleSignature
  :
  (VALUE_DOMAIN|VARIABLE) valueDomainSignature? RULE IDENTIFIER
  ; 
  
 valueDomainSignature
  :
  CONDITION IDENTIFIER (AS IDENTIFIER)? (',' IDENTIFIER (AS IDENTIFIER)?)*
  ; 
  
codeItemRelation
  :
  ( WHEN expr THEN )? codeItemRef codeItemRelationClause (codeItemRelationClause)*
  ;

codeItemRelationClause
  :
  (opAdd=('+'|'-'))? IDENTIFIER ('[' expr ']')?
  ;
  
codeItemRef
  :
  IDENTIFIER (opComp=('='|'>'|'<'|'>='|'<='))?
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
  (VALUE_DOMAIN|VARIABLE) varSignature (',' varSignature)*
  ;
varSignature
  :
  varID (AS IDENTIFIER)?
  ;  

/* Artefacts Definition */
defExpr
  :
  defOperator
  |callFunction
  |joinExpr
  |defDatapoint
  |defHierarchical
  ; 
  
defOperator
  :
  DEFINE OPERATOR operatorID '(' parameterItem (',' parameterItem)* ')' (RETURNS dataType)? IS expr END DEFINE OPERATOR
  ;  
 
parameterItem
  :
  varID dataType (DEFAULT constant)?
  ;
    
callFunction
  :
  operatorID '(' (constant (',' constant)*)? ')'
  ;   

/* Functions */
exprAtom
  :
  ROUND '(' expr (',' (INTEGER_CONSTANT|'_'))? ')'					# roundAtom
  | CEIL '(' expr ')'												# ceilAtom
  | FLOOR '(' expr ')'												# floorAtom
  | MIN '(' expr ')'												# minAtom
  | MAX '(' expr ')'												# maxAtom
  | ABS '(' expr ')'												# minAtom
  | EXP '(' expr ')'												# expAtom
  | LN '(' expr ')'													# lnAtom
  | LOG '(' expr ',' logBase ')'									# logAtom
  | TRUNC '(' expr (',' (INTEGER_CONSTANT|'_'))? ')'				# lnAtom
  | POWER '(' expr ',' exponent ')'									# powerAtom
  | SQRT '(' expr ')'												# sqrtAtom
  | LEN '(' expr ')'												# lenAtom
  | BETWEEN '(' expr ',' expr ',' expr ')'							# betweenAtom
  | TRIM '(' expr ')'												# trimAtom
  | LTRIM '(' expr ')'												# ltrimAtom
  | RTRIM '(' expr ')'												# rtrimAtom
  | UCASE '(' expr ')'												# ucaseAtom
  | LCASE '(' expr ')'												# lcaseAtom
  | SUBSTR '(' expr (',' optionalExpr)? (',' optionalExpr)? ')'		# substrAtom
  | INSTR '(' expr ',' STRING_CONSTANT ( ',' optionalExpr)? (',' optionalExpr)? ')'			# instrAtom
  | REPLACE '(' expr ',' expr ( ',' optionalExpr)? ')'				# replaceAtom
  | INDEXOF '(' expr ',' STRING_CONSTANT ')'						# indexofAtom
  | CHARSET_MATCH '(' expr ','  STRING_CONSTANT ')'	# charsetMatchAtom
  | TYPE '(' expr ')' '=' STRING_CONSTANT							# typeAtom
 /* | INTERSECT '(' '[' expr (',' expr)* ']' ')'									# intersectAtom  */
 /* | UNION '(' '[' expr (',' expr)* ']' ')'										# unionAtom */
 /* | SYMDIFF '(' expr ',' expr ')'									#symdiffAtom */
 /* | SETDIFF '(' expr ',' expr ')'									#setdiffAtom */
  | (NOT)? IN '(' expr ',' expr ')'									# notInAtom
  | ISNULL '(' expr ')'												# isNullAtom
  | NVL '(' expr ',' expr ')'									# nvlAtom
  | MOD '(' expr ',' expr ')'										# modAtom
  | ALL '(' expr ')'												# allAtom
  | ref																# refAtom
  | putExpr															# putExprAtom
  | evalExpr														# evalExprAtom
  | castExpr														# castExprAtom
  | mergeExpr														# mergeExprAtom
  | hierarchyExpr													# hierarchyExprAtom
  | FLOW_TO_STOCK '(' expr ')'										# flowToStockAtom
  | STOCK_TO_FLOW '(' expr ')'										# stockToFlowAtom
  | concatExpr														#concatenationExpr
  | validationDatapoint												#validateDPruleset
  | validationHierarchical 											#validateHRruleset
  | validationExpr													#validationSimple
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
  
identifierList
  :
  '[' IDENTIFIER (',' IDENTIFIER)* ']'
  ;			 

argList
  : arg (',' arg)* 
  ;

arg
  :
  IDENTIFIER (AS dataType)? (ASSIGN constant)?
  ;
  
valueDomainList
  :
  dimensionType (',' dimensionType)*
  ;

/* put PUT_SYMBOL '(' expr ',' persistentDatasetID ')' */
putExpr
  : 
  PUT_SYMBOL expr
  ;
  
  

/* eval */
evalExpr
  :
  EVAL '(' routineName '(' componentID? (',' componentID)* ')' (',' STRING_CONSTANT)? (',' RETURNS dataType)? ')'
  ;
  
/* cast */
castExpr
  :  
  CAST '(' (IDENTIFIER|expr) ',' (dataType|IDENTIFIER) (',' STRING_CONSTANT)? ')'
  ;

/* concatenation */
concatExpr
  :
  (IDENTIFIER|STRING_CONSTANT) CONCAT (IDENTIFIER|STRING_CONSTANT)
  ;

/* Time operators */

periodExpr
  :
  PERIOD_INDICATOR '(' expr? ')'
  ;

/* timeshift */
timeShiftExpr
  :
  TIMESHIFT '(' expr (',' INTEGER_CONSTANT)? ')'
  ;

/* fill time series */
timeSeriesExpr
  :
  FILL_TIME_SERIES '(' expr (',' (SINGLE|ALL))? ')'
  ;  
  
/* time period agg */
timeAggExpr
  :
  TIME_AGGR '(' STRING_CONSTANT (',' (STRING_CONSTANT|'_'))? (',' (expr|'_'))? (',' (FIRST|LAST))? ')' 
  ;
  
/* current date */
 curDate
  :
  CURRENT_DATE '('')'
  ;  

/* check */
validationExpr
  : CHECK '(' exprOr (erCode)? (erLevel)? (IMBALANCE expr)?  (INVALID|ALL)? ')'  
  ;

validationDatapoint
  :
   CHECK_DATAPOINT '(' IDENTIFIER ',' IDENTIFIER (COMPONENTS componentID (',' componentID)*)? (OUTPUT (INVALID|ALL|ALL_MEASURES))? ')'
  ;
  
validationHierarchical
  :
  CHECK_HIERARCHY '(' IDENTIFIER ',' IDENTIFIER (CONDITION componentID (',' componentID)*)? (RULE IDENTIFIER)? (modeHierarchical)? (DATASET|DATASET_PRIORITY)? (INVALID|ALL|ALL_MEASURES)? ')'
  ;
  
validationValueDoman
  :
  CHECK_VALUE_DOMAIN_SUBSET '(' expr ',' componentList | (listofCompList '(' (componentList)+')' ',' valueDomainList)? ',' IDENTIFIER ')'
  ;

erCode 
  :
  ERRORCODE  constant 
  ;
  
erLevel
  :
  ERRORLEVEL  constant
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
  HIERARCHY '(' expr ',' IDENTIFIER (CONDITION componentID (',' componentID)*)? (RULE IDENTIFIER)? (modeHierarchical|'_')? (inputHierarchical|'_')? (outputHierarchical|'_')? ')'
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
  | pivotExpr
  | unpivotExpr
  | subspaceExpr
  ;



anFunctionClause
  :
  aggrFunctionName '(' expr (',' expr)* OVER '(' (partitionByClause)? (orderByClause)? (windowingClause)? ')' ')'
  ;  

partitionByClause
  :
  PARTITION BY IDENTIFIER (',' IDENTIFIER)*
  ;
  
orderByClause
  :
  ORDER BY componentID (ASC|DESC)? (',' componentID (ASC|DESC)?)* 
  ;
  
windowingClause
  :
  (DATA_POINTS|RANGE) BETWEEN limitClauseItem AND limitClauseItem
  ;
  
limitClauseItem
  :
  (INTEGER_CONSTANT PRECEDING)
  | (INTEGER_CONSTANT FOLLOWING)
  | (CURRENT DATA_POINT)
  | UNBOUNDED_PRECEDING 
  | UNBOUNDED_FOLLOWING
  ;   

/* Join Expressions*/

joinExpr
  :
  joinKeyword '(' joinClause (joinBody)? (',' joinClause (joinBody)?)* ')'
  ;

joinClause
  :
  expr (AS IDENTIFIER)? (',' expr (AS IDENTIFIER)?)* (USING componentID (',' componentID)*)?
  ;

joinBody
  :
  clause (clause)* 
  ;

clause
  :
  (joinKeepClause | joinDropClause)
  | (joinCalcClause | joinApplyClause | joinAggClause)
  | joinFilterClause
  | joinRenameClause
  ;

joinCalcClause
  :
  roleID? joinCalcClauseItem (',' joinCalcClauseItem)*
  ;

joinCalcClauseItem
  :
  CALC (roleID)? joinCalcExpr (',' joinCalcExpr)*
  ;

joinCalcExpr
  :
  (componentID ':=')? expr
  ;
  
joinAggClause
  :
  roleID? AGGREGATE joinAggClauseItem (',' joinAggClauseItem)* groupingClause? havingClause?
  ;

joinAggClauseItem
  :
   (roleID)? joinAggExpr (',' joinAggExpr)*
  ;

joinAggExpr
  :
  componentID ':=' aggrFunction 
  ;
  
joinKeepClause
  :
  KEEP keepClauseItem (',' keepClauseItem)* 
  ;

joinDropClause
  :
  DROP dropClauseItem (',' dropClauseItem)* 
  ;

joinFilterClause
  :
  FILTER expr|rulesetID
  ;

joinRenameClause
  :
  RENAME (componentID MEMBERSHIP)? varID  TO (componentID MEMBERSHIP)? varID (',' (componentID MEMBERSHIP)? varID TO (componentID MEMBERSHIP)? varID)*?
  ;
  
joinApplyClause
  :
  APPLY expr
  ; 


/* Analytic Functions*/
anFunction
  :
  FIRST_VALUE '(' expr ')'
  | LAG '(' expr ',' INTEGER_CONSTANT ',' INTEGER_CONSTANT ')'
  | LAST_VALUE '(' expr ')'
  | NTILE '(' expr ')'
  | PERCENT_RANK '(' expr ')'
  | RANK '(' expr ')'
  | RATIO_TO_REPORT '(' expr ')'
  |LEAD '(' expr ')'
  ;


aggregateClause
  :
  aggrFunctionClause (',' aggrFunctionClause)*
  ;

aggrFunctionClause
  :
  (roleID)? expr ':=' aggrFunction
  ;


getFiltersClause
  :
    getFilterClause (',' getFilterClause)*
 ;

getFilterClause
  :
    (FILTER? expr)
  ;

aggrClause 
  : 
  AGGREGATE aggregateClause groupingClause? havingClause?
  ;

filterClause
  :
  FILTER expr 
  ;

renameClause
  :
  varID TO varID (',' varID TO varID)* 
  ;

aggrFunction
  :
  SUM '(' expr ')'
  | AVG '(' expr ')'
  | COUNT '(' expr ')'
  | MEDIAN '(' expr ')'
  | MIN '(' expr ')'
  | MAX '(' expr ')'
  | RANK '(' expr ')'
  | STDDEV_POP '(' expr ')'
  | STDDEV_SAMP '(' expr ')'
  | STDDEV '(' expr ')'
  | VAR_POP '(' expr ')'
  | VAR_SAMP '(' expr ')'
  | VARIANCE '(' expr ')'
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
  DROP dropClauseItem (',' dropClauseItem)*
  ;

dropClauseItem
  :
  varID
  | (componentID MEMBERSHIP varID)
  ;

keepClause
  :
  KEEP keepClauseItem (',' keepClauseItem)*
  ;

keepClauseItem
  :
  varID
  | (componentID MEMBERSHIP varID)
  ;

/* pivot/unpivot/subspace expressions */

unpivotExpr
:
UNPIVOT varID ',' varID
;

pivotExpr
 :
  PIVOT varID ',' varID
 ;

subspaceExpr
  : SUBSPACE varID '=' constant (',' varID '=' constant)*
  ;

inBetweenClause
  :
  IN (setExpr|IDENTIFIER)
  | BETWEEN constant AND constant
  | NOT_IN (setExpr|IDENTIFIER)
  | NOT BETWEEN constant AND constant
  ;

dimClause
  :
  inBetweenClause
  ;

/* Set expressions */
setExpr
  :
  '[' constant (','constant)* ']'
  |'[' expr (',' expr)+ ']'
  |'(' constant (','constant)* ')'
  |'{' constant (','constant)* '}'
  |(IDENTIFIER(',' IDENTIFIER)*)
  | IDENTIFIER
  | UNION '(' setExpr ')'		
  | SYMDIFF '(' setExpr ',' setExpr ')' 
  | SETDIFF '(' expr ',' expr ')'
  | INTERSECT '(' setExpr ')'
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

/*Aggregation operators invocation*/
aggrInvocation
  :
  aggrFunctionName '(' IDENTIFIER (MEMBERSHIP componentID)? (',' IDENTIFIER(MEMBERSHIP componentID)?)* (groupingClause)? (havingClause)? ')'
  ;
  
aggrInvocationCompExpr
  :
  aggrFunctionName '(' IDENTIFIER (MEMBERSHIP componentID)? (',' IDENTIFIER(MEMBERSHIP componentID)?)* ')' (groupingClause)? (havingClause)?
  ;  

aggrFunctionName
  :
  SUM 
  | AVG 
  | COUNT 
  | MEDIAN 
  | MIN 
  | MAX 
  | RANK 
  | STDDEV_POP 
  | STDDEV 
  | STDDEV_SAMP
  | VAR_POP 
  | VAR_SAMP 
  | VARIANCE 
  | FIRST_VALUE
  | LAG
  | LAST_VALUE
  | LEAD
  | RANK
  | RATIO_TO_REPORT
  ;

groupingClause
  :
  groupKeyword ((IDENTIFIER (',' IDENTIFIER)*)|(expr))
  ;
   
havingClause   
  :
  HAVING aggrFunction? expr
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
  
 datasetID
  : 
  IDENTIFIER
  ;

 rulesetID
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
  
  
 routineName
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

 groupKeyword
  :
  GROUP_BY
  |GROUP_EXCEPT
  |GROUP_ALL
  ;

constant
  :
  INTEGER_CONSTANT
  | FLOAT_CONSTANT
  | BOOLEAN_CONSTANT
  | STRING_CONSTANT
  | NULL_CONSTANT
  ;

  
  componentType
  :
  STRING
  | INTEGER
  | FLOAT
  | BOOLEAN
  | DATE
  ;
  
  dataType
  :
  STRING
  | INTEGER
  | NUMBER
  | BOOLEAN
  | DATE
  | TIME_PERIOD
  | DURATION
  ;
  
  retainType
  :
  BOOLEAN_CONSTANT
  | ALL
  ;
  
 defineDatapointRuleset
  :
  DEFINE DATAPOINT RULESET
  ;
  
 defineHierarchicalRuleset
   :
   DEFINE HIERARCHICAL RULESET
   ;
   
 endDatapointRuleset
   :
   END DATAPOINT RULESET
   ;
   
 endHierarchicalRuleset
   :
   END HIERARCHICAL RULESET
   ;
   
   
 defineDataStructure
   :
   DEFINE DATA STRUCTURE
   ; 
   
 inputHierarchical
   :
   RULE_PRIORITY
   |DATASET_PRIORITY
   |RULE
   |DATASET
   ;
   
 modeHierarchical
   :
   TOTAL
   |PARTIAL
   |NON_NULL
   |NON_ZERO
   |PARTIAL_NULL
   |PARTIAL_ZERO
   |ALWAYS_NULL
   |ALWAYS_ZERO
   ;
   
 outputHierarchical
   :
   ALL
   |COMPUTED
   ;      
   
 measuresChoice
  :
  MEASURES
  |(NO_MEASURES)
  ;  
