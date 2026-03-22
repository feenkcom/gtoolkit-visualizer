Class {
	#name : #GtPlotterDataGroupDecorator,
	#superclass : #GtPlotterDataEntity,
	#instVars : [
		'entity'
	],
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #accessing }
GtPlotterDataGroupDecorator >> at: anIndex [
	^ self copy entity: (self entity at: anIndex)
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> children [
	^ { self entity }
]

{ #category : #'api - enumerating' }
GtPlotterDataGroupDecorator >> collect: aBlock [
	^ self entity collect: aBlock
]

{ #category : #copying }
GtPlotterDataGroupDecorator >> copyWithDeepestEntity: anEntity [
	^ self entity isDecorator
		ifTrue: [ self copy entity: (self entity copyWithDeepestEntity: anEntity) ]
		ifFalse: [ self copy entity: anEntity ]
]

{ #category : #'api - decorators' }
GtPlotterDataGroupDecorator >> decorated: aDecorationBlock [
	<return: #GtPlotterDataEntity>
	
	^ self copy entity: (self entity decorated: aDecorationBlock)
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> decoratedEntity [
	^ self entity isDecorator
		ifTrue: [ self entity decoratedEntity ]
		ifFalse: [ self entity ]
]

{ #category : #enumerating }
GtPlotterDataGroupDecorator >> detectDecorator: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	^ self entity
		detectDecorator: aBlock
		ifFound: aFoundBlock
		ifNone: [ (aBlock value: self)
			ifTrue: [ aFoundBlock value: self ]
			ifFalse: anExceptionBlock ]
]

{ #category : #enumerating }
GtPlotterDataGroupDecorator >> do: aBlock [
	aBlock value: self
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> entities [
	^ self entity entities
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
GtPlotterDataGroupDecorator >> groupedBy: aBlock sorted: aSortBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>

	^ self copy entity: (self entity groupedBy: aBlock sorted: aSortBlock decorated: aDecorationBlock)
]

{ #category : #enumerating }
GtPlotterDataGroupDecorator >> groupedBy: aBlock then: eachGroupBlock [
	<return: #GtPlotterDataGroups>

	^ self copy entity: (self entity groupedBy: aBlock then: eachGroupBlock)
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> groups [
	<return: #GtPlotterDataGroups>

	^ GtPlotterDataVirtualGroups new entities: (self entities collect: [ :eachEntity | self copyWithDeepestEntity: eachEntity ])
]

{ #category : #'api - enumerating' }
GtPlotterDataGroupDecorator >> groupsDo: aBlock [
	self decoratedEntity groupsDo: [ :eachGroup | aBlock value: (self copyWithDeepestEntity: eachGroup) ]
]

{ #category : #'gt-extension' }
GtPlotterDataGroupDecorator >> gtGroupsFor: aView [
	<gtView>

	^ aView tree
		title: 'Groups';
		priority: 1;
		expandAll;
		items: [ { self } ];
		children: #children
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
GtPlotterDataGroupDecorator >> isComposite [
	^ self entity isComposite
]

{ #category : #testing }
GtPlotterDataGroupDecorator >> isDecorator [
	^ true
]

{ #category : #testing }
GtPlotterDataGroupDecorator >> isLogicalGroup [
	^ self entity isLogicalGroup
]

{ #category : #copying }
GtPlotterDataGroupDecorator >> postCopy [
	entity := nil
]

{ #category : #accessing }
GtPlotterDataGroupDecorator >> size [
	<return: #Number>

	^ self entity size
]

{ #category : #'api - enumerating' }
GtPlotterDataGroupDecorator >> values [
	^ self entity values
]

{ #category : #'api - enumerating' }
GtPlotterDataGroupDecorator >> valuesDo: aBlock [
	self entity valuesDo: aBlock
]

{ #category : #'api - enumerating' }
GtPlotterDataGroupDecorator >> withIndexCollect: aBlock [
	^ self entity withIndexCollect: aBlock
]
