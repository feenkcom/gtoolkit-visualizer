"
I represent a domain data object
"
Class {
	#name : #GtPlotterDomainObject,
	#superclass : #Object,
	#instVars : [
		'value',
		'projections'
	],
	#category : 'GToolkit-Plotter'
}

{ #category : #adding }
GtPlotterDomainObject >> addProjection: aGtPlotterAxisProjection [
	"Add a projection"
	
	self
		assert: [ aGtPlotterAxisProjection source == self ]
		description: [ 'Can not add not my projection' ].
	
	self projections at: aGtPlotterAxisProjection axis put: aGtPlotterAxisProjection
]

{ #category : #initialization }
GtPlotterDomainObject >> initialize [
	super initialize.
	
	projections := IdentityDictionary new
]

{ #category : #accessing }
GtPlotterDomainObject >> projectionOn: anAxis [
	<return: #GtPlotterAxisProjection>
	
	^ self projections at: anAxis
]

{ #category : #accessing }
GtPlotterDomainObject >> projections [
	^ projections
]

{ #category : #accessing }
GtPlotterDomainObject >> value [
	^ value
]

{ #category : #accessing }
GtPlotterDomainObject >> value: anObject [
	value := anObject
]
