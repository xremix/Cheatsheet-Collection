# MySQL Cheatsheet
Just a couple of citations of the MySQL API Docs, to summarize basic commands and additional parameters.

## Create Database
```SQL
CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name
    [create_specification] ...
create_specification:
    [DEFAULT] CHARACTER SET [=] charset_name
  | [DEFAULT] COLLATE [=] collation_name
```

## Show Database
```
SHOW DATABASES;
```


## [Create Table](https://dev.mysql.com/doc/refman/5.7/en/create-table.html)
```SQL
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name
    (create_definition,...)
    [table_options]
    [partition_options]
```

create_definition
```SQL
column_definition:
    data_type [NOT NULL | NULL] [DEFAULT default_value]
      [AUTO_INCREMENT] [UNIQUE [KEY]] [[PRIMARY] KEY]
      [COMMENT 'string']
      [COLUMN_FORMAT {FIXED|DYNAMIC|DEFAULT}]
      [STORAGE {DISK|MEMORY|DEFAULT}]
      [reference_definition]
  | data_type [GENERATED ALWAYS] AS (expression)
      [VIRTUAL | STORED] [NOT NULL | NULL]
      [UNIQUE [KEY]] [[PRIMARY] KEY]
      [COMMENT 'string']
```

### Primary Key
```SQL
CREATE TABLE tbl_name (
  id  INT,
PRIMARY KEY (id)
);

# OR
CREATE TABLE tbl_name (
id  INT PRIMARY KEY,
);
# e.g.
CREATE TABLE tbl_name (
id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
);
```

## [Data Types](https://dev.mysql.com/doc/refman/5.7/en/data-types.html)

`BOOLEAN` is just a Synonym for `TINYINT`

`DECIMAL (DEC / FIXED)` can have specified sizes.
e.g. `money DECIMAL(9,2)`

### Decimal vs Double
`DOUBLE` can only store unexact numbers, based on IEEE795. They can be processed pretty fast, because process have them implemented natively.

