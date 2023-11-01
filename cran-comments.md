## Test environments
* local R installation, R 4.1.0
* ubuntu 16.04 (on travis-ci), R 4.1.0
* win-builder (devel)

-- R CMD check results -------------------------- rfold 0.1.0 ----
Duration: 15.5s

0 errors v | 0 warnings v | 0 notes v

# Correcitions according to CRAN's team comments: 

- Corrected the author field in DESCRIPTION 
- Removed the usage of any function that modifies the structure of the package folder (functions were previously on the README.Rmd).
