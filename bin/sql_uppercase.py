#!/usr/bin/env python
import sys
import re
import shutil
from sqlparse import keywords

# upper_list = ['select', 'from', 'as', 'in', 'trim', 'drop']
KEYWORDS = [' TEMP', 'ABORT', 'ABS', 'ABSOLUTE', 'ACCESS', 'ADA', 'ADD', 'ADMIN', 'AFTER', 
            'AGGREGATE', 'ALIAS', 'ALL', 'ALLOCATE', 'ANALYSE', 'ANALYZE', 'ANY', 'ARE', 
            'ARRAY', 'ASC', 'ASENSITIVE', 'ASSERTION', 'ASSIGNMENT', 'ASYMMETRIC', 'AT', 
            'ATOMIC', 'AUTHORIZATION', 'AVG', 'BACKWARD', 'BEFORE', 'BEGIN', 'BETWEEN', 
            'BIGINT', 'BINARY', 'BIT', 'BITVAR', 'BIT_LENGTH', 'BLOB', 'BOOLEAN', 'BOTH', 
            'BREADTH', 'CACHE', 'CALL', 'CALLED', 'CARDINALITY', 'CASCADE', 'CASCADED', 
            'CAST', 'CATALOG', 'CATALOG_NAME', 'CHAIN', 'CHAR', 'CHARACTER', 'CHARACTERISTICS', 
            'CHARACTER_LENGTH', 'CHARACTER_SET_CATALOG', 'CHARACTER_SET_NAME', 'CHARACTER_SET_SCHEMA', 
            'CHAR_LENGTH', 'CHECK', 'CHECKED', 'CHECKPOINT', 'CLASS', 'CLASS_ORIGIN', 'CLOB', 
            'CLOSE', 'CLUSTER', 'COALSECE', 'COBOL', 'COLLATE', 'COLLATION', 'COLLATION_CATALOG', 
            'COLLATION_NAME', 'COLLATION_SCHEMA', 'COLUMN', 'COLUMN_NAME', 'COMMAND_FUNCTION', 
            'COMMAND_FUNCTION_CODE', 'COMMENT', 'COMMIT', 'COMMITTED', 'COMPLETION', 'CONDITION_NUMBER', 
            'CONNECT', 'CONNECTION', 'CONNECTION_NAME', 'CONSTRAINT', 'CONSTRAINTS', 'CONSTRAINT_CATALOG',
            'CONSTRAINT_NAME', 'CONSTRAINT_SCHEMA', 'CONSTRUCTOR', 'CONTAINS', 'CONTINUE', 'CONVERSION',
            'CONVERT', 'COPY', 'CORRESPONTING', 'COUNT', 'CREATEDB', 'CREATEUSER', 'CROSS', 'CUBE', 
            'CURRENT', 'CURRENT_DATE', 'CURRENT_PATH', 'CURRENT_ROLE', 'CURRENT_TIME', 'CURRENT_TIMESTAMP', 
            'CURRENT_USER', 'CURSOR', 'CURSOR_NAME', 'CYCLE', 'DATA', 'DATABASE', 'DATE', 
            'DATETIME_INTERVAL_CODE', 'DATETIME_INTERVAL_PRECISION', 'DAY', 'DEALLOCATE', 'DEC', 
            'DECIMAL', 'DECLARE', 'DEFAULT', 'DEFAULTS', 'DEFERRABLE', 'DEFERRED', 'DEFINED', 'DEFINER', 
            'DELIMITER', 'DELIMITERS', 'DEREF', 'DESC', 'DESCRIBE', 'DESCRIPTOR', 'DESTROY', 
            'DESTRUCTOR', 'DETERMINISTIC', 'DIAGNOSTICS', 'DICTIONARY', 'DISCONNECT', 'DISPATCH', 'DO', 
            'DOMAIN', 'DYNAMIC', 'DYNAMIC_FUNCTION', 'DYNAMIC_FUNCTION_CODE', 'EACH', 'ENCODING', 'ENCRYPTED', 
            'END-EXEC', 'EQUALS', 'ESCAPE', 'ESCEPTION', 'EVERY', 'EXCEPT', 'EXCLUDING', 'EXCLUSIVE', 'EXEC', 
            'EXECUTE', 'EXISTING', 'EXISTS', 'EXTERNAL', 'EXTRACT', 'FALSE', 'FETCH', 'FINAL', 'FIRST', 'FLOAT', 
            'FORCE', 'FOREIGN', 'FORTRAN', 'FORWARD', 'FOUND', 'FREE', 'FREEZE', 'FULL', 'FUNCTION', 'G', 'GENERAL', 
            'GENERATED', 'GET', 'GLOBAL', 'GO', 'GOTO', 'GRANT', 'GRANTED', 'GROUPING', 'HANDLER', 'HAVING', 
            'HIERARCHY', 'HOLD', 'HOST', 'IDENTITY', 'IGNORE', 'ILIKE', 'IMMEDIATE', 'IMMUTABLE', 'IMPLEMENTATION', 
            'IMPLICIT', 'INCLUDING', 'INCREMENT', 'INDEX', 'INDITCATOR', 'INFIX', 'INHERITS', 'INITIALIZE',
            'INITIALLY', 'INOUT', 'INPUT', 'INSENSITIVE', 'INSTANTIABLE', 'INSTEAD', 'INT', 'INT8',
            'INTEGER', 'INTERSECT', 'INTERVAL', 'INTO', 'INVOKER', 'IS', 'ISNULL', 'ISOLATION',
            'ITERATE', 'K', 'KEY', 'KEY_MEMBER', 'KEY_TYPE', 'LANCOMPILER', 'LANGUAGE', 'LARGE',
            'LAST', 'LATERAL', 'LEADING', 'LENGTH', 'LESS', 'LEVEL', 'LIMIT', 'LISTEN',
            'LOAD', 'LOCAL', 'LOCALTIME', 'LOCALTIMESTAMP', 'LOCATION', 'LOCATOR', 'LOCK', 'LONG',
            'LOWER', 'M', 'MAP', 'MATCH', 'MAXVALUE', 'MESSAGE_LENGTH', 'MESSAGE_OCTET_LENGTH', 'MESSAGE_TEXT',
            'METHOD', 'MINUTE', 'MINVALUE', 'MOD', 'MODE', 'MODIFIES', 'MODIFY', 'MONTH',
            'MORE', 'MOVE', 'MUMPS', 'NAMES', 'NATIONAL', 'NATURAL', 'NCHAR', 'NCLOB',
            'NEW', 'NEXT', 'NO', 'NOCREATEDB', 'NOCREATEUSER', 'NONE', 'NOT', 'NOTHING',
            'NOTIFY', 'NOTNULL', 'NULL', 'NULLABLE', 'NULLIF', 'NUMBER', 'NUMERIC', 'OBJECT',
            'OCTET_LENGTH', 'OF', 'OFF', 'OFFSET', 'OIDS', 'OLD', 'ONLY', 'OPEN',
            'OPERATION', 'OPERATOR', 'OPTION', 'OPTIONS', 'ORDINALITY', 'OUT', 'OUTPUT', 'OVERLAPS',
            'OVERLAY', 'OVERRIDING', 'OWNER', 'PAD', 'PARAMATER_NAME', 'PARAMATER_ORDINAL_POSITION', 'PARAMATER_SPECIFIC_SCHEMA', 'PARAMETER',
            'PARAMETERS', 'PARAMETER_MODE', 'PARAMETER_SPECIFIC_CATALOG', 'PARAMETER_SPECIFIC_NAME', 'PARTIAL', 'PASCAL', 'PENDANT', 'PLACING',
            'PLI', 'POSITION', 'POSTFIX', 'PRECISION', 'PREFIX', 'PREORDER', 'PREPARE', 'PRESERVE',
            'PRIMARY', 'PRIOR', 'PRIVILEGES', 'PROCEDURAL', 'PROCEDURE', 'PUBLIC', 'RAISE', 'READ',
            'READS', 'REAL', 'RECHECK', 'RECURSIVE', 'REF', 'REFERENCES', 'REFERENCING', 'REINDEX',
            'RELATIVE', 'RENAME', 'REPEATABLE', 'REPLACE', 'RESET', 'RESTART', 'RESTRICT', 'RESULT',
            'RETURN', 'RETURNED_LENGTH', 'RETURNED_OCTET_LENGTH', 'RETURNED_SQLSTATE', 'RETURNS', 'REVOKE', 'RIGHT', 'ROLE',
            'ROLLBACK', 'ROLLUP', 'ROUTINE', 'ROUTINE_CATALOG', 'ROUTINE_NAME', 'ROUTINE_SCHEMA', 'ROW', 'ROWS',
            'ROW_COUNT', 'RULE', 'SAVE_POINT', 'SCALE', 'SCHEMA', 'SCHEMA_NAME', 'SCOPE', 'SCROLL',
            'SEARCH', 'SECOND', 'SECURITY', 'SELF', 'SENSITIVE', 'SERIAL', 'SERIAL8', 'SERIALIZABLE',
            'SERVER_NAME', 'SESSION', 'SESSION_USER', 'SETOF', 'SETS', 'SHARE', 'SHOW', 'SIMILAR',
            'SIMPLE', 'SIZE', 'SMALLINT', 'SOME', 'SOURCE', 'SPACE', 'SPECIFIC', 'SPECIFICTYPE',
            'SPECIFIC_NAME', 'SQL', 'SQLCODE', 'SQLERROR', 'SQLEXCEPTION', 'SQLSTATE', 'SQLWARNINIG', 'STABLE',
            'START', 'STATE', 'STATEMENT', 'STATIC', 'STATISTICS', 'STDIN', 'STDOUT', 'STORAGE',
            'STRICT', 'STRUCTURE', 'STYPE', 'SUBCLASS_ORIGIN', 'SUBLIST', 'SUBSTR', 'SUBSTRING', 'SUM', 'SYMMETRIC',
            'SYSID', 'SYSTEM', 'SYSTEM_USER', 'TABLE', 'TABLE_NAME', 'TEMPLATE', 'TEMPORARY', 'TERMINATE',
            'TEXT', 'THAN', 'TIMESTAMP', 'TIMEZONE_HOUR', 'TIMEZONE_MINUTE', 'TO', 'TOAST', 'TRAILING',
            'TRANSACTIONS_COMMITTED', 'TRANSACTIONS_ROLLED_BACK', 'TRANSATION', 'TRANSATION_ACTIVE', 'TRANSFORM', 'TRANSFORMS', 'TRANSLATE', 'TRANSLATION',
            'TREAT', 'TRIGGER', 'TRIGGER_CATALOG', 'TRIGGER_NAME', 'TRIGGER_SCHEMA', 'TRIM', 'TRUE', 'TRUNCATE',
            'TRUSTED', 'TYPE', 'UNCOMMITTED', 'UNDER', 'UNENCRYPTED', 'UNION', 'UNIQUE', 'UNKNOWN',
            'UNLISTEN', 'UNNAMED', 'UNNEST', 'UNTIL', 'UPPER', 'USAGE', 'USER', 'USER_DEFINED_TYPE_CATALOG',
            'USER_DEFINED_TYPE_NAME', 'USER_DEFINED_TYPE_SCHEMA', 'USING', 'VACUUM', 'VALID', 'VALIDATOR', 'VALUES', 'VARCHAR',
            'VARCHAR2', 'VARIABLE', 'VARYING', 'VERBOSE', 'VERSION', 'VIEW', 'VOLATILE', 'WHENEVER',
            'WITH', 'WITHOUT', 'WORK', 'WRITE', 'YEAR', 'ZONE']

upper_list = [ x.lower() for x in keywords.KEYWORDS.keys() + keywords.KEYWORDS_COMMON.keys() ]
upper_list += ['collect', 'coalesce', 'qualify', 'row_number', 'rank', 'over', 'partition']
upper_list += ['pp_scratch_risk', 'pp_access_views','pp_discovery_views','pp_scratch_ars','pp_scratch_goraeu','pp_risk_views','pp_fraud_views','pp_mstr_access_views']

upper_list_re  = re.compile('|'.join( r"\b%s\b" % w for w in upper_list), re.IGNORECASE)

def make_uppercase(match):
    input = str(match.group())
    return input.upper()

def prnt(x):
    print x

def run(filename, out):
    f = open(filename,'r')
    lines = f.readlines()
    for line in lines:
        #line = line.rstrip()
        if line.strip().startswith('--'):
            out.write(line)
        else:
            out.write(upper_list_re.sub(make_uppercase, line))

if __name__ == '__main__':
    for filename in sys.argv[1:]:
        out = open(filename+'.tmp','w')
        run(filename, out)
        out.close()
        shutil.move(filename, filename + '.old')
        shutil.move(filename + '.tmp', filename)
