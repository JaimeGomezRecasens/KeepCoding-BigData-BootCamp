libname datos '/home/jaimegomezrecase0/my_courses/JaimeGomez/Practica';

/* Cargamos los datos. Borramos las columnas "duration" y "drop" y renombramos aquellas
que tienen "." para que no nos den problemas. Por último, transformamos la variable
objetivo. */
data bankmarketing (drop=duration drop=default 'emp.var.rate'n 'cons.price.idx'n 'cons.conf.idx'n 'nr.employed'n y);
	set datos.bank_additional_full;
	emp_var_rate = 'emp.var.rate'n;
	cons_price_idx = 'cons.price.idx'n; 
	cons_conf_idx = 'cons.conf.idx'n;
	nr_employed = 'nr.employed'n;

	if education = "unknown" then delete;
	if marital = "unknown" then delete;
	if default = "unknown" then delete;
	if job = "unknown" then delete;
	if housing = "unknown" then delete;
	if loan = "unknown" then delete;

	IF (y="yes") THEN yInt = 1; else yInt = 0;
run;

/*Análisis de frecuencias*/
PROC FREQ DATA=bankmarketing; RUN;

/* Agrupamos y categorizamos nuestras variables categóricas*/
data bankmarketing;
	set bankmarketing;
	if age <= 25 then age = 1;      			  
	else if 25 < age <= 35 then age = 2; 
	else if 35 < age <= 45 then age = 3; 
	else if 45 < age <= 55 then age = 4; 
	else if 55 < age <= 65 then age = 5; 
	else age = 6; /* > de 65 */
run;
data bankmarketing;
	set bankmarketing;
	if job = 'admin.' then job = 1;
	else if job = 'blue-collar' then job = 2;
	else if job = 'entrepreneur' then job = 3;
	else if job = 'housemaid' then job = 4;
	else if job = 'management' then job = 5;
	else if job = 'retired' then job = 6;
	else if job = 'self-employed' then job = 7;
	else if job = 'services' then job = 8;
	else if job = 'student' then job = 9;
	else if job = 'technician' then job = 10;
	else if job = 'unr_employed' then job = 11;
	else if job = 'unknown' then job = 1;
run;
data bankmarketing;
	set bankmarketing;
	if marital = 'divorced' then marital = 1;
	else if marital = 'married' then marital = 2;
	else if marital = 'single' then marital = 3;
	else if marital = 'unknown' then marital = 2;
run;
data bankmarketing;
	set bankmarketing;	
	if education = 'basic.4y' then education = 1;
	else if education = 'basic.6y' then education = 2;
	else if education = 'basic.9y' then education = 3;
	else if education = 'high.school' then education = 4;
	else if education = 'illiterate' then education = 5;
	else if education = 'professional.course' then education = 6;
	else if education = 'university.degree' then education = 7;
	else if education = 'unknown' then education = 8;
run;
data bankmarketing;
	set bankmarketing;
	if housing = 'no' then housing = 1;
	else if housing = 'unknown' then housing = 2;
	else if housing = 'yes' then housing = 3;
run;
data bankmarketing;
	set bankmarketing;
	if loan = 'no' then loan = 1;
	else if loan = 'unknown' then loan = 2;
	else if loan = 'yes' then loan = 3;
run;
data bankmarketing;
	set bankmarketing;	
	if contact = 'cellular' then contact = 1;
	else if contact = 'telephone' then contact = 2;
run;
data bankmarketing;
	set bankmarketing;
	if month = 'mar' then month = 1;
	else if month = 'apr' then month = 2;
	else if month = 'may' then month = 3;
	else if month = 'jun' then month = 4;
	else if month = 'jul' then month = 5;
	else if month = 'aug' then month = 6;
	else if month = 'sep' then month = 7;
	else if month = 'oct' then month = 8;
	else if month = 'nov' then month = 9;
	else if month = 'dec' then month = 10;
run;
data bankmarketing;
	set bankmarketing;	
	if day_of_week = 'mon' then day_of_week = 1;
	else if day_of_week = 'tue' then day_of_week = 2;
	else if day_of_week = 'wed' then day_of_week = 3;
	else if day_of_week = 'thu' then day_of_week = 4;
	else if day_of_week = 'fri' then day_of_week = 5;
run;
data bankmarketing;
	set bankmarketing;	
	if campaign > 3 then campaign = 4;
run;
data bankmarketing;
	set bankmarketing;
	if pdays = 999 then pdays = 0; /*NO ha sido contactado*/
	else pdays = 1;                /*SÍ ha sido contactado*/
