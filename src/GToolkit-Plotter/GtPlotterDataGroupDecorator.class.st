Class {
	#name : #GtPlotterDataGroupDecorator,
	#superclass : #GtPlotterDataEntity,
	#instVars : [
		'entity'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #enumerating }
GtPlotterDataGroupDecorator >> detectDecorator: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	^ (aBlock value: self)
		ifTrue: [ aFoundBlock value: self ]
		ifFalse: [ self entity detectDecorator: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock ]
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> entities [
	^ { self entity }
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> entity [
	^ entity
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> entity: anObject [
	entity := anObject
]

{ #category : #enumerating }
GtPlotterDataGroupDecorator >> groupedBy: aBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>

	^ self copy entity: (self entity groupedBy: aBlock decorated: aDecorationBlock)
]

{ #category : #'gt-extension' }
GtPlotterDataGroupDecorator >> gtGroupsFor: aView [
	<gtView>

	^ self entity
		gtGroupsFor: aView
]

{ #category : #'gt-extension' }
GtPlotterDataGroupDecorator >> gtItemsFor: aView [
	<gtView>

	^ self entity
		gtItemsFor: aView
]

{ #category : #initialization }
GtPlotterDataGroupDecorator >> initialize [
	super initialize.
	
	entity := GtPlotterDataGroup new
]

{ #category : #testing }
GtPlotterDataGroupDecorator >> isDecorator [
	^ true
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> size [
	<return: #Number>

	^ self entity size
]
