Class {
	#name : #GtNestedTreeCollection,
	#superclass : #GtNestedTreeItem,
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #testing }
GtNestedTreeCollection class >> isAbstract [
	^ self name = #GtNestedTreeCollection 
]

{ #category : #private }
GtNestedTreeCollection >> sum: aBlockClosure in: aCollection [ 
	<return: #Number>
	^ aCollection
		ifEmpty: [ 0 ] 
		ifNotEmpty: [ aCollection sum: aBlockClosure ]
]