run;
data bankmarketing;
	set bankmarketing;
	if poutcome = 'failure' then poutcome = 1;
	else if poutcome = 'nonexistent' then poutcome = 2;
	else if poutcome = 'success' then poutcome = 3;
run;
data bankmarketing;
	set bankmarketing;
	if previous > 0 then previous = 1; /*contactado*/	
run;
data bankmarketing;
	set bankmarketing;
	if emp_var_rate <= -1.9 then emp_var_rate = 1;
	else if -1.9 < emp_var_rate <= -0.1 then emp_var_rate = 2;
	else emp_var_rate = 3;
run;
data bankmarketing;
	set bankmarketing;
	if cons_price_idx <= 93 then cons_price_idx = 1;
	else if 93 < cons_price_idx < 94.2 then cons_price_idx = 2;
	else cons_price_idx = 3;
run;
data bankmarketing;
	set bankmarketing;
	if cons_conf_idx <= -46.8 then cons_conf_idx = 1;
	else if -46.8 < cons_conf_idx < -34.8 then cons_conf_idx = 2;
	else cons_conf_idx = 3;
run;
data bankmarketing;
	set bankmarketing;
	if euribor3m < 1.25 then euribor3m = 1;
	else if 1.25 <= euribor3m < 3.95 then euribor3m = 2;
	else if 3.95 <= euribor3m < 4.85 then euribor3m = 3;
	else euribor3m3m = 4;
run;
data bankmarketing;
	set bankmarketing;
	if nr_employed < 5091 then nr_employed = 1;
	else if 5091 <= nr_employed <= 5181 then nr_employed = 2;
	else if 5181 < nr_employed <= 5217 then nr_employed = 3;
	else nr_employed = 4;
run;

/* Macro para crear variables Dummy */
%macro crearDummy (t_input, nomvar, nomarray, numNiveles);
*Ordenar las categorias de la variable(s) dummy;
proc sort data=&t_input.; BY &nomvar.; run;

*Creacion de variables dummy o variables ficticias ;
data &t_input. (drop=i &nomvar.);
 set &t_input.;
 array &nomarray.(&numNiveles.);	  
  do i=1 to &numNiveles.;	 
   if &nomvar. = i then &nomarray.(i)= 1; else &nomarray.(i)= 0;
  end;
%mend;

/* Creamos nuestras variables Dummy */
%crearDummy (bankmarketing, age, edad_, 6);
%crearDummy (bankmarketing, job, job_, 11);
%crearDummy (bankmarketing, marital, marital_, 3);
%crearDummy (bankmarketing, education, education_, 8);
%crearDummy (bankmarketing, housing, housing_, 3);
%crearDummy (bankmarketing, loan, loan_, 3);
%crearDummy (bankmarketing, contact, contact_, 2);
%crearDummy (bankmarketing, month, month_, 10);
%crearDummy (bankmarketing, day_of_week, day_of_week_, 5);
%crearDummy (bankmarketing, poutcome, poutcome_, 3);
%crearDummy (bankmarketing, campaign, campaign_, 4);
%crearDummy (bankmarketing, emp_var_rate, emp_var_rate_, 3);
%crearDummy (bankmarketing, cons_price_idx, cons_price_idx_, 3);
%crearDummy (bankmarketing, cons_conf_idx, cons_conf_idx_, 3);
%crearDummy (bankmarketing, euribor3m3m, euribor3m3m_, 4);
%crearDummy (bankmarketing, nr_employed, nr_employed_, 4);

/* Macro regresión logísitca */
%macro logistic (t_input, vardepen, varindep, interaccion, semi_ini, semi_fin );
ods trace on /listing;
%do semilla=&semi_ini. %to &semi_fin.;

 ods output EffectInModel= efectoslog;/*Test de Wald de efectos en el modelo*/
 ods output FitStatistics= ajustelog; /*"Estadisticos de ajuste", AIC */
 ods output ParameterEstimates= estimalog;/*"Estimadores de parametro"*/
 ods output ModelBuildingSummary=modelolog; /*Resumen modelo, efectos*/
 ods output RSquare=ajusteRlog; /*R-cuadrado y Max-rescalado R-cuadrado*/

 proc logistic data=&t_input. EXACTOPTIONS (seed=&semilla.) ;
  class &varindep.; 
  model &vardepen. = &varindep. &interaccion. 
     / selection=stepwise details rsquare NOCHECK;
 run;

 data un1; i=12; set efectoslog; set ajustelog; point=i; run;
 data un2; i=12; set un1; set estimalog; point=i; run;
 data un3; i=12; set un2; set modelolog; point=i; run;
 data union&semilla.; i=12; set un3; set ajusteRlog; point=i; run;

 proc append  base=t_models  data=union&semilla.  force; run;
 proc sql; drop table union&semilla.; quit; 

