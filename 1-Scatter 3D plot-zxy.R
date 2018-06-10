# ЧАСТЬ-1. готовим датафрейм. 
	# шаг-1. вчитываем таблицу с данными по геоморфологии. делаем из нее исходный датафрейм
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
	# шаг-2. чистим датафрейм от NA значений
MDF <- na.omit(MDepths) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) 
sum(row.has.na) 
head(MDF) 


# ЧАСТЬ-2. рисуем 3D график "Slope angle", "Sedimental thickness"
library(latticeExtra)
 
	# шаг-3. создаем выборку для нового дата-фрейма (только нужные 3 значения)
set.seed(1)
my_data <- data.frame(MDF)
head(my_data)
	# шаг-4. 
p<- cloud(slope_angle ~ profile * sedim_thick, data = my_data)
