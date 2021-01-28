---
title: "Modeling tissues: numerical simulations and continuum mechanics"
subtitle: "Workshop"
author: Guillaume Gay, CENTURI multi-engineering platform, Marseille
...


A classic morphogenesis problem is fold formation, the first step of
many important events, such as gastrulation.

In this workshop, we will explore fold formation within the vertex modeling framework.

For this, we will use the [`tyssue`](https://tyssue.readthedocs.io)
Python library to model 2D and 3D cell monolayers. The objective of
the workshop is to build a simulation of fold formation while looking
into the common ingredients of vertex models: topological
rearangements and solving strategies.

1. Introduction to `tyssue` data structures and main concepts
2. The 2D apical mesh: topological and mechanical changes
   - 2.1 Quasistatic equilibrium with the Farhadifar potential, cell division
   - 2.2 Simple Euler model with rearangements

3. Fold formation in 2.5D
   - 3.1 Apical contraction: cell contraction event
   - 3.2 Basal-apical traction: definition of a new force

4. Fold formation in 3D
   - 4.1 Monolayer rearangements in 3D
   - 4.2 Extrapolation of our 2.5D model to 3D
