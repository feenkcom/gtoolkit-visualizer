Class {
	#name : #GtWardleyMapNodeButtonWithLabelMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#instVars : [
		'label',
		'action',
		'condition'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #accessing }
GtWardleyMapNodeButtonWithLabelMenuItem >> action [
	^ action ifNil: [ [ nil ] ]
]

{ #category : #accessing }
GtWardleyMapNodeButtonWithLabelMenuItem >> action: aBlock [
	"An action can be a block with two optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	[ :aContextMenuItem :aButtonElement :aButtonModel :anEvent |  ].

	Button action must not be nil"

	action := aBlock
]

{ #category : #accessing }
GtWardleyMapNodeButtonWithLabelMenuItem >> condition [
	^ condition ifNil: [ [ :aContextMenuItem | true ] ]
]

{ #category : #accessing }
GtWardleyMapNodeButtonWithLabelMenuItem >> condition: aBlock [
	condition := aBlock
]

{ #category : #converting }
GtWardleyMapNodeButtonWithLabelMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	(self condition cull: aContextMenuItem) ifFalse: [ ^ nil ].
	
	^ GtWardleyMapUtility newMenuItemButtonWithLabel
		label: self label;
		action: ([ :aButtonElement :aButtonModel :anEvent | 
			self action cull: aContextMenuItem cull: aButtonElement cull: aButtonModel cull: anEvent ])
]

{ #category : #'gt - extensions' }
GtWardleyMapNodeButtonWithLabelMenuItem >> gtItemName [
	^ self label
		ifNil: [ 'Button' ]
		ifNotNil: [ :aText | 
			'Button: ' asRopedText
				foreground: BrGlamorousColors disabledButtonTextColor;
				append: ('{1}' format: {aText}) asRopedText ]
]

{ #category : #'as yet unclassified' }
GtWardleyMapNodeButtonWithLabelMenuItem >> label [
	^ label ifNil: [ 'Action' ]
]

{ #category : #accessing }
GtWardleyMapNodeButtonWithLabelMenuItem >> label: anObject [
	label := anObject
]
