# assert.sh

Assert.sh is intended to give the assertion mechanism to shell scripts with well-known assert functions like `assert_eq`, `assert_array_eq`, or `assert_empty`.
Inspired by [Assert class of JUnit](http://junit.sourceforge.net/javadoc/org/junit/Assert.html)

### Install & Usage

```
> # git clone https://github.com/torokmark/assert.sh.git; cd assert.sh
> # source assert.sh
> # assert_eq "hello" "world"
> # echo "$?"
# => 1
```

1. Clone the repository

```sh
git clone https://github.com/torokmark/assert.sh.git
```

> Or copy the assert.sh where your project is located.

2. Edit the script where you would like to use asserts and paste the next line on the top:

```sh
source './assert.sh'
```

3. Now assert functions are available for use.

```sh
assert_eq "hello" "world"
```
> 0 return status is considered true and anything else is considered false.


### List of assert functions

* `assert_eq` takes two strings and checks whether they are the same based on the character strings.
* `assert_not_eq` is the opposite of `assert_eq`.
* `assert_true` takes a parameter and returns 0 confirming the parameter is true.
* `assert_false` takes a parameter and decides whether it is false.
* `assert_array_eq` takes two arrays and compare them by items.
* `assert_array_not_eq` takes two arrays and return 0 if the items are not the same on the same index.
* `assert_empty` takes a string and returns 0 if it is empty
* `assert_not_empty` is the opposite of `assert_empty`.

### How to write tests

Example:

```sh
source "./assert.sh"

local expected actual
expected="Hello"
actual="Hello"
assert_eq "$expected" "$actual"
if [ "$?" == 0 ]; then
  log_success "assert_eq returns 0 if two words are equal"
else
  log_failure "assert_eq should return 0"
fi
```

If the return status (`$?`) of `assert_eq` is equal to `0`, which is considered true according to the convention.
If the assert function returns `1`, the expected and actual values are differred.

### Contribution

1. Fork it!
2. Use it!


