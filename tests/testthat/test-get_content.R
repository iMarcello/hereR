test_that("get_content works", {

  content <- hereR:::.get_content(url = "https://jsonplaceholder.typicode.com/posts")
  expect_is(content, "list")
  expect_is(content[[1]], "character")

})
