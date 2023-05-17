# rtaCFR #
rtaCFR (which stands for <ins>**r**</ins>eal-<ins>**t**</ins>ime <ins>**a**</ins>djusted <ins>**C**</ins>ase <ins>**F**</ins>atality <ins>**R**</ins>ate) is a package that performs estimation of the real-time fatality rates with adjustment for reporting delay in deaths proposed by Qu et al. (2022) <DOI: [10.1038/s41598-022-23138-4](https://doi.org/10.1038/s41598-022-23138-4)>.

**rtaCFR** relies on the R-packages `genlasso` and `Rtools`, which is hosted on CRAN.

# How to import the Functions #
> install.packages("devtools")<br />
> library(devtools) <br /> 
> source_url("https://github.com/lcyjames/rtaCFR/blob/main/CoreFunctions.R?raw=TRUE")

# Usage #
The package contains 2 functions:
|Functions  | Description|
|------------- | -------------|
rtaCFR.SIM  | Generate a data set according to the simulation study in Qu et al. (2022)
rtaCFR.EST  | Computation of the rtaCFR as proposed in Qu et al. (2022)

<ins>**rtaCFR.SIM**</ins>

```
rtaCFR.SIM(ct, pt, seed = NA, F_mean = 15.43, F_shape = 2.03)
```
This function generates a data set according to the model in Qu et al. (2022) that takes the arguments:
>- `ct` is the number of confirmed cases, a vector of length `N`
>- `pt` is the proportion of confirmed cases who will eventually die from the disease, a vector of length `N`
>- `F_mean` is the mean of the gamma distribution for the time from disease onset to death
>- `F_shape` is the shape parameter of the gamma distribution for the time from disease onset to death

Taking scenario (b) in the simulation study in Qu et al. (2022) as an example:
```
data <- rtaCFR.SIM(ct = 3000-5*abs(100-c(1:200)), pt = 0.01*exp(0.012*c(1:200)), seed = 1)
head(data)

#    ct        dt
#1 2505 0.1596081
#2 2510 0.6122235
#3 2515 1.3255914
#4 2520 2.2971944
#5 2525 3.4188380
#6 2530 4.6502343
```

This data structure is as follows:
>- `ct` is the number of confirmed cases
>- `dt` is the number of deaths with reporting delay from disease onset to death





# Contact #
Lee Chun Yin, James <<james-chun-yin.lee@polyu.edu.hk>>

# Reference #
Qu, Y., Lee, C. Y., & Lam, K. F. (2022). A novel method to monitor COVID-19 fatality rate in real-time, a key metric to guide public health policy. Scientific Reports, 12(1), 18277. DOI:10.1038/s41598-022-23138-4

