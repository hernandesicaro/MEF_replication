===============================================================
Replication Package for: 
"Marginal Emissions Factors in a Country with a High Penetration of Renewables: The Case of Brazil"
Author: Fulvio Fontini, Filippo Beltrami, Icaro Franco Hernandes
Last updated: [2025-06-25]
===============================================================

1. DESCRIPTION
---------------------------------------------------------------
This replication package contains the raw data and the codes
to generate the results presented in the paper: 
"Marginal Emissions Factors in a Country with a High Penetration of Renewables: The Case of Brazil" by
Fulvio Fontini, Filippo Beltrami, Icaro Franco Hernandes.

Given the size of the files in the raw data, we chose to host them in
a google drive folder.
The raw data can be downloaded through this link:
https://drive.google.com/drive/folders/1aZCc-FfphydB0QSfcRj2ThLkKPf6d3Ay?usp=sharing
 
Aside from the raw data files, all replication codes are within this zip file.


2. CONTENTS
-----------------------------------------------------------------------
The main folder is the "replication package". Within this 
folder you will find:

1) 9 do files. Each one regarding one step of the process
However, only the "master.do" file is necessary to be 
explicitly open and run.

Make sure that the "raw_data" folder (from google drive) is 
within the replication_package folder


3. SOFTWARE REQUIREMENTS
-----------------------------------------------------------------------
The replication files were created using the following:

- Stata version: 18
- Operating System: Windows 10

4. INSTRUCTIONS TO REPLICATE
-----------------------------------------------------------------------
To replicate the results:

1. Download the "raw_data" folder through the link;
2. Place the "raw_data" folder in the same folder as for the 
	codes ;
2. Open STATA;
3. Open the "master.do" file;
4. Set the working directory as the same folder as the codes 
	and the raw data are;
5. You can run the "master.do" file 
   
5. NOTES
-----------------------------------------------------------------------
1. The folders where the clean data and the regression outputs
will be places are automatically created by the "master.do" script

2. "taxas_full.dta" is a dta file included in tha raw data. 
This file contains the data for the emission rates of each power plant
in the brazilian electric system. This file was manually created 
give that this information was only available through a PDF file
from IEMA, and not a csv file, for example.

3. The set of files name "plants_XX_treated.xlsx" contains the 
assigned emission rates for those power plants where this information
was not available through IEMA. This assignment is simply the average
of emissions by each technology. So If a given year a thermal power
plant was dispatech but we do not have its emission rate - we just assign
its emission rate as the average of other power plants with the same
fuel.


