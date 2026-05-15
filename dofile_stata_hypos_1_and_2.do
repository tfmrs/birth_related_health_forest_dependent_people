ssc install rbounds
*********Index
******************Test of H.1.a
******************Test of H.1.b
******************Test of H.2





******************Test of H.1.a******************Test of H.1.a
******************Test of H.1.a******************Test of H.1.a
******************Test of H.1.a******************Test of H.1.a
******************Test of H.1.a******************Test of H.1.a

*************Rosenbaum tests
cd "F:\Fluxo_Pesquisa_2025\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"

clear all
log using "replication_check_h1a_with_ranksum.txt", text replace

capture mat drop ex
***14/05/25: the psmatch2_sinasc_year_1sdcal_13_06_24 files are already filtered for 1SD cal, C and T (R checked)
forvalues i = 2018(1)2022 {
foreach k in "psmatch2_sinasc_`i'_1sdcal_13_06_24.txt"{
*foreach k in "psmatch2_sinasc_`i'_1sdcal__06_06_24.txt" {
dis "`k'"
insheet using "`k'", delimiter("#") clear

keep if pop_census_urban_2010 <= 100000 & d_eth_ind !=.

foreach var of varlist x_* {
local varn = subinstr("`var'","x_","_",1)
if ("`var'" == "x_n1" | "`var'" == "x_birthwt") {
replace `var' = "." if `var' == "NA"
}
capture destring `var', replace
capture rename `var' `varn'
}


**[VERY IMPORTANT] _weight [corrects the frequency of untreated usage]
gen _weight_str = _weight
replace ctr_count ="." if ctr_count=="NA"
destring ctr_count, replace
replace _weight = ctr_count
codebook _weight if d_eth_ind == 0

dis "`i'"
gen delta = birthwt - _birthwt if _treated == "Treated" & _support == "On support"
rbounds delta if pop_census_urban_2010 <= 100000, gamma (1 (0.01) 2)

ranksum birthwt if year == `i' & pop_census_urban_2010 <= 100000, by(d_eth_ind)

ttest birthwt if year == `i' & pop_census_urban_2010 <= 100000, by(d_eth_ind)


}
}





******************Test of H.1.b******************Test of H.1.b
******************Test of H.1.b******************Test of H.1.b
******************Test of H.1.b******************Test of H.1.b
******************Test of H.1.b******************Test of H.1.b

***********************Match pairs, 09/01/25

clear all

*without FCTI 02/01/25
global zlist_h3 pca_soil dist_roads dist_sede_100milhab slope_pct25 slope_pct50 slope_pct75 

clear all

capture mat drop ex ex2
forvalues i = 2018(1)2022 {

dis "`i'"
insheet using "matching_match2003pppb99_treat_only_BWdiff_`i'_11_01_25.txt", delimiter("#") clear case

drop pair_id X_id X_n1
*keep if pop_census_urban_2010 <= 100000 & d_eth_ind !=.

gen d_fcti = 0
replace d_fcti = 1 if fc_ti > 0

psmatch2 d_fcti if year == `i', outcome(diff_birthwt) mahalanobis($zlist_h3) ai(1) altvariance

outsheet using "rematch_pairs_diff_BW_`i'_11_01_25.txt", delimiter("#") replace
}


***********************Match pairs match, 11/01/25

clear all

*without FCTI 02/01/25
*global xlist clinics literacy_rate_ts pib mother_age d_mother_married d_mother_single d_mother_widow d_mother_divorced d_mother_educ_1to3 d_mother_educ_4to7 d_mother_educ_8to11 d_mother_educ_12ab mother_lbirth mother_sbirth d_mother_7antenatal d_child_fem d_child_anomaly d_preg_mult c_birth_covid cov_inf_r cov_let_r d_month_1 d_month_2 d_month_3 d_month_4 d_month_5 d_month_6 d_month_7 d_month_8 d_month_9 d_month_10 d_month_11 d_uf_1 d_uf_2 d_uf_3 d_uf_4 d_uf_5 d_uf_6 d_uf_7 d_uf_8
*global xlist_18_19 clinics literacy_rate_ts pib mother_age d_mother_married d_mother_single d_mother_widow d_mother_divorced d_mother_educ_1to3 d_mother_educ_4to7 d_mother_educ_8to11 d_mother_educ_12ab mother_lbirth mother_sbirth d_mother_7antenatal d_child_fem d_child_anomaly d_preg_mult d_month_1 d_month_2 d_month_3 d_month_4 d_month_5 d_month_6 d_month_7 d_month_8 d_month_9 d_month_10 d_month_11 d_uf_1 d_uf_2 d_uf_3 d_uf_4 d_uf_5 d_uf_6 d_uf_7 d_uf_8

capture cd "E:\Fluxo_Pesquisa_2023\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "G:\Fluxo_Pesquisa_2023\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "E:\BKP_11_11_24\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "C:\Users\tf415\OneDrive - University of Exeter\Desktop\Luke\Matching_pairs_10_01_25"
capture cd "D:\projetos\Transatlantic\2025"

capture mat drop exd
forvalues i = 2018(1)2022 {

dis "`i'"
insheet using "psmatch2_sinasc_paired_`i'_1sdcal_11_01_25.txt", delimiter("#") clear

table d_fcti

ttest diff_birthwt if year == `i', by(d_fcti)
mat exd  = nullmat(exd) \  r(mu_1), r(mu_2),  r(mu_1) - r(mu_2), r(p), r(N_1), r(N_2)
}

*************Rosenbaum test

capture cd "E:\BKP_11_11_24\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
clear
capture mat drop exd
 
capture drop mat ex
forvalues i = 2018(1)2022 {

dis "`i'"
insheet using "psmatch2_sinasc_paired_`i'_1sdcal_11_01_25.txt", delimiter("#") clear

foreach var of varlist matchres d_pair_out x_weight ctr_count x_diff_birthwt {
capture replace `var' ="." if `var' == "NA"
capture destring `var', replace	
}

gen _weight_str = x_weight
replace _weight = ctr_count
codebook _weight if d_fcti == 0

table x_treated d_fcti 

dis "`i'"
gen delta = diff_birthwt - x_diff_birthwt if x_treated == "Treated" & x_support == "On support"
rbounds delta if ((d_fcti == 0 & matchres ==1) |(d_fcti == 1 & d_pair_out == 0)), gamma (1 (0.01) 2)

ranksum diff_birthwt if year == `i', by(d_fcti)
mat ex  = nullmat(ex) \     r(z) ,  r(p_exact), r(N_1), r(N_2)
}


*************20/01/25 qual check paired match

clear all

capture cd "E:\Fluxo_Pesquisa_2023\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "G:\Fluxo_Pesquisa_2023\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "E:\BKP_11_11_24\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "C:\Users\tf415\OneDrive - University of Exeter\Desktop\Luke\Matching_pairs_10_01_25"
capture cd "D:\projetos\Transatlantic\2025"

global zlist_h3 pca_soil dist_roads dist_sede_100milhab slope_pct25 slope_pct50 slope_pct75 

capture mat drop exd
forvalues i = 2018(1)2022 {

dis "`i'"
insheet using "psmatch2_sinasc_paired_`i'_1sdcal_20_01_25_qual_check.txt", delimiter("#") clear case

foreach var of varlist matchres d_pair_out X_weight ctr_count {
replace `var' ="." if `var' == "NA"
destring `var', replace	
}

gen _weight_str = X_weight
replace _weight = ctr_count
codebook _weight if d_fcti == 0

table d_fcti

pstest $zlist_h3, both t(d_fcti) mweight(X_weight) label scatter 

dis "`i'"
table d_fcti
table d_fcti if ((d_fcti == 0 & matchres ==1) |(d_fcti == 1 & d_pair_out == 0))
}

count if d_fcti == 0
count if d_fcti == 0 & matchres == 1


*************Test of H2*************Test of H2*************Test of H2*************Test of H2
*************Test of H2*************Test of H2*************Test of H2*************Test of H2
*************Test of H2*************Test of H2*************Test of H2*************Test of H2
*************Test of H2*************Test of H2*************Test of H2*************Test of H2



clear all
use dbWW_LP_23_01_25

replace apgar5 = "." if apgar5 =="NA"
destring apgar5, replace

***counting local nascimento
tab locnasc year, missing
return list
dis _N
dis 1954293 / 1971915

forvalues i = 2018(1)2022 {
count if locnasc <= 2 & year == `i'
scalar N1 = r(N)
count if year == `i'
scalar N2 = r(N)
dis `i'
dis N1/N2	
}

browse apgar*


forvalues i = 2018(1)2022 {
count if apgar1 ==. & locnasc > 2 & year == `i'
scalar N1 = r(N)
count if apgar5 ==. & locnasc > 2 & year == `i'
scalar N2 = r(N)
count if year == `i' & locnasc > 2 
scalar N3 = r(N)
dis `i'
dis "rate of miss, apgar 1"
dis N1/N2	
dis "rate of miss, apgar 5"
dis N2/N3	
}



***Removing years not used
table year
*keep if (year == 2019 | year == 2020)
keep if (year == 2019 | year == 2020 | year == 2021)
table year

capture drop d_apgar1_b8
gen d_apgar1_a7 = 0
replace d_apgar1_a7 = 1 if apgar1 >= 7
replace d_apgar1_a7 =. if apgar1 ==99

capture drop d_apgar5_b8
gen d_apgar5_a7 = 0
replace d_apgar5_a7 = 1 if apgar5 >= 7
replace d_apgar5_a7 =. if apgar5 ==99

*tab d_apgar1_b8 apgar1
*tab d_apgar5_b8 apgar5


tab month_year
replace month_year = "0" + month_year if strlen(month_year) == 6
tab month_year 
capture cd "G:\Fluxo_Pesquisa_2023\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
capture cd "E:\BKP_11_11_24\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"

joinby month_year using "month_count_calendar_11_05_24", unmatched(both) _merge(_merge_running)
tab _merge_running

joinby cod6 using "month_pandemics_started_by_mun_11_05_24", unmatched(both) _merge(_merge_started)
tab _merge_started
* dis 4830 + 771
*5601; so muns out are out of AML
drop if _merge_started !=3

gen c_birth_covid_month = cod_month - covid_cod_month


***highest COVID19 peak 

*clear all
*capture cd "E:\BKP_11_11_24\Luke\Luke_AMZ_disaster\dados\data_proj_execution\Recollection_05_05_23"
*insheet using "db_top_peak_covid_23_01_25.txt", delimiter(" ") case
*rename prikey rownames
*rename c_birth_topeak prikey
*rename d_birth_topeak c_birth_topeak
*rename v4 d_birth_topeak
*save "db_top_peak_covid_23_01_25", replace


joinby prikey using "db_top_peak_covid_23_01_25.dta", unmatched(both) _merge(_merge_covmaxpeak)
tab _merge_covmaxpeak
tab year _merge_covmaxpeak, missing
*all only in using are out of 2019-2021
drop if _merge_covmaxpeak !=3

*Attention: codes changed as now we have 2018 (21/01/25)
tab cod_sinasc if dtnasc == 1012019
*373
browse dtnasc if cod_sinasc == 373
*ok
tab cod_sinasc if dtnasc == 31122020
*1116
browse dtnasc if cod_sinasc == 1116
*ok
tab cod_sinasc if dtnasc == 31122021
*1488
browse dtnasc if cod_sinasc == 1488
*ok

****Outliers of BW
tabstat birthwt if cod_sinasc>=373 & cod_sinasc<=1116, s(min p1 p5 p95 p99 max)
*min very diff from p1, same for p99 and max

*19-21
tabstat birthwt if cod_sinasc>=373 & cod_sinasc<=1488, s(min p1 p5 p95 p99 max)


**Will remove below p1 and above p99
*19-20
gen d_samp_dec20 = 0
replace d_samp_dec20 = 1 if cod_sinasc>=373 & cod_sinasc<=1116 & birthwt >= 1405 & birthwt <=6855


*19-21
gen d_samp_dec21 = 0
replace d_samp_dec21 = 1 if cod_sinasc>=373 & cod_sinasc<=1488 & birthwt >= 1402 & birthwt <=4440


***03/06, racacor newborn
table racacor

gen d_eth_afr = 0
replace d_eth_afr = 1 if racacor =="2"
replace d_eth_afr =. if racacor =="NA"

gen d_eth_ind = 0
replace d_eth_ind = 1 if racacor =="5"
replace d_eth_ind =. if racacor =="NA"

***05/06, racacor mother
gen d_eth_m_afr = 0
replace d_eth_m_afr = 1 if racacormae =="2"
replace d_eth_m_afr =. if racacormae =="NA"

gen d_eth_m_ind = 0
replace d_eth_m_ind = 1 if racacormae =="5"
replace d_eth_m_ind =. if racacormae =="NA"


gen pop_par_c_four_terr_s = pop_par_c_four_terr / (pop_census_tot_2010 - pop_census_urban_2010)
gen pop_par_c_four_terr_s_tot = pop_par_c_four_terr / pop_census_tot_2010

codebook pop_par_c_four_terr_s
*codebook pop_par_c_four_terr_s if d_samp == 1
tab cod if pop_par_c_four_terr_s > 1 & pop_par_c_four_terr_s  !=.
*Amazonas and Roraima
tab cod if pop_par_c_four_terr > pop_census_tot_2010 & pop_par_c_four_terr !=.
*None
codebook pop_par_c_four_terr_s_tot
*Let's use share in total pop as avoids the two muns issue (which is in fact explainable, but better having no issue, as it is mainly due to the unreasonable definition of rur/urb of IBGE)

*sample sizes
table year if cod6 !=120040 & cod6 !=160030& cod6 !=130260& cod6 !=211130& cod6 !=510340& cod6 !=150140& cod6 !=110020& cod6 !=140010 & cod6 !=172100

table year if pop_census_urban_2010 <= 100000


save data_stata_hypo_2

****Models
*log using "w&w_regress_11_05_24.txt", text

global xlist clinics literacy_rate_ts pib mother_age d_mother_married d_mother_single d_mother_widow d_mother_divorced d_mother_educ_1to3 d_mother_educ_4to7 d_mother_educ_8to11 d_mother_educ_12ab mother_lbirth mother_sbirth d_mother_7antenatal d_child_fem d_child_anomaly d_preg_mult d_month_1 d_month_2 d_month_3 d_month_4 d_month_5 d_month_6 d_month_7 d_month_8 d_month_9 d_month_10 d_month_11 d_uf_1 d_uf_2 d_uf_3 d_uf_4 d_uf_5 d_uf_6 d_uf_7 d_uf_8 d_year_3 d_year_4

gen fc_ti = pop_par_cti / pop_census_tot_2010
gen d_fcti = 0
replace d_fcti = 1 if fc_ti > 0

*19-20
sum  birthwt d_apgar1_a7 d_apgar5_a7 d_birth_covid c_birth_covid pop_par_c_four_terr fc_ti d_fcti  $xlist if d_samp_dec20 == 1

*19-21
sum  birthwt d_apgar1_a7 d_apgar5_a7 d_birth_covid c_birth_covid pop_par_c_four_terr fc_ti d_fcti  $xlist if d_samp_dec21 == 1

*19-21 with maxpeak for pp
sum  birthwt d_apgar1_a7 d_apgar5_a7 d_birth_topeak c_birth_topeak d_birth_nepeak pop_par_c_four_terr fc_ti d_fcti $xlist dist_mun_b_n  if d_samp_dec21 == 1 & d_apgar1_a7 !=. & d_apgar5_a7 !=.


***20/01/25: correl days since first case in region vs income
browse keyyear cod cod_sinasc dtnasc horanasc covid_date covid_cod covid_date_sinasc
summ covid_cod
tab covid_cod if covid_date == "28/02/2020"
tab covid_date if covid_cod == 803
*This is the date of first COVID19 occurrence
*First on or after 26/02 is 28/02, 803

tab dtnasc if cod_sinasc == 803
browse dtnasc if cod_sinasc == 803
*803 is also 28/02/2020 in sinasc

sort covid_cod 
browse covid_date

*both covid_cod and cod_sinasc starting approximately at the same day (no problem if not, statistically)

capture drop c_birth_covid_aml
gen c_birth_covid_aml = cod_sinasc - 803

pwcorr c_birth_covid_aml pibpc, sig
*4% significance, so evidence of endogeneity not strong

capture drop d_bir_covaml
gen d_bir_covaml = 0
replace d_bir_covaml = 1 if c_birth_covid_aml > 0
tab d_bir_covaml if d_samp_dec20 == 1, missing
*%40-60 split

***********neapeak
codebook c_birth_topeak if d_samp_dec20 == 1 & pop_census_urban_2010 <= 100000

capture drop d_birth_nepeak
gen d_birth_nepeak = 0
replace d_birth_nepeak = 1 if c_birth_topeak >= -7 & c_birth_topeak <= 7

tab d_birth_nepeak d_birth_covid if d_samp_dec20 == 1 & pop_census_urban_2010 <= 100000, chi2 exact
help tab


estimates clear
*log using "ww_21_01_25_20h52.txt", text
*log using "ww_22_01_25_07h44.txt", text
*log using "ww_24_01_25_18h42.txt", text
*log using "ww_24_01_25_18h55.txt", text
*log using "ww_24_01_25_19h59.txt", text
*log using "ww_27_01_25_08h50.txt", text
log using "ww_27_01_25_09h18.txt", text

********First wave (01/01/2020 to 31/07/2020) vs3: without highly urbanized (<100khab) and up to Dec.2020
foreach y in "birthwt" "d_apgar1_a7" "d_apgar5_a7" {
foreach treat in "d_birth_topeak" "c_birth_topeak" "d_birth_nepeak" {
*19-20
*regress `y' `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist if d_samp_dec20 == 1 & pop_census_urban_2010 <= 100000 , vce(cluster cod)  
*19-21
regress `y' `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist if d_samp_dec21 == 1 & pop_census_urban_2010 <= 100000 , vce(cluster cod)  
test `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist
estimates store f`y'_`treat'
}
}


*esttab f* using "W&W_OLS_below100urbpop_23_01_25_Jan19Dec21_COVIDtopeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace
*esttab f* using "W&W_OLS_below100urbpop_23_01_25_Jan19Dec21_COVIDtopeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace
esttab f* using "W&W_OLS_below100urbpop_27_01_25_Jan19Dec21_COVIDtopeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace


********03/12, LBW
*Rocha & Soares: < 2500 g, but also < 1500 g  --> there was no effect of COVID and int in P(<2.51)
*Rangel & Volg, low < 2500 g, very low < 1500 g
*Chacon-Montalvan, low < 2500 g

gen d_lbw  = 0
replace d_lbw  = 1 if birthwt < 2500

gen d_vlbw  = 0
replace d_vlbw  = 1 if birthwt < 1500

estimates clear
foreach y in "d_lbw" "d_vlbw" {
foreach treat in "d_birth_topeak" "c_birth_topeak" "d_birth_nepeak" {
regress `y' `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist if d_samp_dec21 == 1 & pop_census_urban_2010 <= 100000, vce(cluster cod)  
test `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist
estimates store lbw_`y'_`treat'
}
}

*esttab lbw_* using "FC_LBW_OLS_24_01_25_topeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

*esttab lbw_* using "FC_LBW_OLS_24_01_25_topeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

esttab lbw_* using "FC_LBW_OLS_27_01_25_topeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace



**********Travelling mothers
browse cod cod6 codmunnasc codmunnatu
replace codmunnatu ="." if codmunnatu =="NA"
destring codmunnatu, replace
browse cod cod6 codmunnasc codmunnatu

*clear all
*insheet using "G:/Fluxo_Pesquisa_2023/Luke/Luke_AMZ_disaster/dados/data_proj_execution/geoproc_out/muncentroids_13_05_24_(from_remoteness_metric).txt", delimiter("#")
*rename cod6 codmunnasc
*save "centroids_codmunnasc", replace
*rename codmunnasc codmunnatu
*rename point_x point_x_natu
*rename point_y point_y_natu
*save "centroids_codmunnatu", replace

joinby codmunnasc using "centroids_codmunnasc", unmatched(both) _merge(_merge_nasc)
table _merge_nasc
drop if _merge_nasc != 3
table _merge_nasc

joinby codmunnatu using "centroids_codmunnatu", unmatched(both) _merge(_merge_natu)
table _merge_natu
drop if _merge_natu != 3
table _merge_natu

gen dist_mun_b_n = sqrt((point_x - point_x_natu)^2 + (point_y - point_y_natu)^2)
codebook dist_mun_b_n

estimates clear

********First wave (01/01/2019 to 31/07/2020): extensive
foreach y in "birthwt" "d_apgar1_a7" "d_apgar5_a7" {
foreach treat in "d_birth_topeak" "c_birth_topeak" "d_birth_nepeak" {
regress `y' `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr  $xlist dist_mun_b_n if d_samp_dec21 == 1 & pop_census_urban_2010 <= 100000 & codmunnasc != codmunnatu & dist_mun_b_n !=., vce(cluster cod)  
test `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr  $xlist dist_mun_b_n
local name = "tr_" + substr("`y'",1,8) + "_" + "`treat'"
estimates store `name'
}
}


*sample size count 
count if d_samp_dec20 == 1 & pop_census_urban_2010 <= 100000 & codmunnasc != codmunnatu & dist_mun_b_n !=.


*esttab tr_* using "W&W_OLS_travelling_mothers_24_01_25_topeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

*esttab tr_* using "W&W_OLS_travelling_mothers_24_01_25_topeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

esttab tr_* using "W&W_OLS_travelling_mothers_27_01_25_topeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace


estimates clear

****LBW
foreach y in d_lbw d_vlbw {
foreach treat in "d_birth_topeak" "c_birth_topeak" "d_birth_nepeak" {
regress `y' `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist dist_mun_b_n if d_samp_dec21 == 1 & pop_census_urban_2010 <= 100000 & codmunnasc != codmunnatu & dist_mun_b_n !=., vce(cluster cod)  
test `treat' c.`treat'#c.pop_par_c_four_terr pop_par_c_four_terr $xlist dist_mun_b_n
local name = "trl_" + substr("`y'",1,8) + "_" + "`treat'"
estimates store `name'
}
}

*esttab trl_* using "FC_LBW_OLS_24_01_25_travelled_mothers_topeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace
*esttab trl_* using "FC_LBW_OLS_24_01_25_travelled_mothers_topeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

esttab trl_* using "FC_LBW_OLS_27_01_25_travelled_mothers_topeak_nepeak.txt", se scalars(N chi2 F ll ll_0 p r2_a r2_o r2_w r2_b N_clust) nolines nogaps star(+ 0.10 * 0.05 ** 0.01 *** 0.001) varwidth(41) replace

