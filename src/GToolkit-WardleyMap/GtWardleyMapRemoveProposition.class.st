Class {
	#name : #GtWardleyMapRemoveProposition,
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
GtWardleyMapRemoveProposition >> decorateEdgeElement: anEdgeElement decoratorViewModel: aDecoratorViewModel [
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
			beRemoveProposition;
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
GtWardleyMapRemoveProposition >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new
		beRemoveProposition;
		wardleyMapNodeViewModel: aNodeElement wardleyMapNodeViewModel;
		wardleyMapDecoratorViewModel: aDecoratorViewModel;
		nodeElement: aNodeElement.
		
	BlTaskAction
		enqueueElement: aNodeElement 
		action: [ aNodeElement parent addChild: aHighlightElement ].
			
	acceptAction decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel.
	rejectAction decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel.
]

{ #category : #initialization }
GtWardleyMapRemoveProposition >> initialize [
	super initialize.

	acceptAction := GtWardleyMapAction new.
	acceptAction icon: BrGlamorousVectorIcons accept.
	acceptAction tooltip: 'Remove node'.
	acceptAction action: [ self onAcceptAction ].
	rejectAction := GtWardleyMapAction new.
	rejectAction icon: BrGlamorousVectorIcons cancel.
	rejectAction tooltip: 'Keep node'.
	rejectAction action: [ self onRejectAction ].
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