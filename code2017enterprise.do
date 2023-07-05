************************************************************
***The Bolivia 2017 Enterprise Surveys Data Set ***
************************************************************
{
/*Entorno de trabajo*/
	clear all
	cls
	cd "G:\Mi unidad\Enterprise Survey Bolivia\2017enterprise" // Link Oficina y Casa
	set more off
	*use "Bolivia-2017-full-data.dta"
	use "G:\Mi unidad\Enterprise Survey Bolivia\2017enterprise\Bolivia-2017-full-data.dta" 
}

{
    /*Descripcion de variables*/
	* 311 variables, 364 observaciones
		*a15a1ax	str50   Main Respondent Position In The 	Firm
		*a15a2a		byte    Main Respondent Years Working In The Firm:
		*a15a3		byte    Main Respondent's Gender
	* % of Sales: National, Indirect Exports, Direct Exports by(Industry Sector)
	tabstat d3a d3b d3c, by(a4b)
	* % To What Degree Is The Following Is Effective: Legal System?
	tab ASCd18f
	* % How Much Of An Obstacle: Customs And Trade Regulations? 
	tab d30b
	* Does This Establishment Compete Against Unregistered Or Informal Firms?
	tab e11
	* Which Practices Of Informal Firms Affects This Establishment The Most?
	* Other (Specify) 
	tab ASCe12 
	tab ASCe12x
	
	tab a4b e30
	* ¿Durante el último año fiscal, el establecimiento gastó en investigación y desarrollo (excluida la investigación de mercado)?
	tab h8
	* The Court System Is Fair, Impartial And Uncorrupted
	tab h7a
	* How Much Of An Obstacle: Tax Rates 
	tab j30a // j30a j30b j30c j30e j30f
	* How Much Of An Obstacle: Labor Regulations? 
	tab l30a
	* Biggest Obstacle Affecting The Operation Of This Establishment
	tab m1a
	* Total labor cost by(Industry Sector)
	tabstat n2a, by(a4b)

	* number of employees
	graph hbar (mean) b6 if b6>0, over(a4b)  ytitle("Number of employees")  title("Number of  full time employees")
	* total sales last fiscal year
	gen d2gg = d2/1000000

	set scheme s2color
	graph pie if d13 > 0, over(d13) title("Material inputs and supplies imported directly") legend(on) clegend(region(fcolor(yellow) lalign(center)))
	
	graph pie if ASCn3 > 0, over(ASCn3 ) title("The price for main good or service change?") legend(on) clegend(region(fcolor(yellow) lalign(center)))
	
	graph hbar (count) if ASCn5>0, over(ASCn5) over(a6a) title(Main reasons for price change)
	
tabstat d3a d3b d3c, by(a4b)
tabstat d3a d3b d3c, by(a4a)
tabstat d3a d3b d3c, by(a6a)	
	
	
	* Obstaculos en el transporte
	graph hbar (count) if d30a>0, over(d30a) title(How much of an obstacle: Transport)
	
	graph hbar (count) if d30a>0, over(d30a) over(a4a) title(How much of an obstacle: Transport)
		* Obstaculos en la customs and trade regulations
	graph hbar (count) if e30>0, over(e30) title(Practices of competitors in informal sectors)
	
		* Obstaculos en la customs and trade regulations
	graph hbar (count) if d30b>0, over(d30b) title(Customs and trade regulations)
	
		* Which Practices Of Informal Firms Affects This Establishment The Most? 
	graph hbar (count) if ASCe12>0, over(ASCe12) title(Informal Firms Affects)
	
	*** RD Reserarch Development
	gen h9gg = h9/1000000
		graph hbar (mean) h9gg if h9gg>0, over(a4b)  ytitle("R&D")  title("Spent on R&D (Millions of Bs)")
				graph hbar (mean) h9gg if h9gg>0, over(a4a)  ytitle("R&D")  title("Spent on R&D (Millions of Bs)")
								graph hbar (mean) h9gg if h9gg>0, over(a6a)  ytitle("R&D")  title("Spent on R&D (Millions of Bs)")
	
	
	
			* Obstaculos acces to land
	graph hbar (count) if g30a>0, over(g30a) title(Access to land)
	
			* Obstaculos Crime, Theft and Disorder
	graph hbar (count) if i30>0, over(i30) title("Crime, theft and disorder")
	
			* Obstaculos Acces to finance
	graph hbar (count) if k30>0, over(k30) title("Acces to finance")	
	
	
	
				*1 Obstaculos Tax rates
	graph hbar (count) if k30>0, over(k30) title("Tax rates")	
				*2 Obstaculos Tax administrations
	graph hbar (count) if k30>0, over(k30) title("Tax administrations")	
				*3 Obstaculos Business Licensing and Permits
	graph hbar (count) if k30>0, over(k30) title("Business Licensing and Permits")	
				*4 Obstaculos Political Instability
	graph hbar (count) if k30>0, over(k30) title("Political Instability")	
				*5 Obstaculos Corruption
	graph hbar (count) if k30>0, over(k30) title("Corruption")	
				*7 Obstaculos Labor regulations
	graph hbar (count) if k30>0, over(k30) title("Labor regulations")	
				*8 Obstaculos Inadequately Educated Workforce
	graph hbar (count) if k30>0, over(k30) title("Inadequately Educated Workforce")	
	
}
	
	*** Did this establishment purchase any fixed assets in last year?
	*** ¿Este establecimiento compró activos fijos el año pasado?
	*** l1: numero de empleadps
	*** l9b: % de trabajadores que completaron la secundaria 
	****  a7 establishment Is Part o|f A Large Firm 
	*** c7 number of power outages
	gen a7gg = .
	replace a7gg = 1 if a7 ==1
	replace a7gg = 0 if a7 ==2
		
	gen b8gg= .
	replace b8gg = 1 if b8 ==1
	replace b8gg = 0 if b8 ==2
	**** Logit
gen k4logit  = .
replace k4logit = 1 if k4 == 1
replace k4logit = 0 if k4 == 2
* Logit si la emporesa compro un activo fijo
logit k4logit l1 l9b  b8gg c7  d2
logit k4logit l1 l9b  c7  d2
mfx


logit k4logit l1 l9b if a3a == 1
logit k4logit l1 l9b if a3a == 2
logit k4logit l1 l9b if a3a == 3

gen n5agg = n5a/1000000

		graph hbar (mean) n5agg if n5agg>0, over(a4b)  ytitle("Expenditure for Purchases of equipment")  title("Expenditure equipment")
		
		graph hbar (mean) n5c if n5c>0, over(a4b)  ytitle("Expenditure for Purchases of equipment")  title("Spent on R&D (Millions of Bs)")
		
		gen n2ag = n2a/1000000
		
		graph hbar (mean) n2ag if n2ag>0, over(a4b)  ytitle("Total labor cost")  title("Total Labor cost (Millions of Bs)")
		