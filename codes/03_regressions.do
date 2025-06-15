/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: REGRESSIONS
##############################################################################*/

cd "C:\Users\icaro\OneDrive\Área de Trabalho\replication package - MEF"

****************************************************
* Note 1 : These regressions regard the raw data i.e
* without treating for seasonality. The outputs from
* this do file is for the table 4 in the paper
****************************************************

/*------------------------------- 2018 ---------------------------------------*/

use "clean_data/emissions_18.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2018/2018_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2018
**************************************************


use "clean_data/emissions_18.dta", clear

keep if type == "TÉRMICA"

*************************************************
* Here i must remove the zero emissions since
* there are renewable thermal power plants
* such as biomass and biodiesel and still count
* as thermal by ONS. So removing the zero emissions
* will keep only the non-renewable plants
*************************************************
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


esttab using "regression_results/2018/2018_thermal.tex", se nonumbers nocons


/*------------------------------- 2019 ---------------------------------------*/


use "clean_data/emissions_19.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2019/2019_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2019
**************************************************


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


/*------------------------------- 2020 ---------------------------------------*/
use "clean_data/emissions_20.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2020/2020_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2020
**************************************************


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

/*------------------------------- 2021---------------------------------------*/
use "clean_data/emissions_21.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2021/2021_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2021
**************************************************


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

/*------------------------------- 2022---------------------------------------*/
use "clean_data/emissions_22.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2022/2022_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2022
**************************************************


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

/*------------------------------- 2023---------------------------------------*/
use "clean_data/emissions_23.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2023/2023_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2023
**************************************************


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

/*------------------------------- 2024---------------------------------------*/
use "clean_data/emissions_24.dta", clear

/* aggregate by hour */
collapse (sum) hour_gen hour_emission, by(hour zone)

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

esttab using "regression_results/2024/2024_all.tex", se nonumbers nocons


**************************************************
* STEP 1: Thermal Only for 2024
**************************************************


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





