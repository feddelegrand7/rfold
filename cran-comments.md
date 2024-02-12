-- R CMD check results ---------------------------------- rfold 0.2.0 ----
Duration: 14.9s

0 errors v | 0 warnings v | 0 notes v

### New features: 
* The user can now similarly to script files, refactor `test` files disposition. For example, one might want to put script files and test files within the same folder. By appending the `test-` word to an `R` script, `rfold` will recognise it as a test file and move it to the corresponding folder. Note that for now, `rfold` works with `testthat` only.
