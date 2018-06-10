# ЧАСТЬ-1. готовим датафрейм. 
	# шаг-1. вчитываем таблицу с данными по геоморфологии. делаем из нее исходный датафрейм

MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
	# шаг-2. чистим датафрейм от NA значений
MDF <- na.omit(MDepths) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) 
sum(row.has.na) 
head(MDF)

MDFt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonic plates"))
	# на выходе имеем лист с 4 колонками (номера измерений 1:518, номера профилей 1:25, глубины, тектоника).
MDFt

# ЧАСТЬ-2. рисуем 3D график "Slope angle", "Sedimental thickness"
library(latticeExtra)
 
	# шаг-3. Базовый график Basic stip plot 
	
	# вариант 3.1 угол крутизны склона:
stripplot(slope_angle ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  xlab = "tectonic.plates", ylab = "slope.angle(tg(A/H))")
	# вариант 3.2  седиментология (морские отложения):
stripplot(sedim_thick ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  xlab = "tectonic.plates", ylab = "sedimental thickness")
	# вариант 3.3  мин глубины:
	stripplot(Min ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  xlab = "tectonic.plates", ylab = "Min")
	# вариант 3.4 зоны подводных вулканов:
stripplot(igneous_volc ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  xlab = "tectonic.plates", ylab = "igneous_volc")

