---
title: "Modeling tissues: numerical simulations and continuum mechanics"
author: Guillaume Gay, CENTURI multi-engineering platform, Marseille
subtitle: Part II - Numerical Simulations
fontsize: 10pt
width: 1080
height: 800
bibliography: tyssue.bib
data-transition: none
center: 1
abstract:
    "In this second part of the course, we will go over the various methods used to simulate tissues.
    We will start by showing a rough taxonomy of cell models in general and we'll briefly discuss the general framework of agent-based modelling.  Then we will see in some details the three big classes of tissue modeling strategies:
    1. Lattice based models rely on a descretized space to simulate cells. Each cell here occupies a set of pixels, and the physics of the system is solved locally. Those model are adapted to rapid assessment of tissue dynamics with mixed cell types, proliferation and differentiation models.
    2. Cell-center based models. Here each cell is an individual sphere (maybe deformable) interacting in free space with it's immediate neighbours. This class of model is adapted to problems in cancer biology, involving high cell numbers.
    4. Vertex-based models. Here cells are delinated by polygons or polyhedron, and the phyics is applied at the polygon vertices. This class of models is widely used for morphogenesis modeling.
    For each section, we'll look at published examples and point towards available implementations."
...




# A rough taxonomy of tissue models

::::::{.columns}:::
:::{.column width=30%}
![](images/tamulonis.png)
:::
:::{.column width=70%}
\vspace{2cm}
This courses relies a lot on Carlos Tamulonis' [PhD Thesis](https://hdl.handle.net/11245/1.394902) (2013)
:::
::::::


## Population dynamics

:::incremental:::
* Only concerned with $N(t)$
* Focus on **signaling** and growth / death rates
* Main use is **mathematical oncology**:
  predict cancer growth in response to treatment
::::

---------

![[[@zhaoModelingTumorClonal2016]](https://doi.org/10.1016/j.trecan.2016.02.001)](images/pop_dyn.jpg){ width=80% }



## Agent based modelling

:::incremental::::
* Cells are **agents**: they _act_
* Follow each cell behavior
* Broad range of problems:
  - cancer
  - morphogenesis
:::::


# Lattice based models


![Discrete space in 2 and 3D](images/grids.png)

## Game of life
(James Conway)

* Not really cells, but Cellular Automata
* Classical 'emergent behavior' system

![Game of life](images/gol.gif){ width=50% }

. . .

Follow [this link](https://distill.pub/2020/growing-ca/) for a fun example of cellular automata

## The Graner Glazier Hogeweg model


:::::::::{.columns}:::
:::{.column width=60%}::::
:::incremental::::
\vspace{1cm}
* The world is a fixed grid
* Each cell $\alpha$ occupies a set of pixels
* Pixels at the interface can swap cells
::::
::::
:::{.column width=40%}::::
![step n](images/CPM00.png){ width=60% }

:::
:::::::


### The Modified Metropolis Algorithm


The behavior is governed by the definition of a **Hamiltonian** $H$ governing the energy of the cells

Changes follow a simple local algorithm:

:::::::::{.columns}:::
:::{.column width=60%}::::
:::incremental
1. Choose randomly a site $(i, j)$
2. Compute the change $\Delta H$ if $(i, j)$ swaps cell
3. If $\Delta H < 0$ : swap cell
4. If $\Delta H \geq 0$ : swap cell with probability $\exp( - \Delta H / kT)$ _(T is not a "real" temperature)_

:::
::::
:::{.column width=40%}::::
![step n](images/CPM00.png){ width=60% }

. . .

![step n+1](images/CPM01.png){ width=60% }
:::
:::::::


### Cellular Potts Model Hamiltonian

The game is now to define the Hamiltonian to better reflect our problem!

. . .

The simplest model: volume conservation and adhesion:


\begin{align*}
H & = & H_V + H_i \\
H_V & = & \frac{\lambda}{2} \sum_\alpha (V_\alpha - V_0)^2 \\
H_i & = & \sum_{ij, i'j'} J \left( \tau(ij), \tau(i'j') \right)
\end{align*}

$\tau(ij)$ type of cell at $ij$

$J\left(\tau(ij), \tau(i'j')\right)$ : bond energy

----

#### Cell sorting

A classical problem:

2 cell types $(1, 2)$ --- $0$ is the medium

\begin{eqnarray*}
J(1, 1) & = & 0\\
J(1, 1) & = & 1\\
J(2, 2) & = & 8\\
J(2, 1) & = & 16\\
J(1, 0) & = &  J(2, 0) = 32
\end{eqnarray*}

. . .

Contact prefered between same type, 1 more so than 2


----

What happens?

. . .

![Cell sorting in CompuCell3D](images/CC3D.png)



#### Chemotaxis

* Add a term for chemotaxis:
- chemoatractant distribution on the grid ($C(ij)$)
- pixel energy inversely $ \propto \Dela C$

$$
H' = H - \mu \left(C(ij) - C(i'j') \right)
$$


#### More recent exemple


### Existing Software

- Chaste
- CompuCell3D
- Morpheus


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
