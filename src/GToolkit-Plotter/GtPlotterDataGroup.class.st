Class {
	#name : #GtPlotterDataGroup,
	#superclass : #GtPlotterDataEntity,
	#instVars : [
		'values'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #'api - utility' }
GtPlotterDataGroup class >> groupByDecorator: aCollectionOfDecorators [
	| aPreviousDecorator theGroups |
	aCollectionOfDecorators size <= 1
		ifTrue: [ ^ aCollectionOfDecorators ].
	
	theGroups := OrderedCollection new.
	
	aPreviousDecorator := nil.
	aCollectionOfDecorators do: [ :eachDecorator |
		aPreviousDecorator = eachDecorator
			ifTrue: [ theGroups last value addAll: eachDecorator entity values ]
			ifFalse: [ theGroups add: (eachDecorator -> (OrderedCollection withAll: eachDecorator entity values)) ].
		aPreviousDecorator := eachDecorator ].
	
	^ theGroups
		collect: [ :eachAssociation | eachAssociation key copy entity: (self new values: eachAssociation value asArray) ]
		as: Array
]

{ #category : #accessing }
GtPlotterDataGroup >> at: anIndex [
	^ self class new values: { self values at: anIndex }
]

{ #category : #accessing }
GtPlotterDataGroup >> children [
	^ #()
]

{ #category : #enumerating }
GtPlotterDataGroup >> collect: aBlock [
	^ self values collect: aBlock
]

{ #category : #'api - decorators' }
GtPlotterDataGroup >> decorated: aDecorationBlock [
	| theDecoratedValues theGroups |
	<return: #GtPlotterDataGroups>
	
	self size isZero
		ifTrue: [ ^ self ].
	
	(aDecorationBlock isKindOf: GtPlotterDataGroupDecorator)
		ifTrue: [ ^ aDecorationBlock copy entity: self ].

	theDecoratedValues := self values collect: [ :eachValue |
		| aGroup aDecorator |
		aGroup := self class new values: { eachValue }.
		aDecorator := aDecorationBlock cull: eachValue cull: aGroup.
		aDecorator entity: aGroup ].

	theGroups := self class groupByDecorator: theDecoratedValues.
	^ theGroups size = 1
		ifTrue: [ theGroups first ]
		ifFalse: [ GtPlotterDataVirtualGroups new entities: theGroups ]
]

{ #category : #'api - enumerating' }
GtPlotterDataGroup >> do: aBlock [
	aBlock value: self
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
GtPlotterDataGroup >> groupedBy: aBlock sorted: aSortBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>
	| theGroupedValues theAssociations theGroups |

	theGroupedValues := self values groupedBy: aBlock.
	
	theAssociations := theGroupedValues associations.
	aSortBlock
		ifNotNil: [ theAssociations := theAssociations sorted: [ :a :b | aSortBlock value: a value: b ] ].
	
	theGroups := theAssociations collect: [ :anAssociation |
		| aGroup aDecorator |
		aGroup := self class new values: anAssociation value.
		aDecorator := aDecorationBlock cull: anAssociation key cull: anAssociation value.
		self class decorate: aGroup with: aDecorator ].

	^ GtPlotterDataLogicalGroups new entities: theGroups
]

{ #category : #'api - grouping' }
GtPlotterDataGroup >> groupedBy: aBlock then: eachGroupBlock [
	<return: #GtPlotterDataGroups>
	| theGroupedValues theAssociations theGroups |

	theGroupedValues := self values groupedBy: aBlock.
	theAssociations := theGroupedValues associations.

	theGroups := theAssociations collect: [ :anAssociation |
		| aGroup aModifiedGroup |
		aGroup := self class new values: anAssociation value.
		aModifiedGroup := eachGroupBlock cull: aGroup cull: anAssociation key cull: anAssociation value.
		aModifiedGroup ].

	^ GtPlotterDataLogicalGroups new entities: theGroups
]

{ #category : #accessing }
GtPlotterDataGroup >> groups [
	<return: #GtPlotterDataGroups>

	^ GtPlotterDataVirtualGroups new entities: { self }
]

{ #category : #'api - enumerating' }
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

{ #category : #testing }
GtPlotterDataGroup >> isComposite [
	^ false
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
	^ self class new values: (self values sorted: aBlock)
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

{ #category : #'api - enumerating' }
GtPlotterDataGroup >> valuesDo: aBlock [
	self values do: aBlock
]

{ #category : #enumerating }
GtPlotterDataGroup >> withIndexCollect: aBlock [
	^ self values withIndexCollect: aBlock
]
