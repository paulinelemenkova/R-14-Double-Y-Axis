# ЧАСТЬ-1. готовим датафрейм. 
	# шаг-1. вчитываем таблицу с данными. делаем из нее исходный датафрейм. чистим датафрейм от NA значений
MDepths <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDepths) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) 
sum(row.has.na) 
head(MDF)

	# шаг-2. сшиваем 4 колонки с названиями плит в одну - "тектон. плиты" 
MDFt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonic plates"))
head(MDFt)

	# шаг-3. задаем колонку с названями плит как факторное значение (она имеет название variable) 
MDFt$variable =as.factor(MDFt$variable)
levels(MDFt$variable)=c("Philippine" , "Pacific", "Mariana", "Caroline") # прописываем названия 4 плит чтобы отображались на оси X

# ЧАСТЬ-2. делаем структурированное название (заголовок + подзоголовок) в Латтисе
library(latticeExtra)
	# шаг-4. 
doubleTitle <- function(a,b) {     
	gTree(children=gList(         
		textGrob(a, gp=gpar(fontsize=12, fontface=2), y=0,              
			vp=viewport(layout.pos.row=1, layout.pos.col=1)),         
		textGrob(b, gp=gpar(fontsize=10, fontface=3), y=0,              
			vp=viewport(layout.pos.row=2, layout.pos.col=1))     
		), vp=viewport(layout=grid.layout(nrow=2, ncol=1)), cl="doubletitle") 
	}  
	heightDetails.doubletitle <- function(x, recording=T) {     
		Reduce(`+`, lapply(x$children, grid:::heightDetails.text)) * 2 
	}

# ЧАСТЬ-3. Strip Plot // рисуем полосчатые графики (вертикальное распределение значений по 4 категориям))
	# шаг-5. Полосчатый график // Stip plot 

	# вариант 5.1 угол крутизны склона:
s1<- stripplot(slope_angle ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  
	xlab = list(label="Tectonic Plates", cex=0.75), 
	ylab = list(label="Slope Angle(tg(A/H))", cex=0.75), 
	main=doubleTitle("Mariana Trench","Strip Plot: Slope Angle(tg(A/H)) in 25 Profiles by Tectonic Plates"))
s1	
	
	# вариант 5.2  седиментология (морские отложения):
s2<- stripplot(sedim_thick ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  
	xlab = list(label="Tectonic Plates", cex=0.75), 
	ylab = list(label="Sedimental Thickness", cex=0.75), 
	main=doubleTitle("Mariana Trench","Strip Plot: Sedimental Thickness in 25 Profiles by Tectonic Plates"))
s2	

	# вариант 5.3  мин глубины:
s3<- stripplot(Min ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,  
	xlab = list(label="Tectonic Plates", cex=0.75), 
	ylab = list(label="Maximal Depth", cex=0.75), 
	main=doubleTitle("Mariana Trench","Strip Plot: Maximal Depth in 25 Profiles by Tectonic Plates"))
s3	
	
	# вариант 5.4 зоны подводных вулканов:
s4<- stripplot(igneous_volc ~ variable,  data = MDFt, jitter.data = TRUE, pch = 19,
	xlab = list(label="Tectonic Plates", cex=0.75), 
	ylab = list(label="Igneous Volcanic Areas", cex=0.75),
	main=doubleTitle("Mariana Trench","Strip Plot: Igneous Volcanic Zones Distribution in 25 Profiles by Tectonic Plates"))
s4