import pandas as pd
import statsmodels.formula.api as smf

# import dataset
df = pd.read_stata("http://fmwww.bc.edu/ec-p/data/wooldridge/mroz.dta")

# ols
results = smf.ols(formula='lwage ~ educ + exper + expersq', data=df).fit()
print(results.summary())
