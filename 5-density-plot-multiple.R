# ЧАСТЬ-1. готовим датафрейм. 
	# шаг-1.
MDepths <- read.csv("DepthTect.csv", header=TRUE, sep = ",")
MDFl <- na.omit(MDepths) 
row.has.na <- apply(MDFl, 1, function(x){any(is.na(x))}) # проверяем, удалил ли все NA
sum(row.has.na) # суммируем все NA, должно получиться: [1] 0
head(MDFl) # смотрим очищенный датафрейм. теперь с ним работаем. 
	
	# шаг-2. сшиваем группы категорий по классам (здесь: тектоника, глубины, углы)
DFDT = melt(setDT(MDFl), measure = patterns("^profile", "^tectonics", "^tg"), value.name = c("depth", "tectonics", "trench_angle"))
DFDT

	# шаг-3. строим мульти-график (здесь: по типам тектон плит как изменяются углы и глубины) 
densityplot(~ depth, groups = variable, data = DFDT, plot.points = FALSE, auto.key = FALSE)

densityplot(~ depth, groups = tectonics, data = DFDT, plot.points = FALSE, auto.key = TRUE)
