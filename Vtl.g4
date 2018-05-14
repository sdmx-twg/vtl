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
| callFunction #callFunctionExpression
| joinExpr #joinExpression
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
exprEq: <assoc=right> exprExists (op=( '='|'<>') exprExists )*;

/* Matching */
exprExists: 
           exprComp (EXISTS_IN  exprComp (ALL)? )*
		   | EXISTS_IN '(' expr ',' expr (',' retainType)? ')'
		   ;

/* Comparison, range */

exprComp: 
		exprAdd exprCompExt*;

exprCompExt: 
		<assoc=right> (NOT_IN|IN) (lists|IDENTIFIER) #exprCompSet
		| opComp=('>'|'<'|'<='|'>='|'='|'<>') exprAdd #exprCompComp
		;	

/* Addition, subtraction */
exprAdd: exprMultiply (opAdd=('+'|'-') exprMultiply)*;

/* Multiplication, division */
exprMultiply: <assoc=right> exprFactor (opMult=('*'|'/') exprFactor)*;

/* Unary plus, unary minus, not */
exprFactor: <assoc=right>(opUnary=('+'|'-'|NOT)? exprMember)*;

/* Membership and clauses */
exprMember : exprAtom ('[' (datasetClause|(expr ASSIGN expr)) ']')*(MEMBERSHIP componentID)?										
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
  |defDatapoint
  |defHierarchical
  ; 
  
defOperator
  :
  DEFINE OPERATOR operatorID '(' parameterItem (',' parameterItem)* ')' (RETURNS dataType)? IS expr END OPERATOR
  ;  
 
parameterItem
  :
  varID dataType (DEFAULT constant)?
  ;
    
callFunction
  :
  operatorID '(' ((constant|'_') (',' (constant|'_'))*)? ')'
  ;   

/* Functions */
exprAtom
  :
  ROUND '(' expr (',' (INTEGER_CONSTANT|'_'))? ')'					# roundAtom
  | CEIL '(' expr ')'												# ceilAtom
  | FLOOR '(' expr ')'												# floorAtom
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
  | CHARSET_MATCH '(' expr ','  STRING_CONSTANT ')'	# charsetMatchAtom
 /* | INTERSECT '(' '[' expr (',' expr)* ']' ')'									# intersectAtom  */
 /* | UNION '(' '[' expr (',' expr)* ']' ')'										# unionAtom */
 /* | SYMDIFF '(' expr ',' expr ')'									#symdiffAtom */
 /* | SETDIFF '(' expr ',' expr ')'									#setdiffAtom */
  | ISNULL '(' expr ')'												# isNullAtom
  | NVL '(' expr ',' expr ')'									# nvlAtom
  | MOD '(' expr ',' expr ')'										# modAtom
  | ref																# refAtom
  | putExpr															# putExprAtom
  | concatExpr														# concatExprAtom
  | evalExpr														# evalExprAtom
  | castExpr														# castExprAtom
  | hierarchyExpr													# hierarchyExprAtom
  | FLOW_TO_STOCK '(' expr ')'										# flowToStockAtom
  | STOCK_TO_FLOW '(' expr ')'										# stockToFlowAtom
  | validationDatapoint												#validateDPruleset
  | validationHierarchical 											#validateHRruleset
  | validationExpr													#validationSimple
  ;


/* Parentheses */
ref: '(' exprOr ')'													# parenthesisExprRef
  | varID															# varIdRef
  | constant														# constantRef
  ; 

/* identifier list*/		
  
identifierList
  :
  '[' IDENTIFIER (',' IDENTIFIER)* ']'
  ;			 

putExpr
  : 
  varID PUT_SYMBOL expr
  ;
  
lists
 :
 '{' constant (',' constant)* '}'
 ;  

/* eval */
evalExpr
  :
  EVAL '(' routineName '(' componentID? (',' componentID)* ')' (',' STRING_CONSTANT)? (',' RETURNS scalarType)? ')'
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
  TIMESHIFT '(' expr ',' INTEGER_CONSTANT ')'
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
   CHECK_DATAPOINT '(' expr ',' IDENTIFIER (COMPONENTS componentID (',' componentID)*)? (INVALID|ALL|ALL_MEASURES)? ')'
  ;
  
validationHierarchical
  :
  CHECK_HIERARCHY '(' expr',' IDENTIFIER (CONDITION componentID (',' componentID)*)? (RULE IDENTIFIER)? (modeHierarchical)? (DATASET|DATASET_PRIORITY)? (INVALID|ALL|ALL_MEASURES)? ')'
  ;

