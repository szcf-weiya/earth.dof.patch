# earth.dof.patch

[![codecov](https://codecov.io/gh/szcf-weiya/earth.dof.patch/graph/badge.svg?token=6Am5b8xJrj)](https://codecov.io/gh/szcf-weiya/earth.dof.patch)
[![CI](https://github.com/szcf-weiya/earth.dof.patch/actions/workflows/CI.yaml/badge.svg)](https://github.com/szcf-weiya/earth.dof.patch/actions/workflows/CI.yaml)

`earth.dof.patch` is an R package providing a patch (correction) on degrees of freedom (dof) of MARS (Multivariate Adaptive Regression Splines), whose R package is called `earth`. The correction has been shown to achieve a better performance, see more details in our paper.

> Wang, L., Zhao, H., & Fan, X. (2023). Degrees of Freedom: Search Cost and Self-consistency (arXiv:2308.13630). arXiv. http://arxiv.org/abs/2308.13630

See also: Our Julia package [DegreesOfFreedom.jl](https://github.com/szcf-weiya/DegreesOfFreedom.jl) also provide an implementation on dof of MARS, together with implementations for other classical statistical learning approaches.
