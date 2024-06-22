Class {
	#name : #GtWardleyMapAddProposition,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'acceptAction',
		'rejectAction',
		'parent'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAddProposition >> decorateEdgeElement: anEdgeElement decoratorViewModel: aDecoratorViewModel [
	"The parent (map canvas) might not be available yet at the moment of decoration creation.
	For that reason the add-child action is postponed."
	
	BlTaskAction enqueueElement: anEdgeElement action: [
		| anEdgeViewModel aMapElement aFromNodeElement aToNodeElement aPropositionElement |
		anEdgeViewModel := anEdgeElement wardleyMapEdgeViewModel.
		aMapElement := anEdgeElement parent.
		aFromNodeElement := aMapElement
				nodeViewFor: anEdgeViewModel fromNodeViewModel
				ifFound: [ :anElement | anElement ]
				ifNone: [ nil ].
	
		aToNodeElement := aMapElement
				nodeViewFor: anEdgeViewModel toNodeViewModel
				ifFound: [ :anElement | anElement ]
				ifNone: [ nil ].
	
		aPropositionElement := GtWardleyMapEdgePropositionElement new
			beAddProposition;
			wardleyMapEdgeViewModel: anEdgeViewModel;
			wardleyMapDecoratorViewModel: aDecoratorViewModel;
			fromAnchor: (BlNearestPositionEllipseAnchor
					referenceElement: aFromNodeElement
					relatedTo: aToNodeElement);
			toAnchor: (BlNearestPositionEllipseAnchor
					referenceElement: aToNodeElement
					relatedTo: aFromNodeElement).
					
		aMapElement addChild: aPropositionElement ]
]

{ #category : #accessing }
GtWardleyMapAddProposition >> decorateNodeElementInContext: aNodeDecoratorContext [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new
		beAddProposition;
		wardleyMapNodeViewModel: aNodeDecoratorContext nodeViewModel;
		wardleyMapDecoratorViewModel: aNodeDecoratorContext decoratorViewModel;
		nodeElement: aNodeDecoratorContext nodeElement.
		
	aNodeDecoratorContext canvasElement addChild: aHighlightElement.
			
	acceptAction decorateNodeElementInContext: aNodeDecoratorContext.
	rejectAction decorateNodeElementInContext: aNodeDecoratorContext
]

{ #category : #initialization }
GtWardleyMapAddProposition >> initialize [
	super initialize.

	acceptAction := GtWardleyMapAction new.
	acceptAction icon: BrGlamorousVectorIcons accept.
	acceptAction tooltip: 'Keep node'.
	acceptAction action: [ self onAcceptAction ].
	rejectAction := GtWardleyMapAction new.
	rejectAction icon: BrGlamorousVectorIcons cancel.
	rejectAction action: [ self onRejectAction ].
	rejectAction tooltip: 'Remove node'.
]

{ #category : #'event handling' }
GtWardleyMapAddProposition >> onAcceptAction [
	parent ifNil: [ ^ self ].
	parent removeWardleyMapDecoratorModel: self.
]

{ #category : #'event handling' }
GtWardleyMapAddProposition >> onRejectAction [
	parent ifNil: [ ^ self ].
	parent removeFromMap.
]

{ #category : #initialization }
GtWardleyMapAddProposition >> parent: aParent [
	self assert: [ parent isNil ] description: [ 'Only one parent is allowed' ].

	parent := aParent
]

{ #category : #initialization }
GtWardleyMapAddProposition >> removeParent [
	parent := nil
]
