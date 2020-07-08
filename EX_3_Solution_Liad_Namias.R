#install.packages("sna")
#install.packages("igraph")
#install.packages("network")
#install.packages("intergraph")
#install.packages("lsa")
library(lsa)
library(sna)
library(igraph)
library(network)
library(intergraph)
setwd("C:/Users/Liad/Desktop/SNA_Exam_2018/forStudents")
#part_1
network3_sna<-read.paj("jazz.net")
network3_igraph<-asIgraph(network3_sna)
network.size(network3_sna)
is.connected(network3_igraph)
plot(network3_igraph)
#part_2 
wc <- cluster_walktrap(network3_igraph,steps=1)
#wc
#modularity(wc)
membership(wc)
plot(wc, network3_igraph)
deg<-degree(network3_igraph)
norm<-deg/max(deg)*30
V(network3_igraph)$size = norm
plot(wc, network3_igraph)
#part_3
hc<-as.dendrogram(wc, use.modularity = FALSE)
plot(hc)
#part_4
A = get.adjacency(network3_igraph, sparse=FALSE)
S = cosine(A)
D = 1-S
d = as.dist(D)
cc = hclust(d, method = "average")
plot(cc)