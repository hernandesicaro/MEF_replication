/*##############################################################################
REPLICATION PACKAGE FOR THE PAPER MARGINAL EMISSIONS FACTORS IN A COUNTRY WITH
 HIGH PENETRATION OF RENEWABLES: THE CASE OF BRAZIL
 
 FILE: TIME SERIES TESTS
##############################################################################*/

******************************************************
* STEP 1: Firstly I'll deseasonalize the emissions
* and generation series to generate dta files on which 
* I'll run the tests


* This is to make easier to perform the tests.
* I'll save the files and perform the tests 
* for each year separately

* This step folows the same process of the 
* previous codes so I won't come into
* great detail regarding each individual command.
******************************************************


forvalues i = 18/24{
	use "clean_data/emissions_`i'.dta", clear

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


	reg hour_gen i.hour i.dow
	predict res_gen, residuals
	local constant _b[_cons]
	foreach c of local constant{
		gen cons_gen = `c'
	}


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

	eststo clear

	save "clean_data\deseason_`i'.dta"
	
}


******************************************************
* STEP 2: Now we'll perform the PP and ADF tests.

* Here we have a nested loop. The outer loop runs over
* the years. Inside this loop there another one.
* This inside loop perform both tests but going over
* each zone.
******************************************************



tempname memhold //Creating a temporary name for a file
tempfile results // Creating a temporary file to store the results
postfile `memhold' str20 file str20 zone str10 test_type stat using `results', replace // Initializes the postfile system and state the variables which will be saved

forvalues i = 18/24 {
    
    use "clean_data/deseason_`i'.dta", clear

    levelsof zone, local(levels)

    foreach l of local levels {
        preserve
        keep if zone == "`l'"
        gen hour_year = _n
        tsset hour_year

        * DFuller on generation
        dfuller gen_season
        post `memhold' ("`i'") ("`l'") ("DF_gen") (`r(Zt)')

        * PP on generation
        pperron gen_season
        post `memhold' ("`i'") ("`l'") ("PP_gen") (`r(Zt)')

        * DFuller on emissions
        dfuller emi_season
        post `memhold' ("`i'") ("`l'") ("DF_emi") (`r(Zt)')

        * PP on emissions
        pperron emi_season
        post `memhold' ("`i'") ("`l'") ("PP_emi") (`r(Zt)')

        restore
    }
}

postclose `memhold' //To actually use the temporary file we must close the the postfile connection

******************************************************
* STEP 3: Finally, after the outer loop is completed
* we save the results into a csv file.
******************************************************

use `results', clear //Now we can use the temporary file and export to csv
export delimited using "unitroot_results.csv", replace



