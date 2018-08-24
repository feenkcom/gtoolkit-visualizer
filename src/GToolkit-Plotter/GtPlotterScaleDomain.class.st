"
In mathematics, and more specifically in naive set theory, the domain of definition (or simply the domain) of a function is the set of ""input"" or argument values for which the function is defined. That is, the function provides an ""output"" or value for each member of the domain.[1] Conversely, the set of values the function takes on as output is termed the image of the function, which is sometimes also referred to as the range of the function.

https://en.wikipedia.org/wiki/Domain_of_a_function
"
Class {
	#name : #GtPlotterScaleDomain,
	#superclass : #Object,
	#instVars : [
		'interval'
	],
	#category : 'GToolkit-Plotter-Scale'
}

{ #category : #'as yet unclassified' }
GtPlotterScaleDomain >> clamp: aValue [

	aValue < self interval min
		ifTrue: [ ^ self interval min ].
		
	aValue > self interval max
		ifTrue: [ ^ self interval max ].
		
	^ aValue
]

{ #category : #testing }
GtPlotterScaleDomain >> includes: aValue [
	"Return true if a given value lays within this domain"
	<return: #Boolean>
	
	^ aValue >= self interval min and: [ aValue <= self interval max ]
]

{ #category : #interpolation }
GtPlotterScaleDomain >> interpolate: aValue [
	^ ((self clamp: aValue) - self interval min) / self length
]

{ #category : #accessing }
GtPlotterScaleDomain >> interval [
	^ interval
]

{ #category : #accessing }
GtPlotterScaleDomain >> interval: anObject [
	interval := anObject
]

{ #category : #accessing }
GtPlotterScaleDomain >> length [
	^ self interval length
]
