
*******INDEX
**(A) Variables and data prep
**(B) H3: FC and mortality
**(C) Social determinants of birth-related health





**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep
**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep
**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep
**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep**(A) Variables and data prep



clear all
capture cd "[Your directory here]"
capture cd "F:\Fluxo_Pesquisa_2025\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
use data_stata_hypo_3


xtset cod year

***no log summary
global xlist phys_gps phys_specialists nurses beds icu_beds ventilators pib idh_m_educ literacy_afr literacy_ind literacy_n_afr_n_ind ngos pbf_familias pca_remote vaccrate_21_22 oscs_health area_mun

global zlist pca_soil dist_roads dist_sede_100milhab slope_pct25 slope_pct50 slope_pct75

global poplist pop_all_urb pop_all_rur pop_afr_urb pop_afr_rur pop_ind_urb pop_ind_rur pop

global hlist tot_hosp_hosplace_l hosp_ind_l hosp_afr_l

summ $ylist pop_par_c_four_terr pop_par_cti  pop_par_cpa  pop_par_cuc pop_par_cq $xlist $zlist $poplist $hlist if d_samp == 1 & year < 2022

*log in Y to check if dispersion reduced
global ylist_l mortality_total_occurrence_l mort_afr_l mort_ind_l mort_m1a_total_occurrence_l mort_m1a_afr_l mort_m1a_ind_l hmort_l hmort_ind_l hmort_afr_l mfetal_l mfetal_ind_l mfetal_afr_l mmother_l mmother_ind_l mmother_afr_l mneonatal_l mneonatal_ind_l mneonatal_afr_l mort_avoidcause_l mort_avoidcause_ind_l  mort_avoidcause_afr_l phys_gps_l phys_specialists_l nurses_l beds_l icu_beds_l ventilators_l ngos_l pbf_familias_l

*sum $ylist_l if d_samp == 1 & year < 2022

****Models
*global ylist total_hospitalization_l resp_hosp_l mortality_total_l resp_mort_l

global ylist_mfetal mfetal mfetal_ind mfetal_afr 

global ylist_mmother mmother mmother_ind mmother_afr

global ylist_mneonatal mneonatal mneonatal_ind mneonatal_afr

global ylist_m1a mort_m1a_total_occurrence mort_m1a_ind mort_m1a_afr

global ylist_covid cov_mor_r cov_let_r

global xlist phys_gps_l phys_specialists_l nurses_l beds_l icu_beds_l ventilators_l pib_l idh_m_educ_ts literacy_afr_ts literacy_ind_ts oscs_health_l_ts pbf_familias_l area_mun_l_ts pca_remote_l_ts

global dlist  d_uf_1_ts-d_uf_8_ts d_year_2-d_year_15 

global zlist pca_soil_l_ts slope_pct25_p_ts slope_pct50_p_ts slope_pct75_p_ts

*only COVID (no Mapbio which stop at 21)
global zlist_covid $xlist


summ $ylist_eth $ylist_mfetal $ylist_mmother $ylist_mneonatal $ylist_avoid $ylist_avoid $ylist_m1a pop_par_c_four_terr pop_par_cti pop_par_cpa pop_par_cuc pop_par_cq $xlist pop_all_rur pop_all_urb pop_ind_rur pop_ind_urb pop_afr_rur pop_afr_urb $zlist if d_samp == 1 & year < 2022

*sum for pp
global xlistpp phys_gps phys_specialists nurses beds icu_beds ventilators pib idh_m_educ literacy_afr literacy_ind oscs_health pbf_familias area_mun pca_remote

global zlistpp pca_soil slope_pct25 slope_pct50 slope_pct75

summ $ylist_eth $ylist_mfetal $ylist_mmother $ylist_mneonatal $ylist_avoid $ylist_avoid $ylist_m1a pop_par_c_four_terr pop_par_cti pop_par_cpa pop_par_cuc pop_par_cq tot_hosp_hosplace hosp_ind hosp_afr_l $xlistpp pop_all_rur pop_all_urb pop_ind_rur pop_ind_urb pop_afr_rur pop_afr_urb $zlistpp if d_samp == 1 & year < 2022


*****Distribution for data description
gen fci_rur = pop_accu_four_terr_2022/(pop_census_tot_2010-pop_census_urban_2010)
gen fci_tot = pop_accu_four_terr_2022/pop_census_tot_2010

