Class {
	#name : #GtPlotterAxis,
	#superclass : #Object,
	#instVars : [
		'name',
		'scale',
		'projections',
		'minLimit',
		'maxLimit'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #'instance creation' }
GtPlotterAxis class >> named: aString [
	"Return a new axis instance with specified name"
	<return: #GtPlotterAxis>
	
	^ self new name: aString
]

{ #category : #initialization }
GtPlotterAxis >> computeProjections: aCollectionOfDomainObjects [
	<return: #GtPlotterAxisProjections>

	^ (GtPlotterAxisProjections streamContents: [ :aStream | 
		aCollectionOfDomainObjects
			doWithIndex: [ :aDomainObject :anIndex |
				| aProjection |
				aProjection := self projection: aDomainObject at: anIndex.
				aProjection source: aDomainObject.
				aProjection axis: self.
				aDomainObject addProjection: aProjection.
				aStream nextPut: aProjection ] ])
			axis: self
]

{ #category : #initialization }
GtPlotterAxis >> initialize [
	super initialize.
	
	name := 'Axis'.
	scale := GtPlotterIdentityScale new.
	projections := GtPlotterAxisProjections on: self.
	minLimit := GtPlotterAxisAutoMinLimit new axis: self.
	maxLimit := GtPlotterAxisAutoMaxLimit new axis: self
]

{ #category : #initialization }
GtPlotterAxis >> initializeOn: aCollectionOfDomainObjects [

	projections := self computeProjections: aCollectionOfDomainObjects
]

{ #category : #accessing }
GtPlotterAxis >> length [
	"Return axis length defined as absolute distance between maximum and minimum values"
	<return: #GtPlotterAxisDistance>
	
	^ (self max - self min) absolute
]

{ #category : #accessing }
GtPlotterAxis >> max [
	"Return a maximum axis value defined by my range"
	<return: #GtPlotterAxisValue>

	^ self maxLimit limit
]

{ #category : #accessing }
GtPlotterAxis >> maxLimit [
	^ maxLimit
]

{ #category : #accessing }
GtPlotterAxis >> maxLimit: anAxisLimit [
	maxLimit := anAxisLimit.
	maxLimit axis: self
]

{ #category : #accessing }
GtPlotterAxis >> min [
	"Return a minimum axis value defined by my range"
	<return: #GtPlotterAxisValue>
	
	^ self minLimit limit
]

{ #category : #accessing }
GtPlotterAxis >> minLimit [
	^ minLimit
]

{ #category : #accessing }
GtPlotterAxis >> minLimit: anObject [
	minLimit := anObject
]

{ #category : #accessing }
GtPlotterAxis >> name [
	"Return an optional axis name to be used for debugging / inspecting purposes"
	<return: #String>

	^ name
]

{ #category : #accessing }
GtPlotterAxis >> name: aString [
	"Change axis name.
	aString must not be nil"

	name := aString
]

{ #category : #computation }
GtPlotterAxis >> normalize: aDomainObject [
	<return: #Number>
	| aProjection aLength |

	aProjection := aDomainObject projectionOn: self.
	aLength := self length.
	aLength isZero
		ifTrue: [ ^ 0 ].
	
	^ (aProjection - self min) / self length
]

{ #category : #initialization }
GtPlotterAxis >> projection: aDomainObject at: anIndex [
	"Return a projection of a given domain object on this axis"
	<return: #GtPlotterAxisProjection>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPlotterAxis >> projections [
	<return: #GtPlotterAxisProjections>

	^ projections
]

{ #category : #accessing }
GtPlotterAxis >> scale [
	<return: #GtPlotterScale>
	
	^ scale
]

{ #category : #accessing }
GtPlotterAxis >> scale: aScale [
	scale := aScale
]
