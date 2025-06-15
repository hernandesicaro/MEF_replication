/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: DRY REGRESSIONS
##############################################################################*/

cd "C:\Users\icaro\OneDrive\Área de Trabalho\replication package - MEF"

**************************************************
* Note 1: This script is segmented into all regressions
* for the dry analysis and then another chunk for the
* we analysis
**************************************************


/*------------------------------- 2018 DRY ---------------------------------------*/

**************************************************
* STEP 1: Deseasonalize data
**************************************************



use "clean_data/emissions_18.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2018) & date <= td(30/09/2018)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2018/2018_overall_dry.tex", nocons

**************************************************
* STEP 2: Only thermals of 2018 dry
**************************************************


use "clean_data/emissions_18.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2018) & date <= td(30/09/2018)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2018/2018_thermal_dry.tex", nocons

/*------------------------------- 2019 DRY ---------------------------------------*/

**************************************************
* STEP 1: Deseasonalize data
**************************************************

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2019) & date <= td(30/09/2019)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2019/2019_overall_dry.tex", nocons

**************************************************
* STEP 2: Only thermals of 2019 dry
**************************************************


use "clean_data/emissions_19.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2019) & date <= td(30/09/2019)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2019/2019_thermal_dry.tex", nocons


/*------------------------------- 2020 DRY ---------------------------------------*/

**************************************************
* STEP 1: Deseasonalize data
**************************************************

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2020) & date <= td(30/09/2020)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2020/2020_overall_dry.tex", nocons

**************************************************
* STEP 2: Only thermals of 2020 dry
**************************************************


use "clean_data/emissions_20.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2020) & date <= td(30/09/2020)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2020/2020_thermal_dry.tex", nocons


/*------------------------------- 2021 DRY ---------------------------------------*/

**************************************************
* STEP 1: Deseasonalize data
**************************************************

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2021) & date <= td(30/09/2021)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2021/2021_overall_dry.tex", nocons

**************************************************
* STEP 2: Only thermals of 2021 dry
**************************************************


use "clean_data/emissions_21.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2021) & date <= td(30/09/2021)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2021/2021_thermal_dry.tex", nocons

/*------------------------------- 2022 DRY ---------------------------------------*/

**************************************************
* STEP 1: Deseasonalize data
**************************************************

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2022) & date <= td(30/09/2022)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2022/2022_overall_dry.tex", nocons

**************************************************
* STEP 2: Only thermals of 2022 dry
**************************************************


use "clean_data/emissions_22.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2022) & date <= td(30/09/2022)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2022/2022_thermal_dry.tex", nocons


/*------------------------------- 2023 DRY ---------------------------------------*/

**************************************************
* STEP 1: Deseasonalize data
**************************************************

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2023) & date <= td(30/09/2023)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2023/2023_overall_dry.tex", nocons

**************************************************
* STEP 2: Only thermals of 2023 dry
**************************************************


use "clean_data/emissions_23.dta", clear

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
la var gen_season "Deseasonalized Generation"
eststo clear
reg hour_emission i.hour i.dow
predict res_emission, residuals
global constant _b[_cons]
foreach c of global constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

gen estacao = "dry" if date >= td(01/04/2023) & date <= td(30/09/2023)
replace estacao = "wet" if estacao == ""


keep if estacao == "dry"

levelsof zone, local(levels)
foreach l of local levels{	
	preserve
	keep if zone == "`l'"
	sort date
	gen gen_lag = season_generation[_n-1]
	gen emission_lag = season_emission[_n-1]
	gen delta_emission = season_emission - emission_lag
	gen delta_gen_`l' = season_generation - gen_lag
	eststo: reg delta_emission delta_gen
	restore
}

esttab using "regression_results/2023/2023_thermal_dry.tex", nocons





