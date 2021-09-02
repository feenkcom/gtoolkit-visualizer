"
I am a function that maps input values from a predifined domain to values within a range


"
Class {
	#name : 'GtPlotterScale',
	#superclass : 'Object',
	#instVars : [
		'range',
		'domain',
		'tickFormat'
	],
	#category : 'GToolkit-Plotter-Scale'
}

{ #category : 'api - polymorphism' }
GtPlotterScale >> cull: anObject [
	"To be polymorphic with blocks"

	^ self map: anObject
]

{ #category : 'accessing' }
GtPlotterScale >> domain [
	<return: #GtPlotterScaleDomain>

	^ domain
]

{ #category : 'accessing' }
GtPlotterScale >> domain: aGtPlotterScaleDomain [
	domain := aGtPlotterScaleDomain
]

{ #category : 'api - ticks' }
GtPlotterScale >> formattedTick: anObject [
	^ tickFormat cull: anObject
]

{ #category : 'gt-extension' }
GtPlotterScale >> gtTicksFor: aView [
	<gtView>
	
	^ aView list
		title: 'Ticks';
		priority: 5;
		items: [ self ticks asArray ]
]

{ #category : 'initialization' }
GtPlotterScale >> initialize [
	super initialize.
	
	domain := GtPlotterScaleUnitDomain new.
	range := GtPlotterScaleUnitRange new.
	tickFormat := #printString
]

{ #category : 'operators-mapping' }
GtPlotterScale >> map: aDomainValue [
	"I take an input (usually a number, date or category) and return a value (such as a coordinate, a colour, a length or a radius)"

	^ range interpolate: (domain normalize: (self transform: aDomainValue))
]

{ #category : 'accessing' }
GtPlotterScale >> range [
	<return: #GtPlotterScaleRange>

	^ range
]

{ #category : 'accessing' }
GtPlotterScale >> range: aGtPlotterScaleRange [
	range := aGtPlotterScaleRange
]

{ #category : 'comparing' }
GtPlotterScale >> sameAs: anotherScale [
	^ self class = anotherScale class and: [ 
		self domain sameAs: anotherScale domain ]
]

{ #category : 'api - ticks' }
GtPlotterScale >> tickFormat: aFormatBlock [
	tickFormat := aFormatBlock
]

{ #category : 'api - ticks' }
GtPlotterScale >> ticks [
	<return: #Array of: #Object>

	^ self ticks: 10
]

{ #category : 'api - ticks' }
GtPlotterScale >> ticks: anAmount [
	<return: #Array of: #Object>

	^ self subclassResponsibility
]

{ #category : 'operators-mapping' }
GtPlotterScale >> transform: aDomainValue [
	self subclassResponsibility
]

{ #category : 'api - polymorphism' }
GtPlotterScale >> value: anObject [
	"To be polymorphic with blocks"

	^ self map: anObject
]

{ #category : 'api - ticks' }
GtPlotterScale >> valuedTick: aTickObject [
	^ aTickObject
]
