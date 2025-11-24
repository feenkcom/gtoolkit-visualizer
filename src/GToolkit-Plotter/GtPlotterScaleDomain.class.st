"
In mathematics, and more specifically in naive set theory, the domain of definition (or simply the domain) of a function is the set of ""input"" or argument values for which the function is defined. That is, the function provides an ""output"" or value for each member of the domain.[1] Conversely, the set of values the function takes on as output is termed the image of the function, which is sometimes also referred to as the range of the function.

https://en.wikipedia.org/wiki/Domain_of_a_function


"
Class {
	#name : #GtPlotterScaleDomain,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Scale'
}

{ #category : #'api - polymorphism' }
GtPlotterScaleDomain >> cull: aDomainValue [
	^ self normalize: aDomainValue
]

{ #category : #accessing }
GtPlotterScaleDomain >> max [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterScaleDomain >> min [
	^ self subclassResponsibility
]

{ #category : #interpolation }
GtPlotterScaleDomain >> normalize: aDomainValue [
	"I take a domain value x and return the corresponding parameter t in [0,1]."

	^ self subclassResponsibility
]

{ #category : #comparing }
GtPlotterScaleDomain >> sameAs: anotherDomain [
	^ self class = anotherDomain class and: [ 
		self min = anotherDomain min and: [ 
			self max = anotherDomain max ] ]
]

{ #category : #'api - polymorphism' }
GtPlotterScaleDomain >> value: aDomainValue [
	^ self normalize: aDomainValue
]
