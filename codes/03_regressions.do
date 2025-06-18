/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: REGRESSIONS
##############################################################################*/


****************************************************
* Note 1 : These regressions regard the raw data i.e
* without treating for seasonality. The outputs from
* this do file is for the table 4 in the paper
****************************************************


*****************************************************
* Note 2 : For the same manner as the previous codes
* We chose not to do in a loop to make it more clear
* and not produce a huge number of .tex files.

* But the calculation pattern is the same for every
* year. So we chose to comment in greater detail
* the first iteration of code and then ommit - given
* that the steps are basically the same
******************************************************

*****************************************************
* Note 3 : The regressions are run by year and
* by the overall and thermal only analysis
******************************************************

/*------------------------------- 2018 Overall--------------------------------*/

***********************************************************
* STEP 1: Loading the generation and emission data for 2018
***********************************************************

use "clean_data/emissions_18.dta", clear

***********************************************************
* STEP 2: Aggregate the emission and generation series
* by hour. This is to generate hourly series to run then
* regressions
***********************************************************

collapse (sum) hour_gen hour_emission, by(hour zone)

***********************************************************
* STEP 3: Here the loop goes over the zones. We take
* all values for the zones and perform the regressions
* for each of these zones

* Here we also generate the lagged values to calculate the
* first differences
***********************************************************

/* run regressions by zone */
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

***********************************************************
* STEP 4: Saving the regression outputs in a dedicated 
* folder by each year. We are saving as a .tex file
* to then build table 4.
***********************************************************

esttab using "regression_results/2018/2018_all.tex", se nonumbers nocons

/*------------------------------- 2018 Thermal--------------------------------*/


**************************************************
* STEP 1: Load again the data for the 
* emission and generation
**************************************************


use "clean_data/emissions_18.dta", clear

**************************************************
* STEP 2: Subsetting only the thermal 
* power plants
**************************************************

keep if type == "TÉRMICA"

*************************************************
* Here i must remove the zero emissions since
* there are renewable thermal power plants
* such as biomass and biodiesel and still count
* as thermal by ONS. So removing the zero emissions
* will keep only the non-renewable plants
*************************************************
drop if hour_emission == 0

***********************************************************
* STEP 2: Aggregate the emission and generation series
* by hour. This is to generate hourly series to run then
* regressions for the thermal only analysis
***********************************************************

collapse (sum) hour_gen hour_emission, by(hour zone)


***********************************************************
* STEP 3: Here the loop goes over the zones. We take
* all values for the zones and perform the regressions
* for each of these zones

* Here we also generate the lagged values to calculate the
* first differences

* It is similarly to the overall analysis - but in this
* chunk is the regression regarding the thermal only data.
***********************************************************

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

***********************************************************
* STEP 4: Saving the regression outputs in a dedicated 
* folder by each year. We are saving as a .tex file
* to then build table 4.

* We put the suffix _thermal to signal that these 
* outcomes regard the thermal regressions
***********************************************************

esttab using "regression_results/2018/2018_thermal.tex", se nonumbers nocons


/*------------------------------ 2019 Overall --------------------------------*/
use "clean_data/emissions_19.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2019/2019_all.tex", se nonumbers nocons

/*------------------------------ 2019 Thermal --------------------------------*/
use "clean_data/emissions_19.dta", clear

keep if type == "TÉRMICA"
drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2019/2019_thermal.tex", se nonumbers nocons


/*------------------------------ 2020 Overall --------------------------------*/
use "clean_data/emissions_20.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2020/2020_all.tex", se nonumbers nocons

/*------------------------------ 2020 Thermal --------------------------------*/

use "clean_data/emissions_20.dta", clear

keep if type == "TÉRMICA"
drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2020/2020_thermal.tex", se nonumbers nocons

/*------------------------------ 2021 Overall --------------------------------*/
use "clean_data/emissions_21.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2021/2021_all.tex", se nonumbers nocons


/*------------------------------ 2021 Thermal --------------------------------*/
use "clean_data/emissions_21.dta", clear

keep if type == "TÉRMICA"
drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2021/2021_thermal.tex", se nonumbers nocons

/*------------------------------ 2022 Overall --------------------------------*/
use "clean_data/emissions_22.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2022/2022_all.tex", se nonumbers nocons


/*------------------------------ 2022 Thermal --------------------------------*/

use "clean_data/emissions_22.dta", clear

keep if type == "TÉRMICA"
drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2022/2022_thermal.tex", se nonumbers nocons

/*------------------------------ 2022 Overall --------------------------------*/
use "clean_data/emissions_23.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2023/2023_all.tex", se nonumbers nocons


/*------------------------------ 2023 Thermal --------------------------------*/
use "clean_data/emissions_23.dta", clear

keep if type == "TÉRMICA"
drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2023/2023_thermal.tex", se nonumbers nocons

/*------------------------------ 2024 Overall --------------------------------*/
use "clean_data/emissions_24.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2024/2024_all.tex", se nonumbers nocons

/*------------------------------ 2024 Thermal --------------------------------*/

use "clean_data/emissions_24.dta", clear

keep if type == "TÉRMICA"
drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort hour
	gen emission_lag = hour_emission[_n-1]
	gen gen_lag = hour_gen[_n-1]
	gen delta_emission = hour_emission - emission_lag
	gen delta_gen = hour_gen - gen_lag
	rename delta_gen delta_gen_T_`l'
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2024/2024_thermal.tex", se nonumbers nocons