erCode 
  :
  ERRORCODE  constant 
  ;
  
erLevel
  :
  ERRORLEVEL  constant
  ;

/* hierarchy */
hierarchyExpr
  : 
  HIERARCHY '(' expr ',' IDENTIFIER (CONDITION componentID (',' componentID)*)? (RULE IDENTIFIER)? (modeHierarchical|'_')? (inputHierarchical|'_')? (outputHierarchical|'_')? ')'
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
  (aggrFunctionName|anFunction)? '(' expr (',' expr)* OVER '(' (partitionByClause)? (orderByClause)? (windowingClause)? ')' ')'
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


/* Analytic Functions
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
  ; */


anFunction
  :
  FIRST_VALUE 
  | LAG 
  | LAST_VALUE 
  | NTILE 
  | PERCENT_RANK 
  | RANK 
  | RATIO_TO_REPORT 
  |LEAD 
  ;

aggregateClause
  :
  aggrFunctionClause (',' aggrFunctionClause)*
  ;

aggrFunctionClause
  :
  (roleID)? componentID ':=' aggrFunction
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
  (roleID)? componentID ':=' calcExpr
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
  componentID
  | (datasetID MEMBERSHIP componentID)
  ;

keepClause
  :
  KEEP keepClauseItem (',' keepClauseItem)*
  ;

keepClauseItem
  :
  componentID
  | (datasetID MEMBERSHIP componentID)
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
  | NOT_IN (setExpr|IDENTIFIER)
  ;

/* Set expressions */
setExpr
  :
  UNION '(' expr (',' expr)* ')'		
  | SYMDIFF '(' expr ',' expr ')' 
  | SETDIFF '(' expr ',' expr ')'
  | INTERSECT '(' expr (',' expr)* ')'
  ;
  

/* subscript expression*/
subscriptExpr
  :
  persistentDatasetID '[' componentID '=' constant ( ',' componentID '=' constant)? ']' 
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
  | STDDEV_POP 
  | STDDEV_SAMP
  | VAR_POP 
  | VAR_SAMP
  ;

groupingClause
  :
  groupKeyword ((IDENTIFIER (',' IDENTIFIER)*)|(expr))
  ;
   
havingClause   
  :
  HAVING '('? aggrFunction?  expr ')'?
  ;
  
/* aggregate sequences */
  
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

/* Arithmetic */
logBase
  :
  expr
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
  
  /*remove this dataType when the one in comments is used*/
 dataType
  :
  scalarType
  ;
  
  scalarType
  :
  STRING
  | INTEGER
  | NUMBER
  | BOOLEAN
  | DATE
  | TIME_PERIOD
  | DURATION
  | SCALAR
  | TIME
  ;
  
/*  dataType
  :
  scalarType
  | compoundType
  ;
  
  compoundType
  :
  componentType2
  | datasetType
  | operatorType
  | rulesetType
  | productType
  | universalSetType
  | universalListType
  ;
  
  componentType2
  :
  (roleID)? (scalarType)?
  ;
  
  datasetType
  :
  DATASET '{'compConstraint (',' compConstraint)* '}'
  ;
  
  compConstraint
  :
  componentType (componentID|multModifier)
  ;
  
  multModifier
  :
  '_' ('+'|'*')?
  ;
  
  productType
  :
  dataType ('*' dataType)*
  ;
  
  operatorType
  :
  dataType '-''>' dataType
  ;
  
  rulesetType
  :
  RULESET
  |dpRuleset
  |hrRuleset
  ;
  
  dpRuleset
  :
  DATAPOINT
  |(DATAPOINT_ON_VD '{' prodValueDomains '}')
  |(DATAPOINT_ON_VAR '{' prodVariables '}')
  ;
  
  hrRuleset
  :
  HIERARCHICAL
  |(HIERARCHICAL_ON_VD '{' prodValueDomains '}')
  |(HIERARCHICAL_ON_VAR '{' prodVariables '}')
  ;
  
  prodValueDomains
  :
  '(' IDENTIFIER ('*' IDENTIFIER)* ')'
  ;
  
  prodVariables
  :
  '(' varID ('*' varID)* ')'
  ;
  
  universalSetType
  :
  SET '<' dataType '>'
  ;
  
  universalListType
  :
  LIST '<' dataType '>'
  ;
  
  */ 
  
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
   |RULE
   |DATASET
   ;
   
 modeHierarchical
   :
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
 
