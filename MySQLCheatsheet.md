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

### Update

### Delete

### Select