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
#nodes - 210
#edges - range[1-630]
#part_1
x1<-c(1:630)
comp<-c()
for (value in x1){
  comp<-c(comp, max(igraph::components(erdos.renyi.game(210,value,"gnm",directed="True"))$csize))
}
plot(comp)

#part_2
#Explanations in the pdf
#part_3
network4<-erdos.renyi.game(210,420,"gnm",directed="True")
graph.density(network4)
diameter(network4)
#part_4
setwd("C:/Users/Liad/Desktop/SNA_Exam_2018/forStudents")
dens<-0.1
nodes<-210
edges<-round(dens*nodes)
network4<-erdos.renyi.game(nodes,edges,"gnm",directed="True")
network4
network4_sna<-read.paj("erdos_reyni_targil4_part4.net")
#I took the edges data and created a .net file with python for the clique calculation
clique.census(network4_sna)
#part_5
x2<-c(1:630)
triad<-c()
for (value in x2){
  network4_temp<-igraph::triad.census(erdos.renyi.game(210,value,"gnm",directed="True"))
  triad<-c(triad, sum(sum(network4_temp[9:10]),sum(network4_temp[12:16])))
}
plot(triad)
