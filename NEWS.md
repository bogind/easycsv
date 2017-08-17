---
title: "NEWS"
output: html_document
---

# easycsv 1.0.2 09/08/2017

* Added `fread_folder()` for faster table reading with data.table::fread and suggests for data.table

# easycsv 1.0.3 10/08/2017

* 'txt' parameter no longer exists, changed to extension and now takes as argument either 'TXT','CSV' or 'BOTH', in lower or upper case, this extends to loadcsv_multi and fread_folder.

# easycsv 1.0.4 17/08/2017

*removed option to add a colnames vector in fread_folder, added a Names option for tables instead.
