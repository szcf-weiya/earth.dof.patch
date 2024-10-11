# earth.dof.patch

[![codecov](https://codecov.io/gh/szcf-weiya/earth.dof.patch/graph/badge.svg?token=6Am5b8xJrj)](https://codecov.io/gh/szcf-weiya/earth.dof.patch)
[![CI](https://github.com/szcf-weiya/earth.dof.patch/actions/workflows/CI.yaml/badge.svg)](https://github.com/szcf-weiya/earth.dof.patch/actions/workflows/CI.yaml)

`earth.dof.patch` is an R package providing a patch (correction) on degrees of freedom (dof) of MARS (Multivariate Adaptive Regression Splines), whose R package is called `earth`. The correction has been shown to achieve a better performance, see more details in our paper.

> Wang, L., Zhao, H., & Fan, X. (2024). Degrees of Freedom: Search Cost and Self-consistency. Journal of Computational and Graphical Statistics, 0(ja), 1–23. https://doi.org/10.1080/10618600.2024.2388545

## :rocket: Only One Line to Correct

Suppose you fit a MARS model via `earth`,

```r
model = earth(y ~ ., data = data)
```

To correct the degrees of freedom, just one line:

```r
df = correct_df(model)
```

then refit the MARS model by specifying the corrected degrees of freedom,

```r
model.corrected = earth(y ~ ., data = data, penalty = df$penalty)
```

More examples can be found on the auto-generated vignettes <https://hohoweiya.xyz/earth.dof.patch/>, including

- simulations for comparing MSE
- the prediction task for Ozone data
- the classification task for the Spam email data

In all examples, our corrected MARS outperforms the corresponding MARS.

See also: Our Julia package [DegreesOfFreedom.jl](https://github.com/szcf-weiya/DegreesOfFreedom.jl) also provide an implementation on DoF of MARS, together with implementations for other classical statistical learning approaches.
