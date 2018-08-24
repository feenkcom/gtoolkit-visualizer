"
I am a function that maps input values from a predifined domain to values within a range
"
Class {
	#name : #GtPlotterScale,
	#superclass : #Object,
	#instVars : [
		'range',
		'domain'
	],
	#category : 'GToolkit-Plotter-Scale'
}

{ #category : #accessing }
GtPlotterScale >> domain [
	^ domain
]

{ #category : #accessing }
GtPlotterScale >> domain: anObject [
	domain := anObject
]

{ #category : #'operators-mapping' }
GtPlotterScale >> interpolate: aValue [
	| domainValue mappedValue |
	
	domainValue := self domain interpolate: aValue.
	
	^ domainValue
	
	"mappedValue := self map: domainValue.
	
	^ self range interpolate: mappedValue"
]

{ #category : #'operators-mapping' }
GtPlotterScale >> map: aValue [

	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterScale >> range [
	^ range
]

{ #category : #accessing }
GtPlotterScale >> range: anObject [
	range := anObject
]
