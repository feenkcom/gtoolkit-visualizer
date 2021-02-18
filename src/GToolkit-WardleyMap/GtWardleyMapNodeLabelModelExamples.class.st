Class {
	#name : #GtWardleyMapNodeLabelModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'instance creation' }
GtWardleyMapNodeLabelModelExamples >> newNodeLabel [
	<gtExample>
	| aWardleyNode |
	
	aWardleyNode := GtWardleyMapNodeLabelModel new.
	self assert: aWardleyNode label equals: 'Label'.
	self assert: aWardleyNode coordinate equals: 0.5 @ 2.0.

	^ aWardleyNode
]
