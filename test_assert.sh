#!/usr/bin/env bash

#####################################################################
##
## description:
## Tests for assert extension
##
## author: Mark Torok
##
## date: 07. Dec. 2016
##
## license: MIT
##
#####################################################################

source "./assert.sh"

log_header "Test assert : test_assert.sh"

test_assert_eq() {
  log_header "Test :: assert_eq"

  assert_eq "Hello" "Hello"
  if [ "$?" == 0 ]; then
    log_success "assert_eq returns 0 if two words are equal"
  else
    log_failure "assert_eq should return 0"
  fi

  assert_eq "Hello" "World"
  if [ "$?" == 1 ]; then
    log_success "assert_eq returns 1 if two words are not equal"
  else
    log_failure "assert_eq should return 1"
  fi
}

test_assert_not_eq() {
  log_header "Test :: assert_not_eq"

  assert_not_eq "Hello" "Hello"
  if [ "$?" == 1 ]; then
    log_success "assert_not_eq returns 1 if two words are equivalent"
  else
    log_failure "assert_not_eq should return 1"
  fi

  assert_not_eq "Hello" "World"
  if [ "$?" == 0 ]; then
    log_success "assert_not_eq returns 0 if two params are not equal"
  else
    log_failure "assert_not_eq should return 0"
  fi
}

test_assert_true() {
  log_header "Test :: assert_true"

  assert_true true
  if [ "$?" == 0 ]; then
    log_success "assert_true returns 0 if param is true"
  else
    log_failure "assert_true does not work"
  fi

  assert_true false
  if [ "$?" == 1 ]; then
    log_success "assert_true returns 1 if param is false"
  else
    log_failure "assert_true does not work"
  fi
}

test_assert_false() {
  log_header "Test :: assert_false"

  assert_false false
  if [ "$?" == 0 ]; then
    log_success "assert_false returns 0 if param is false"
  else
    log_failure "assert_false does not work"
  fi

  assert_false true
  if [ "$?" == 1 ]; then
    log_success "assert_false returns 1 if param is true"
  else
    log_failure "assert_false does not work"
  fi
}

test_assert_array_eq() {
  log_header "Test :: assert_array_eq"

  declare -a exp
  declare -a act

  exp=("one" "tw oo" "333")
  act=("one" "tw oo" "333")
  assert_array_eq exp[@] act[@] "Should not be equal"
  if [ "$?" == 0 ]; then
    log_success "assert_array_eq returns 0 if two arrays are equal by values"
  else
    log_failure "assert_array_eq should return 0"
  fi

  exp=("one")
  act=("one" "tw oo" "333")
  assert_array_eq exp[@] act[@]  # it can be an issue on other implementation of shell
  if [ "$?" == 1 ]; then
    log_success "assert_array_eq returns 1 if the lengths of the two arrays are not equal"
  else
    log_failure "assert_array_eq should return 1"
  fi

  exp=("one" "222" "333")
  act=("one" "tw oo" "333")
  assert_array_eq exp[@] act[@]
  if [ "$?" == 1 ]; then
    log_success "assert_array_eq returns 1 if two arrays are not equal"
  else
    log_failure "assert_array_eq should return 1"
  fi

  exp=()
  act=("one" "tw oo" "333")
  assert_array_eq exp[@] act[@]
  if [ "$?" == 1 ]; then
    log_success "assert_array_eq returns 1 if one array is empty"
  else
    log_failure "assert_array_eq should return 1"
  fi

}

