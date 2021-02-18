Class {
	#name : #GtWardleyMapModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #examples }
GtWardleyMapModelExamples >> mapElementWithNodes [
	<gtExample>
	| aWardleyMap aWardleyMapViewModel aWardleyMapElement |

	aWardleyMap := self newMapWithNodes.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.
	
	aWardleyMapElement := GtWardleyMapElement new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.

	^ aWardleyMapElement
]

{ #category : #examples }
GtWardleyMapModelExamples >> newMap [
	<gtExample>
	| aWardleyMap |
	
	aWardleyMap := GtWardleyMapModel new.
	self assert: aWardleyMap nodes isEmpty.
	^ aWardleyMap
]

{ #category : #examples }
GtWardleyMapModelExamples >> newMapWithNodes [
	<gtExample>
	| aWardleyMap aNodeA aNodeB aNodeC |

	aNodeA := GtWardleyMapNodeModelExamples new newNode.
	aNodeA coordinate: (0.25@0.75).
	aNodeA label: 'Node A'.

	aNodeB := GtWardleyMapNodeModelExamples new newNode.
	aNodeB coordinate: (0.5@0.25).
	aNodeB label: 'Node B'.

	aNodeC := GtWardleyMapNodeModelExamples new newNode.
	aNodeC coordinate: (0.75@0.5).
	aNodeC label: 'Node C'.

	aWardleyMap := self newMap.
	aWardleyMap addNode: aNodeA.
	aWardleyMap addNode: aNodeB.
	aWardleyMap addNode: aNodeC.
	
	self assert: aWardleyMap nodes size equals: 3.

	^ aWardleyMap
]
