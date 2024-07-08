Class {
	#name : #GtWardleyMapAllProposition,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'parent'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapAllProposition >> decorateMapElementInContext: aMapDecoratorContext [
	| anActionContainer anElement |
	anActionContainer := GtWardleyMapUtility
			ensureTopRightInnerDecoratorContainerFor: aMapDecoratorContext canvasElement.
	anElement := GtWardleyMapAllPropositionElement new
		wardleyMapViewModel: aMapDecoratorContext mapViewModel;
		wardleyMapDecoratorViewModel: aMapDecoratorContext decoratorViewModel.
		
	anActionContainer addChild: anElement.
]

{ #category : #private }
GtWardleyMapAllProposition >> evaluateAllActionablePropositionsCalling: aSymbol [
	parent nodes copy
		do: [ :eachNode | 
			eachNode wardleyMapDecoratorModels copy
				do: [ :eachDecorator | eachDecorator isActionableProposition ifTrue: [ eachDecorator perform: aSymbol ] ] ].
	parent edges copy
		do: [ :eachNode | 
			eachNode wardleyMapDecoratorModels copy
				do: [ :eachDecorator | eachDecorator isActionableProposition ifTrue: [ eachDecorator perform: aSymbol ] ] ].
	parent wardleyMapDecoratorModels copy
		do: [ :eachDecorator | eachDecorator isActionableProposition ifTrue: [ eachDecorator perform: aSymbol ] ]
]

{ #category : #testing }
GtWardleyMapAllProposition >> isAllProposition [
	"Return true if it is a GtWardleyMapAllProposition.
	Return false in other cases."

	<return: #Boolean>
	^ true
]

{ #category : #'event handling' }
GtWardleyMapAllProposition >> onAcceptAction [
	"Note that it does not remove itself from the model as it is the element
	which makes itself visible or hidden based on actionable proposition count."

	parent ifNil: [ ^ self ].
	self evaluateAllActionablePropositionsCalling: #onAcceptAction
]

{ #category : #'event handling' }
GtWardleyMapAllProposition >> onRejectAction [
	"Note that it does not remove itself from the model as it is the element
	which makes itself visible or hidden based on actionable proposition count."

	parent ifNil: [ ^ self ].
	self evaluateAllActionablePropositionsCalling: #onRejectAction
]

{ #category : #initialization }
GtWardleyMapAllProposition >> parent: aParent [
	self assert: [ parent isNil ] description: [ 'Only one parent is allowed' ].
	self assert: [ aParent isKindOf: GtWardleyMapModel ] description: [ 'I properly work only with map models' ].

	parent := aParent
]

{ #category : #initialization }
GtWardleyMapAllProposition >> removeParent [
	parent := nil
]