test_assert_array_not_eq() {
  log_header "Test :: assert_array_not_eq"

  declare -a exp
  declare -a act

  exp=("one" "tw oo" "333")
  act=("one" "tw oo" "333")
  assert_array_not_eq exp[@] act[@]
  if [ "$?" == 1 ]; then
    log_success "assert_array_not_eq returns 1 if two arrays are equal by values"
  else
    log_failure "assert_array_not_eq should return 1"
  fi

  exp=("one")
  act=("one" "tw oo" "333")
  assert_array_not_eq exp[@] act[@]  # it can be an issue on other implementation of shell
  if [ "$?" == 0 ]; then
    log_success "assert_array_not_eq returns 0 if the lengths of the two arrays are not equal"
  else
    log_failure "assert_array_not_eq should return 0"
  fi

  exp=("one" "222" "333")
  act=("one" "tw oo" "333")
  assert_array_not_eq exp[@] act[@]
  if [ "$?" == 0 ]; then
    log_success "assert_array_not_eq returns 0 if two arrays are not equal"
  else
    log_failure "assert_array_not_eq should return 0"
  fi

  exp=()
  act=("one" "tw oo" "333")
  assert_array_not_eq exp[@] act[@]
  if [ "$?" == 0 ]; then
    log_success "assert_array_not_eq returns 0 if one array is empty"
  else
    log_failure "assert_array_not_eq should return 0"
  fi

}

test_assert_empty() {
  log_header "Test :: assert_empty"

  assert_empty ""
  if [ "$?" == 0 ]; then
    log_success "assert_empty returns 0 if param is empty string"
  else
    log_failure "assert_empty does not work"
  fi

  assert_empty "some text"
  if [ "$?" == 1 ]; then
    log_success "assert_empty returns 1 if param is some text string"
  else
    log_failure "assert_empty does not work"
  fi

  assert_empty "\n"
  if [ "$?" == 1 ]; then
    log_success "assert_empty returns 1 if param is some white space"
  else
    log_failure "assert_empty does not work"
  fi
}

test_assert_not_empty() {
  log_header "Test :: assert_not_empty"

  assert_not_empty "some text"
  if [ "$?" == 0 ]; then
    log_success "assert_not_empty returns 0 if param is some text string"
  else
    log_failure "assert_not_empty does not work"
  fi

  assert_not_empty "\n"
  if [ "$?" == 0 ]; then
    log_success "assert_not_empty returns 0 if param is some white space"
  else
    log_failure "assert_not_empty does not work"
  fi

  assert_not_empty ""
  if [ "$?" == 1 ]; then
    log_success "assert_not_empty returns 1 if param is empty string"
  else
    log_failure "assert_not_empty does not work"
  fi
}

test_assert_contain() {
  log_header "Test :: assert_contain"

  assert_contain "haystack" "needle"
  if [ "$?" == 1 ]; then
    log_success "assert_contain returns 1 if the needle is not in the haystack"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "haystack"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if no needle is given"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "haystack" "stack"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if the haystack ends in the needle"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "haystack" "hay"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if the haystack starts with the needle"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "haystack" "aysta"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if the needle is somewhere in the middle of the haystack"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "foo\nbar\nhello\nworld" "foo"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if the needle matches the first haystack line"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "foo\nbar\nhello\nworld" "bar"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if the needle matches the second haystack line"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "foo\nbar\nhello\nworld" "ell"
  if [ "$?" == 0 ]; then
    log_success "assert_contain returns 0 if the needle is on the third haystack line"
  else
    log_failure "assert_contain does not work"
  fi

  assert_contain "foo\nbar\nhello\nworld" "barbecue"
  if [ "$?" == 1 ]; then
    log_success "assert_contain returns 1 if the needle is not in a multi-line haystack"
  else
    log_failure "assert_contain does not work"
  fi
}

