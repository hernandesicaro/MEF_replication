/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: DATA CLEANING
##############################################################################*/


****************************************************
* Note 1 : The descriptions will be more detailed
* for the first year - which is 2018. This is due
* to the fact that the cleaning process is basically
* the same for all years. We will describe the steps
* more carefully for the year of 2018 and the pattern
* remains for the following years.
****************************************************

*******************************************************
* Note 2 : We decided to clean each year individually
* and not make it a loop given the uncertainty of
* uniformity across years. This may not be optimal
* but in turn makes the cleaning process more reliable.   
*******************************************************

/*------------------------------- 2018 ---------------------------------------*/

**************************************************
* STEP 1: Load raw data
**************************************************
import delim using "raw_data/GERACAO_USINA_2018.csv", clear

*****************************************************
* STEP 2: Drop observations: Here I am dropping
* all the non-generating plants or those which
* have null values. I can do this given that
* in no hour and zone there is a hour with no 
* generation - meaning that we do not lose the time
* series proporties for the regressions that will be
* done
*****************************************************

drop if val_geracao == 0
drop if val_geracao ==.

**************************************************
* STEP 3: Dropping the names of states and zones.
* since we already have their indicators in the 
* dataset
**************************************************

drop nom_subsistema nom_estado 

****************************************************
* STEP 4: Renaming the CEG - which is the 
* identificator for each plant. Keeping only
* the numbers will help us match the plants with the
* rate of emissions data
****************************************************

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

**************************************************
* STEP 5: Renaming the variables
**************************************************

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

**************************************************
* STEP 6: Assigning labels for each variable
**************************************************

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

**************************************************
* STEP 6: Saving the clean data
**************************************************
save "clean_data/generation_18.dta"

/*------------------------------- 2019 ---------------------------------------*/

import delim using "raw_data/GERACAO_USINA_2019.csv", clear

drop if val_geracao == 0
drop if val_geracao ==.
drop nom_subsistema nom_estado 

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

save "clean_data/generation_19.dta"

/*------------------------------- 2020 ---------------------------------------*/
import delim using "raw_data/GERACAO_USINA_2020.csv", clear

drop if val_geracao == 0
drop if val_geracao ==.
**************************************************
* Note that starting from 2020 and onwards, I am also 
* dropping the id_ons - which is a identificator which
* will not be of any use for us
**************************************************
drop nom_subsistema id_ons nom_estado 

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

save "clean_data/generation_20.dta"

/*------------------------------- 2021 ---------------------------------------*/

import delim using "raw_data/GERACAO_USINA_2021.csv", clear

drop if val_geracao == 0
drop if val_geracao ==.

drop nom_subsistema nom_estado 

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

save "clean_data/generation_21.dta"

/*------------------------------- 2022 ---------------------------------------*/

*******************************************************
* Note 3 : For 2022 and subsequent years We'll generate
* an auxiliary file when cleaning. Due to the fact that 
* the generation data comes for each month separately. 
* We first drop 
* the variables and observations and then we append to the
* final file. This intermediary file is erased.
*******************************************************

forvalues i = 1/12{
	import delim using "raw_data\2022\GERACAO_USINA-2_2022_`i'.csv", clear
	drop if val_geracao == 0
	drop if val_geracao ==.
	save "raw_data\2022\ger_`i'.dta"
}

use "raw_data\2022\ger_1.dta", clear
forvalues i = 2/12{
	append using "raw_data\2022\ger_`i'.dta"
}

drop nom_subsistema nom_estado id_ons

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

save "clean_data\generation_22.dta"

forvalues i = 1/12{
	erase "raw_data\2022\ger_`i'.dta" 
}

/*------------------------------- 2023 ---------------------------------------*/

forvalues i = 1/12{
	import delim using "raw_data\2023\GERACAO_USINA-2_2023_`i'.csv", clear
	drop if val_geracao == 0
	drop if val_geracao ==.
	drop nom_subsistema nom_estado id_ons
	save "raw_data\2023\ger_`i'.dta"
}

use "raw_data\2023\ger_1.dta", clear
forvalues i = 2/12{
	append using "raw_data\2023\ger_`i'.dta"
}

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

save "clean_data\generation_23.dta"

forvalues i = 1/12{
	erase "raw_data\2023\ger_`i'.dta" 
}

use "clean_data\generation_23.dta"

/*------------------------------- 2024 ---------------------------------------*/

forvalues i = 1/7{
	import delim using "raw_data\2024\GERACAO_USINA-2_2024_`i'.csv", clear
	drop if val_geracao == 0
	drop if val_geracao ==.
	drop nom_subsistema nom_estado id_ons
	save "raw_data\2024\ger_`i'.dta"
}

use "raw_data\2024\ger_1.dta", clear
forvalues i = 2/7{
	append using "raw_data\2024\ger_`i'.dta"
}

replace ceg = subinstr(ceg, ".", "",.)
replace ceg = substr(ceg, 1, strlen(ceg)-2)

rename din_instante hour
rename id_subsistema zone 
rename id_estado state 
rename cod_modalidadeoperacao mod 
rename nom_tipousina type 
rename nom_tipocombustivel fuel 
rename nom_usina name
rename val_geracao gen

la var hour "The moment of generation"
la var zone "Zone within the system"
la var state "State where plant is located"
la var mod "ONS modality of plant"
la var type "Type of plant"
la var fuel "Which fuel sorce is used in the plant"
la var name "Name of power plant"
la var gen "Amount of energy generated - in MWh"
la var ceg "Unique code of power plant"

save "clean_data\generation_24.dta"

forvalues i = 1/7{
	erase "raw_data\2024\ger_`i'.dta" 
}











