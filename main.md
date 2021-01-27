---
title: "Modeling tissues: numerical simulations and continuum mechanics"
author: Guillaume Gay, CENTURI multi-engineering platform, Marseille
subtitle: Part II - Numerical Simulations
fontsize: 10pt
width: 1080
height: 800
bibliography: tyssue.bib
data-transition: none
center: 0
...



# Abstract

In this second part of the course, we will go over the various methods used to simulate tissues.

We will start by showing a rough taxonomy of cell models in general and we'll briefly discuss the general framework of agent-based modelling.  Then we will see in some details the three big classes of tissue modeling strategies:

1. Lattice based models rely on a descretized space to simulate cells. Each cell here occupies a set of pixels, and the physics of the system is solved locally. Those model are adapted to rapid assessment of tissue dynamics with mixed cell types, proliferation and differentiation models.

2. Cell-center based models. Here each cell is an individual sphere (maybe deformable) interacting in free space with it's immediate neighbours. This class of model is adapted to problems in cancer biology, involving high cell numbers.

4. Vertex-based models. Here cells are delinated by polygons or polyhedron, and the phyics is applied at the polygon vertices. This class of models is widely used for morphogenesis modeling.

For each section, we'll look at published examples and point towards available implementations.


# A rough taxonomy of tissue models

## Population dynamics

:::incremental
* Only concerned with $N(t)$
* Focus on **signaling** and division / death rates
* Main use is **mathematical oncology**:
  predict cancer growth in response to treatment
::::

---------

![[[@zhaoModelingTumorClonal2016]](https://doi.org/10.1016/j.trecan.2016.02.001)](images/pop_dyn.jpg){ width=800px }





## Agent based modelling


# Lattice based models

## Game of life

## The Graner Glazier Hogeweg model

### The Modified Metropolis Algorithm

### Cellular Potts Model Hamiltonian

### Extending the CPM: the example of Chemotaxis

### Existing Software


# Cells as spheres

## The work of Dirk Drasdo et al.

## JF. Joanny

## PhysiCell (Mathematical Oncology)


# Cells as polygons

## Topology of epithelium

### Voronoï tessalation (Honda et al.)

### Topology changes in 2D & 3D

### Active vertex model

### Rosettes


## Mechanical Model formulations

### Work by Farhadifar et al.

### Work by Lisa Manning et al.

### Towards rheological models

### Existing implementations
