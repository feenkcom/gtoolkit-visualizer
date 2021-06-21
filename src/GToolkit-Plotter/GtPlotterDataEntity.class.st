Class {
	#name : #GtPlotterDataEntity,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #'api - utility' }
GtPlotterDataEntity class >> decorate: aGroup with: aDecoratorOrCollectionOfDecorators [
	<return: #GtPlotterDataGroupDecorator>

	^ aDecoratorOrCollectionOfDecorators isCollection
		ifTrue: [
			| anArray |
			anArray := aDecoratorOrCollectionOfDecorators asArray reversed.
			anArray inject: aGroup into: [ :aPreviousDecorator :aNextDecorator |
				aNextDecorator entity: aPreviousDecorator.
				aNextDecorator ].
			anArray last ]
		ifFalse: [ aDecoratorOrCollectionOfDecorators entity: aGroup ]
]

{ #category : #accessing }
GtPlotterDataEntity >> children [
	^ self subclassResponsibility
]

{ #category : #enumerating }
GtPlotterDataEntity >> collect: aBlock [
	^ self subclassResponsibility
]

{ #category : #enumerating }
GtPlotterDataEntity >> collectWithIndex: elementAndIndexBlock [
	"Use the new version with consistent naming"
	^ self withIndexCollect: elementAndIndexBlock
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> color [
	"Return transparent color if it is not defined"
	<return: #Color>
	self
		colorDo: [ :aColor | ^ aColor ].
	^ Color lightGray
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> colorDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithColor
		ifFound: [ :aDecorator | aBlock value: aDecorator color ]
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> colored: aColorBlock [
	<return: #GtPlotterDataGroups>

	^ self decorated: [ :eachValue | GtPlotterDataGroupWithColor new color: (aColorBlock gtValue: eachValue) ]
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>

	^ self subclassResponsibility
]

{ #category : #enumerating }
GtPlotterDataEntity >> detectDecorator: aBlock ifFound: aFoundBlock ifNone: anExceptionBlock [
	^ anExceptionBlock value
]

{ #category : #enumerating }
GtPlotterDataEntity >> detectDecoratorType: aDecoratorClass ifFound: aFoundBlock [
	self
		detectDecorator: [ :eachDecorator | eachDecorator isKindOf: aDecoratorClass ]
		ifFound: aFoundBlock
		ifNone: [  ]
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> do: aBlock [
	"A composite group should evaluate a Block with each if its direct sub-entity
	while single group or decorator evaluate it with itself"

	self subclassResponsibility
]

{ #category : #accessing }
GtPlotterDataEntity >> entities [
	^ self subclassResponsibility
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> entitiesDo: aBlock [
	"A composite group evaluates aBlock with each its entity, while non-composite group does nothing"

	self entities do: aBlock
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock [
	<return: #GtPlotterDataGroups>
	^ self
		groupedBy: aBlock
		decorated: [ :eachCriteria | GtPlotterDataGroupWithCriteria new criteria: eachCriteria ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock colored: aColorBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: nil
		colored: aColorBlock
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: nil
		decorated: aDecorationBlock
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock labelled: aLabelBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: nil
		labelled: aLabelBlock
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock labelled: aLabelBlock colored: aColorBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: nil
		decorated: [ :eachCriteria |  {
			GtPlotterDataGroupWithLabel new label: (aLabelBlock gtValue: eachCriteria).
			GtPlotterDataGroupWithColor new color: (aColorBlock gtValue: eachCriteria) } ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock named: aNameStringOrSymbol [
	<return: #GtPlotterDataGroups>
	^ self
		groupedBy: aBlock
		decorated: [ :eachCriteria |
			GtPlotterDataGroupWithNamedCriteria new
				criteria: eachCriteria;
				name: aNameStringOrSymbol ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock sorted: aSortBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: aSortBlock
		decorated: [ :eachCriteria | GtPlotterDataGroupWithCriteria new criteria: eachCriteria ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock sorted: aSortBlock colored: aColorBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: aSortBlock
		decorated: [ :eachCriteria | GtPlotterDataGroupWithColor new color: (aColorBlock gtValue: eachCriteria) ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock sorted: aSortBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>

	^ self subclassResponsibility
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock sorted: aSortBlock labelled: aLabelBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		sorted: aSortBlock 
		decorated: [ :eachCriteria | GtPlotterDataGroupWithLabel new label: (aLabelBlock gtValue: eachCriteria) ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock then: eachGroupBlock [
	<return: #GtPlotterDataGroups>

	^ self subclassResponsibility
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> grouping [
	"Return false if grouping is not set"
	<return: #Boolean>

	self groupingDo: [ :isGrouping | ^ isGrouping ].
	^ false
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> groupingDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithGrouping
		ifFound: [ :aDecorator | aBlock value: aDecorator isGrouping ]
]

{ #category : #accessing }
GtPlotterDataEntity >> groups [
	<return: #GtPlotterDataGroups>

	^ self subclassResponsibility
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> groupsCollect: aBlock [
	^ Array streamContents: [ :aStream | self groupsDo: [ :eachGroup | aStream nextPut: (aBlock value: eachGroup) ] ]
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> groupsDo: aBlock [
	self subclassResponsibility
]

{ #category : #'gt-extension' }
GtPlotterDataEntity >> gtGroupsFor: aView [
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtPlotterDataEntity >> gtItemsFor: aView [
	^ self subclassResponsibility
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> inject: thisValue intoValues: binaryBlock [ 
	| nextValue |
	
	nextValue := thisValue.
	self valuesDo: [ :each | nextValue := binaryBlock value: nextValue value: each ].
	^ nextValue
]

{ #category : #testing }
GtPlotterDataEntity >> isComposite [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPlotterDataEntity >> isDecorator [
	^ false
]

{ #category : #testing }
GtPlotterDataEntity >> isLogicalGroup [
	^ false
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> label [
	"Return empty string if there is no label"
	<return: #String>
	
	self labelDo: [ :aLabel | ^ aLabel ].
	^ ''
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> labelDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithLabel
		ifFound: [ :aDecorator | aBlock value: aDecorator label ]
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> labelled: aLabelBlock [
	<return: #GtPlotterDataGroups>

	^ self decorated: [ :eachValue | GtPlotterDataGroupWithLabel new label: (aLabelBlock gtValue: eachValue) ]
]

{ #category : #accessing }
GtPlotterDataEntity >> size [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> stacking [
	"Return false if stacking property is not set"
	<return: #Boolean>
	
	self stackingDo: [ :isStacking | ^ isStacking ].
	^ false
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> stacking: aBoolean [
	<return: #GtPlotterDataGroups>

	^ self decorated: (GtPlotterDataGroupWithStacking new isStacking: aBoolean)
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> stackingDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithStacking
		ifFound: [ :aDecorator | aBlock value: aDecorator isStacking ]
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> values [
	^ self subclassResponsibility
]

{ #category : #'api - enumerating' }
GtPlotterDataEntity >> valuesDo: aBlock [
	self subclassResponsibility
]

{ #category : #enumerating }
GtPlotterDataEntity >> withIndexCollect: aBlock [
	^ self subclassResponsibility
]
