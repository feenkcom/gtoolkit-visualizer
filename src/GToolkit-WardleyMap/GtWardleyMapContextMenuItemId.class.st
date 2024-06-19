Class {
	#name : #GtWardleyMapContextMenuItemId,
	#superclass : #BlElementId,
	#instVars : [
		'definingMethod'
	],
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'instance creation' }
GtWardleyMapContextMenuItemId class >> definingMethod: aCompiledMethod [
	^ self new definingMethod: aCompiledMethod
]

{ #category : #comparing }
GtWardleyMapContextMenuItemId >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ self definingMethod = anObject definingMethod
]

{ #category : #converting }
GtWardleyMapContextMenuItemId >> asSymbol [
	^ #'wardley--context-menu-item-{1}' format: {self definingMethod printString}
]

{ #category : #accessing }
GtWardleyMapContextMenuItemId >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtWardleyMapContextMenuItemId >> definingMethod: aCompiledMethod [
	definingMethod := aCompiledMethod
]

{ #category : #comparing }
GtWardleyMapContextMenuItemId >> hash [
	^ self class hash bitXor: self definingMethod hash
]
