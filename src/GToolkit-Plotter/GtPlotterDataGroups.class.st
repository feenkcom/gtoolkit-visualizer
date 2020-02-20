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

{ #category : #enumerating }
GtPlotterDataGroups >> collect: aBlock [
	^ self entities collect: aBlock
]

{ #category : #'instance creation' }
GtPlotterDataGroups >> decorate: aGroupDecorator [
	"Apply a given decorator on top of the cookies group as the last decorator"

	^ aGroupDecorator cookiesGroup: self
]

{ #category : #'api - decoration' }
GtPlotterDataGroups >> decorated: aBlock [
	<return: #GtPlotterDaraGroups>

	^ self class new groups: (self collect: aBlock)
]

{ #category : #'api - decoration' }
GtPlotterDataGroups >> decoratedWith: aGroupDecoratorBlock suchAs: aBlock [
	^ self decorated: [ :eachGroup | eachGroup decoratedWith: aGroupDecoratorBlock suchAs: aBlock ]
]

{ #category : #enumerating }
GtPlotterDataGroups >> do: aBlock [
	self groupsDo: aBlock
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
GtPlotterDataGroups >> groupedBy: aBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>
	| anArrayOfGroups |
	
	anArrayOfGroups := self entities collect: [ :eachGroupOrGroups | eachGroupOrGroups groupedBy: aBlock decorated: aDecorationBlock ].
	^ self class new entities: anArrayOfGroups
]

{ #category : #accessing }
GtPlotterDataGroups >> groupsDo: aBlock [
	self entities do: [ :eachGroupOrGroups | eachGroupOrGroups groupsDo: aBlock ]
]

{ #category : #'gt-extension' }
GtPlotterDataGroups >> gtGroupsFor: aView [
	<gtView>

	^ aView tree
		title: 'Groups';
		priority: 35;
		expandAll;
		items: [ { self } ];
		children: #entities
]

{ #category : #'gt-extension' }
GtPlotterDataGroups >> gtItemsFor: aView [
	<gtView>

	^ aView empty
]

{ #category : #enumerating }
GtPlotterDataGroups >> inject: thisValue into: binaryBlock [ 
	"Accumulate a running value associated with evaluating the argument, binaryBlock, with the current value of the argument, thisValue, and the receiver as block arguments."
	
	"( #(1 2 3) inject: 0 into: [ :sum :each | sum + each ] ) >>> 6"

	| nextValue |
	nextValue := thisValue.
	self groupsDo: [ :each | nextValue := binaryBlock value: nextValue value: each ].
	^ nextValue
]

{ #category : #testing }
GtPlotterDataGroups >> isComposite [
	^ true
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