summ fci_rur
summ fci_tot
codebook fci_tot
count if fci_tot == 0
dis r(N) / _N
*46% with no FC
count if fci_tot >= 0.05
dis r(N) / _N
*21% at least 5%

*29/06, share of TIs and UCs in 4 terr
tabstat pop_par_cti pop_accu_four_terr_2022 if d_samp ==1 & year == 2022, s(sum) format(%15.0g)
help tabstat
*TI =  276818.3769143   725730.707057

tabstat pop_par_cuc pop_accu_four_terr_2022 if d_samp ==1 & year == 2022, s(sum) format(%15.0g)
*UC = 112718.6474251
dis (276818.3769143 + 112718.6474251) / 725730.707057

*other check
tabstat pop_par_cpa pop_par_cq if d_samp ==1 & year == 2022, s(sum) format(%15.0g)
* 296980.3210408  39213.36218176

dis (276818.3769143 + 112718.6474251 + 296980.3210408 + 39213.36218176) / 725730.707057
*100% --> so share of TI And UC are ok



**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality
**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality
**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality
**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality**(B) H3: FC and mortality


************(A) Fetal mortality
***(1) Four territories

global xlist_mfetal $xlist $dlist pop_all_urb_l_ts pop_all_rur_l_ts
global xlist_mfetal_ind $xlist d_year_4-d_year_15 pop_ind_urb_l_ts pop_ind_rur_l_ts
global xlist_mfetal_afr $xlist d_year_4-d_year_15 pop_afr_urb_l_ts pop_afr_rur_l_ts

summ $ylist_mfetal $xlist_mfetal $zlist if d_samp == 1 & year < 2022
summ $ylist_mfetal $xlist_mfetal_ind $zlist if d_samp == 1 & year < 2022
summ $ylist_mfetal $xlist_mfetal_afr $zlist if d_samp == 1 & year < 2022

*mat drop roll_xtiv roll_xt

scalar ynumb_mat = 2


foreach var of varlist $ylist_mfetal {
dis "`var'"
xtivreg `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*mat store (x pos = 1)
mat roll_xtiv_mfetal = nullmat(roll_xtiv_mfetal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}

***OLS

foreach var of varlist $ylist_mfetal {
dis "`var'"
xtreg `var' pop_par_c_four_terr ${xlist_`var'} if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_mfetal = nullmat(roll_xt_mfetal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .
}


***(2) BRKDW
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_mfetal {
dis "`var'"
xtivreg `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*mat store (x pos = 1)
mat roll_xtiv_mfetal = nullmat(roll_xtiv_mfetal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}
}

***OLS
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_mfetal {
dis "`var'"
xtreg `var' `j' ${xlist_`var'}  if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_mfetal = nullmat(roll_xt_mfetal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .

}
}


log using "matrices_recover_19_10_24_part2.txt", text


************(B) Maternal mortality

***(1) Four territories

global xlist_mmother $xlist $dlist pop_all_urb_l_ts pop_all_rur_l_ts
global xlist_mmother_ind $xlist d_year_4-d_year_15 pop_ind_urb_l_ts pop_ind_rur_l_ts
global xlist_mmother_afr $xlist d_year_4-d_year_15 pop_afr_urb_l_ts pop_afr_rur_l_ts

summ $ylist_mmother $xlist_mmother $zlist if d_samp == 1 & year <2022
summ $ylist_mmother $xlist_mmother_ind $zlist if d_samp == 1 & year <2022
summ $ylist_mmother $xlist_mmother_afr $zlist if d_samp == 1 & year <2022

describe $ylist_mmother


*mat drop roll_xtiv roll_xt

scalar ynumb_mat = 3


foreach var of varlist $ylist_mmother {
dis "`var'"
xtivreg `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*mat store (x pos = 1)
mat roll_xtiv_mmother = nullmat(roll_xtiv_mmother) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}

***OLS

foreach var of varlist $ylist_mmother {
dis "`var'"
xtreg `var' pop_par_c_four_terr ${xlist_`var'} if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_mmother = nullmat(roll_xt_mmother) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .

}


***(2) BRKDW
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_mmother {
dis "`var'"
xtivreg `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*xtivreg:
*mat store (x pos = 1)
mat roll_xtiv_mmother = nullmat(roll_xtiv_mmother) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}
}

***OLS
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_mmother {
dis "`var'"
xtreg `var' `j' ${xlist_`var'}  if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_mmother = nullmat(roll_xt_mmother) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .
}
}


