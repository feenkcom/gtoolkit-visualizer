Class {
	#name : #GtPlotterDataGroups,
	#superclass : #GtPlotterDataEntity,
	#instVars : [
		'entities'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #accessing }
GtPlotterDataGroups >> at: anIndex [
	^ self entities at: anIndex
]

{ #category : #accessing }
GtPlotterDataGroups >> children [
	^ self entities
]

{ #category : #enumerating }
GtPlotterDataGroups >> collect: aBlock [
	^ self entities collect: aBlock
]

{ #category : #'api - decoration' }
GtPlotterDataGroups >> decorated: aBlock [
	<return: #GtPlotterDataGroups>

	^ self class new entities: (self collect: [ :eachEntity | eachEntity decorated: aBlock ])
]

{ #category : #'api - enumerating' }
GtPlotterDataGroups >> do: aBlock [
	"Evaluate a given block with each of my direct entities"

	self entities do: aBlock
]

{ #category : #accessing }
GtPlotterDataGroups >> entities [
	^ entities
]

{ #category : #accessing }
GtPlotterDataGroups >> entities: aCollectionOfEntities [
	entities := aCollectionOfEntities
]

{ #category : #grouping }
GtPlotterDataGroups >> groupedBy: aBlock sorted: aSortBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>
	| anArrayOfGroups |
	
	anArrayOfGroups := self entities collect: [ :eachGroupOrGroups | eachGroupOrGroups groupedBy: aBlock sorted: aSortBlock decorated: aDecorationBlock ].
	^ self class new entities: anArrayOfGroups
]

{ #category : #'api - grouping' }
GtPlotterDataGroups >> groupedBy: aBlock then: eachGroupBlock [
	<return: #GtPlotterDataGroups>
	| anArrayOfGroups |
	
	anArrayOfGroups := self entities collect: [ :eachGroupOrGroups | eachGroupOrGroups groupedBy: aBlock then: eachGroupBlock ].
	^ self class new entities: anArrayOfGroups
]

{ #category : #accessing }
GtPlotterDataGroups >> groups [
	<return: #GtPlotterDataGroups>

	^ self
]

{ #category : #'api - enumerating' }
GtPlotterDataGroups >> groupsDo: aBlock [
	"Evaluate a block with all groups (containers of values)"

	self entities do: [ :eachGroupOrGroups | eachGroupOrGroups groupsDo: aBlock ]
]

{ #category : #'gt-extension' }
GtPlotterDataGroups >> gtGroupsFor: aView [
	<gtView>

	^ aView tree
		title: 'Groups';
		priority: 1;
		expandAll;
		items: [ { self } ];
		children: #children
]

{ #category : #'gt-extension' }
GtPlotterDataGroups >> gtItemsFor: aView [
	<gtView>

	^ aView empty
]

{ #category : #enumerating }
GtPlotterDataGroups >> inject: thisValue into: binaryBlock [ 
	| nextValue |
	
	nextValue := thisValue.
	self groupsDo: [ :each | nextValue := binaryBlock value: nextValue value: each ].
	^ nextValue
]

{ #category : #testing }
GtPlotterDataGroups >> isComposite [
	^ true
]

{ #category : #testing }
GtPlotterDataGroups >> isLogical [
	<return: #Boolean>

	^ false
]

{ #category : #testing }
GtPlotterDataGroups >> isLogicalGroup [
	^ self isLogical
]

{ #category : #testing }
GtPlotterDataGroups >> isVirtual [
	<return: #Boolean>

	^ false
]

{ #category : #printing }
GtPlotterDataGroups >> printOn: aStream [
	aStream
		nextPutAll: 'Groups (';
		nextPutAll: self size asString;
		nextPut: $)
]

{ #category : #accessing }
GtPlotterDataGroups >> size [
	"Return the amount of my direct sub-entities"
	<return: #Number>

	^ self entities size
]

{ #category : #sorting }
GtPlotterDataGroups >> sorted: aSortBlock [
	<return: #GtPlotterDataGroups>

	^ self class new entities: (self entities sorted: aSortBlock)
]

{ #category : #'api - enumerating' }
GtPlotterDataGroups >> values [
	^ Array streamContents: [ :aStream | self entities do: [ :eachEntity | aStream nextPutAll: eachEntity values ] ]
]

{ #category : #'api - enumerating' }
GtPlotterDataGroups >> valuesDo: aBlock [
	self entities do: [ :eachEntity | eachEntity valuesDo: aBlock ]
]

{ #category : #enumerating }
GtPlotterDataGroups >> withIndexCollect: aBlock [
	^ self entities withIndexCollect: aBlock
]
