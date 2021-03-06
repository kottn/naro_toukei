##
## Example 3: Stan
##

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# data
data <- read.csv("example3.csv")
n.block <- max(data$block)      # number of blocks
n.data <- nrow(data)            # number of data

fit <- stan("example3.stan",
             data = list(X = cbind(rep(1, n.data), data$x1, data$x2),
                         Y = data$y, B = data$block,
                         M = n.block, N = n.data, L = 3),
             chains = 4, iter = 2000, warmup = 1000)

#
rstan::traceplot(fit, pars = c("beta", "sigma"))
print(fit, pars = c("beta", "sigma"), digits = 3)
