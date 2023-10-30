testthat::test_that("fold works as expected", {

  testthat::expect_error(
    object = {
      fold::fold(folders_to_ignore = "dont_exist")
    },
     regexp = "The following directories do not exist. Can't ignore them: dont_exist"
  )

   testthat::expect_error(
    object = {
      fold::fold(script_name_prefix = c("pref1", "pref2"))
    },
     regexp = "script_name_prefix must be of length 1"
  )

})