************(C) Neonatal mortality

***(1) Four territories

global xlist_mneonatal $xlist $dlist pop_all_urb_l_ts pop_all_rur_l_ts
global xlist_mneonatal_ind $xlist d_year_4-d_year_15 pop_ind_urb_l_ts pop_ind_rur_l_ts
global xlist_mneonatal_afr $xlist d_year_4-d_year_15 pop_afr_urb_l_ts pop_afr_rur_l_ts

summ $ylist_mneonatal $xlist_mneonatal $zlist if d_samp == 1 & year < 2022
summ $ylist_mneonatal $xlist_mneonatal_ind $zlist if d_samp == 1 & year < 2022
summ $ylist_mneonatal $xlist_mneonatal_afr $zlist if d_samp == 1 & year < 2022

describe $ylist_mneonatal

*capture log close
*log using "log_mneonatal_mun_08_10_24.txt", text
*log using "log_mneonatal_mun_18_10_24.txt", text

*mat drop roll_xtiv roll_xt

scalar ynumb_mat = 4


foreach var of varlist $ylist_mneonatal {
dis "`var'"
xtivreg `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*xtivreg:
*mat store (x pos = 1)
mat roll_xtiv_mneonatal = nullmat(roll_xtiv_mneonatal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}

***OLS

foreach var of varlist $ylist_mneonatal {
dis "`var'"
xtreg `var' pop_par_c_four_terr ${xlist_`var'} if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_mneonatal = nullmat(roll_xt_mneonatal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .

}


***(2) BRKDW
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_mneonatal {
dis "`var'"
xtivreg `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*xtivreg:
*mat store (x pos = 1)
mat roll_xtiv_mneonatal = nullmat(roll_xtiv_mneonatal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}
}

***OLS
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_mneonatal {
dis "`var'"
xtreg `var' `j' ${xlist_`var'} if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_mneonatal = nullmat(roll_xt_mneonatal) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .

}
}


************(D) Infant mortality < 1 year

global xlist_mort_m1a_total_occurrence $xlist $dlist pop_all_urb_l_ts pop_all_rur_l_ts
global xlist_mort_m1a_ind $xlist d_year_4-d_year_15 pop_ind_urb_l_ts pop_ind_rur_l_ts
global xlist_mort_m1a_afr $xlist d_year_4-d_year_15 pop_afr_urb_l_ts pop_afr_rur_l_ts

summ $ylist_m1a $xlist_mort_m1a_total_occurrence $zlist if d_samp == 1 & year < 2022
summ $ylist_m1a_ind $xlist_mort_m1a_ind $zlist if d_samp == 1 & year < 2022
summ $ylist_m1a_afr $xlist_mort_m1a_afr $zlist if d_samp == 1 & year < 2022

*mat drop roll_xtiv roll_xt

scalar ynumb_mat = 5

***
foreach var of varlist $ylist_m1a {
dis "`var'"
xtivreg `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*mat store (x pos = 1)
mat roll_xtiv_m1a = nullmat(roll_xtiv_m1a) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)

*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (pop_par_c_four_terr = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}

help xtivreg2

***OLS
estimates clear

foreach var of varlist $ylist_m1a {
dis "`var'"
xtreg `var' pop_par_c_four_terr  ${xlist_`var'} if d_samp ==1 & year < 2022, fe vce(cluster cod)
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*mat store (x pos = 1)
mat roll_xt_m1a = nullmat(roll_xt_m1a) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(p), e(r2_o), e(N), e(N_clust), ynumb_mat, .

}


