*===============================================================================
* MASTER DO-FILE
* Replication package for the paper: Marginal Emissions Factors
* in a Country with a High Penetration of Renewables: The case 
* of Brazil

* Author: Fulvio Fontini, Filippo Beltrami and Ícaro Franco Hernandes
* Date: 25/06/2025
* Purpose: Run all steps to replicate results
* Stata Version used: 18
*===============================================================================

clear all
set more off

cd "C:\Users\icaro\OneDrive\Área de Trabalho\replication package - MEF\run_test"  // <-- Change to your root folder

**************************************************
* STEP 1: Create the folders to store the
* clean data and results
**************************************************
capture mkdir "clean_data"


capture mkdir "regression_results"
forvalues year = 2018/2024 {
    capture mkdir "regression_results/`year'"
}

capture mkdir "regression_results/ap_2_mar"

**************************************************
* Note 1: The raw data folder and the files
* within is provided so we dont have to create it

*The link to download it is in the readme file 
**************************************************


*----------------------------------------------------------
* Step-by-step execution
*----------------------------------------------------------

do "01_clean_data.do" 
do "02_emissions_calculations.do"
do "03_regressions.do"
do "04_deseason_regressions.do"
do "05_dry_regressions.do"
do "06_wet_regressions.do"
do "07_april_to_march.do"
do "08_tests.do"

*----------------------------------------------------------
* Done
*----------------------------------------------------------
di as result "Replication complete!"