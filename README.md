
Gray-Scott Model of Diffusion
===============

This repo contains matlab implementaton of the Gray-Scott finite difference model a coupled set of non-linear second order differential equations with Neuman boundary conditions - a closed system with no flux at the boundaries.

Manual
======

Requires Matlab.  Run GrayScott.m

use one of: 

* justdiffusion = 1
* dyemodel = 1 
* grayscott = 1	


The first term in each equation describes simple diffusion, and when the coefficient a in the second term is zero, this equation reduces to the heat equation.  The second term describes the reaction between to two species or reactants; it represents the coupling strength and controls the rate of reaction between the dye and water concentrations.	

The more general Gray-Scott equation includes another term that describes the feed of reactant and the consumption of A and B in the reaction.  These equations can give rise to patterns including stationary or traveling spots, stripes, and labyrinths that are exhibited in many places in nature.  The appearance of patterns occurs as a result of differing diffusion rates between two reactants, creating different gradients.  The patterns created depend on the parameters of the reaction-diffusion model, but are dependent on local random inhomogeneities and were predicted by Alan Turing in 1952.  Pattern formation is also heavily dependent on the relationship between the diffusion coefficients where Dw > Dc.  As can be demonstrated in the model by removing the random perturbations or by setting the diffusion coefficients equal to one another, no patterns are formed in either case.  Sources indicate that the labyrinth-like patterns are generated from high concentration gradients due to their interaction at their mutual fronts when the ratio of the diffusion coefficients is large.[2]  The last term in the Gray-Scott equation, represents the feed term which would be used if additional reactants are added during the course of the reaction, and the consumption of A through B.[1]  Concentrations diffuse along their gradients towards depleted regions, regions depleted by consumption.  Several sources suggested that the relations between the parameters f and k would result in the development of maze-like structures.[3,4].    

I have implemented 3 different options, a diffusion only, and a Gray Scott model with and without the feed/consumption terms selectable within the code.  


References 

1. T. Shinbrot, F. Muzzio, Nature, 410, 2001, 251-258.
1. A.Hagberg, Dissertation Fronts and patterns in reaction-diffusion equations, University of Arizona, 1994.
1. R. Goldstein, Phys. Rev. E, 53(4) 1996, 3933-3957.
1. A. Malevanets, R. Kapral, Phys. Rev E., 55(5) 1997, 5657-5670.