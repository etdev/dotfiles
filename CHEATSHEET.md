# etdev's Useful Command Cheatsheet

### MySQL

Create a new user
```sql
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
```

Grant permissions to user
```sql
GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'lccalhost';
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

Given `favorite_foods.txt`:
```bash
1 carrot sandy
2 wasabi luke
3 sandwich brian
4 salad ryan
5 spaghetti jessica
```

E.g. Match based on regex per-field
```bash
awk '/$2 ~ ^sa/' favorite_food.txt
# => 3 sandwich brian
# => 4 salad ryan
```

E.g. combined matching, including `!~` to NOT match a regex per-field, and `&&` to combine conditions
```bash
awk 'BEGIN { print "NUM\tFOOD"; } $2 ~ /^(c|w)/ && $1 !~ /1/ { print $1,"\t",$2; }' favorite_foods.txt
# => NUM   FOOD
# => 2     wasabi
```

More info: https://www.digitalocean.com/community/tutorials/how-to-use-the-awk-language-to-manipulate-text-in-linux

#### sed

Sed is a **s**tream **ed**itor.

Basic syntax:
```bash
sed [options] commands [file-to-edit]
```

E.g. print first line of test.txt
```bash
sed -n '1p' test.txt
```
* The `-n` suppresses the default print each line behavior
* The `1` tells sed what line(s) to operate on -- line 1
* The `p` means the `print` command; so `print line 1, suppressing default print`

E.g. print lines 1-5 of test.txt
```bash
sed -n '1,5p' test.txt
```

E.g. print every other line of test.txt
sed '1~2p' test.txt

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
echo 'a\na\nb' | uniq -c
# => 2 a
# => 1 b
```

#### xargs

Get args from standard input and do things with them

E.g. remove files matching `test3`
```bash
find . -name "*test3*" | xargs rm
```

E.g. remove files matching `test3` #2
```bash
find . -name "*test3*" | xargs -i rm {}
```

The `-i` basically replaces `{}` with the current parameter

E.g. Print filenames + 'is a file!' for files matching `/test[1,2]{2}$/`
```bash
ag -g 'test[1,2]{2}\.txt$' | xargs -Iresult echo result is a file!
```

The `-I` lets you refer to the current matched param in the command.

#### shell

Simple for loop

```bash
for i in 1 2 3 .. N
do
<commands>
done
```

E.g. create files `test1.txt` through `test5.txt`
```bash
for i in 1 2 3 4 5
do
touch test$i.txt
done
```

E.g. print files in directory, but preceeded by some message
```bash
for i in $(ls); do
echo item: $i;
done
```

E.g. rename files in current dir with a `2` in their name, to `item_<old_name>`
```bash
for i in $(ls | grep 2); do
mv $1 item_$1;
done
```
