Class {
	#name : #GtPlotterBoxPlotModel,
	#superclass : #Object,
	#instVars : [
		'values',
		'quartile0',
		'quartile1',
		'quartile2',
		'quartile3',
		'quartile4',
		'bottomOutliers',
		'topOutliers'
	],
	#category : #'GToolkit-Plotter-Builder - Scatter Chart'
}

{ #category : #accessing }
GtPlotterBoxPlotModel class >> newFrom: aCollectionOfNumbers [
	^ self new
		values: aCollectionOfNumbers;
		yourself
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> bottomOutliers [
	^ bottomOutliers ifNil: [ bottomOutliers := self calculateBottomOutliers]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateBottomOutliers [
	| minVal collection q0 |
	collection := self values.
	minVal := collection min.
	
	q0 := self quartile0. 
	^ q0 = minVal
		ifTrue: [ #() ]
		ifFalse: [ collection select: [:each | each <  q0 ] ]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateQuartile0 [
	| res minVal |
	minVal := self values min.
	res := self quartile1 - (self interquartileRange * 1.5).
	res <= minVal 
		ifTrue: [ res := minVal ].
	^ res
			
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateQuartile1 [
	^ self quantile: 0.25
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateQuartile2 [
	^ values median
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateQuartile3 [
	^ self quantile: 0.75
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateQuartile4 [
	| res maxVal |
	maxVal := self values max.
	res := self quartile3 + (self interquartileRange * 1.5).
	res >= maxVal 
		ifTrue: [ res := maxVal ].
	^ res
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> calculateTopOutliers [
	| maxVal collection q4 |
	collection := self values.
	maxVal := collection max.
	
	q4 := self quartile4. 
	^ q4 = maxVal
		ifTrue: [ #() ]
		ifFalse: [ collection select: [:each | each >  q4 ] ]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> interquartileRange [
	^ self quartile3 - self quartile1
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> outliers [
	^ self bottomOutliers, self topOutliers
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quantile: aProbability [
	| a b c d p f aCollection|
	a := 1.
	b := -1.
	c := 0.
	d := 1.
	aCollection := self values.
	p := (aCollection size + b) * aProbability + a.
	p := p < 1
		ifTrue: [ 1 ]
		ifFalse: [ p min: aCollection size ].
	^ p truncated = p
		ifTrue: [ aCollection at: p asInteger ]
		ifFalse: [ (f := aCollection at: p floor)
				+ (((aCollection at: p ceiling) - f) * 
				(p fractionPart * d + c)) ]
	
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quartile0 [
	^ quartile0 ifNil: [ quartile0 := self calculateQuartile0]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quartile1 [
	^ quartile1 ifNil: [ quartile1 := self calculateQuartile1]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quartile2 [
	^ quartile2 ifNil: [ quartile2 := self calculateQuartile2]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quartile3 [
	^ quartile3 ifNil: [ quartile3 := self calculateQuartile3]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quartile4 [
	^ quartile4 ifNil: [ quartile4 := self calculateQuartile4]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> quartiles [
	^ { 
	self quartile0.
	self quartile1.
	self quartile2.
	self quartile3.
	self quartile4}
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> tickValues [
	^ SortedCollection new
		addAll: self quartiles;
		addAll: self bottomOutliers;
		addAll: self topOutliers;
		yourself
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> topOutliers [
	^ topOutliers ifNil: [ topOutliers := self calculateTopOutliers]
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> values [
	^ values
]

{ #category : #accessing }
GtPlotterBoxPlotModel >> values: aCollectionOfNumbers [
	values := aCollectionOfNumbers asSortedCollection
]
