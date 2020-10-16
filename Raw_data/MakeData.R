setwd("/Users/zerohertz/Downloads/")
kospi<-read.csv("KOSPI Historical Data.csv",header=T)
krw<-read.csv("USD_KRW Historical Data.csv",header=T)
vko<-read.csv("KOSPI Volatility Historical Data.csv",header=T)
wti<-read.csv("Crude Oil WTI Futures Historical Data.csv",header=T)
cboe<-read.csv("CBOE Volatility Index Historical Data.csv",header=T)

kosp=substr(kospi[,7],0,nchar(kospi[,7])-1)
kos=as.numeric(kosp)

i=2
ko=0
while(i<(length(kos)-60)){
	j=1
	k=0
	while(j<61){
		k=k+kos[i+j]
		j=j+1
	}
	ko[i]<-k
	i=i+1
}

a=1
label_ko=0
while(a<length(ko)){
	if(ko[a]>=4){
		label_ko[a]<-"up"
	}
	else if(0<=ko[a]&&ko[a]<4){
		label_ko[a]<-"neutral"
	}
	else if(ko[a]<0){
		label_ko[a]<-"down"
	}
	else{
		label_ko[a]<-"NA"
	}
	a=a+1
}

krw=gsub(",","",kospi[,2])
krw=as.numeric(krw)
vko=as.numeric(vko[,2])
wti=as.numeric(wti[,2])
cboe=as.numeric(cboe[,2])

krw=krw[1:1705]
vko=vko[1:1705]
wti=wti[1:1705]
cboe=cboe[1:1705]

data=cbind(krw,vko,wti,cboe,label_ko)

write.table(data,"data.csv",sep=',',row.names=F)