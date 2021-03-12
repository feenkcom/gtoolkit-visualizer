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

	aWardleyMapElement evolutionSections: {
		'genesis'.
		'custom built'.
		'product (+rental)'.
		'commodity'
	}.
	self assert: aWardleyMapElement children size = 2.
	self assert: aWardleyMapElement children last children size = 4.
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
	| aWardleyMap aNodeA aNodeB aNodeC anEdgeAtoB |

	aNodeA := GtWardleyMapNodeModelExamples new newNode.
	aNodeA coordinate: (0.25@0.75).
	aNodeA color: Color gray.
	aNodeA label: 'Node A'.

	aNodeB := GtWardleyMapNodeModelExamples new newNode.
	aNodeB coordinate: (0.5@0.25).
	aNodeB color: (Color black alpha: 0.2).
	aNodeB label: 'Node B'.

	aNodeC := GtWardleyMapNodeModelExamples new newNode.
	aNodeC coordinate: (0.75@0.5).
	aNodeC color: Color red darker.
	aNodeC label: 'Node C'.

	anEdgeAtoB := GtWardleyMapEdgeModel new
		fromNode: aNodeA;
		toNode: aNodeB;
		arrow: true;
		width: 2.

	aWardleyMap := self newMap.
	aWardleyMap addNode: aNodeA.
	aWardleyMap addNode: aNodeB.
	aWardleyMap addNode: aNodeC.
	aWardleyMap addEdge: anEdgeAtoB.
	
	self assert: aWardleyMap nodes size equals: 3.
	self assert: aWardleyMap edges size equals: 1.

	^ aWardleyMap
]

{ #category : #examples }
GtWardleyMapModelExamples >> understandingWhenMapChanges [
	<gtExample>
	| aWardleyMap theAnnouncements |

	aWardleyMap := self newMapWithNodes.
	
	theAnnouncements := OrderedCollection new.
	aWardleyMap when: GtWardleyMapAnnouncement do: [ :anAnnouncement | theAnnouncements add: anAnnouncement ].
	
	aWardleyMap nodes second label: 'Changed Node B'.
	
	self assert: theAnnouncements size equals: 1.
	
	^ theAnnouncements
]
