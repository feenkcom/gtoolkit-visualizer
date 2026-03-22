Class {
	#name : #GtWardleyMapHighlight,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'parent'
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

	aPropositionElement := GtWardleyMapEdgePropositionElement new
			beHighlight;
			wardleyMapEdgeViewModel: anEdgeViewModel;
			wardleyMapDecoratorViewModel: anEdgeDecoratorContext decoratorViewModel;
			edgeElement: anEdgeDecoratorContext edgeElement;
			fromAnchor: (BlNearestPositionEllipseAnchor
					referenceElement: aFromNodeElement
					relatedTo: aToNodeElement);
			toAnchor: (BlNearestPositionEllipseAnchor
					referenceElement: aToNodeElement
					relatedTo: aFromNodeElement).

	aCanvasElement addChild: aPropositionElement.
]

{ #category : #accessing }
GtWardleyMapHighlight >> decorateNodeElementInContext: aNodeDecoratorContext [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new
		beHighlight;
		wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
		wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel;
		nodeElement: aNodeDecoratorContext nodeElement.
		
	aNodeDecoratorContext canvasElement addChild: aHighlightElement.
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

{ #category : #initialization }
GtWardleyMapHighlight >> removeParent [
	parent := nil
]