***(2) BRKDW
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist $ylist_m1a {
dis "`var'"
xtivreg `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe vce(cluster cod) first
local name_st = "IV_" + substr("`var'",1,20)
estimates store `name_st'

*exogeneity test for FC (indep var)
dmexogxt

*mat store (x pos = 1)
mat roll_xtiv_m1a = nullmat(roll_xtiv_m1a) \ e(b)[1,1], sqrt(e(V)[1,1]), 2*normal(-abs(e(b)[1,1]/sqrt(e(V)[1,1]))), e(chi2_p), e(r2_o), e(N), e(N_clust) , ynumb_mat, r(p)


*overID test (bugging, so am using the H of xtivreg2)
capture xtoverid

*weak IV test (OBS: the tests above do not work with xtivreg2)
xtivreg2 `var' ${xlist_`var'} (`j' = $zlist) if d_samp ==1 & year < 2022, fe cluster(cod) first

}
}



****(C) Social determinants of birth-related health****(C) Social determinants of birth-related health
****(C) Social determinants of birth-related health****(C) Social determinants of birth-related health
****(C) Social determinants of birth-related health****(C) Social determinants of birth-related health
****(C) Social determinants of birth-related health****(C) Social determinants of birth-related health
****(C) Social determinants of birth-related health****(C) Social determinants of birth-related health
****(C) Social determinants of birth-related health****(C) Social determinants of birth-related health




****Social determinant 1: nutrition


global xlist_m1 pex_annual pex_peren salhor_allout_l annual_value_l pca_soil_l_ts slope_pct25_p_ts slope_pct50_p_ts slope_pct75_p_ts dist_roads_l_ts dist_sede_100milhab_l_ts farm_area_l pop_ind_urb_l_ts pop_ind_rur_l_ts pop_afr_urb_l_ts pop_afr_rur_l_ts pop_l

summ staple_value pop_par_c_four_terr $xlist_m1

capture drop d_samp_m1
gen d_samp_m1 = 0
replace d_samp_m1 = 1 if annual_value !=. & pca_soil_l_ts !=.
*only min N

summ staple_value pop_par_c_four_terr $xlist_m1 if d_samp_m1 == 1

duplicates report cod if d_samp_m1 == 1
return list

capture drop c_pan t_pan
gen c_pan = 0
replace c_pan = 1 if annual_value ==. | pca_soil_l_ts ==.
bysort cod: egen t_pan = total(c_pan)
table cod if (year == 2006 | year == 2017), statistic(mean t_pan)
codebook t_pan
*browse cod year annual_value pca_soil_l_ts c_pan t_pan
*there are 7 cases of attrition (16 years with missing)
*to avoid attrition, must require both d_samp_m1 == 1 & t_pan == 15

*how many muns in sample
duplicates report cod if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan == 15
return list
*768 muns in sample

xtreg staple_value pop_par_c_four_terr $xlist_m1 if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan == 15, fe vce(cluster cod)
estimates store pop_four

***(2) BRKDW
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
xtreg staple_value `j' $xlist_m1 if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan == 15, fe vce(cluster cod)
estimates store `j'
}


*esttab pop_* using "FE_mecha1_30_10_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

*esttab pop_* using "FE_mecha1_31_10_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

esttab pop_* using "FE_mecha1_04_11_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace


****Social determinant 1-b: crops Y-E
global xlist_m1 pex_annual pex_peren salhor_allout_l annual_value_l pca_soil_l_ts slope_pct25_p_ts slope_pct50_p_ts slope_pct75_p_ts dist_roads_l_ts dist_sede_100milhab_l_ts farm_area_l pop_ind_urb_l_ts pop_ind_rur_l_ts pop_afr_urb_l_ts pop_afr_rur_l_ts pop_l


summ arroz_vicon mandioca_vicon milho_vicon pop_par_c_four_terr_l $xlist_m1

capture drop d_samp_m1
gen d_samp_m1 = 0
replace d_samp_m1 = 1 if annual_value !=. & pca_soil_l_ts !=.
*only min N

summ arroz_vicon mandioca_vicon milho_vicon pop_par_c_four_terr $xlist_m1 if d_samp_m1 == 1


foreach i in "arroz" "mandioca" "milho" {
capture drop c_pan_`i'
capture drop t_pan_`i'
gen c_pan_`i' = 0 
replace c_pan_`i' = 1 if annual_value ==. | pca_soil_l_ts ==. | `i'_vicon ==.
bysort cod: egen t_pan_`i' = total(c_pan_`i')
table cod if (year == 2006 | year == 2017), statistic(mean t_pan_`i')
codebook t_pan_`i'
}

*browse cod year annual_value pca_soil_l_ts c_pan t_pan
*there are 7 cases of attrition (16 years with missing)
*to avoid attrition, must require both d_samp_m1 == 1 & t_pan == 15

foreach y in "arroz" "mandioca" "milho" {
xtreg `y'_vicon pop_par_c_four_terr $xlist_m1 if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan_`y' == 15, fe vce(cluster cod)
estimates store pop_f_`y'
}

***(2) BRKDW
foreach y in "arroz" "mandioca" "milho" {
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
xtreg `y'_vicon `j' $xlist_m1 if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan_`y' == 15, fe vce(cluster cod)
estimates store `j'_`y'
}
}

