#install.packages("sna")
#install.packages("ndtv")
install.packages("tnsa")
#install.packages("ergm")
#install.packages("igraph")
#install.packages("network")
#install.packages("intergraph")
#install.packages("latticeExtra")
install.packages("networkDynamic")

library(sna)
library(ndtv)
library(tsna)
library(ergm)
library(igraph)
library(network)
library(intergraph)
library(latticeExtra)
library(networkDynamic)
setwd("C:/Users/Liad/Desktop/SNA_Exam_2018/forStudents")

#part_1
#A
network2_A.mat<-as.matrix(read.table("matrix_A.csv", sep=",",header=T, row.names=1, quote="\""))
network2_A.atts<-read.table("importExport_after_delNA_A.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_A.net<-network(network2_A.mat, vertex.attr=network2_A.atts, vertex.attrnames=colnames(network2_A.atts),directed=T, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_A.net)
network2_A_igraph<-asIgraph(network2_A.net)
#B
network2_B.mat<-as.matrix(read.table("matrix_B.csv", sep=",",header=T, row.names=1, quote="\""))
network2_B.atts<-read.table("importExport_after_delNA_B.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_B.net<-network(network2_B.mat, vertex.attr=network2_B.atts, vertex.attrnames=colnames(network2_B.atts),directed=T, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_B.net)
network2_B_igraph<-asIgraph(network2_B.net)
#C
network2_C.mat<-as.matrix(read.table("matrix_C.csv", sep=",",header=T, row.names=1, quote="\""))
network2_C.atts<-read.table("importExport_after_delNA_C.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_C.net<-network(network2_C.mat, vertex.attr=network2_C.atts, vertex.attrnames=colnames(network2_C.atts),directed=T, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_C.net)
network2_C_igraph<-asIgraph(network2_C.net)
#D
network2_D.mat<-as.matrix(read.table("matrix_D.csv", sep=",",header=T, row.names=1, quote="\""))
network2_D.atts<-read.table("importExport_after_delNA_D.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_D.net<-network(network2_D.mat, vertex.attr=network2_D.atts, vertex.attrnames=colnames(network2_D.atts),directed=T, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_D.net)
network2_D_igraph<-asIgraph(network2_D.net)
#E
network2_E.mat<-as.matrix(read.table("matrix_E.csv", sep=",",header=T, row.names=1, quote="\""))
network2_E.atts<-read.table("importExport_after_delNA_E.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_E.net<-network(network2_E.mat, vertex.attr=network2_E.atts, vertex.attrnames=colnames(network2_E.atts),directed=T, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_E.net)
network2_E_igraph<-asIgraph(network2_E.net)
#F
network2_F.mat<-as.matrix(read.table("matrix_F.csv", sep=",",header=T, row.names=1, quote="\""))
network2_F.atts<-read.table("importExport_after_delNA_F.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_F.net<-network(network2_F.mat, vertex.attr=network2_F.atts, vertex.attrnames=colnames(network2_F.atts),directed=T, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_F.net)
network2_F_igraph<-asIgraph(network2_F.net)
#test
network2_F.mat<-as.matrix(read.table("matrix_F_short.csv", sep=",",header=T, row.names=1, quote="\""))
network2_F.atts<-read.table("importExport_after_delNA_F_short.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_F.net<-network(network2_F.mat, vertex.attr=network2_F.atts, vertex.attrnames=colnames(network2_F.atts),directed=F, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_F.net)
network2_F_igraph<-asIgraph(network2_F.net)
network2_F_igraph

#part_2
network2_D_igraph
network2_F_igraph
nodes_A<-get.edgelist(network2_A_igraph)
nodes_B<-get.edgelist(network2_B_igraph)
nodes_C<-get.edgelist(network2_C_igraph)
nodes_D<-get.edgelist(network2_D_igraph)
nodes_E<-get.edgelist(network2_E_igraph)
nodes_F<-get.edgelist(network2_F_igraph)
gcor(nodes_D,nodes_F)
qaptest_DF<-qaptest(list(nodes_D,nodes_F),gcor,g1=1,g2=2)
summary(qaptest_DF)
plot(qaptest_DF,xlim=c(-0.2,0.8))
#part_3
model_orange.base<-ergm(network2_D.net ~ edges + nodefactor("Partner.ISO"))
summary(model_orange.base)
#part_4
#the explantions in the PDF
#part_5
model_orange_m1.base<-ergm(network2_D.net~edges+ nodefactor("Partner.ISO"))
gof_net1 <- gof(model_orange_m1.base, GOF =~idegree)
summary(gof_net1)
model_orange_m2.base<-ergm(network2_D.net ~ edges + nodefactor("Partner.ISO"))
gof_net2 <- gof(model_orange_m2.base, GOF =~idegree+espartners+dspartners)
summary(gof_net2)
model_orange_m3.base<-ergm(network2_D.net ~ edges + nodefactor("Partner.ISO"))
gof_net3 <- gof(model_orange_m3.base, GOF =~idegree+espartners+dspartners+odegree)
summary(gof_net3)
#part_6
#Cleaned the data with Excel
network2_E.mat<-as.matrix(read.table("matrix_E.csv", sep=",",header=T, row.names=1, quote="\""))
network2_E.atts<-read.table("wb_indicators_clean.csv", sep=",", header=T, quote="\"",stringsAsFactors=F, strip.white=T, as.is=T)
network2_E.net<-network(network2_E.mat, vertex.attr=network2_E.atts, vertex.attrnames=colnames(network2_E.atts),directed=F, hyper=F, loops=F, multiple=F, bipartite=F)
plot(network2_E.net)
network2_E_igraph<-asIgraph(network2_E.net)
#part_7
model_circus_m1.base<-ergm(network2_E.net~edges)
gof_net1 <- gof(model_circus_m1.base, GOF =~espartners+dspartners)
summary(gof_net1)
model_circus_m2.base<-ergm(network2_E.net~edges+ nodefactor("region"))
summary(model_circus_m2.base)
model_circus_m3.base<-ergm(network2_E.net~edges+ absdiff("IT.NET.USER.ZS"))
summary(model_circus_m3.base)
model_circus_m4.base<-ergm(network2_E.net~edges+ absdiff("SP.POP.TOTL"))
summary(model_circus_m4.base)
#part_8
#the explantions in the PDF
#part_9
#Don't know
#part_10
olive_oil_list <- list(network2_A.net,network2_B.net,network2_C.net)
sampdyn <- networkDynamic(network.list=olive_oil_list)
sampdyn
#network.collapse(sampdyn, at=4)
tSnaStats(sampdyn,"degree")
tErgmStats(sampdyn, "~ edges+triangle")
tp <- tPath(sampdyn, 1, direction = 'fwd')
plotPaths(sampdyn, tp)

table(edgeDuration(sampdyn, mode='duration', subject='spells'))

samp.fit <- stergm(samplist,
                   formation= ~edges+mutual+cyclicalties+transitiveties,
                   dissolution = ~edges+mutual+cyclicalties+transitiveties,
                   estimate = "CMLE",
                   times=c(1:3)
)
summary(samp.fit)

#part_11
#the explantions in the PDF