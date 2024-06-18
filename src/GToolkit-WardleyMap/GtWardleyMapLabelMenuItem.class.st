Class {
	#name : #GtWardleyMapLabelMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#instVars : [
		'text',
		'condition'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #accessing }
GtWardleyMapLabelMenuItem >> condition [
	^ condition ifNil: [ [ :aContextMenuItem | true ] ]
]

{ #category : #accessing }
GtWardleyMapLabelMenuItem >> condition: aBlock [
	condition := aBlock
]

{ #category : #converting }
GtWardleyMapLabelMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	(self condition cull: aContextMenuItem) ifFalse: [ ^ nil ].

	^ GtWardleyMapUtility newContextMenuLabel 
		text: (self text ifNil: [ '' ])
]

{ #category : #'gt - extensions' }
GtWardleyMapLabelMenuItem >> gtItemName [
	^ self text
		ifNil: [ 'Label' ]
		ifNotNil: [ :aText | 
			'Label: ' asRopedText
				foreground: BrGlamorousColors disabledButtonTextColor;
				append: ('{1}' format: {aText}) asRopedText ]
]

{ #category : #accessing }
GtWardleyMapLabelMenuItem >> text [
	^ text
]

{ #category : #accessing }
GtWardleyMapLabelMenuItem >> text: anObject [
	text := anObject
]
