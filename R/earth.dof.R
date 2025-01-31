#' Calculate degrees of freedom of MARS
#'
#' @param n sample size
#' @param p number of features
#' @param N number of repetitions
#' @param nk maximum number of model terms before pruning in earth::earth
#' @param d maximum degree of interactions
#' @param penalty penalty per knot
#' @param seed random seed for construct x and y
#' @return a vector of two elements: \describe{
#' \item{dfcov}{empirical df based on covariance formula}
#' \item{dfapp}{average df based on mars' approximation formula}
#' }
#' @export
#' @importFrom earth earth
#' @importFrom stats predict cov rnorm
#'
calc_df_mars = function(n = 100, p = 10,
                        N = 100,
                        nk = 5,
                        d = 1,
                        penalty = 2, # d+1
                        seed = 1234) {
  if (seed == -1)
    set.seed(NULL)
  else
    set.seed(seed)
  y = matrix(rnorm(n*N), nrow = n, ncol = N)
  x = matrix(rnorm(n*p), nrow = n, ncol = p)
  yhat = matrix(0, nrow = n, ncol = N)
  dfhat = numeric(N)
  for (i in 1:N) {
    mars.fit = earth(x, y[, i], nk = nk, pmethod = "none", thresh = 0, degree = d, penalty = penalty)
    yhat[, i] = predict(mars.fit)
    m = length(mars.fit$selected.terms)
    dfhat[i] = m + penalty * (m-1) / 2
  }
  df = sum(sapply(1:n, function(i) cov(y[i, ], yhat[i, ])))
  return(c(df, mean(dfhat)))
}

#' Solve penalty factor by equating empirical df
#' @param n sample size
#' @param p number of features
#' @param N number of repetitions
#' @param nk maximum number of model terms before pruning in earth::earth
#' @param d maximum degree of interactions
#' @param penalty the initial penalty. If not specified, it is `d + 1`.
#' @return a list of three elements \describe{
#' \item{df_cov}{empirical df based on covariance formula}
#' \item{df_app}{average df based on mars' approximation formula}
#' \item{penalty}{penalty factor}
#' }
#' @note Note that `penalty` only works in the backward procedure, so we do not
#' need to a while loop to ensure the self-consistency.
#' @export
sol_mars_df_and_penalty = function(n = 20, p = 2,
                                   N = 100, nk = 5,
                                   d = 1, penalty = NULL) {
  # init penalty
  if (is.null(penalty)) {
    penalty = d + 1
  }
  dfs = calc_df_mars(penalty = penalty, n = n, p = p, N = N, nk = nk, d = d)
  df_cov = dfs[1]
  df_app = dfs[2]
  # avg number of selected terms
  avg_m = (df_app + penalty / 2) / (penalty / 2 + 1)
  if ((avg_m > 1) && (df_cov > avg_m)) {
    penalty = 2 * (df_cov - avg_m) / (avg_m - 1)
  }
  return(list(df_cov = df_cov,
              df_app = df_app,
              penalty = penalty))
}

#' Correct df given a fitted earth.object
#' @param x an earth object
#' @param N number of repetitions for approximating empirical df
#' @return a list of three elements \describe{
#' \item{df_cov}{empirical df based on covariance formula}
#' \item{df_app}{average df based on mars' approximation formula}
#' \item{penalty}{penalty factor}
#' }
#' @export
correct_df = function(x, N = 100) {
  if (attr(x, "class") != "earth") {
    stop("`x` is supposed to be an earth object. Or you pass parameters to `sol_mars_df_and_penalty` to calculate the corrected penalty.")
  }
  n = nrow(x$fitted.values)
  p = ncol(x$modvars)
  sol_mars_df_and_penalty(n = n, p = p, d = x$penalty - 1, nk = x$nk, penalty = x$penalty, N = N)
}
