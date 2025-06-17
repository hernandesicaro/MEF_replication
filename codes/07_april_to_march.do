/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: APRIL TO MARCH REGRESSIONS
##############################################################################*/

cd "C:\Users\icaro\OneDrive\Área de Trabalho\replication package - MEF"


*******************************************************
* Note 1 : In this set of regressions I'll save 
* intermediary dta files with the time frames from
* april of one year through march of the following
* year. This is just so I can make the regressions
* afterwards in a loop. I found it to be more tidy
* to make this way: first make interediary files
* and then run all the regressions

* The outcomes from the regressions of this file
* is those of table 8 in the paper.
*******************************************************

*******************************************************
* Note 2 : These intermediary files will be called
* 18_19_overall.dta and 18_19_thermal.dta - for then
* total emission and generation, and only thermal emission
* and generation respectively. I'll make it very clear
* in the code what steps I am doing, and in the final
* section the regressions which will be performed
*******************************************************



/*----------------------------- 2018/2019 Overall ----------------------------*/

****************************************************
* STEP 1: Appending the 2018 and 2019 datasets
****************************************************

use "clean_data/emissions_18.dta", clear

append using "clean_data/emissions_19.dta"

collapse (sum) hour_gen hour_emission, by(hour zone)
****************************************************
* STEP 2: Deseasonalizing the series
****************************************************
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

keep if date >= td(01/04/2018) & date <=td(31/03/2019)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

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

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

****************************************************
* STEP 3: Saving the dataset for the overall
* emissions and generation
****************************************************

save "clean_data\18_19_overall.dta"

****************************************************
* NOTE 3: Note that for the thermal only
* series I'll deseasonalize the series again - since
* I have to subset the thermal observations. So I repeat 
* the process of loading both years, deseasonalize
* and then generate the dataset
****************************************************

/*----------------------------- 2018/2019 Thermal-----------------------------*/


****************************************************
* STEP 1: Appending the 2018 and 2019 datasets
****************************************************

use "clean_data/emissions_18.dta", clear

append using "clean_data/emissions_19.dta"

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

keep if date >= td(01/04/2018) & date <=td(31/03/2019)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

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

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\18_19_thermal.dta"

/*----------------------------- 2019/2020 Overall ----------------------------*/

use "clean_data/emissions_19.dta", clear

append using "clean_data/emissions_20.dta"

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

keep if date >= td(01/04/2019) & date <=td(31/03/2020)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\19_20_overall.dta"

/*----------------------------- 2019/2020 Thermal ----------------------------*/


use "clean_data/emissions_19.dta", clear

append using "clean_data/emissions_20.dta"

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

keep if date >= td(01/04/2019) & date <=td(31/03/2020)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\19_20_thermal.dta"

/*----------------------------- 2020/2021 Overall ----------------------------*/


use "clean_data/emissions_20.dta", clear

append using "clean_data/emissions_21.dta"

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

keep if date >= td(01/04/2020) & date <=td(31/03/2021)


gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\20_21_overall.dta"

/*----------------------------- 2020/2021 Thermal ----------------------------*/


use "clean_data/emissions_20.dta", clear

append using "clean_data/emissions_21.dta"

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

keep if date >= td(01/04/2020) & date <=td(31/03/2021)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\20_21_thermal.dta"

/*----------------------------- 2021/2022 Overall ----------------------------*/

use "clean_data/emissions_21.dta", clear

append using "clean_data/emissions_22.dta"

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

keep if date >= td(01/04/2021) & date <=td(31/03/2022)


gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\21_22_overall.dta"

/*----------------------------- 2021/2022 Thermal ----------------------------*/


use "clean_data/emissions_21.dta", clear

append using "clean_data/emissions_22.dta"

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

keep if date >= td(01/04/2021) & date <=td(31/03/2022)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\21_22_thermal.dta"

/*----------------------------- 2022/2023 Overall ----------------------------*/

use "clean_data/emissions_22.dta", clear

append using "clean_data/emissions_23.dta"

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

keep if date >= td(01/04/2022) & date <=td(31/03/2023)


gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\22_23_overall.dta"

/*----------------------------- 2022/2023 Thermal ----------------------------*/


use "clean_data/emissions_22.dta", clear

append using "clean_data/emissions_23.dta"

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

keep if date >= td(01/04/2022) & date <=td(31/03/2023)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\22_23_thermal.dta"

/*----------------------------- 2023/2024 Overall ----------------------------*/


use "clean_data/emissions_23.dta", clear

append using "clean_data/emissions_24.dta"

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

keep if date >= td(01/04/2023) & date <=td(31/03/2024)


gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\23_24_overall.dta"
/*----------------------------- 2023/2024 Thermal ----------------------------*/


use "clean_data/emissions_23.dta", clear

append using "clean_data/emissions_24.dta"

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

keep if date >= td(01/04/2023) & date <=td(31/03/2024)

/*gerando o dia da semana pra desazonalizar*/
gen dow = dow(date)
drop date

reg hour_gen i.hour i.dow
predict res_gen, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_gen = `c'
}

gen gen_season = res_gen + cons_gen
la var gen_season "Deseasonalized Generation"

eststo clear


reg hour_emission i.hour i.dow
predict res_emission, residuals
local constant _b[_cons]
foreach c of local constant{
	gen cons_emission = `c'
}

gen emi_season = res_emission + cons_emission
la var emi_season "Deseasonalized Emissions"

keep full_date zone hour_gen hour_emission emi_season gen_season

rename emi_season season_emission
rename gen_season season_generation

la var hour_gen "Unadjusted Generation"
la var hour_emission "Unadjusted Emissions"

save "clean_data\23_24_thermal.dta"



