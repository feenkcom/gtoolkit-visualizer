Class {
	#name : #GtWardleyMapModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - elements' }
GtWardleyMapModelExamples >> elementWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	<return: #GtWardleyMapElement>
	| aWardleyMap aWardleyMapViewModel aWardleyMapElement |
	aWardleyMap := self newMapWithNodes_nodeBAsEvolveTarget.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.
	aWardleyMapViewModel isEvolutionAxisVisible: true.

	aWardleyMapElement := GtWardleyMapElement new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.

	self assert: aWardleyMapElement children size = 2.
	self assert: aWardleyMapElement canvasElement children size = 6.
	^ aWardleyMapElement
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> evolutionSections [
	^ {'genesis / concept'.
		'custom / emerging'.
		'product / converging'.
		'commodity / accepted'}
]

{ #category : #'examples - elements' }
GtWardleyMapModelExamples >> mapElementWithNodes [
	<gtExample>
	<return: #GtWardleyMapElement>
	| aWardleyMap aWardleyMapViewModel aWardleyMapElement |
	aWardleyMap := self newMapWithNodes.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.
	aWardleyMapViewModel isEvolutionAxisVisible: true.

	aWardleyMapElement := GtWardleyMapElement new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.

	self assert: aWardleyMapElement children size = 2.
	self assert: aWardleyMapElement canvasElement children size = 4.
	^ aWardleyMapElement
]

{ #category : #'examples - elements' }
GtWardleyMapModelExamples >> mapElementWithPipelines [
	<gtExample>
	<return: #GtWardleyMapElement>
	| aWardleyMapViewModel aWardleyMapElement |
	aWardleyMapViewModel := self mapViewModelWithPipelines.
	aWardleyMapViewModel isEvolutionAxisVisible: true.

	aWardleyMapElement := GtWardleyMapElement new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.

	self assert: aWardleyMapElement children size equals: 2.	"3 nodes, 1 pipeline, 1 edge"
	self assert: aWardleyMapElement canvasElement children size equals: 5.
	^ aWardleyMapElement
]

{ #category : #'examples - elements' }
GtWardleyMapModelExamples >> mapElementWithPipelinesInnerNodes [
	<gtExample>
	<return: #GtWardleyMapElement>
	| aWardleyMapViewModel aWardleyMapElement |
	aWardleyMapViewModel := self mapViewModelWithPipelineInnerNodes.
	aWardleyMapViewModel isEvolutionAxisVisible: true.

	aWardleyMapElement := GtWardleyMapElement new.
	aWardleyMapElement wardleyMapViewModel: aWardleyMapViewModel.


	self assert: aWardleyMapElement children size equals: 2.	"7 nodes, 1 pipeline, 1 edge, 1 note"
	self assert: aWardleyMapElement canvasElement children size equals: 10.
	^ aWardleyMapElement
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aWardleyMap aWardleyMapViewModel |
	aWardleyMap := self newMapWithNodes_nodeBAsEvolveTarget.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.

	self assert: aWardleyMapViewModel wardleyMapModel equals: aWardleyMap.
	self assert: aWardleyMapViewModel nodeViewModels size equals: 3.
	self assert: aWardleyMapViewModel edgeViewModels size equals: 1.
	self assert: aWardleyMapViewModel evolveViewModels size equals: 1.
	self assert: aWardleyMapViewModel evolveEdgeViewModels size equals: 1.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelineInnerNodes [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aWardleyMap aWardleyMapViewModel aNodeAViewModel |
	aWardleyMap := self newMapWithPipelineInnerNodes.
	aWardleyMapViewModel := GtWardleyMapViewModel new.
	aWardleyMapViewModel wardleyMapModel: aWardleyMap.

	self assert: aWardleyMapViewModel wardleyMapModel equals: aWardleyMap.
	self assert: aWardleyMapViewModel nodeViewModels size equals: 7.
	self assert: aWardleyMapViewModel edgeViewModels size equals: 1.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel innerNodeViewModels size equals: 2.

	aNodeAViewModel innerNodeViewModels
		detect: [ :eachViewModel | eachViewModel label = 'Node D' ].
	aNodeAViewModel innerNodeViewModels
		detect: [ :eachViewModel | eachViewModel label = 'Node E' ].

	aNodeAViewModel innerNodeViewModels
		do: [ :eachInnerNodeViewModel | 
			self
				assert: eachInnerNodeViewModel pipelineNodeViewModel
				equals: aNodeAViewModel ].

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelineInnerNodes_addInnerNode [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aWardleyMapViewModel aNodeAViewModel aNodeGViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelineInnerNodes.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].
	aNodeGViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node G' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel innerNodeViewModels size equals: 2.
	self assert: aNodeGViewModel pipelineNodeViewModel isNil.

	aNodeAViewModel addInnerNodeViewModel: aNodeGViewModel.

	self assert: aNodeAViewModel innerNodeViewModels size equals: 3.
	self assert: aNodeGViewModel pipelineNodeViewModel equals: aNodeAViewModel.

	self assert: aNodeAViewModel wardleyMapNodeModel innerNodes size equals: 3.
	self
		assert: aNodeGViewModel wardleyMapNodeModel pipelineNode
		equals: aNodeAViewModel wardleyMapNodeModel.	"Let's move it explicitly into the pipeline to make it visually inside"
	aNodeGViewModel moveNodeTo: 0.36 @ 0.76.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelineInnerNodes_removeInnerNode [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aWardleyMapViewModel aNodeAViewModel aNodeEViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelineInnerNodes.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].
	aNodeEViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node E' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel innerNodeViewModels size equals: 2.
	self assert: aNodeEViewModel pipelineNodeViewModel equals: aNodeAViewModel.

	aNodeAViewModel removeInnerNodeViewModel: aNodeEViewModel.

	self assert: aNodeAViewModel innerNodeViewModels size equals: 1.
	self assert: aNodeEViewModel pipelineNodeViewModel isNil.

	self assert: aNodeAViewModel wardleyMapNodeModel innerNodes size equals: 1.
	self assert: aNodeEViewModel wardleyMapNodeModel pipelineNode isNil.	"Let's move it explicitly outside the pipeline to make it visually inside"
	aNodeEViewModel moveNodeTo: 0.3 @ 0.78.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines [
	<gtExample>
	<return: #GtWardleyMapViewModel>
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
	<return: #GtWardleyMapViewModel>
	| aWardleyMapViewModel aNodeAViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel coordinate equals: 0.25 @ 0.75.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	aNodeAViewModel moveNodeTo: 0.5 @ 0.6.

	self assert: aNodeAViewModel coordinate equals: 0.4 @ 0.75.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_moveNodeA_toTheLeft [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aWardleyMapViewModel aNodeAViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel coordinate equals: 0.25 @ 0.75.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	aNodeAViewModel moveNodeTo: 0.1 @ 0.6.

	self assert: aNodeAViewModel coordinate equals: 0.15 @ 0.75.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_moveNodeB [
	<gtExample>
	<return: #GtWardleyMapViewModel>
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
	<return: #GtWardleyMapViewModel>
	| aWardleyMapViewModel aNodeAViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeAViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node A' ].

	self
		assert: aNodeAViewModel isPipelineVisible
		description: [ 'Pipeline must be visible' ].
	self assert: aNodeAViewModel coordinate equals: 0.25 @ 0.75.
	self assert: aNodeAViewModel pipelineCoordinate equals: 0.15 @ 0.4.

	aNodeAViewModel moveNodePipelineTo: 0.5 @ 0.6.

	self
		assert: aNodeAViewModel wardleyMapNodeModel pipelineCoordinate
		equals: 0.5 @ 0.75.
	self assert: aNodeAViewModel wardleyMapNodeModel coordinate equals: 0.6 @ 0.6.

	self assert: aNodeAViewModel pipelineCoordinate equals: 0.5 @ 0.75.
	self assert: aNodeAViewModel coordinate equals: 0.6 @ 0.6.

	^ aWardleyMapViewModel
]

{ #category : #'examples - view model' }
GtWardleyMapModelExamples >> mapViewModelWithPipelines_movePipelineB [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aWardleyMapViewModel aNodeBViewModel |
	aWardleyMapViewModel := self mapViewModelWithPipelines.

	aNodeBViewModel := aWardleyMapViewModel nodeViewModels
			detect: [ :eachViewModel | eachViewModel label = 'Node B' ].

	self
		assert: aNodeBViewModel isPipelineVisible not
		description: [ 'Pipeline must NOT be visible' ].
	self assert: aNodeBViewModel coordinate equals: 0.5 @ 0.25.

	aNodeBViewModel moveNodePipelineTo: 0.6 @ 0.2.	"Nothing happens if the pipeline is not visible"
	self assert: aNodeBViewModel coordinate equals: 0.5 @ 0.25.

	^ aWardleyMapViewModel
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> mapWithNodesEqualsEvaluatedStoreString [
	<gtExample>
	<return: #GtWardleyMapModel>
	| map |
	map := self newMapWithNodes.
	self assert: (Smalltalk compiler evaluate: map storeString) equals: map.
	^ map
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMap [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap |
	aWardleyMap := GtWardleyMapModel new.
	self assert: aWardleyMap nodes isEmpty.
	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithEvolutionSections [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap anEvolutionSections |
	aWardleyMap := self newMapWithNodesAndTitle.
	anEvolutionSections := self evolutionSections.
	aWardleyMap evolutionSections: anEvolutionSections.
	aWardleyMap isEvolutionAxisVisible: true.

	self assert: aWardleyMap evolutionSections equals: anEvolutionSections.
	self assert: aWardleyMap isEvolutionAxisVisible.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithNodes [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeB aNodeC anEdgeAtoB |
	aNodeA := GtWardleyMapNodeModelExamples new newNode.
	aNodeA coordinate: 0.25 @ 0.75.
	aNodeA color: Color gray.
	aNodeA label: 'Node A'.

	aNodeB := GtWardleyMapNodeModelExamples new newNode.
	aNodeB coordinate: 0.5 @ 0.25.
	aNodeB color: (Color black alpha: 0.2).
	aNodeB label: 'Node B'.
	aNodeB labelModel coordinate: -1.5 @ -1.5.

	aNodeC := GtWardleyMapNodeModelExamples new newNode.
	aNodeC coordinate: 0.75 @ 0.5.
	aNodeC color: Color red darker.
	aNodeC label: 'Node C'.

	anEdgeAtoB := GtWardleyMapEdgeModel new
			fromNode: aNodeA;
			toNode: aNodeB;
			arrow: true;
			label: 'Edge A->B';
			isLabelVisible: true;
			labelCoordinate: 0.33 @ 0.53;
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
GtWardleyMapModelExamples >> newMapWithNodesAndTitle [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap |
	aWardleyMap := self newMapWithNodes.
	aWardleyMap title: 'Wardley Map with nodes'.
	aWardleyMap isTitleVisible: true.

	self assert: aWardleyMap title equals: 'Wardley Map with nodes'.
	self assert: aWardleyMap isTitleVisible.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithNodes_displayPipeline [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA |
	aWardleyMap := self newMapWithNodes.

	aNodeA := aWardleyMap nodes first.

	self assert: aNodeA coordinate equals: 0.25 @ 0.75.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA isPipelineVisible not.

	aNodeA isPipelineVisible: true.

	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA pipelineCoordinate equals: 0.175 @ 0.325.	"make it visually nicer"
	aNodeA labelModel coordinate: -1.5 @ -1.5.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithNodes_nodeAtLeft_displayPipeline [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA |
	aWardleyMap := self newMapWithNodes.

	aNodeA := aWardleyMap nodes first.

	aNodeA coordinate: 0.01 @ 0.75.

	self assert: aNodeA coordinate equals: 0.01 @ 0.75.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA isPipelineVisible not.

	aNodeA isPipelineVisible: true.

	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA pipelineCoordinate equals: 0.0 @ 0.15.	"make it visually nicer"
	aNodeA labelModel coordinate: 3.9 @ -0.5.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithNodes_nodeAtRight_displayPipeline [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA |
	aWardleyMap := self newMapWithNodes.

	aNodeA := aWardleyMap nodes first.

	aNodeA coordinate: 0.99 @ 0.45.

	self assert: aNodeA coordinate equals: 0.99 @ 0.45.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA isPipelineVisible not.

	aNodeA isPipelineVisible: true.

	self assert: aNodeA innerNodes size equals: 0.
	self assert: (aNodeA pipelineCoordinate closeTo: 0.85 @ 1.0 precision: 0.001).	"make it visually nicer"
	aNodeA labelModel coordinate: -1.5 @ -2.25.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithNodes_nodeBAsEvolveTarget [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeB anEdgeAtoB |
	aWardleyMap := self newMapWithNodes.

	aNodeA := aWardleyMap nodes first.
	aNodeB := aWardleyMap nodes second.
	anEdgeAtoB := aWardleyMap edges first.

	self assert: aNodeA coordinate equals: 0.25 @ 0.75.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeA isPipelineVisible not.

	self assert: aNodeB coordinate equals: 0.5 @ 0.25.
	self assert: aNodeB innerNodes size equals: 0.
	self assert: aNodeB isPipelineVisible not.

	aNodeA isEvolveVisible: true.
	aNodeA evolvedEvolution: 0.8.
	aNodeA evolvedLabel: 'Evolved Node A'.
	aNodeA evolvedLabelCoordinate: 0.5 @ 2.0.
	aNodeA isEvolvedLabelVisible: true.

	self assert: aNodeA evolvedEvolution equals: 0.8.
	self assert: aNodeA evolvedLabel equals: 'Evolved Node A'.
	self assert: aNodeA evolvedLabelCoordinate equals: 0.5 @ 2.0.
	self assert: aNodeA evolvedCoordinate equals: 0.8 @ 0.75.
	self assert: aNodeA isEvolvedLabelVisible.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelineInnerNodes [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeD aNodeE aNodeF aNodeG aNoteA |
	aWardleyMap := self newMapWithPipelines.

	aNodeA := aWardleyMap nodes first.

	aNodeD := GtWardleyMapNodeModelExamples new newNode.
	aNodeD coordinate: 0.2 @ 0.761.
	aNodeD color: Color blue.
	aNodeD label: 'Node D'.

	aNodeE := GtWardleyMapNodeModelExamples new newNode.
	aNodeE coordinate: 0.3 @ 0.762.
	aNodeE color: Color blue.
	aNodeE label: 'Node E'.

	aNodeF := GtWardleyMapNodeModelExamples new newNode.
	aNodeF coordinate: 0.41 @ 0.76.
	aNodeF color: Color yellow darker.
	aNodeF label: 'Node F'.

	aNodeG := GtWardleyMapNodeModelExamples new newNode.
	aNodeG coordinate: 0.38 @ 0.78.
	aNodeG color: Color yellow darker.
	aNodeG label: 'Node G'.

	aNoteA := GtWardleyMapNoteModelExamples new newNote.
	aNoteA label: 'Note A'.
	aNoteA color: Color lightOrange.
	aNoteA coordinate: 0.47 @ 0.40.

	aWardleyMap addNode: aNodeD.
	aWardleyMap addNode: aNodeE.
	aWardleyMap addNode: aNodeF.
	aWardleyMap addNode: aNodeG.
	aWardleyMap addNote: aNoteA.

	self assert: aNodeD coordinate equals: 0.2 @ 0.761.
	self assert: aNodeE coordinate equals: 0.3 @ 0.762.
	self assert: aNodeF coordinate equals: 0.41 @ 0.76.
	self assert: aNodeG coordinate equals: 0.38 @ 0.78.

	aNodeA addInnerNode: aNodeD.
	aNodeA addInnerNode: aNodeE.

	self assert: aWardleyMap nodes size equals: 7.
	self assert: aWardleyMap edges size equals: 1.
	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: aNodeA innerNodes second equals: aNodeE.
	self assert: (aNodeA pipelineCoordinate closeTo: 0.19 @ 0.31 precision: 0.01).

	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: aNodeA.
	self assert: aNodeF pipelineNode isNil.
	self assert: aNodeG pipelineNode isNil.

	self assert: aNodeD coordinate equals: 0.2 @ aNodeA y.
	self assert: aNodeE coordinate equals: 0.3 @ aNodeA y.
	self assert: aNodeF coordinate equals: 0.41 @ 0.76.
	self assert: aNodeG coordinate equals: 0.38 @ 0.78.

	self assert: aNoteA label equals: 'Note A'.
	self assert: aNoteA color equals: Color lightOrange.	"self assert: aNoteA coordinate equals: 0.04 @ 0.80."

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelineInnerNodes_removeInnerNodesFromMap [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeD aNodeE |
	aWardleyMap := self newMapWithPipelineInnerNodes.

	aNodeA := aWardleyMap nodes first.
	aNodeD := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node D' ].
	aNodeE := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node E' ].

	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: aNodeA innerNodes second equals: aNodeE.
	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: aNodeA.

	aWardleyMap removeNode: aNodeE.

	self assert: aNodeA innerNodes size equals: 1.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: nil.

	aWardleyMap removeNode: aNodeD.

	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeD pipelineNode equals: nil.
	self assert: aNodeE pipelineNode equals: nil.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelineInnerNodes_removeInnerNodesFromPipeline [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeD aNodeE |
	aWardleyMap := self newMapWithPipelineInnerNodes.

	aNodeA := aWardleyMap nodes first.
	aNodeD := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node D' ].
	aNodeE := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node E' ].

	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: aNodeA innerNodes second equals: aNodeE.
	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: aNodeA.
	self assert: (aNodeA pipelineCoordinate closeTo: 0.19 @ 0.31 precision: 0.01).

	aNodeE removeFromPipeline.

	self assert: aNodeA innerNodes size equals: 1.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: (aNodeA pipelineCoordinate closeTo: 0.19 @ 0.26 precision: 0.01).
	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: nil.

	aNodeA removeInnerNode: aNodeD.

	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeD pipelineNode equals: nil.
	self assert: aNodeE pipelineNode equals: nil.
	self assert: (aNodeA pipelineCoordinate closeTo: 0.175 @ 0.325 precision: 0.01).

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelineInnerNodes_removePipelineNodeFromMap [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeD aNodeE |
	aWardleyMap := self newMapWithPipelineInnerNodes.

	aNodeA := aWardleyMap nodes first.
	aNodeD := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node D' ].
	aNodeE := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node E' ].

	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: aNodeA innerNodes second equals: aNodeE.
	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: aNodeA.

	aWardleyMap removeNode: aNodeA.

	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeD pipelineNode equals: nil.
	self assert: aNodeE pipelineNode equals: nil.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelineInnerNodes_switchOffPipelineNode [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA aNodeD aNodeE |
	aWardleyMap := self newMapWithPipelineInnerNodes.

	aNodeA := aWardleyMap nodes first.
	aNodeD := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node D' ].
	aNodeE := aWardleyMap nodes detect: [ :eachNode | eachNode label = 'Node E' ].

	self assert: aNodeA isPipelineVisible equals: true.
	self assert: aNodeA innerNodes size equals: 2.
	self assert: aNodeA innerNodes first equals: aNodeD.
	self assert: aNodeA innerNodes second equals: aNodeE.
	self assert: aNodeD pipelineNode equals: aNodeA.
	self assert: aNodeE pipelineNode equals: aNodeA.

	aNodeA isPipelineVisible: false.

	self assert: aNodeA isPipelineVisible equals: false.
	self assert: aNodeA innerNodes size equals: 0.
	self assert: aNodeD pipelineNode equals: nil.
	self assert: aNodeE pipelineNode equals: nil.

	^ aWardleyMap
]

{ #category : #'examples - model' }
GtWardleyMapModelExamples >> newMapWithPipelines [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aWardleyMap aNodeA |
	aWardleyMap := self newMapWithNodes.

	aNodeA := aWardleyMap nodes first.
	aNodeA labelModel coordinate: -1.5 @ -1.5.
	aNodeA pipelineCoordinate: 0.15 @ 0.4.

	self assert: aNodeA labelModel coordinate equals: -1.5 @ -1.5.
	self assert: aNodeA pipelineCoordinate equals: 0.15 @ 0.4.
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
	<return: #OrderedCollection>
	| aWardleyMap theAnnouncements |
	aWardleyMap := self newMapWithNodes.

	theAnnouncements := OrderedCollection new.
	aWardleyMap
		when: GtWardleyMapAnnouncement
		do: [ :anAnnouncement | theAnnouncements add: anAnnouncement ]
		for: self.

	aWardleyMap nodes second label: 'Changed Node B'.

	self assert: theAnnouncements size equals: 1.

	^ theAnnouncements
]
