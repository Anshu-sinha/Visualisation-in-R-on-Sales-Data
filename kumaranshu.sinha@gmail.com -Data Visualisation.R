
setwd("F:/BA-R programming/R case studies/R case study 3 (Visualization)/CaseStudy_R_Visualizations")

SalesData <- read.csv("SalesData.csv")


#Question no.1

require(dplyr)
Region_Sales <-SalesData %>% group_by(Region) %>% summarise(TotalSales2015=sum(Sales2015),TotalSales2016=sum(Sales2016)) 

require(reshape2)
Region_Sales1 <- melt(Region_Sales,id.vars = "Region", variable.name = "Year",value.name = "Sales")

require(ggplot2)
Plot_Region_Sales <- ggplot(data = Region_Sales1) + aes(x = Region, y = Sales, fill = Year) + 
                            geom_bar(stat = "identity", position = "Dodge") + 
                            geom_text(label = round(Region_Sales1$Sales,0),na.rm = F)+ 
                            scale_y_continuous()

#Question no.2


require(plotrix)
Pie1 <- pie(Region_Sales$TotalSales2016,labels = Region_Sales$Region,clockwise = F, edges = 500,  
              main = "Pie Chart of Sales 2016", radius = 0.6)

Region_Sales$Percent_2016 <- (Region_Sales$TotalSales2016/sum(Region_Sales$TotalSales2016))*100
Region_Sales$Percent_2016 <- round(Region_Sales$Percent_2016,digits = 1)

# To get the "%" and ":" lebels along with the region and Percent

lbls <- paste(Region_Sales$Percent_2016,"%")
lbls2 <- paste(":",Region_Sales$Region)
lbls <- paste(lbls,lbls2)

Pie2 <- pie(Region_Sales$Percent_2016 ,labels = lbls ,clockwise = F , 
              main = "Pie Chart of Sales 2016" ,col = c("Red","Blue","Green"))

pie3 <- pie3D(Region_Sales$Percent_2016 ,labels = lbls ,   #Clockwise function doesn't 
              main = "Pie Chart of Sales 2016" ,col = c("Red","Green","Blue"),explode = .08)

#Question no.3

require(scales)

Comparision_Sales <- SalesData %>% group_by(Tier,Region) %>% 
                      summarise(TotalSales2015=sum(Sales2015),TotalSales2016=sum(Sales2016))

Comparision_Sales1 <- melt(Comparision_Sales,id.vars = c("Region","Tier"),variable.name = "Year",value.name = "Sales")

#format(Sales,scientific=T) is used just to convert the scientific notations to normal form

Plot_Comparision_Sales <- ggplot(Comparision_Sales1) + aes( x = Tier, y = Sales , fill =Year ) + #options("scipen" = 10,"digits"= 6) + 
                            geom_bar(stat = "identity" , position = "Dodge") + facet_grid(.~Region) + 
                            ggtitle("Comparision Of Sales of 2015-16 with Region and Tiers") +
                            theme(plot.title = element_text(hjust = 0.5)) + scale_y_continuous()


#Question no.4

East_Region <- SalesData %>% group_by(State,Region) %>% summarise(TotalSales2015=sum(Sales2015),TotalSales2016=sum(Sales2016))

East_Region1 <- melt(East_Region,id.vars = c("Region","State"),variable.name = "Year",value.name = "Sales")
East_Region2 <- East_Region1[East_Region1$Region =="East",]

Plot_East_Region <- ggplot(East_Region2) + aes(x = State, y = Sales, fill = Year) +
                        geom_bar(stat = "identity",position = "Dodge") +
                        labs(title = "In East Region, NY registered a decline in sales 2016") +
                        theme(plot.title = element_text(hjust = 0.5))



#Question no.5

Unit_Division <- SalesData %>% group_by(Division) %>% summarise(TotalUnits2015=sum(Units2015),TotalUnits2016=sum(Units2016))
Unit_Division1 <- melt(Unit_Division,id.vars = "Division",variable.name = "Year",value.name = "Units")
Unit_Division1$Units <- round(Unit_Division1$Units,digits = 1)
Plot_Unit_Division <- ggplot(Unit_Division1) + aes(x = Division, y = Units, fill = Year) +
                            geom_bar(stat = "identity", position = "dodge") +
                            theme(text = element_text(size = 20), 
                            axis.text.x= element_text(angle = -45,hjust = 0.01)) 
                            #axis(side = 2 , at = seq(0, 600,by = 100)) #For changing the units division


#Question no.6 
SalesData$Month_Num <- match(SalesData$Month,month.abb)
SalesData$Month_Num <- as.numeric(SalesData$Month_Num)
SalesData$Qtr <- ifelse(SalesData$Month_Num <= 3, "Q1",
                        ifelse(SalesData$Month_Num >3 & SalesData$Month_Num<= 6, "Q2",
                        ifelse(SalesData$Month_Num > 6 & SalesData$Month_Num <=9,"Q3","Q4")))



#Question no.7

Qtr_Sales <- SalesData %>% group_by(Qtr) %>% summarise(TotalSales2015=sum(Sales2015),TotalSales2016=sum(Sales2016))

Qtr_Sales1 <- melt(Qtr_Sales,id.vars = "Qtr",variable.name = "Year", value.name = "Sales")
Plot_Qtr_Sales1 <- ggplot(Qtr_Sales1) +aes(x = Qtr , y = Sales ,fill = Year) +
                    geom_bar(stat = "Identity" ,position = "dodge") + 
                    ggtitle("Comparision of Qtr wise Sales in 2015-16") +
                    theme(plot.title = element_text(hjust = 0.5),text = element_text(size = 15))



#Question no.8

Qtr <- SalesData %>% group_by(Qtr,Tier) %>% summarise(TotalSales2016=sum(Sales2016))
Qtr$TotalSales2016 <- ifelse(Qtr$TotalSales2016 < 0 ,Qtr$TotalSales2016 *-1, Qtr$TotalSales2016)

Qtr1 <- Qtr[Qtr$Qtr == "Q1", ]
pie_Qtr1 <- pie(Qtr1$TotalSales2016,labels = Qtr$Tier,clockwise = F, main = "Qtr1")

Qtr2 <- Qtr[Qtr$Qtr == "Q2",]
pie_Qtr2 <- pie(Qtr2$TotalSales2016,labels = Qtr2$Tier,clockwise = F, main = "Qtr2")

Qtr3 <- Qtr[Qtr$Qtr == "Q3",]
pie_Qtr3 <- pie(Qtr3$TotalSales2016,labels = Qtr3$Tier,clockwise = F,main = "Qtr3")

Qtr4 <- Qtr[Qtr$Qtr == "Q4",]
pie_Qtr4 <- pie(Qtr4$TotalSales2016,labels = Qtr4$Tier,clockwise = F,main = "Qtr4")




