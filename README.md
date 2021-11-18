README
================
--- 
> Presenting Thursday, December 2nd 

---  

## Thesis 

Among wisconsin counties, the libraries with higher funding have lower 
computer usage compared to libraries with lower funding after controlling for 
the number of computers and the age demographics of the county. 

**Karl's Comments** 
- So you're using library funding as a proxy for wealth/socieo-economic level  
- Have you considered added wealth to see if it cancels out the difference? 
- DAG (County Wealth, Library Funding, Number of Computers, Computer Use, Age) 
	- County Wealth -> Lib Funding, Number of Computers, Computer Use 
	- Library Funding -> # Computers, Computer Use 
		- **Main Treatment: Library Funding -> Computer Use** 
	- Number of Computers -> Computer Use 
	- Age -> Library Funding, Computer Use 
- County Wealth and Age are Confounders: 
	- County Wealth causes Library Funding and Computer Use. Therefore, they will be correlated. 
	- Multiple Linear Regression: Put County Wealth and Library Funding as featuers for Computer Use. If County Wealth is still positive it says that Library Funding is still correlated even if you remove county wealth. 
- Number of Computers is a mediator 
- Maybe try to use County Wealth as a treatment instead of Library Funding. 


---
### How the funding is allocated to libraries 
**Demographic Makeup**

General Introduction: Understanding the data and where funding goes
Where does increased funding go?
- Progams? Self-Directed Programs?
- Number of Computers? Books? AV Materias? 
- Salaries (Librarians vs Staff) 
- Materials 
- Other Expenditures 

### How is funding affected & where does it go?
**Computer Usage** 
- Income vs Computer Usage
- Income vs Age Range vs Computer Usage (if old maybe don't use computers) 
- Number of Computers 
- Funding for Computers 
- Index of Usage per Computer 

#### Shiny Appearance 
- Map by County (color by xyz) 
- We could have all the variables with a checkbox. Then click to include the variables -> print plots and stats

#### Linear Model + Age/Income 
Type in Income + Age -> Return Computer Usage Statistic 


  
	
	
	
	
