Class {
	#name : #GtWardleyMapHighlight,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'parent',
		'highlightType'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapHighlight >> decorateEdgeElementInContext: anEdgeDecoratorContext [
	| anEdgeViewModel aCanvasElement aFromNodeElement aToNodeElement aPropositionElement |
	anEdgeViewModel := anEdgeDecoratorContext edgeElement wardleyMapEdgeViewModel.
	aCanvasElement := anEdgeDecoratorContext canvasElement.
	aFromNodeElement := anEdgeDecoratorContext fromNodeElement.
	aToNodeElement := anEdgeDecoratorContext toNodeElement.

	aPropositionElement := GtWardleyMapEdgePropositionElement new.
	self setHighlightTypeOn: aPropositionElement.
	aPropositionElement
		wardleyMapEdgeViewModel: anEdgeViewModel;
		wardleyMapDecoratorViewModel: anEdgeDecoratorContext decoratorViewModel;
		edgeElement: anEdgeDecoratorContext edgeElement;
		fromAnchor: (BlNearestPositionEllipseAnchor
				referenceElement: aFromNodeElement
				relatedTo: aToNodeElement);
		toAnchor: (BlNearestPositionEllipseAnchor
				referenceElement: aToNodeElement
				relatedTo: aFromNodeElement).

	aCanvasElement addChild: aPropositionElement
]

{ #category : #accessing }
GtWardleyMapHighlight >> decorateNodeElementInContext: aNodeDecoratorContext [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new.
	self setHighlightTypeOn: aHighlightElement.
	aHighlightElement
		wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
		wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel;
		nodeElement: aNodeDecoratorContext nodeElement.

	aNodeDecoratorContext canvasElement addChild: aHighlightElement
]

{ #category : #accessing }
GtWardleyMapHighlight >> highlightType [
	^ highlightType
]

{ #category : #accessing }
GtWardleyMapHighlight >> highlightType: aSymbol [
	highlightType := aSymbol
]

{ #category : #initialization }
GtWardleyMapHighlight >> initialize [
	super initialize
]

{ #category : #initialization }
GtWardleyMapHighlight >> parent: aParent [
	self assert: [ parent isNil ] description: [ 'Only one parent is allowed' ].

	parent := aParent
]

{ #category : #copying }
GtWardleyMapHighlight >> postCopy [
	super postCopy.
	parent := nil
]

{ #category : #initialization }
GtWardleyMapHighlight >> removeParent [
	parent := nil
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapHighlight >> setHighlightTypeOn: aPropositionElement [
	highlightType = #add
		ifTrue: [ aPropositionElement beAddProposition ]
		ifFalse: [ highlightType = #remove
				ifTrue: [ aPropositionElement beRemoveProposition ]
				ifFalse: [ aPropositionElement beHighlight ] ]
]
