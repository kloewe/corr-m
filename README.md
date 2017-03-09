# corr-m
#### Matlab tools for computing pairwise correlations from fMRI data

Facilitates fast correlation computation for pairwise internodal
functional connectivity estimation based on fMRI data.
So far, two measures of association are supported: Pearson's _r_ and
the tetrachoric correlation coefficient.
With Pearson's _r_, efficient implementation (based on CPU instruction
set extensions) and parallelization yield speedups up to ~3x compared
to Matlab's corrcoef (R2011b).
With the tetrachoric correlation coefficient, data reduction in the
temporal domain based on binarization of nodal time series combined
with tetrachoric correlation estimation and efficient implementation
(based on a 16-bit lookup table or CPU instruction set extensions)
and parallelization yield speedups up to ~20x compared to
Matlab's corrcoef (R2011b).


##### Prerequisites
* 64-bit Linux
* 64-bit Matlab
* The GCC C compiler
* A working MEX setup that uses GCC to compile the MEX files


##### Download
Obtain an archive containing the lastest version from
http://www.kristianloewe.com or clone the repository using
```
$ git clone --recursive https://github.com/kloewe/corr-m.git
```


##### Installation
Change to the root directory of the extracted archive (or the cloned
repository) and install corr-m and cpuinfo-m.
```
$ ./install-m.sh corr-m <target-dir-corr-m>
$ ./install-m.sh cpuinfo-m <target-dir-cpuinfo-m>
```
It is assumed here that Matlab is on your path and that MEX is set up.

Next, start Matlab and add the relevant directories to its path.
```
>> addpath <target-dir-corr-m>
>> addpath <target-dir-cpuinfo-m>
```


##### Documentation
A description of each function can be displayed in Matlab using
```
>> help <function-name>
```


##### Bugs
If you run into problems, please send an email to kl@kristianloewe.com.


##### Citation
If you use this program, please cite:

Loewe K, Grueschow M, Stoppel C, Kruse R, and Borgelt C (2014).<br>
Fast construction of voxel-level functional connectivity graphs.<br>
_BMC Neuroscience_ 15:78.<br>
[doi](http://dx.doi.org/10.1186/1471-2202-15-78)