%end;
ods html close; 
proc sql; drop table efectoslog,ajustelog,ajusteRlog,estimalog,modelolog; quit;

%mend;

ods noresults;
%logistic (bankmarketing, yInt, edad_1-edad_6 job_1-job_11 marital_1-marital_3
           education_1-education_8 housing_1-housing_3 loan_1-loan_3 contact_1-contact_2 month_1-month_10 
           day_of_week_1-day_of_week_5 campaign_1-campaign_4 previous poutcome_1-poutcome_3 pdays 
           emp_var_rate_1-emp_var_rate_3 cons_price_idx_1-cons_price_idx_3 cons_conf_idx_1-cons_conf_idx_3 
           euribor3m3m_1-euribor3m3m_4 nr_employed_1-nr_employed_4, ,12345, 12354);
ods results;

/* No sé por qué falla esto */
/*Analisis de los resultados obtenidos de la macro*/
/*
proc freq data=t_models (keep=effect ProbChiSq);  tables effect*ProbChiSq /norow nocol nopercent; run;
proc sql; select distinct * from t_models (keep=effect nvalue1 rename=(nvalue1=RCuadrado)) order by RCuadrado desc; quit;
proc sql; select distinct * from t_models (keep=effect StdErr) order by StdErr; quit;
*/

/*** CURVA ROC ***/
ods graphics on;

proc logistic data=bankmarketing desc  PLOTS(MAXPOINTS=NONE); 
 class job_1 job_2 job_10 nr_employed_1 nr_employed_2 education_4 education_7
 	   marital_1 month_4 pdays;
 model yInt = job_1 job_2 job_10 nr_employed_1 nr_employed_2 education_4 education_7
 	   marital_1 month_4 pdays
 /ctable pprob = (.05 to 1 by .05)  outroc=roc; 
run;

/* macro redes neuronales:
	t_input  = Tabla Input
	vardepen = Variable Dependiente
	nparam   = Numero de Parametros
	nnodos   = Numero de Nodos
	semi_ini = Valor Inicial de la semilla
	semi_fin = Valor Final de la semilla
	factiva = funcion de activacion (tanh=tangente hiperbolica; LIN=funcion de activacion lineal).NORMALMENTE PARA DATOS NO LINEALES MEJOR ACT=TANH
	varindep = Variable(s) Independiente(s)
*/

/* Tampoco sé por qué no funcionan las redes neuronales */
/*
%macro cruzaneural(t_input,vardepen,nparam,nnodos, semi_ini, semi_fin, factiva, varindep );
data t_output;run;
%do semilla=&semi_ini. %to &semi_fin.;
data dos;set &t_input.; u=ranuni(&semilla.); run;
proc sort data=dos; by u; run;

data dos;
retain grupo 1;
set dos nobs=nume;
if _n_>grupo*nume/&nparam. then grupo=grupo+1;
run;

data fantasma;run;
%do exclu=1 %to &nparam.;
data trestr tresval;
set dos;if grupo ne &exclu. then output trestr; else output tresval; run;

PROC DMDB DATA=trestr dmdbcat=catatres;
target &vardepen.;
var &vardepen. &varindep.; run;

proc neural data=trestr dmdbcat=catatres random=789 
validata=tresval;
input &varindep.;

target &vardepen.;
hidden &nnodos. / act=&factiva.;
prelim 30;
train maxiter=1000 outest=mlpest technique=dbldog;
score data=tresval role=valid out=sal ;
run;

data sal;set sal;resi2=(p_&vardepen.-&vardepen.)**2;run;
data fantasma;set fantasma sal;run;
%end; 
proc means data=fantasma sum noprint;var resi2;
output out=sumaresi sum=suma;
run;
data sumaresi;set sumaresi;semilla=&semilla.;
data t_output (keep=suma semilla);set t_output sumaresi;if suma=. then delete;run;
%end; 
proc sql; drop table dos,trestr,tresval,fantasma,mlpest,sumaresi,sal,_namedat; quit;
%mend;
*/

/* Modelo 1: 
   con funcion de activacion tangente hiperbolica,
   metodo de particion validacion cruzada, con 4 nodos y 5 semillas. 
*/
/*
%cruzaneural(bankmarketing, yInt, 4, 4, 12341, 12345, tanh, 
             age job_1-job_11 marital_1-marital_3 education_1-education_8
             housing_1-housing_3 loan_1-loan_3 contact_1-contact_2
             month_1-month_10 day_of_week_1-day_of_week_5 emp_var_rate cons_price_idx cons_conf_idx 
             euribor3m3m nr_employed);
data modelo1; set t_output; modelo='Modelo 1'; run;
*/