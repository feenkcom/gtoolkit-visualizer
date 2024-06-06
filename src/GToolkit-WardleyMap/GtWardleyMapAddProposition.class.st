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
	#category : #'GToolkit-WardleyMap-Helpers - Actions'
}

{ #category : #accessing }
GtWardleyMapAddProposition >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	| aHighlightElement |
	aHighlightElement := GtWardleyMapNodePropositionElement new
		beAddProposition;
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
