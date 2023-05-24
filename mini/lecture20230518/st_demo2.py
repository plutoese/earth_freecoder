import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import statsmodels.formula.api as smf

df = pd.read_stata("http://fmwww.bc.edu/ec-p/data/wooldridge/mroz.dta")

st.title("我的第一个Web应用程序")
st.markdown("---")

st.markdown("## Morz数据集")
is_show_dataset = st.checkbox('显示数据集')
if is_show_dataset:
    st.write(df)

st.markdown("---")
st.markdown("## 散点图")
is_show_scatter = st.checkbox('显示散点图')

if is_show_scatter:
    fig, ax = plt.subplots(figsize=(10, 4))
    sns.scatterplot(x="educ", y="lwage", size="exper", sizes=(40, 400), alpha=.5, data=df, ax=ax)
    st.pyplot(fig)

st.markdown("---")
st.markdown("## 线性回归模型")
ind_vars = list(df.columns)
ind_vars.remove("lwage")

selected = st.multiselect(
    '选择解释变量',
    ind_vars,
    [])

if len(selected) > 0:
    results = smf.ols(formula=f'lwage ~ {"+ ".join(selected)}', data=df).fit()
    summary = results.summary()
    st.text(summary)
else:
    st.text("未选择解释变量，请返回选择！")