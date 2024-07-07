Class {
	#name : #GtWardleyMapAllProposition,
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
GtWardleyMapAllProposition >> decorateMapElementInContext: aMapDecoratorContext [
	acceptAction decorateMapElementInContext: aMapDecoratorContext.
	rejectAction decorateMapElementInContext: aMapDecoratorContext
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

{ #category : #initialization }
GtWardleyMapAllProposition >> initialize [
	super initialize.

	acceptAction := GtWardleyMapAction new.
	acceptAction elementId: GtWardleyMapAllAcceptId.
	acceptAction icon: BrGlamorousVectorIcons accept.
	acceptAction tooltip: 'Accept all'.
	acceptAction action: [ self onAcceptAction ].
	rejectAction := GtWardleyMapAction new.
	rejectAction elementId: GtWardleyMapAllRejectId.
	rejectAction icon: BrGlamorousVectorIcons cancel.
	rejectAction action: [ self onRejectAction ].
	rejectAction tooltip: 'Reject all'.
]

{ #category : #'event handling' }
GtWardleyMapAllProposition >> onAcceptAction [
	parent ifNil: [ ^ self ].
	self evaluateAllActionablePropositionsCalling: #onAcceptAction.
	parent removeWardleyMapDecoratorModel: self
]

{ #category : #'event handling' }
GtWardleyMapAllProposition >> onRejectAction [
	parent ifNil: [ ^ self ].
	self evaluateAllActionablePropositionsCalling: #onRejectAction.
	parent removeWardleyMapDecoratorModel: self
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
