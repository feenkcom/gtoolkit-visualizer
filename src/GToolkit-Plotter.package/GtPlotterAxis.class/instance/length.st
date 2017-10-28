accessing
length
	"Return axis length defined as absolute distance between maximum and minimum values"
	<return: #GtPlotterAxisDistance>
	
	^ (self max - self min) absolute