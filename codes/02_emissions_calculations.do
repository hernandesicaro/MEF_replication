/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: EMISSIONS CALCULATIONS
##############################################################################*/


/*------------------------------- 2018 ---------------------------------------*/
**************************************************
* STEP 1: Load the generation data from prior 
**************************************************


use "clean_data/generation_18.dta", clear


********************************************************
* Note 1 : We again decided to make these calculations
* for each separate year. The structure is the same
* for all the years. So for the following years I ommit 
* these comments
********************************************************

keep if type == "TÉRMICA"
drop if fuel == "Biomassa"


drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL") /*this line is to remove 
the thermal power plants fueled by residual forest fuels*/
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

********************************************************
* STEP 3: Merge all the plants dispatched for this 
* year with the rates coming from IEMA. The contruction
* of the data set called "taxas_full" is detailed 
* in the read me file. This file is also provided.
********************************************************

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

*********************************************************
* STEP 4: Export all dispatched thermal power plants
* to excel to make the manual calculation and assignment
* of the emission rates
*********************************************************
export excel using "clean_data/plants_18.xlsx", firstrow(variables) replace 


import excel using "raw_data/plants_18_treated.xlsx", firstrow clear

rename tx_antigo tx
drop H
la var tx "Emission Rate - tCO2/MWh"

*Saving this _treated file as a dta so we can merge with the generation and emission file
save "clean_data/plants_18_treated.dta"


use "clean_data/generation_18.dta", clear
merge m:1 ceg using "clean_data/plants_18_treated.dta"

**************************************************
* STEP 5: Assigning zero emission rate to the 
* other technologies
**************************************************

drop _merge
replace tx = 0 if tx==.

**************************************************
* STEP 5: Multiplication to get the total emitted 
**************************************************
gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen

**************************************************
* STEP 5: Save the file 
**************************************************
save "clean_data/emissions_18.dta"

/*------------------------------- 2019 ---------------------------------------*/

****************************************************
* Note 2 : Note that all following years require
* the same steps.
****************************************************


use "clean_data/generation_19.dta", clear
keep if type == "TÉRMICA"
drop if fuel == "Biomassa"
drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL")
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

export excel using "clean_data/plants_19.xlsx", firstrow(variables) 

* If it exists, proceed as normal
import excel using "raw_data/plants_19_treated.xlsx", firstrow clear

rename tx_antigo tx
drop H
la var tx "Emission Rate - tCO2/MWh"

save "clean_data/plants_19_treated.dta"


use "clean_data/generation_19.dta", clear
merge m:1 ceg using "clean_data/plants_19_treated.dta"

drop _merge
replace tx = 0 if tx==.

gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen
save "clean_data/emissions_19.dta"

/*------------------------------- 2020 ---------------------------------------*/


use "clean_data/generation_20.dta", clear
keep if type == "TÉRMICA"
drop if fuel == "Biomassa"
drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL")
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

export excel using "clean_data/plants_20.xlsx", firstrow(variables) 


import excel using "raw_data/plants_20_treated.xlsx", firstrow clear

rename tx_antigo tx
la var tx "Emission Rate - tCO2/MWh"

save "clean_data/plants_20_treated.dta"



use "clean_data/generation_20.dta", clear
merge m:1 ceg using "clean_data/plants_20_treated.dta"

drop _merge
replace tx = 0 if tx==.

gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen
save "clean_data/emissions_20.dta"

/*------------------------------- 2021 ---------------------------------------*/


use "clean_data/generation_21.dta", clear
keep if type == "TÉRMICA"
drop if fuel == "Biomassa"
drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL")
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

export excel using "clean_data/plants_21.xlsx", firstrow(variables) 

import excel using "raw_data/plants_21_treated.xlsx", firstrow clear

rename tx_antigo tx
la var tx "Emission Rate - tCO2/MWh"

save "clean_data/plants_21_treated.dta"



use "clean_data/generation_21.dta", clear
merge m:1 ceg using "clean_data/plants_21_treated.dta"

drop _merge
replace tx = 0 if tx==.

gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen
save "clean_data/emissions_21.dta"

/*------------------------------- 2022 ---------------------------------------*/


use "clean_data/generation_22.dta", clear
keep if type == "TÉRMICA"
drop if fuel == "Biomassa"
drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL")
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

export excel using "clean_data/plants_22.xlsx", firstrow(variables) 

import excel using "raw_data/plants_22_treated.xlsx", firstrow clear

rename tx_antigo tx
la var tx "Emission Rate - tCO2/MWh"

save "clean_data/plants_22_treated.dta"



use "clean_data/generation_22.dta", clear
merge m:1 ceg using "clean_data/plants_22_treated.dta"

drop _merge
replace tx = 0 if tx==.

gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen
save "clean_data/emissions_22.dta"


/*------------------------------- 2023 ---------------------------------------*/


use "clean_data/generation_23.dta", clear
keep if type == "TÉRMICA"
drop if fuel == "Biomassa"
drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL")
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

export excel using "clean_data/plants_23.xlsx", firstrow(variables) 


* If it exists, proceed as normal
import excel using "raw_data/plants_23_treated.xlsx", firstrow clear

rename tx_antigo tx
la var tx "Emission Rate - tCO2/MWh"

save "clean_data/plants_23_treated.dta"



use "clean_data/generation_23.dta", clear
merge m:1 ceg using "clean_data/plants_23_treated.dta"

drop _merge
replace tx = 0 if tx==.

gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen
save "clean_data/emissions_23.dta"


/*------------------------------- 2024 ---------------------------------------*/


use "clean_data/generation_24.dta", clear
keep if type == "TÉRMICA"
drop if fuel == "Biomassa"
drop if fuel == "Resíduos Industriais" & strpos(ceg, "FL")
drop if ceg == ""
drop hour mod gen
duplicates drop ceg, force

merge 1:1 ceg using "raw_data/taxas_full.dta"

drop if _merge ==2

export excel using "clean_data/plants_24.xlsx", firstrow(variables) 


* If it exists, proceed as normal
import excel using "raw_data/plants_24_treated.xlsx", firstrow clear

rename tx_antigo tx
la var tx "Emission Rate - tCO2/MWh"

save "clean_data/plants_24_treated.dta"

use "clean_data/generation_24.dta", clear
merge m:1 ceg using "clean_data/plants_24_treated.dta"

drop _merge
replace tx = 0 if tx==.

gen emission = gen*tx
rename emission hour_emission
rename gen hour_gen
save "clean_data/emissions_24.dta"









