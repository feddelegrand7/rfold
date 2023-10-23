testthat::test_that("fold works as expected", {

  testthat::expect_error(
    object = {
      fold::fold(folders_to_ignore = "/dev")
    },
     regexp = "provide plain folder names"
  )

  testthat::expect_error(
    object = {
      fold::fold(folders_to_ignore = "dont_exist")
    },
     regexp = "The following directories do not exist. Can't ignore them: dont_exist"
  )

})
