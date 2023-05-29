# Maths
Collection of functions for solving maths problems

## Jacobian
Takes an arbitary function with m input and n output dimensions and calculates a numerical 2<sup>nd</sup> order finite difference approximation of the matrix of first derivatives.  
Inputs: Function handle, a point in the function space and the stepsize.  
Outputs: Matrix of 1<sup>st</sup> derivatives.

## Solver
Performs Newton iteration steps to approximate the solution to f(x) = 0, where f is the function specified. Requires well behaved Jacobian around the root.  
Inputs: Function handle, an initial point, the handle to the appropriate jacobian function, the tolerance of solution required and the maximum number of iterations.  
Outputs: Solution, convergence flag and Jacobian at the solution point.

## Track Curve
Tracks a curve of solutions given an n-dimension input with an n+1-dimension output \[E.g an n-dimensional system with 1 parameter\].  
Inputs: Function handle, the derivative handle, an initial point on the curve, the initial tangent to head towards and optional arguements around the stepsize.  
Outputs: List of the solutions to the system along the curve.

## IVP
Solves an initial value problem x' = f(x) using the Dormand-Prince algorithm.  
Inputs: Function handle, an initial point, the time span and step size.  
Output: final result and vectors of the intermediate times + values.
