Class {
	#name : #GtPlotterDataGroup,
	#superclass : #GtPlotterDataEntity,
	#instVars : [
		'values'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #enumerating }
GtPlotterDataGroup >> collect: aBlock [
	^ self values collect: aBlock
]

{ #category : #accessing }
GtPlotterDataGroup >> entities [
	^ #()
]

{ #category : #grouping }
GtPlotterDataGroup >> groupIntervals [
	^ { 
		(GtPlotterDuration years: 3) -> (GtPlotterDuration years: Float infinity).
		(GtPlotterDuration years: 1) -> (GtPlotterDuration years: 3).
		(GtPlotterDuration months: 6) -> (GtPlotterDuration years: 1).
		(GtPlotterDuration months: 3) -> (GtPlotterDuration months: 6).
		(GtPlotterDuration months: 1) -> (GtPlotterDuration months: 3).
		(GtPlotterDuration months: 0) -> (GtPlotterDuration months: 1) }
]

{ #category : #'api - grouping' }
GtPlotterDataGroup >> groupedBy: aBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>
	| theGroupedValues theGroups |

	theGroupedValues := self values groupedBy: aBlock.
	
	theGroups := theGroupedValues associations collect: [ :anAssociation |
		| aDecoration aGroup |
		aGroup := self class new values: anAssociation value.
		aDecoration := aDecorationBlock cull: anAssociation key cull: anAssociation value.
		aDecoration isCollection
			ifTrue: [
				| anArray |
				anArray := aDecoration asArray reversed.
				aDecoration := anArray inject: aGroup into: [ :aPreviousDecorator :aNextDecorator |
					aNextDecorator entity: aPreviousDecorator.
					aNextDecorator ].
				anArray last ]
			ifFalse: [ aDecoration entity: aGroup ] ].

	^ GtPlotterDataGroups new entities: theGroups
]

{ #category : #enumerating }
GtPlotterDataGroup >> groupsDo: aBlock [
	aBlock value: self
]

{ #category : #'gt-extension' }
GtPlotterDataGroup >> gtGroupsFor: aView [
	<gtView>

	^ aView empty
]

{ #category : #'gt-extension' }
GtPlotterDataGroup >> gtItemsFor: aView [
	<gtView>

	^ aView list
		title: 'Items';
		priority: 2;
		items: [ self values ]
]

{ #category : #initialization }
GtPlotterDataGroup >> initialize [
	super initialize.
	
	values := #()
]

{ #category : #printing }
GtPlotterDataGroup >> printOn: aStream [
	aStream
		nextPutAll: 'Values (';
		nextPutAll: self size asString;
		nextPut: $)
]

{ #category : #accessing }
GtPlotterDataGroup >> size [
	<return: #Number>

	^ self values size
]

{ #category : #enumerating }
GtPlotterDataGroup >> sorted: aBlock [
	^ self class new cookies: (self values sorted: aBlock)
]

{ #category : #accessing }
GtPlotterDataGroup >> values [
	<return: #Collection>

	^ values
]

{ #category : #accessing }
GtPlotterDataGroup >> values: aCollection [
	values := aCollection
]