*esttab pop_* using "FE_mecha1_b_vicon_01_11_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

esttab pop_* using "FE_mecha1_b_vicon_04_11_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace



****Social determinant 1-c: crops Y-E, area refined
global xlist_m1 pex_annual pex_peren salhor_allout_l annual_value_l pca_soil_l_ts slope_pct25_p_ts slope_pct50_p_ts slope_pct75_p_ts dist_roads_l_ts dist_sede_100milhab_l_ts farm_area_l pop_ind_urb_l_ts pop_ind_rur_l_ts pop_afr_urb_l_ts pop_afr_rur_l_ts pop_l

summ cassava_u100ha_vicon cassava_a100ha_vicon corn_u100ha_vicon corn_a100ha_vicon pop_par_c_four_terr_l $xlist_m1

capture drop d_samp_m1
gen d_samp_m1 = 0
replace d_samp_m1 = 1 if annual_value !=. & pca_soil_l_ts !=.
*only min N

summ cassava_u100ha_vicon cassava_a100ha_vicon corn_u100ha_vicon corn_a100ha_vicon $xlist_m1 if d_samp_m1 == 1
estimates clear

foreach i in "cassava_u100ha_vicon" "cassava_a100ha_vicon" "corn_u100ha_vicon" "corn_a100ha_vicon" {
capture drop c_pan_`i'
capture drop t_pan_`i'
gen c_pan_`i' = 0 
replace c_pan_`i' = 1 if annual_value ==. | pca_soil_l_ts ==. | `i' ==.
bysort cod: egen t_pan_`i' = total(c_pan_`i')
table cod if (year == 2006 | year == 2017), statistic(mean t_pan_`i')
codebook t_pan_`i'
}

*browse cod year annual_value pca_soil_l_ts c_pan t_pan
*there are 7 cases of attrition (16 years with missing)
*to avoid attrition, must require both d_samp_m1 == 1 & t_pan == 15

foreach y in "cassava_u100ha_vicon" "cassava_a100ha_vicon" "corn_u100ha_vicon" "corn_a100ha_vicon" {
xtreg `y' pop_par_c_four_terr $xlist_m1 if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan_`y' == 15, fe vce(cluster cod)
estimates store pop_f_`y'
}

***(2) BRKDW
foreach y in "cassava_u100ha_vicon" "cassava_a100ha_vicon" "corn_u100ha_vicon" "corn_a100ha_vicon" {
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
xtreg `y' `j' $xlist_m1 if (year == 2006 | year == 2017) & d_samp_m1 == 1 & t_pan_`y' == 15, fe vce(cluster cod)

local name = substr("`j'",1,10) + "_" + substr("`y'",1,10)
estimates store `name'
}
}

esttab pop_* using "FE_mecha1_c_vicon_05_11_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace



****Social determinant 2: primmary care

global xlist_m2 pib_l idh_m_educ_ts literacy_afr_ts literacy_ind_ts oscs_health_l_ts pbf_familias_l area_mun_l_ts pca_remote_l_ts pop_ind_urb_l_ts pop_ind_rur_l_ts pop_afr_urb_l_ts pop_afr_rur_l_ts pop_l time d_uf*_ts

sum pca_pricare pop_par_c_four_terr $xlist_m2 if year >= 2008


foreach var of varlist pca_pricare ubs esf vaccines_all_types_ages acs {

xtreg `var' pop_par_c_four_terr $xlist_m2 if year >= 2008, fe vce(cluster cod)
*estimates store hpop_four
estimates store m2_`var'
}


esttab m2_* using "FE_mecha2_vars_sep_16_04_25.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

estimates clear
***(2) BRKDW
foreach j in "pop_par_cti" "pop_par_cpa" "pop_par_cuc" "pop_par_cq" {
foreach var of varlist pca_pricare ubs esf vaccines_all_types_ages acs {
xtreg `var' `j' $xlist_m2 if year >= 2008, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'
}
}


*esttab hpop_* using "FE_mecha2_30_10_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

*esttab hpop_* using "FE_mecha2_31_10_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

*esttab hpop_* using "FE_mecha2_04_11_24.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

*esttab hpop_* using "FE_mecha2_26_03_25.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

