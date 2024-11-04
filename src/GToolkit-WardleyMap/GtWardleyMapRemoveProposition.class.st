Class {
	#name : #GtWardleyMapRemoveProposition,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'acceptAction',
		'rejectAction',
		'parent',
		'isReadOnly'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'as yet unclassified' }
GtWardleyMapRemoveProposition >> beReadOnly [
	isReadOnly := true
]

{ #category : #'api - wardley map decorator model' }
GtWardleyMapRemoveProposition >> decorateEdgeElementInContext: anEdgeDecoratorContext [
	| anEdgeViewModel aCanvasElement aFromNodeElement aToNodeElement aPropositionElement |
	anEdgeViewModel := anEdgeDecoratorContext edgeElement wardleyMapEdgeViewModel.
	aCanvasElement := anEdgeDecoratorContext canvasElement.
	aFromNodeElement := anEdgeDecoratorContext fromNodeElement.
	aToNodeElement := anEdgeDecoratorContext toNodeElement.

	aPropositionElement := GtWardleyMapEdgePropositionElement new
			beRemoveProposition;
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

	isReadOnly
		ifFalse: [ acceptAction decorateEdgeElementInContext: anEdgeDecoratorContext.
			rejectAction decorateEdgeElementInContext: anEdgeDecoratorContext ]
]

{ #category : #accessing }
GtWardleyMapRemoveProposition >> decorateNodeElementInContext: aNodeDecoratorContext [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new
			beRemoveProposition;
			wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
			wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel;
			nodeElement: aNodeDecoratorContext nodeElement.

	aNodeDecoratorContext canvasElement addChild: aHighlightElement.

	isReadOnly
		ifFalse: [ acceptAction decorateNodeElementInContext: aNodeDecoratorContext.
			rejectAction decorateNodeElementInContext: aNodeDecoratorContext ]
]

{ #category : #initialization }
GtWardleyMapRemoveProposition >> initialize [
	super initialize.

	acceptAction := GtWardleyMapAction new.
	acceptAction elementId: GtWardleyMapRemoveAcceptId.
	acceptAction icon: BrGlamorousVectorIcons accept.
	acceptAction tooltip: 'Remove'.
	acceptAction action: [ self onAcceptAction ].
	rejectAction := GtWardleyMapAction new.
	rejectAction elementId: GtWardleyMapRemoveRejectId.
	rejectAction icon: BrGlamorousVectorIcons cancel.
	rejectAction tooltip: 'Keep'.
	rejectAction action: [ self onRejectAction ].
]

{ #category : #testing }
GtWardleyMapRemoveProposition >> isActionableProposition [
	"Return true if it can be handled by GtWardleyMapAllProposition.
	Such decorator must implement #onAcceptAction and #onRejectAction methods.
	Return false in other cases."

	<return: #Boolean>
	^ true
]

{ #category : #'event handling' }
GtWardleyMapRemoveProposition >> onAcceptAction [
	parent ifNil: [ ^ self ].
	parent removeFromMap.
]

{ #category : #'event handling' }
GtWardleyMapRemoveProposition >> onRejectAction [
	parent ifNil: [ ^ self ].
	parent removeWardleyMapDecoratorModel: self.
]

{ #category : #initialization }
GtWardleyMapRemoveProposition >> parent: aParent [
	self assert: [ parent isNil ] description: [ 'Only one parent is allowed' ].

	parent := aParent
]

{ #category : #initialization }
GtWardleyMapRemoveProposition >> removeParent [
	parent := nil
]
