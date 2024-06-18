Trait {
	#name : #TGtWardleyMapContextMenuItem,
	#instVars : [
		'definingMethod'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #converting }
TGtWardleyMapContextMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	^ nil
]

{ #category : #accessing }
TGtWardleyMapContextMenuItem >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
TGtWardleyMapContextMenuItem >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #'gt - extensions' }
TGtWardleyMapContextMenuItem >> gtCreateElementUsingContextMethodFor: aView [
	<gtView>
	^ aView forward
		title: 'Element creation';
		object: [ (self class >> #createElementUsingContext:) asRingDefinition ];
		view: #gtSourceFor:
]

{ #category : #'gt - extensions' }
TGtWardleyMapContextMenuItem >> gtDefiningMethodFor: aView [
	<gtView>
	self definingMethod ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Defining method';
		object: [ self definingMethod asRingDefinition ];
		view: #gtSourceFor:
]

{ #category : #'gt - extensions' }
TGtWardleyMapContextMenuItem >> gtItemName [
	^ self gtDisplayText
]