`DECIMAL` can store exact numbers, but the values do get stores as series of digits (like `CHAR`
These need to get converted to numbers before, so processors can do calculations.
DECIMAL has no issues related to rounding.

### ENUM
```SQL
CREATE TABLE tbl_name(
    # ...
    status ENUM('open', 'closed', 'onhold')
);
```
When ENUM is usefull

| Criteria                 | ENUM         | TABLE    |
|--------------------------|--------------|----------|
| Number of Values         | Less         | Many     |
| Changes                  | Almost Never | Often    |
| New Values Added         | Not often    | Often    |
| Delete Values            | Never        | Possible |
| Values for special cases | Not often    | often    |

### VARCHAR(N)
Stores only values as need (maximum is set before).

### CHAR(N)
Takes always the space configured, but doesn't has to handle flexible text lengths.
Useful for variables with constant length.

### TEXT
Can store big amount of text, but got downs in editing, sorting, etc.

### Time and Date

`DATE` with `YYYY-MM-DD`
`DATETIME` with `YYYY-MM-DD HH:MM:SS`

### NULL
Performance increase, if no `NULL` values.


## Indexes

- increase speed for search and sort in large amount
- decrease speed of writing
- optimization of physical layer
- Not handled by SQL-Standard

```SQL
CREATE INDEX firstname
ON tbl_name(firstname);

# or first 10 chars

CREATE INDEX firstname
ON tbl_name(firstname(10));

# or
CREATE TABLE tbl_name (
  firstname  VARCHAR(255),
INDEX (firstname)
);
```

Show indexes
```SQL
SHOW INDEX FROM tbl_name
```

Rename index
```
ALTER TABLE RENAME INDEX old_index_name TO new_index_name
```

Delete index
```SQL
DROP INDEX index_name ON tbl_name
    [algorithm_option | lock_option] ...

algorithm_option:
    ALGORITHM [=] {DEFAULT|INPLACE|COPY}

lock_option:
    LOCK [=] {DEFAULT|NONE|SHARED|EXCLUSIVE}
 ```

### Indexselectivity
Numerous Datatypes can do comparison pretty quick, so the whole value is an Index.
On Char-based datatypes the system needs to compare char by char. The longer the search query, the slower the search.
To check the relevance of a index the indexselectivity is used.

### Foreign Key

Add Foreign Key
```SQL
ALTER TABLE tbl_name
	ADD FOREIGN KEY column_name
	REFERENCES tbl_name2 column_name2

## SQL Dump
Create Dump File
```sh
mysqldump -u root -p -d db_name
```

Import Dump File
```sh
mysqldump -u root -D db_name < dumpfile.sql
```


## CRUD

### [Insert](https://dev.mysql.com/doc/refman/5.7/en/insert.html)
It is always recommendet to 
```SQL
INSERT INTO tbl_name
  SET name='Toni', lastname=’Hoffmann’, username=’xremix’;

#or for multiple insert

INSERT INTO tbl_name (name, lastname, username)
VALUES ('a', 'b', 'user1'),
('c', 'd', 'user2');
```

Recieve AUTO_INCREMENT id form last inserted data
```SQL
SELECT LAST_INSERT_ID()
```

### Update
Can also contain calculations like
```SQL
UPDATE grades SET grade = GREATEST(1, grade+1);
```

### Delete
```SQL
DELETE FROM users WHERE id = 1;
```

To empty a table use
```SQL
TRUNCATE TABLE tbl_name;
```

### [Select](https://dev.mysql.com/doc/refman/5.7/en/select.html)
The column names in an select statement are the same as π (Projection) in relational algebra.
Where statement is equivalent ot the Selection σ.
```SQL
SELECT
    [ALL | DISTINCT | DISTINCTROW ]
      [HIGH_PRIORITY]
      [STRAIGHT_JOIN]
      [SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]
      [SQL_CACHE | SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]
    select_expr [, select_expr ...]
    [FROM table_references
      [PARTITION partition_list]
    [WHERE where_condition]
    [GROUP BY {col_name | expr | position}
      [ASC | DESC], ... [WITH ROLLUP]]
    [HAVING where_condition]
    [ORDER BY {col_name | expr | position}
      [ASC | DESC], ...]
    [LIMIT {[offset,] row_count | row_count OFFSET offset}]
    [PROCEDURE procedure_name(argument_list)]
    [INTO OUTFILE 'file_name'
        [CHARACTER SET charset_name]
        export_options
      | INTO DUMPFILE 'file_name'
      | INTO var_name [, var_name]]
    [FOR UPDATE | LOCK IN SHARE MODE]]
```

Sample
```SQL
SELECT * FROM tbl_name WHERE id % 10 = 0;

SELECT * FROM tbl_name WHERE name LIKE('Pete%');
# or
SELECT * FROM tbl_name WHERE name LIKE 'Pete%';
# or
SELECT * FROM tbl_name WHERE LOWER(name) LIKE 'pete%';
```

Sample for Timestamp
```SQL
SELECT * FROM users WHERE timestampdiff(YEAR, birthdate, NOW()) < 18

SELECT timestampdiff(YEAR, birthdate, NOW()) as age FROM users
```

#### Distinct


### Sort
Equals τ (Sort) in relational algebra

### LIMIT
```SQL
SELECT * FROM tbl_name LIMIT 10;
# Paging (startpoint, limit)
SELECT * FROM tbl_name LIMIT 70, 10;
```

## [Grouping](https://dev.mysql.com/doc/refman/5.7/en/group-by-functions-and-modifiers.html)

**Basic Aggregation functions**
- AVG(x)
- COUNT(x)
- COUNT(DISTINCT x)
- SUM(x)
- MIN(x)
- MAX(x)

**Sample**
```SQL
SELECT city, COUNT(*) AS citizen
FROM users
GROUP BY city
HAVING citizen > 10
ORDER BY citizen DESC;
```

To aggregate everything its possible to have an always true group by (which doesn't make sense in this sample):
```SQL
SELECT COUNT(*) FROM events
WHERE users >100 GROUP BY 1=1;
```

## NULL
SELECT * FROM users WHERE lastloggedin IS NOT NULL

## JOIN
INNER JOIN = JOIN // In linear algebra the Inner Join is equal to subset of the Cartesian product if foreign key and primary key match together
LEFT OUTER JOIN = LEFT JOIN
RIGHT OUTER JOIN = RIGHT JOIN
FULL OUTER JOIN = FULL OUTER JOIN

If primary key and foreign key are equiavalent:
```SQL
SELECT * FROM tbl_name
  INNER JOIN tbl_name2 USING column_name
```

If there are no other equivalent columns its possible to do a **NATURAL JOIN**
```
SELECT * FROM tbl_name
  NATURAL JOIN tbl_name2
```

**FULL OUTER JOIN** is equal to a UNION of LEFT JOIN and RIGHT JOIN