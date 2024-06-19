Class {
	#name : #GtWardleyMapStencilMenuItem,
	#superclass : #Object,
	#traits : 'TGtWardleyMapContextMenuItem',
	#classTraits : 'TGtWardleyMapContextMenuItem classTrait',
	#instVars : [
		'condition',
		'block',
		'name'
	],
	#category : #'GToolkit-WardleyMap-Helpers - Context Menu'
}

{ #category : #accessing }
GtWardleyMapStencilMenuItem >> block [
	^ block
]

{ #category : #accessing }
GtWardleyMapStencilMenuItem >> block: aBlock [
	"A block receives one optional parameter:
	 - a context menu item
	[ :aContextMenuItem |  ].
	
	Block action must not be nil."

	block := aBlock
]

{ #category : #accessing }
GtWardleyMapStencilMenuItem >> condition [
	^ condition ifNil: [ [ :aContextMenuItem | true ] ]
]

{ #category : #accessing }
GtWardleyMapStencilMenuItem >> condition: anObject [
	condition := anObject
]

{ #category : #converting }
GtWardleyMapStencilMenuItem >> createElementUsingContext: aContextMenuItem [
	<return: #BlElement or: nil>
	(self condition cull: aContextMenuItem) ifFalse: [ ^ nil ].

	^ self block cull: aContextMenuItem
]

{ #category : #'gt - extensions' }
GtWardleyMapStencilMenuItem >> gtItemName [
	^ self name ifNil: [ 'Element stencil' ]
]

{ #category : #accessing }
GtWardleyMapStencilMenuItem >> name [
	^ name
]

{ #category : #accessing }
GtWardleyMapStencilMenuItem >> name: anObject [
	name := anObject
]
