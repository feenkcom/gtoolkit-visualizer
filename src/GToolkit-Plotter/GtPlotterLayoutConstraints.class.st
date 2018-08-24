Class {
	#name : #GtPlotterLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'domainObject'
	],
	#category : 'GToolkit-Plotter-Layout'
}

{ #category : #initialization }
GtPlotterLayoutConstraints >> defaultHorizontal [
	^ GtPlotterLayoutConstraintsAxis new
]

{ #category : #initialization }
GtPlotterLayoutConstraints >> defaultVertical [
	^ GtPlotterLayoutConstraintsAxis new
]

{ #category : #accessing }
GtPlotterLayoutConstraints >> domainObject [
	^ domainObject
]

{ #category : #accessing }
GtPlotterLayoutConstraints >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #testing }
GtPlotterLayoutConstraints >> hasDomainObject [
	"Return true if holder of this contraint represents a domain object on a plot"
	<return: #Boolean>
	
	^ domainObject isNotNil
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isAxis [
	"Return true if a holder of this constraint represents a vertical or horizontal axis"
	<return: #Boolean>
	
	^ self isHorizonalAxis or: [ self isVerticalAxis ]
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isHorizonalAxis [
	"Return true if a holder of this constraint represents a horizontal axis"
	<return: #Boolean>
	
	^ self horizontal isAxis
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isHorizonalTick [
	"Return true if a holder of this constraint represents a horizontal tick"
	<return: #Boolean>
	
	^ self horizontal isTick
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isPoint [
	^ self hasDomainObject and: [ self isTick not and: [ self isAxis not ] ]
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isTick [
	"Return true if a holder of this constraint represents a vertical or horizontal tick"
	<return: #Boolean>
	
	^ self isHorizonalTick or: [ self isVerticalTick ]
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isVerticalAxis [
	"Return true if a holder of this constraint represents a vertical axis"
	<return: #Boolean>
	
	^ self vertical isAxis
]

{ #category : #testing }
GtPlotterLayoutConstraints >> isVerticalTick [
	"Return true if a holder of this constraint represents a vertical tick"
	<return: #Boolean>
	
	^ self vertical isTick
]
