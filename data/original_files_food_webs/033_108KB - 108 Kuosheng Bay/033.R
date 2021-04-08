setwd("C:/MUNKA/Hálózatelemzés/KSI")

# Az elsõ 17, eleve loopless hálózat adatainak beolvasása:
lless17=read.table("KSI_loopless.csv",header=T,sep=";",dec=",")
fix(lless17)
str(lless17)

#'data.frame':   241 obs. of  28 variables:
# $ Area      : Factor w/ 5 levels "Africa","Australasia",..: 3 3 3 3 3 5 5 5 5 5 ...
# $ Country   : Factor w/ 11 levels "Canary Islands",..: 1 1 1 1 1 2 2 2 2 2 ...
# $ Network   : Factor w/ 17 levels "005_25ML","006_27CC92",..: 1 1 1 1 1 2 2 2 2 2 ...
# $ Eco_type  : Factor w/ 5 levels "Bay","Estuary",..: 3 3 3 3 3 5 5 5 5 5 ...
# $ Group     : Factor w/ 194 levels "Adult tilapias",..: 58 57 116 2 85 165 132 24 81 31 ...
# $ Short_name: Factor w/ 183 levels "Amph","AnchA",..: 58 57 117 1 85 95 156 25 81 30 ...
# $ TL        : num  2.39 2.24 2.16 2 2 4.1 3.79 3.74 3.74 3.54 ...
# $ KSI       : num  -0.6413 -0.934 -0.0158 -1.2698 -0.3012 ...
# $ nwDC      : num  1.743 0.872 5.605 1.991 6.229 ...
# $ nDC       : num  0.5 0.5 0.5 0.8 0.8 0.474 0.105 0.105 0.158 0.632 ...
# $ nBC       : num  5.56 5.56 5.56 25 25 ...
# $ nCC       : num  0.75 0.75 0.833 0.875 0.75 0.613 0.475 0.432 0.5 0.731 ...
# $ TI3       : num  0.78 0.78 0.78 1.33 1.33 1.69 0.34 0.35 0.5 2.25 ...
# $ TI3prop   : num  0.16 0.16 0.16 0.27 0.27 ...
# $ WI3       : num  4.91e+10 2.50e+10 1.32e+11 9.20e+10 2.17e+11 ...
# $ WI3prop   : num  0.0954 0.0485 0.2561 0.1786 0.4214 ...
# $ TO        : num  0.4 0.4 0.4 0.3 0.3 1 0 0 0.15 2.23 ...
# $ Toprop    : num  0.222 0.222 0.222 0.167 0.167 ...
# $ WO        : num  0.1 0 0.1 0.1 0.1 0 0.83 0.83 1.63 0.83 ...
# $ Woprop    : num  0.25 0 0.25 0.25 0.25 0 0.0402 0.0402 0.079 0.0402 ...
# $ S         : num  0 0 0 3 3 0 0 1 4 2 ...
# $ contraS   : num  2 2 2 0 0 23 18 5 5 16 ...
# $ dS        : num  -2 -2 -2 3 3 -23 -18 -4 -1 -14 ...
# $ Kbu       : num  0 0 0 1.5 1.5 ...
# $ Ktd       : num  0.667 0.667 0.667 0 0 ...
# $ Kdir      : num  0.667 0.667 0.667 1.5 1.5 ...
# $ Kindir    : num  0 0 0 0 0 ...
# $ K         : num  0.667 0.667 0.667 1.5 1.5 ...

library(Rcmdr)

# Sperman-féle rangkorreláció CI-kkel: spearman.ci(var1, var2, nrep = 1000, conf.level = 0.95) Package: RVAideMemoire
library(RVAideMemoire)

with(lless17, summary(Network))
web33=lless17[lless17$Network=="033_108KB",]
fix(web33)
str(web33)

?scatterplotMatrix
with (web33,scatterplotMatrix(~KSI+nCC+TI3+TO, reg.line=lm, smooth=FALSE, spread=FALSE, diagonal = 'density', main="Network033: KSI- nCC, TI, TO"))

web33$lognwDC=log(web33$nwDC)
web33$logWI3=log(web33$WI3)

web33$expKSI=exp(web33$KSI)
plot(density(web33$expKSI))

with(web33,cor.test(KSI,K,method="spearman"))
with(web33, spearman.ci(KSI,K, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,Kdir,method="spearman"))
with(web33, spearman.ci(KSI,Kdir, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,Kindir,method="spearman"))
with(web33, spearman.ci(KSI,Kindir, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,Kbu,method="spearman"))
with(web33, spearman.ci(KSI,Kbu, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,Ktd,method="spearman"))
with(web33, spearman.ci(KSI,Ktd, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,S,method="spearman"))
with(web33, spearman.ci(KSI,S, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,dS,method="spearman"))
with(web33, spearman.ci(KSI,dS, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,contraS,method="spearman"))
with(web33, spearman.ci(KSI,contraS, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,nDC,method="spearman"))
with(web33, spearman.ci(KSI,nDC, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,nwDC,method="spearman"))
with(web33, spearman.ci(KSI,nwDC, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,nBC,method="spearman"))
with(web33, spearman.ci(KSI,nBC, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,nCC,method="spearman"))
with(web33, spearman.ci(KSI,nCC, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,TI3,method="spearman"))
with(web33, spearman.ci(KSI,TI3, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,TO,method="spearman"))
with(web33, spearman.ci(KSI,TO, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,WI3,method="spearman"))
with(web33, spearman.ci(KSI,WI3, nrep = 1000, conf.level = 0.95))

with(web33,cor.test(KSI,WO,method="spearman"))
with(web33, spearman.ci(KSI,WO, nrep = 1000, conf.level = 0.95))