---
title: "Modeling tissues: numerical simulations and continuum mechanics"
author: Guillaume Gay, CENTURI multi-engineering platform, Marseille
subtitle: Part II - Numerical Simulations
fontsize: 10pt
width: 1080
height: 800
font-size: 10pt
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

------


::::::{.columns}:::
:::{.column width=70%}
\vspace{2cm}
This courses relies a lot on Carlos Tamulonis'

[PhD Thesis](https://hdl.handle.net/11245/1.394902) (2013)
:::
:::{.column width=30%}
![](images/tamulonis.png)
:::
::::::


------


![An (incomplete) tree of models of living tissues](images/models_family_tree.png){ width=70% }


# Lattice based models

![Discrete space in 2 and 3D](images/grids.png)


### Conway's Game of life


:::::::::{.columns}:::
:::{.column width=60%}::::
::: incremental
* Not really cells, but Cellular Automata

* Classical 'emergent behavior' system

* See [distill.pub/2020/growing-ca](https://distill.pub/2020/growing-ca/) for a fun example of cellular automata

::::
::::
:::{.column width=40%}::::

![Game of life](images/gol.gif){ width=50% }

:::
:::::::


### The Graner Glazier Hogeweg model


:::::::::{.columns}:::
:::{.column width=60%}::::
::: incremental
\vspace{1cm}
* The world is a fixed grid
* Each cell $\alpha$ occupies a set of pixels
* Pixels at the interface can swap cells
::::
::::
:::{.column width=40%}::::
![GGH grid](images/CPM00.png){ width=60% }
:::
:::::::


### The Modified Metropolis Algorithm


The behavior is governed by the definition of a **Hamiltonian** $H$ governing the energy of the cells

:::::::::{.columns}:::
:::{.column width=60%}::::
Changes follow a local algorithm:

::: incremental
1. Choose randomly a site $(i, j)$
2. Compute the change $\Delta H$ if $(i, j)$ swaps cell
3. If $\Delta H < 0$ : swap cell
4. If $\Delta H \geq 0$ : swap cell with probability $\exp( - \Delta H / kT)$ _(T is not a "real" temperature)_

:::
::::
:::{.column width=40%}::::

::: incremental

- ![step n](images/CPM00.png){ width=60% }


- ![step n+1](images/CPM01.png){ width=60% }

:::
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

:::{.columns}::::
:::{.column width=70% }

A classical problem:

2 cell types $(1, 2)$ --- $0$ is the medium

\begin{eqnarray*}
J(0, 0) & = & 0\\
J(1, 1) & = & 1\\
J(2, 2) & = & 8\\
J(2, 1) & = & 16\\
J(1, 0) & = &  J(2, 0) = 32
\end{eqnarray*}

:::
:::{.column width=30% }
![](images/CC3D.png){ width=80% }
:::
:::::::

### Chemotaxis

Add a term for chemotaxis:

- chemoatractant distribution on the grid ($C(ij)$)

- Favor switch for increasing $C$:

$$
H' = H - \mu \left(C(ij) - C(i'j') \right)
$$

* The chemoatractant can be *produced* by the cells (cAMP)

. . .

:::{.columns}::::
:::{.column width=30%}:::
![Dictyostelium Aggregation](images/Dictyostelium_Aggregation.JPG)
:::
:::{.column width=70%}:::
![[@savillModellingMorphogenesisSingle1997]](images/SavillHogweg.png)
:::
::::::

### Existing Software

- Chaste
- CompuCell3D
- Morpheus


# Cells as spheres

:::{.columns}::::
:::{.column width=40%}
![A ball pit](images/ballpit.jpeg){ width=60% }
:::
:::{.column width=60%}
::: incremental
- Cells are defined by their position in free space
- Movement goverened by Newton's 2nd law:
$$
\sum F = m a \approx 0
$$
- Forces:
  * Cell-cell interactions
  * Friction with the medium
:::
:::
::::::


## Cells as dipoles

:::{.columns}:::
:::{.column}:::

![](images/joanny_model.png)

![](images/joanny_curve.png)

:::
:::{.column}:::
- Cell-cell interactions:

$$
V^{CC}(r) = \begin{cases}
    A R_{cc}^5 / r_k^4 + B r_k &\quad r_k \leq R_{pp}\\
    0 &\quad r_k > R_{pp}\\
    \end{cases}
$$

- Self-interaction (growth):

$$
V^G(r) = \frac{B}{r_i + r_0}
$$

:::
::::::



----


![Fluidization [@ranftFluidizationTissuesCell2010]](images/joanny.png)

> Due to proliferation and death, cell aggreagate behaves as a fluid


## Modeling tumors

- Spheres with adhesion and repulsion

![[@drasdoSinglecellbasedModelTumor2005]](images/drasdo1.png){ width=60% }

- Same Metropolis alorithm as GGH:

$$
P(\delta r) = \min \{ 1, \exp \frac{- (V(t + dt) - V(t))}{F_T} \}
$$

## Mixed resolution models

- Deformable cells at high resolution meshes mixed with cell-based model

![[@vanliedekerkeQuantitativeHighresolutionComputational2020]](images/drasdo2.png)

- Continuous / fluid dynamics finite elements for cells
- Very "realistic" results
- High computational cost


## PhysiCell (Mathematical Oncology)

[Physicell](https://physicell.wordpress.com/about-2/) is a very powerfull simulation toolkit

:::{.columns}:::::::::
:::{.column}:::
![[@ghaffarizadehPhysiCellOpenSource2018]](images/PhysiCell.png){ width=60% }
:::
:::{.column}:::
::: incremental
* Friction and adhesion model
* Very multi-agent oriented
* Coupled with a powerfull reaction / diffusion solver,
  [BioFMV](http://biofvm.mathcancer.org/)
* open development, great community
:::
:::
::::::

# Cells as polygons

The apical junctions meshwork plays a central role in many
morphogenesis events [@lecuit_cell_2007] and are poorly rendered by cell center models.

![Apical junctions in Drosophila leg disk](images/legdisck_apical.jpeg){ width=60% }


## Mechanical Model formulations

### 2D Models

#### Influence of cell packing

Quasi-static solution of:

$$
E = \sum_\alpha \frac{K_A}{2}(A_\alpha - A_0)^2 + \Gamma P_\alpha^2 + \sum_{ij}\Lambda \ell_{ij}
$$

:::{.columns}:::::::::
:::{.column width=60% }:::
![[@farhadifar_influence_2007]](images/faradifar_model.jpeg)
:::
:::{.column width=40% }:::
![Phase space of cell arrangements](images/farhadifar_phasespace.png)

:::
::::::

---------

#### Rigidity transition

![[@biDensityindependentRigidityTransition2015]](images/bietal.png)

$$
\epsilon = \sum_\alpha (a_\alpha - 1)^2 +\frac{(p_\alpha - p_0)^2}{r}
$$

----

#### Apical junctions in 2.5D

:::{.columns}:::::::::
:::{.column width=40% }

![](images/whole_leg.png)

- total volume conservation
- weigthed sum for the perimeter
- Apico-basal traction during apoptosis

:::
:::{.column width=60% }

![[@martinArp23dependentMechanical2021]](images/martinetal.png){ width=80% }

$$
p'_\alpha = \frac{1}{n}\frac {\sum_{ij \in \alpha} w_{ij}\ell_{ij}}{\sum_{ij \in \alpha} w_{ij}}
$$

:::
::::::

-----

### 3D Models

#### Monolayer and the ECM

* [@bielmeier_interface_2016] Extrapolates to 3D the 2D formulation

:::{.columns}:::::::::
:::{.column}
![Model with ECM](images/salbreux1.jpeg)
:::
:::{.column}
![Crypt formation](images/salbreux2.jpeg)
:::
::::::

-----


#### Monlayer and bulk tissues

Sophisticated expression for the friction in [@okudaThreedimensionalVertexModel2015]

![Anisotropic friction regulates tissue shape](images/okudaetal.png)

-----

#### Cells as foam

Consider surface tension and Laplace foce balance

![[@maitreAsymmetricDivisionContractile2016]](images/turlieretal.png)


## Topology problems


![](images/t1_transition.png)

> **Problem**: we can have oscillating T1 transitions

> Each time this happens, we have to write the equations again

-----

::: incremental

* Solution 1 : The active vertex model : Consider the Delaunay
triangulation instead of it's dual [@bartonActiveVertexModel2016], and
compute it at every step.

* Solution 2 : Allow for more than 3 way vertices!
  [@fineganTricellularVertexspecificAdhesion2019], give a finite life
  time to those.

:::

### Topology gets trickier in 3D

:::{.columns}:::::::::
:::{.column width=30%}:::

![I-H-O transition](images/IH_transition.png)

:::
:::{.column width=40%}:::

[@okuda_reversible_2013] define rules for stable deformations

![](images/okudacondition4.png)

:::
:::{.column width=30%}:::

Can we generalize Tara Finegan et al. solution?

![](images/rosette.png)
:::
::::::

### Open problems

:::{.columns}:::::::::
:::{.column}:::
::: incremental
* Self collisions at high deformation
* True curvature (E. Moisdon thesis)
* Non-naive ECM
* Nuclei
* Many more (it's exciting!)
:::
:::
:::{.column}:::

![Pseudo stratified epithelium](images/2304_Pseudostratified_Epithelium.jpg)

:::
::::::


### Existing (public) implementations

* Chaste
* Tyssue

### Tank you

:::{.columns}:::::::::
:::{.column width=80% }:::
* Sophie Theis
* Magali Suzanne
* Cyprien Gay
* Audrey Ferrand & Florian Bugarin
* The `tyssue` contributors
* The Scipy and Python communities
:::
:::{.column width=20% }:::
* ANRT
* ERC
* CIR
:::
::::::


## References

::: {#refs}

:::
