Class {
	#name : #GtWardleyMapLepiterPageLink,
	#superclass : #Object,
	#traits : 'TGtWardleyMapDecoratorModel',
	#classTraits : 'TGtWardleyMapDecoratorModel classTrait',
	#instVars : [
		'page'
	],
	#category : #'GToolkit-WardleyMap-! Models - Decorators'
}

{ #category : #'api - wardley map decorator model' }
GtWardleyMapLepiterPageLink >> decorateNodeElement: aNodeElement decoratorViewModel: aDecoratorViewModel [
	aNodeElement
		labelContainerDo: [ :aLabelContainer | 
			| anActionContainer aButton |
			anActionContainer := GtWardleyMapUtility ensureRightDecoratorContainerFor: aLabelContainer.
			aButton := self newButton.
			aDecoratorViewModel weak
				when: GtWardleyMapNodeDecoratorViewModelRemoved
				send: #removeFromParent
				to: aButton.
			anActionContainer addChild: aButton. ]
]

{ #category : #accessing }
GtWardleyMapLepiterPageLink >> page [
	^ page
]

{ #category : #accessing }
GtWardleyMapLepiterPageLink >> page: anObject [
	page := anObject
]
