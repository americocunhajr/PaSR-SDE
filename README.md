<img src="logo/PaSR-SDE.png" width="40%">

**PaSR-SDE** is a Matlab package to simulate premixed turbulent combustion in ideal reactors using stochastic mixing models.

## Documentation

**PaSR-SDE** routines are commented to explain their functionality to the final user. Each routine has a short description of its purpose and a list of inputs and/or outputs.


## Software History

**PaSR-SDE** is the result of a master's thesis:

- *A. Cunha Jr, Reduction of Complexity in Combustion Thermochemistry, PUC-Rio, Master Thesis, 2010 https://doi.org/10.17771/PUCRio.acad.17685*
 
The PDF of this thesis is available for free at: https://hal.archives-ouvertes.fr/tel-01541173

The results of this thesis were disclosed in the following publication:

- *A. Cunha Jr and L. F. Figueira da Silva, Assessment of a transient homogeneous reactor through in situ adaptive tabulation, Journal of the Brazilian Society of Mechanical Sciences and Engineering, v. 36, pp. 377-391, 2014 http://dx.doi.org/10.1007/s40430-013-0080-4* 
 
The PDF of this article is available for free at: https://hal.archives-ouvertes.fr/hal-01438646

## Program Execution


## External Dependencies

#### CRFlowLib-1.0 - the original implementation

* GNU Scientific Library 1.12 (open source) --- https://www.gnu.org/software/gsl/
* CVODE 2.5.0, which is part of SUNDIALS 2.3.0 (open source) --- https://computing.llnl.gov/projects/sundials
* Chenkin-II (proprietary software) --- Once this code is proprietary, you need to obtain its routines by yourself.

The following Chenkin-II libraries are necessary:
 - cklib.f
 - ckinterp.f
 - ckstrt.h

## Reaction Mechanisms (CK-II format)

This repository stores a collection of thermochemistry mechanisms in Chemkin-II format. These kinetic mechanisms were developed by several research groups that works in the simulation of chemically reactive flows. This collection is the result of more than 15 years of search. All of these mechanisms were made available, at some time, on the Internet or in specialized literature. 

The repository owner makes them available here with the intention that they may be useful for researchers interested in the topic. Unfortunately, no guarantee can be given regarding the integrity of the files or the accuracy of the mechanisms. Use it at your own risk!

## Reproducibility

Simulations done with **PaSR-SDE** are fully reproducible, as can be seen on this <a href="https://codeocean.com/capsule/xxx" target="_blank">CodeOcean capsule</a>

## Authors
- Elder Marino Mendoza Orbegoso (PUC-Rio)
- Americo Cunha (UERJ)

## Citing PaSR-SDE

We kindly ask users to cite the following references in any publications reporting work done with **CRFlowLib**:
- *E. M. Orbegoso and L. F. Figueira da Silva, Study of stochastic mixing models for combustion in turbulent flows, Proceedings of the Combustion Institute, v. 32, pp. 1595-1603, 2009 http://dx.doi.org/10.1016/j.proci.2008.06.008*  

```
@article{Orbegoso2009p1595,
   author  = {E. M. Orbegoso and L. F. {Figueira da Silva}},
   title   = {Study of stochastic mixing models for combustion in turbulent flows},
   journal = {Proceedings of the Combustion Institute},
   year    = {2009},
   volume  = {32},
   pages   = {1595-1603},
   doi     = {10.1016/j.proci.2008.06.008},
}
```

```
@mastersthesis{CunhaJr2010msc,
   author       = {E. M. Orbegoso}, 
   title        = {},
   school       = {PUC-Rio},
   year         = {2007},
   address      = {Rio de Janeiro},
   note         = {https://doi.org/10.17771/PUCRio.acad.17685},
}
```

## License

**PaSR-SDE** is released under the MIT license. See the LICENSE file for details. All new contributions must be made under the MIT license.

<img src="logo/mit_license_red.png" width="10%"> 

## Institutional support

<img src="logo/logo_pucrio_color.jpg" width="07%"> &nbsp; &nbsp; <img src="logo/logo_uerj_color.jpeg" width="10%">

## Funding

<img src="logo/faperj.jpg" width="20%"> &nbsp; &nbsp; <img src="logo/cnpq.png" width="20%"> &nbsp; &nbsp; <img src="logo/capes.png" width="10%">