test_assert_not_contain() {
  log_header "Test :: assert_not_contain"

  assert_not_contain "haystack" "needle"
  if [ "$?" == 0 ]; then
    log_success "assert_not_contain returns 0 if the needle is not in the haystack"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "haystack"
  if [ "$?" == 0 ]; then
    log_success "assert_not_contain returns 0 if no needle is given"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "haystack" "stack"
  if [ "$?" == 1 ]; then
    log_success "assert_not_contain returns 1 if the haystack ends in the needle"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "haystack" "hay"
  if [ "$?" == 1 ]; then
    log_success "assert_not_contain returns 1 if the haystack starts with the needle"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "haystack" "aysta"
  if [ "$?" == 1 ]; then
    log_success "assert_not_contain returns 1 if the needle is somewhere in the middle of the haystack"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "foo\nbar\nhello\nworld" "foo"
  if [ "$?" == 1 ]; then
    log_success "assert_not_contain returns 1 if the needle matches the first haystack line"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "foo\nbar\nhello\nworld" "bar"
  if [ "$?" == 1 ]; then
    log_success "assert_not_contain returns 1 if the needle matches the second haystack line"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "foo\nbar\nhello\nworld" "ell"
  if [ "$?" == 1 ]; then
    log_success "assert_not_contain returns 1 if the needle is on the third haystack line"
  else
    log_failure "assert_not_contain does not work"
  fi

  assert_not_contain "foo\nbar\nhello\nworld" "barbecue"
  if [ "$?" == 0 ]; then
    log_success "assert_not_contain returns 0 if the needle is not in a multi-line haystack"
  else
    log_failure "assert_not_contain does not work"
  fi
}

test_assert_gt() {
  log_header "Test :: assert_gt"

  assert_gt 1 2 
  if [ "$?" == 1 ]; then
    log_success "assert_gt returns 1 if second param is greater than first param"
  else
    log_failure "assert_gt does not work"
  fi

  assert_gt 2 -1 
  if [ "$?" == 0 ]; then
    log_success "assert_gt returns 0 if first param is greater than second param"
  else
    log_failure "assert_gt does not work"
  fi

  assert_gt 2 2 
  if [ "$?" == 1 ]; then
    log_success "assert_gt returns 1 if two params are equal"
  else
    log_failure "assert_gt does not work"
  fi


}

test_assert_ge() {
  log_header "Test :: assert_ge"

  assert_ge 1 1
  if [ "$?" == 0 ]; then
    log_success "assert_ge returns 0 if two params are equal"
  else
    log_failure "assert_ge does not work"
  fi

  assert_ge 1 2 
  if [ "$?" == 1 ]; then
    log_success "assert_ge returns 1 if second param is greater than first param"
  else
    log_failure "assert_ge does not work"
  fi

  assert_ge 2 -1 
  if [ "$?" == 0 ]; then
    log_success "assert_ge returns 0 if first param is greater than second param"
  else
    log_failure "assert_ge does not work"
  fi
}

test_assert_lt() {
  log_header "Test :: assert_lt"

  assert_lt 2 1 
  if [ "$?" == 1 ]; then
    log_success "assert_lt returns 1 if second param is less than first param"
  else
    log_failure "assert_lt does not work"
  fi

  assert_lt -2 1
  if [ "$?" == 0 ]; then
    log_success "assert_lt returns 0 if first param is less than second param"
  else
    log_failure "assert_lt does not work"
  fi

  assert_lt 2 2 
  if [ "$?" == 1 ]; then
    log_success "assert_lt returns 1 if two params are equal"
  else
    log_failure "assert_lt does not work"
  fi


}

test_assert_le() {
  log_header "Test :: assert_le"

  assert_le 1 1
  if [ "$?" == 0 ]; then
    log_success "assert_le returns 0 if two params are equal"
  else
    log_failure "assert_le does not work"
  fi

  assert_le 2 1
  if [ "$?" == 1 ]; then
    log_success "assert_le returns 1 if second param is less than first param"
  else
    log_failure "assert_le does not work"
  fi

  assert_le -2 1
  if [ "$?" == 0 ]; then
    log_success "assert_le returns 0 if first param is less than second param"
  else
    log_failure "assert_le does not work"
  fi
}



# test calls

test_assert_eq
test_assert_not_eq
test_assert_true
test_assert_false
test_assert_array_eq
test_assert_array_not_eq
test_assert_empty
test_assert_not_empty
test_assert_contain
test_assert_not_contain
test_assert_gt
test_assert_ge
test_assert_lt
test_assert_le

