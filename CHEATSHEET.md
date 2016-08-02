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

### Command-line

#### awk
Basic syntax
```bash
awk '/search_pattern/ { action_to_take_on_matches; another_action; }' file_to_parse
```

E.g. print each line in `etc/fstab` beginning with `UUID`
```bash
awk '/^UUID/' /etc/fstab
```

E.g. print the 6th column of netstat output:
```
sudo netstat -pant | awk '{print $6}'
```

Full syntax:
```bash
awk 'BEGIN { action; }
/search/ { action; }
END { action; }' input_file
```

E.g. set FieldSeparator to `:` and then print first column of `/etc/passwd`
```bash
awk 'BEGIN { FS=":"; }
{ print $1; }' /etc/passwd
```

More info: https://www.digitalocean.com/community/tutorials/how-to-use-the-awk-language-to-manipulate-text-in-linux

#### sort

Sorts text by line
```bash
echo 'c\nb\na' | sort
# => a
# => b
# => c
```

More info: http://www.computerhope.com/unix/usort.htm

#### uniq

Get the unique values from some text stream/file

E.g. simply remove duplicates
```bash
echo 'a\na\nb' | uniq
# => a
# => b
```

E.g. show counts

```bash
echo 'a\na\nb' | uniq
# => 2 a
# => 1 b
```







