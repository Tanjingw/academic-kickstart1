*****************************前言*****************************
*因变量：流动人口社会融合指标*
*核心解释变量：农村产权，城市产权*
*自变量：个体自变量，城市自变量*
*****************************正文*****************************

**第一部分 农村产权对流动人口社会融合的影响
*基准OLS回归（宅基地）
qui reg econ_1 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_econ_1
qui reg econ_2 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_econ_2
qui reg pscy_1 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_pscy_1
qui reg pscy_2 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_pscy_2
esttab OLS_econ_1 OLS_econ_2 OLS_pscy_1 OLS_pscy_2 using OLS011.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

*固定效应稳健性检验
qui reg econ_1 lnzjd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_econ_1
qui reg econ_2 lnzjd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_econ_2
qui reg pscy_1 lnzjd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_pscy_1
qui reg pscy_2 lnzjd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_pscy_2
esttab OLS_econ_1 OLS_econ_2 OLS_pscy_1 OLS_pscy_2 using OLS0111.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

*Probit稳健性检验（宅基地）
qui oprobit econ_1 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto Probit_econ_1
qui oprobit econ_2 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto Probit_econ_2
qui oprobit pscy_1 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto Probit_pscy_1
qui oprobit pscy_2 lnzjd married sex edu scope teacher book doctor tgdp pgdp ,r
est sto Probit_pscy_2
esttab Probit_econ_1 Probit_econ_2 Probit_pscy_1 Probit_pscy_2 using Probit01111.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

*稳健性检验（承包地）
qui reg econ_1 lncbd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_econ_1
qui reg econ_2 lncbd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_econ_2
qui reg pscy_1 lncbd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_pscy_1
qui reg pscy_2 lncbd married sex edu scope teacher book doctor tgdp pgdp i.code ,r
est sto OLS_pscy_2
esttab OLS_econ_1 OLS_econ_2 OLS_pscy_1 OLS_pscy_2 using OLS011111.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

****PSM****
*random number seque*
set seed 10101
gen ranorder = runiform()
sort ranorder
****生成01变量****
g psm01 = 0
replace psm01=1 if lncbd>0
*regress psm 1:1 nearly*
psmatch2 psm01 married sex edu scope teacher book doctor tgdp pgdp, outcome( econ_1 ) n(1) ate ties logit common
psmatch2 psm01 married sex edu scope teacher book doctor tgdp pgdp, outcome( econ_2 ) n(1) ate ties logit common
psmatch2 psm01 married sex edu scope teacher book doctor tgdp pgdp, outcome( pscy_1 ) n(1) ate ties logit common
psmatch2 psm01 married sex edu scope teacher book doctor tgdp pgdp, outcome( pscy_2 ) n(1) ate ties logit common
*PStest*
quietly psmatch2 psm01 married sex edu scope teacher book doctor tgdp pgdp, outcome( econ_1 ) n(1) ate ties logit common
pstest married sex edu scope teacher book doctor tgdp pgdp,both graph
psgraph
*regress psm with other method*
psmatch2 houseincome01 jobdata health old family edudata hkdata green pbook pteacher phospitalr gdp, outcome( pregnant ) n(2) ate ties logit common quietly
psmatch2 houseincome01 jobdata health old family edudata hkdata green pbook pteacher phospitalr gdp, outcome( pregnant ) radius cal(0.01) ate ties logit common quietly
psmatch2 psm01 jobdata health old family edudata hkdata green pbook pteacher phospitalr gdp, outcome( pregnant ) kernel ate ties logit common quietly


**第三部分 城市产权对流动人口社会融合的影响
*基准OLS回归
qui reg econ_1 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_econ_1
qui reg econ_2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_econ_2
qui reg pscy_1 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_pscy_1
qui reg pscy_2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_pscy_2
esttab OLS_econ_1 OLS_econ_2 OLS_pscy_1 OLS_pscy_2 using OLS0211.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)
*固定效应稳健性检验
qui reg econ_1 hosin married sex edu scope teacher book doctor tgdp pgdp i.code,r
est sto OLS_econ_1
qui reg econ_2 hosin married sex edu scope teacher book doctor tgdp pgdp i.code,r
est sto OLS_econ_2
qui reg pscy_1 hosin married sex edu scope teacher book doctor tgdp pgdp i.code,r
est sto OLS_pscy_1
qui reg pscy_2 hosin married sex edu scope teacher book doctor tgdp pgdp i.code,r
est sto OLS_pscy_2
esttab OLS_econ_1 OLS_econ_2 OLS_pscy_1 OLS_pscy_2 using OLS02111.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

*房价收入比二次项分析
qui reg econ_1 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_econ_1
qui reg econ_2 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_econ_2
qui reg pscy_1 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_pscy_1
qui reg pscy_2 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS_pscy_2
esttab OLS_econ_1 OLS_econ_2 OLS_pscy_1 OLS_pscy_2 using OLS021111.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)
*工具变量回归
qui reg econ_1 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS
qui ivregress 2sls econ_1 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto TSLS
qui ivregress liml econ_1 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto LIML
qui ivregress gmm econ_1 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 )
est sto GMM
esttab OLS TSLS IVProbit LIML GMM using chart7.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

qui reg econ_2 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS
qui ivregress 2sls econ_2 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto TSLS
qui ivregress liml econ_2 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto LIML
qui ivregress gmm econ_2 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 )
est sto GMM
esttab OLS TSLS LIML GMM using chart7.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

qui reg pscy_1 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS
qui ivregress 2sls pscy_1 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto TSLS
qui ivregress liml pscy_1 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto LIML
qui ivregress gmm pscy_1 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 )
est sto GMM
esttab OLS TSLS LIML GMM using chart7.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)

qui reg pscy_2 hosin2 hosin married sex edu scope teacher book doctor tgdp pgdp ,r
est sto OLS
qui ivregress 2sls pscy_2 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto TSLS
qui ivregress liml pscy_2 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 ),r
est sto LIML
qui ivregress gmm pscy_2 hosin married sex edu scope teacher book doctor tgdp pgdp ( hosin2 = iv2 )
est sto GMM
esttab OLS TSLS LIML GMM using chart7.rtf,se r2 mtitle star(* 0.10 ** 0.05 *** 0.01)