esttab h_* using "FE_mecha2_varsep_BRDW_16_04_25.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

help esttab

pwcorr ubs pop_census_urban_2010 if year >= 2008, sig

pwcorr vaccines_all_types_ages pop_census_urban_2010 if year >= 2008, sig


***vaccination negative in settle

estimates clear
***(2) BRKDW
gen pop_par_cpa_2016 = pop_par_cpa * d_year_11
gen pop_par_cpa_2017 = pop_par_cpa * d_year_12
gen pop_par_cpa_2018 = pop_par_cpa * d_year_13
gen pop_par_cpa_2019 = pop_par_cpa * d_year_14
gen pop_par_cpa_2020 = pop_par_cpa * d_year_15

xtreg vaccines_all_types_ages pop_par_cpa pop_par_cpa_2016 pop_par_cpa_2017 pop_par_cpa_2018 pop_par_cpa_2019 pop_par_cpa_2020 $xlist_m2 if year >= 2008, fe vce(cluster cod)

table time, statistic(mean pop_up_5_yr)

gen pop_up_5_yr_ts = pop_up_5_yr * time


xtreg vaccines_all_types_ages pop_par_cpa pop_up_5_yr_ts  $xlist_m2 if year >= 2008, fe vce(cluster cod)



local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'


***(2) BRKDW
foreach j in "pop_par_cpa" {
foreach var of varlist vaccines_all_types_ages {
xtreg `var' `j' $xlist_m2 c.pca_remote#c.pop_par_cpa if year >= 2008, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'
}
}


codebook pca_remote if year >= 2008

foreach j in "pop_par_cpa" {
foreach var of varlist vaccines_all_types_ages {
xtreg `var' `j' $xlist_m2 if year >= 2008 & pca_remote <= 0, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'

xtreg `var' `j' $xlist_m2 if year >= 2008 & pca_remote > 0, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'


}
}

foreach j in "pop_par_cpa" {
foreach var of varlist vaccines_all_types_ages {
xtreg `var' `j' $xlist_m2 if year >= 2008 & year <= 2019, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'


}
}

**ubs interactions, worked
foreach j in "pop_par_cpa" {
foreach var of varlist vaccines_all_types_ages {
xtreg `var' `j' $xlist_m2 c.pop_par_cpa#c.ubs if year >= 2008, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'


}
}

codebook ubs if year >= 2008

gen d_ubs = 0
replace d_ubs = 1 if ubs > 0 & ubs !=.

**ubs interactions, worked

foreach j in "pop_par_cpa" {
foreach var of varlist vaccines_all_types_ages {
xtreg `var' `j' $xlist_m2 if year >= 2008 & ubs <= 6, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'

xtreg `var' `j' $xlist_m2 if year >= 2008 & ubs > 6, fe vce(cluster cod)
local name = "h_" + substr("`j'",9,3) + "_" + substr("`var'",1,8)
dis "`name'"
estimates store `name'


}
}


codebook pop_census_urban_2010 if year >= 2008 & ubs <= 6
codebook pop_census_urban_2010 if year >= 2008 & ubs > 6

sum pop_census_urban_2010 if year >= 2008 & ubs <= 6
scalar cv_low = r(sd)/r(mean)
sum pop_census_urban_2010 if year >= 2008 & ubs > 6
scalar cv_high = r(sd)/r(mean)

dis cv_high / cv_low

scalar list



codebook ubs if year >= 2008 & ubs <= 6
codebook ubs if year >= 2008 & ubs > 6

tabstat ubs if year >= 2008 & ubs > 6, s(p95 p99)



codebook pop_par_cpa if year >= 2008 & ubs <= 6
sum pop_par_cpa if year >= 2008 & ubs <= 6
scalar m_M6 = r(mean)
codebook pop_par_cpa if year >= 2008 & ubs > 6
sum pop_par_cpa if year >= 2008 & ubs > 6
scalar m_m6 = r(mean)

dis m_m6/m_M6
scalar list


sum pop_census_urban if year >= 2008 

sum vaccines_all_types_ages if year >= 2008 & pop_census_urban >= 22903.2

sum vaccines_all_types_ages if year >= 2008 & pop_census_urban < 22903.2

gen d_mean = 0
replace d_mean = 1 if pop_census_urban_2010 >= 22903.2

ttest vaccines_all_types_ages if year >= 2008, by(d_mean)
*vaccination higher in rural, so rural not less vaccinated
