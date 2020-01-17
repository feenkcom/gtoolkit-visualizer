Class {
	#name : #GtNestedTreeLeaf,
	#superclass : #GtNestedTreeItem,
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #testing }
GtNestedTreeLeaf class >> isAbstract [
	^ self name = #GtNestedTreeLeaf 
]

{ #category : #'accessing - computed' }
GtNestedTreeLeaf >> children [
	^ #()
]

{ #category : #accessing }
GtNestedTreeLeaf >> leaves [
	^ #()
]

{ #category : #accessing }
GtNestedTreeLeaf >> nodes [
	^ #()
]
