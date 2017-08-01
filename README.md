# easycsv

why should use easycsv?

because reading multiple csv files is a hassle, 
and you want an easy to use function to read all of them,
either from a central folder, a remote website or a handy zip file.

how do you use easycsv?

well its easy, if all your csv files are inside a folder, 
  just use `loadcsv_multi(my_folder)` or `loadcsv_multi(my_folder, txt = TRUE)` if you have comma separated text files.
the same easy and simple use is available for .zip files (`loadcsvfromZIP(my_zip_file)`),
and .zip files on a remote url (`loadZIPcsvfromURL(my_remote_zip_file)`).  

how do you install easycsv?

well since the library is not on CRAN you need devttols to install it.
you can paste the following code to install easycsv:

```
install.packages("devtools")
devtools::install_github("bogind/easycsv")

```
and load it with `library(easycsv)` like any other library.

