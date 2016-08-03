# etdev's Useful Command Cheatsheet

# Contents
* [Databases](#databases)
  * [MySQL](#mysql)
* [Command line](#command-line)
  * [ag](#ag)
  * [awk](#awk)
  * [sed](#sed)
  * [sort](#sort)
  * [uniq](#uniq)
  * [xargs](#xargs)
  * [wc](#wc)
  * [shell](#shell) (bash/zsh scripting)
* [Git](#git)
  * [Gitignore patterns](#gitignore-patterns)

### <a name="databases">Databases</a>

#### <a name="mysql">MySQL</a>

Create a new user
```sql
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
```

Grant permissions to user
```sql
GRANT ALL PRIVILEGES ON *.* TO 'newuser'@'localhost';
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

### <a name="command-line">Command line</a>

#### <a name="ag">ag (Silver Searcher)</a>

Agignore patterns

* Basically the same as `gitignore` patterns, but has some issues
* Use the latest version if possible

E.g. Minified css or js files anywhere
```bash
# .agignore
**.min.*
# matches script.min.js, styles.min.css etc.
```

More info: https://github.com/ggreer/the_silver_searcher/issues/385

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

#### <a name="sed">sed</a>

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
```bash
sed -n '1,+4p' test.txt
```

E.g. print every other line of test.txt
```bash
sed '1~2p' test.txt
```

E.g. **d**elete every other line of test.txt
```bash
sed '1~2d' test.txt
```

* Doesn't affect the actual file
* You can make it change the source file with the `-i` option though.

E.g. delete every other line of test.txt, actually changing original file
```bash
sed -i.bak '1~2d' file.txt
```
* The `-i.bak` means it will create a backup file with the extension `.bak`

Given `annoying.txt`:
```bash
this is the song that never ends
yes, it goes on and on, my friend
some people started singing it
not knowing what it was
and they'll continue singing it forever
just because...
```

E.g. Substitute `on` with `forward`
```bash
sed 's/on/forward' annoying.txt
```

* Only replaces first match in each line
* Replaces any instance of `on`, even in the middle of other words

E.g. Substitute all instances of `on` in first 3 lines with `forward`
```bash
sed '1,3s/on/forward/g' annoying.txt
```

E.g. Substitute case-insensitively all instances of `SINGING` with `saying`, and only print changed lines
```bash
sed -n 's/SINGING/saying/gip' annoying.txt
```

E.g. Substitute from beginning of line to last instance of `at` with parenthesized version
```bash
sed 's/^.*at/(&)/' annoying.txt
```
* The `&` represents the captured text (which is captured despite lack of parentheses in the regex)

E.g. Switch the first two words in each line
```bash
sed 's/\([^ ][^ ]*\) \([^ ][^ ]*\)/\2 \1/' annoying.txt
```

* You can use escaped parentheses for capture groups, which you can then refer to with `\1`, `\2`, ...

E.g. Substitute `it` with `it loudly` but only on lines that match `/singing/`
```bash
sed '/singing/s/it/& loudly/' annoying.txt
```

E.g. Delete all empty lines
```bash
sed '/^$/d' annoying.txt
```

E.g. Delete all lines that AREN'T empty
```bash
sed '/^$/!d' annoying.txt
```

E.g. Delete all lines between lines starting with `START` and `END` (including the start, end lines)
```bash
sed '/^START/,/^END/d' test.txt
```

#### <a name="sort">sort</a>

Sorts text by line
```bash
echo 'c\nb\na' | sort
# => a
# => b
# => c
```

More info: http://www.computerhope.com/unix/usort.htm

#### <a name="uniq">uniq</a>

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

#### <a name="xargs">"xargs</a>

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

#### <a name="shell">shell</a>

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

More info: http://www.tecmint.com/wc-command-examples/

#### <a name="wc">wc</a>

Count **l**ines / **w**ords / **c**haracters in a file or stream

E.g. Show line count, word count, and char count for test.txt
```bash
wc test.txt
# => 15  229 1529 test.txt
```

E.g. Show line count for test.txt
```bash
wc -l test.txt
# => 15 test.txt
```

E.g. Show word count for test.txt
```bash
wc -w test.txt
# => 229 test.txt
```

E.g. Show char count for test.txt
```bash
wc -c test.txt
# => 1529 test.txt
```

### <a name="git">Git</a>

#### <a name="gitignore-patterns">gitignore patterns</a>

E.g. Any file or directory called `doc`, recursive
```bash
# .gitignore
doc
```

E.g. Any directory called `doc`, recursive
```bash
# .gitignore
doc/
```

E.g. Any file or directory called `doc`, root dir only
```bash
# .gitignore
/doc
```

E.g. Directory called `doc`, root dir only
```bash
# .gitignore
/doc/
```

E.g. Files anywhere ending with `.tmp`
```bash
# .gitignore
*.tmp
```

E.g. Files under the /doc directory ending with `.tmp`
```bash
# .gitignore
/doc/*.tmp
# matches /doc/test.tmp, NOT /doc/stuff/test.tmp
```

E.g. File or directory `bar` whenever its parent directory is `foo`
```bash
# .gitignore
**/foo/bar
```

E.g. All files and directories inside `foo` directory, anywhere
```bash
# .gitignore
foo/**
```

E.g. `baz` directory with ancestor directory `foo`
```bash
# .gitignore
foo/**/baz/
```

E.g. All `.html` files except `index.html`
```bash
# .gitignore
*.html
!index.html
```

More info: https://git-scm.com/docs/gitignore
