/* ECON 120C Problem Set 1  */
/* Question 4 */

clear

/* Open a log file, so that you can keep track of all your work.*/
mydirC  // ignore this line
log using ./log/PS1-Q5-dependency_effect.log, replace

* loading data
use ./data/dependency-effect.dta  

describe

/* a) What percentage of daughters received welfare? */
sum recwelfd

/* Generate a new variable daughter 1 that is equal to 1 if both recwelfd and recwelfm = 1 */
generate daughter1=(recwelfd==1 & recwelfm==1)
sum daughter1

/* Generate a new variable daughter 1 that is equal to 1 if recwelfd = 1 and recwelfm = 0 */
generate daughter0=(recwelfd==1 & recwelfm==0)
sum daughter0


/* b) Linear Probability Model */
regress recwelfd recwelfm, robust
display _b[_cons]+_b[recwelfm]*1
display _b[_cons]+_b[recwelfm]*0


/* c) Probit Model */
probit recwelfd recwelfm, robust 

/* marginal effect at the mean */
margins, dydx(*) atmean

/* average marginal effect is equal to marginal effect in this case*/
display normal(_b[_cons]+_b[recwelfm]*1)
display normal(_b[_cons]+_b[recwelfm]*0)


/* d) include lnfaminc */
regress recwelfd recwelfm lnfaminc, robust
display _b[_cons]+_b[recwelfm]*1+_b[lnfaminc]*9.48
display _b[_cons]+_b[recwelfm]*0+_b[lnfaminc]*9.48

probit recwelfd recwelfm lnfaminc, robust
margins, dydx(*) atmean

/* e) Predicted probability difference when lnfaminc = 10.4631 */
regress recwelfd recwelfm lnfaminc, robust
display _b[_cons]+_b[recwelfm]*1+_b[lnfaminc]*10.4631
display _b[_cons]+_b[recwelfm]*0+_b[lnfaminc]*10.4631

probit recwelfd recwelfm lnfaminc, robust
display normal(_b[_cons]+_b[recwelfm]*1+_b[lnfaminc]*10.4631)
display normal(_b[_cons]+_b[recwelfm]*0+_b[lnfaminc]*10.4631)


/* f) Calculate correctly predicted values from probit model */
predict yhat
estat classification

log close
