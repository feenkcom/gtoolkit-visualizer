Class {
	#name : #GtWardleyMapModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - elements' }
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

{ #category : #'examples - elements' }
GtWardleyMapModelExamples >> mapElementWithPipelines [
	<gtExample>
	| aWardleyMapViewModel aWardleyMapElement |

	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aWardleyMapElement := GtWardleyMapElement new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.

	aWardleyMapElement evolutionSections: {
		'genesis'.
		'custom built'.
		'product (+rental)'.
		'commodity'
	}.
	self assert: aWardleyMapElement children size equals: 2.
	"3 nodes, 1 pipeline, 1 edge"
	self assert: aWardleyMapElement children last children size equals: 5.
	^ aWardleyMapElement
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines [
	<gtExample>
	| aWardleyMap aWardleyMapViewModel |
	aWardleyMap := self newMapWithPipelines.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.

	self assert: aWardleyMapViewModel wardleyMapModel equals: aWardleyMap.
	self assert: aWardleyMapViewModel nodeViewModels size equals: 3.
	self assert: aWardleyMapViewModel edgeViewModels size equals: 1.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_moveNodeA [
	<gtExample>
	| aWardleyMapViewModel aNodeAViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	aNodeAViewModel moveNodeTo: 0.5 @ 0.6.

	self assert: aNodeAViewModel coordinate equals: 0.5 @ 0.6.
	
	"We do not recompute pipeline coordinate on #moveNodeTo:, 
	yet we adjust the pipeline coordinate when requested 
	if the node is away of the pipeline horizontal range.
	It is the node view model that recomputes it."
	self
		assert: aNodeAViewModel wardleyMapNodeModel pipelineCoordinate
		equals: 0.15 @ 0.4.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.5.
	self
		assert: aNodeAViewModel wardleyMapNodeModel pipelineCoordinate
		equals: 0.15 @ 0.5.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_moveNodeB [
	<gtExample>
	| aWardleyMapViewModel aNodeBViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeBViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node B' ].

	self
		assert: aNodeBViewModel isPipelineVisible not
		description: [ 'Pipeline must not be visible' ].
	self assert: aNodeBViewModel coordinate equals: 0.5 @ 0.25.

	aNodeBViewModel moveNodeTo: 0.6 @ 0.2.

	self assert: aNodeBViewModel coordinate equals: 0.6 @ 0.2.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_movePipelineA [
	<gtExample>
	| aWardleyMapViewModel aNodeAViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel coordinate equals: 0.25@0.75.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	aNodeAViewModel moveNodePipelineTo: 0.5 @ 0.6.
	
	self
		assert: aNodeAViewModel wardleyMapNodeModel pipelineCoordinate
		equals: 0.5 @ 0.75.
	self
		assert: aNodeAViewModel wardleyMapNodeModel coordinate
		equals: 0.6 @ 0.6.

	self assert: aNodeAViewModel pipelineCoordinate equals: 0.5 @ 0.75.
	self assert: aNodeAViewModel coordinate equals: 0.6 @ 0.6.
		
	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_movePipelineB [
	<gtExample>
	| aWardleyMapViewModel aNodeBViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeBViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node B' ].

	self
		assert: aNodeBViewModel isPipelineVisible not
		description: [ 'Pipeline must NOT be visible' ].
	self assert: aNodeBViewModel coordinate equals: 0.5 @ 0.25.

	aNodeBViewModel moveNodePipelineTo: 0.6 @ 0.2.

	"Nothing happens if the pipeline is not visible"
	self assert: aNodeBViewModel coordinate equals: 0.5 @ 0.25.

	^ aWardleyMapViewModel
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> mapWithNodesEqualsEvaluatedStoreString [

	<gtExample>
	| map |
	map := self newMapWithNodes.
	self
		assert: (Smalltalk compiler evaluate: map storeString)
		equals: map.
	^ map
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMap [
	<gtExample>
	| aWardleyMap |
	
	aWardleyMap := GtWardleyMapModel new.
	self assert: aWardleyMap nodes isEmpty.
	^ aWardleyMap
]

{ #category : #'examples - model' }
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
	aNodeB labelModel coordinate: (-1.5 @ -1.5). 
	
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

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelines [
	<gtExample>
	| aWardleyMap aNodeA |

	aWardleyMap := self newMapWithNodes.
	
	aNodeA := aWardleyMap nodes first.
	aNodeA labelModel coordinate: (-1.5 @ -1.5). 
	aNodeA pipelineCoordinate: (0.15 @ 0.4).
	
	self assert: aNodeA labelModel coordinate equals: (-1.5 @ -1.5).
	self assert: aNodeA pipelineCoordinate equals: (0.15 @ 0.4).
	self assert: aNodeA isPipelineVisible not.
	
	aNodeA isPipelineVisible: true.
	self assert: aNodeA isPipelineVisible.
	
	self assert: aWardleyMap nodes size equals: 3.
	self assert: aWardleyMap edges size equals: 1.

	^ aWardleyMap
]

{ #category : #'examples - model' }
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
