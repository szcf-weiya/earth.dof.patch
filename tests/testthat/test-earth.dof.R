res = calc_df_mars()
test_that("calc df of mars", {
  expect_length(res, 2)
  expect_gt(res[1], 0)
  expect_gt(res[2], 0)
})

res = sol_mars_df_and_penalty()
test_that("penalty factor", {
  expect_length(res, 3)
  expect_gt(res$df_cov, 0)
  expect_gt(res$df_app, 0)
  expect_gt(res$penalty, 0)
})
