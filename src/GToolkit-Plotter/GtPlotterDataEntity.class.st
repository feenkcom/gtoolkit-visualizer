Class {
	#name : #GtPlotterDataEntity,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Data'
}

{ #category : #enumerating }
GtPlotterDataEntity >> collect: aBlock [
	^ self subclassResponsibility
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> colorDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithColor
		ifFound: [ :aDecorator | aBlock value: aDecorator color ]
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

{ #category : #accessing }
GtPlotterDataEntity >> entities [
	^ self subclassResponsibility
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
		decorated: [ :eachCriteria | GtPlotterDataGroupWithColor new color: (aColorBlock gtValue: eachCriteria) ]
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock decorated: aDecorationBlock [
	<return: #GtPlotterDataGroups>

	^ self subclassResponsibility
]

{ #category : #'api - grouping' }
GtPlotterDataEntity >> groupedBy: aBlock labelled: aLabelBlock [
	<return: #GtPlotterDataGroups>

	^ self
		groupedBy: aBlock
		decorated: [ :eachCriteria | GtPlotterDataGroupWithLabel new label: (aLabelBlock gtValue: eachCriteria) ]
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

{ #category : #'api - decorators' }
GtPlotterDataEntity >> groupingDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithColor
		ifFound: [ :aDecorator | aBlock value: aDecorator isGrouping ]
]

{ #category : #'gt-extension' }
GtPlotterDataEntity >> gtGroupsFor: aView [
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtPlotterDataEntity >> gtItemsFor: aView [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPlotterDataEntity >> isComposite [
	^ false
]

{ #category : #testing }
GtPlotterDataEntity >> isDecorator [
	^ false
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> labelDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithColor
		ifFound: [ :aDecorator | aBlock value: aDecorator label ]
]

{ #category : #accessing }
GtPlotterDataEntity >> size [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - decorators' }
GtPlotterDataEntity >> stackingDo: aBlock [
	self
		detectDecoratorType: GtPlotterDataGroupWithColor
		ifFound: [ :aDecorator | aBlock value: aDecorator isStacking ]
]
