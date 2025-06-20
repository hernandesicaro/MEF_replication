/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: DESEASONALIZED REGRESSIONS
##############################################################################*/


*******************************************************
* Note 1 : In this file we are running the regressions
* with the deseasonalized inputs i.e. deseasonalized
* series of generation and emissions

* As in the same manner of previous scrips - we comment
* in more detail the first iteration and for 
* the subsequent years we ommit the comments
*******************************************************

*******************************************************
* Note 2: In this file we are running the regressions
* with the deseasonalized inputs i.e. deseasonalized
* series of generation and emissions

* As in the same manner of previous scrips - we comment
* in more detail the first iteration and for 
* the subsequent years we ommit the comments
*******************************************************

********************************************************
* Note 3: The general structure of this script is the
* following: first we deseasonalize the generation
* and emission series with the whole set of power plants
* we then run the regressions for all regions.

* We reload the data, subset only the thermal power 
* plants, deseasonalize again this new series and then
* re-run the regressions for each region

* This process is done by each year and the regressions
* over the regions are done in a loop
********************************************************

/*------------------------------- 2018 Overall--------------------------------*/

***********************************************************
* STEP 1: Loading the generation and emission data for 2018
***********************************************************

use "clean_data/emissions_18.dta", clear

****************************************************************
* STEP 2: Deseasonalizing the series for emission and generation
****************************************************************

* First we aggregate the emission and generation
collapse (sum) hour_gen hour_emission, by(hour zone)

* Here we are taking the string date variable and turning
* into seprate information for days of the week and hours

rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)

* To actually desesonalize we must take of the 
* components regarding the day and hour from the series

* We regress the generation sereis on the indicators for hours
* and days then take the residuas and the constant
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

* The deseasonalized series will be the sum of
* the residuals and the constante i.e. taking out
* the coefficients of days and hours

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"

* Cleaning the regression memory
eststo clear


* Now we do the same steps for the emissions
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission

****************************************************************
* STEP 3: Run the regressions on the deseasonalized series foreach
* the overall analysis
****************************************************************

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

* Saving the estimates

esttab using "regression_results\2018\season_overall_18.tex"


/*------------------------------- 2018 Thermal -------------------------------*/

****************************************************************
* STEP 3: Running the deseasonalized regressions for the 
* thermal analysis
****************************************************************

****************************************************
* Note 1 : I have to deseasonalize all over again
* since when accounting for only thermal power plants
* we obtain new generation and emission series
****************************************************

****************************************************************
* STEP 4: Dropping the non-polluting sources
****************************************************************
use "clean_data\emissions_18.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2018\season_thermo_18.tex"


/*------------------------------ 2019 Overall --------------------------------*/


use "clean_data/emissions_19.dta", clear


collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission


levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2019\season_overall_19.tex"

/*------------------------------ 2019 Thermal --------------------------------*/
use "clean_data\emissions_19.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2019\season_thermo_19.tex"


/*------------------------------- 2020 Overall -------------------------------*/

use "clean_data/emissions_20.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2020\season_overall_20.tex"

/*------------------------------- 2020 Thermal -------------------------------*/
use "clean_data\emissions_20.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2020\season_thermo_20.tex"

/*------------------------------- 2021 Overall -------------------------------*/

use "clean_data/emissions_21.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2021\season_overall_21.tex"

/*------------------------------- 2021 Thermal -------------------------------*/
use "clean_data\emissions_21.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2021\season_thermo_21.tex"

/*------------------------------- 2022 Overall -------------------------------*/

use "clean_data/emissions_22.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2022\season_overall_22.tex"

/*------------------------------- 2022 Thermal -------------------------------*/
use "clean_data\emissions_22.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2022\season_thermo_22.tex"

/*------------------------------- 2023 Overall -------------------------------*/

use "clean_data/emissions_23.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2023\season_overall_23.tex"

/*------------------------------- 2023 Thermal -------------------------------*/
use "clean_data\emissions_23.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2023\season_thermo_23.tex"

/*------------------------------- 2024 Overall -------------------------------*/

use "clean_data/emissions_24.dta", clear

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2024\season_overall_24.tex"


use "clean_data\emissions_24.dta", clear

drop if hour_emission == 0

collapse (sum) hour_gen hour_emission, by(hour zone)
rename hour full_date
split full_date
rename full_date1 date
rename full_date2 hour
encode hour, gen(ind_hour)
drop hour
rename ind_hour hour
la var hour "Dummy variables for each hour of the day"
gen v2 = date(date, "YMD")
drop date
rename v2 date
format date %td
gen dow = dow(date)
la var full_date "String - Full date of the generation"
la var dow "Dummy variables - Day Of Week"
order date, after(full_date)
reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

eststo clear

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized emissions"
drop date
drop hour_gen - cons_gen
drop res_emission cons_emission
levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort full_date
	gen gen_lag = gen_season[_n-1]
	gen emission_lag = emi_season[_n-1]
	gen delta_emission = emi_season - emission_lag
	gen delta_gen_`l' = gen_season - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results\2024\season_thermo_24.tex"