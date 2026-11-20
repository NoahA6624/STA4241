library(glmnet)

set.seed(1)

n = 1000
p = 20

sigma = 1

x = matrix(rnorm(n*p), n, p)

## create orthonormal matrix
SVD = svd(t(x) %*% x)
xOrthonormal = x %*% SVD$u %*% diag(1/sqrt(SVD$d))

## True regression coefficients
beta = rep(0.5, 20)

## center the outcome so that the intercept is zero
y = xOrthonormal %*% beta + rnorm(n, sd=sigma)
y = y - mean(y)

## Find CV curve for this data
fitCV = cv.glmnet(x = xOrthonormal, y = y, alpha = 0)
plot(fitCV)

trueLambda = p*sigma^2 / (t(beta) %*% beta)
abline(v=log(trueLambda), lwd=3)

## Now do a simulation to see how well CV does at finding optimal lambda
nSim = 200

## Store the lambda found by CV
estLambda = rep(NA, nSim)

## Error rates for each estimator
sqError = matrix(NA, nSim, 3)

for (ni in 1 : nSim) {
  cat("Simulation number", ni, "\r")

  sigma = 1
  
  x = matrix(rnorm(n*p), n, p)
  
  ## create orthonormal matrix
  SVD = svd(t(x) %*% x)
  xOrthonormal = x %*% SVD$u %*% diag(1/sqrt(SVD$d))
  
  ## Generate data
  y = xOrthonormal %*% beta + rnorm(n, sd=sigma)
  y = y - mean(y)
  
  ## Find CV curve
  fitCV = cv.glmnet(x = xOrthonormal, y = y, alpha = 0)

  trueLambda = p*sigma^2 / (t(beta) %*% beta)
  estLambda[ni] = fitCV$lambda.min
  
  ## Find MSE for model using CV based lambda estimate
  sqError[ni,1] = sum((coef(fitCV, s="lambda.min")[-1] - beta)^2)
  
  ## Using the known and optimal value of lambda (not feasible in practice)
  fitTrue = glmnet(x = xOrthonormal, y = y, alpha = 0, lambda=trueLambda)
  sqError[ni,2] = sum((coef(fitTrue)[-1] - beta)^2)
  
  ## Using OLS
  fitOLS = lm(y ~ xOrthonormal)
  sqError[ni,3] = sum((fitOLS$coefficients[-1] - beta)^2)
}

## Compare estimated lambdas to true optimal value
median(estLambda)
p*sigma^2 / (t(beta) %*% beta)

## How does each method do in terms of MSE?
apply(sqError, 2, mean, na.rm=TRUE)

