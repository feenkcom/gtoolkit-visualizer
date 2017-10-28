accessing
absolute
	"Return a distance object representing an absolute distance between axis values.
	Note: if I am already a positive distance, return instance of me"
	<return: #GtPlotterAxisDistance>
	
	^ self from <= self to
		ifTrue: [ self ]
		ifFalse: [ GtPlotterAxisDistance from: self to to: self from ]