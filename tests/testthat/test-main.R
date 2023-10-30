testthat::test_that("rfold works as expected", {

  testthat::expect_error(
    object = {
      rfold::rfold(folders_to_ignore = "dont_exist")
    },
     regexp = "The following directories do not exist. Can't ignore them: dont_exist"
  )

   testthat::expect_error(
    object = {
      rfold::rfold(script_name_prefix = c("pref1", "pref2"))
    },
     regexp = "script_name_prefix must be of length 1"
  )

})
