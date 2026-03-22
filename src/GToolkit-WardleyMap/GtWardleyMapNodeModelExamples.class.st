Class {
	#name : #GtWardleyMapNodeModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'instance creation' }
GtWardleyMapNodeModelExamples >> newNode [
	<gtExample>
	<return: #GtWardleyMapNodeModel>
	| aWardleyNode |
	aWardleyNode := GtWardleyMapNodeModel new.
	self assert: aWardleyNode label equals: 'Label'.
	self assert: aWardleyNode coordinate equals: 0.5 @ 0.5.
	self assert: aWardleyNode size equals: 12 @ 12.
	self assert: aWardleyNode color equals: GtWardleyMapConstants nodeColor.
	self assert: aWardleyNode isPipelineVisible not.


	^ aWardleyNode
]
