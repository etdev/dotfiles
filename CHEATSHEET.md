# etdev's Useful Command Cheatsheet

### MySQL

Create a new user
```sql
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
```

Grant permissions to user
```sql
GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'loccalhost';
```

Reload privileges:
```sql
FLUSH PRIVILEGES;
```

Update record(s):
```sql
UPDATE `potluck`
SET
`confirmed` = 'Y'
WHERE `potluck`.`name` = 'Sandy';
```

Delete record(s):
```sql
DELETE FROM `potluck` WHERE `potluck`.`name` = 'John';
```

Add column to table:
```sql
ALTER TABLE potluck ADD email VARCHAR(40) AFTER name;
```

Remove column from table:
```sql
ALTER TABLE potluck DROP email;
```

Analyze (explain) query:
```sql
EXPLAIN SELECT COUNT(*) FROM salaries WHERE salary BETWEEN 60000 AND 70000;
```

Change a column's data type,options:
```sql
ALTER TABLE t1 MODIFY a TINYINT NOT NULL;
```

Add an index to existing column:
```sql
ALTER TABLE t1 ADD index (d);
```

