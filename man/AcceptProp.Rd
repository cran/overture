% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities.R
\name{AcceptProp}
\alias{AcceptProp}
\title{Determine if a Metropolis–Hastings step should be accepted}
\usage{
AcceptProp(log.curr, log.prop, log.curr.to.prop = 0,
  log.prop.to.curr = 0)
}
\arguments{
\item{log.curr}{log density of the target at the current value,
\eqn{log(P(x))}}

\item{log.prop}{log density of the target at the proposed value,
\eqn{log(P(x'))}}

\item{log.curr.to.prop}{log of transition distribution from current value to
proposed value, \eqn{log(g(x'|x))}}

\item{log.prop.to.curr}{log of transition distribution from proposed value to
current value, \eqn{log(g(x|x'))}}
}
\value{
\code{TRUE/FALSE} for whether the proposal should be accepted or
  rejected, respectively
}
\description{
\code{AcceptProp} is a utility function to determine if a proposal should
be accepted in a Metropolis or Metropolis-Hastings step.
}
\details{
The function uses the Metropolis choice for a Metropolis/Metropolis-Hastings
sampler, which accepts a proposed value \eqn{x'} with probability \deqn{
A(x', x) = min(1, P(x')/P(x) g(x|x')/g(x'|x)) } where \eqn{P(x)} is the
target distribution and \eqn{g(x'|x)} is the proposal distribution.
}
\examples{
# Sample from triangular distribution P(x) = -2x + 2 ----------------------
# Target distribution
LogP <- function(x) {
    log(-2*x + 2)
}

# Generate proposals using Beta(1/2, 1/2)
shape1 <- 1/2
shape2 <- 1/2

RProp <- function() { # Draw proposal
    rbeta(1, shape1, shape2)
}

DLogProp <- function(x) { # Log density of proposal distribution
    dbeta(x, shape1, shape2, log=TRUE)
}

SampleX <- function(x) { # Draw once from the target distribution
    x.prop <- RProp()
    if(AcceptProp(LogP(x), LogP(x.prop), DLogProp(x.prop), DLogProp(x))) {
        x <- x.prop
    }

    return(x)
}

# Draw from the target distribution
n.samples <- 10000
samples <- vector(length=n.samples)
x <- 0.5
Mcmc <- InitMcmc(n.samples)
samples <- Mcmc({
    x <- SampleX(x)
})

# Plot the results
hist(samples$x, freq=FALSE, ylim=c(0, 2.5), xlim=c(0, 1), xlab="x")
grid <- seq(0, 1, length.out=500)
lines(grid, exp(LogP(grid)), col="blue")
legend("topright", legend="True density", lty=1, col="blue", cex=0.75)
}
