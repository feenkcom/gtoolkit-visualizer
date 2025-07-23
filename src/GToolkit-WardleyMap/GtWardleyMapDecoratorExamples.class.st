"
I exemplify {{gtClass:TGtWardleyMapDecoratorModel}}. 
"
Class {
	#name : #GtWardleyMapDecoratorExamples,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Examples'
}

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapElementWithProposedModifications [
	<gtExample>
	<return: #GtWardleyMapElement>
	| aMapViewModel anElement |
	aMapViewModel := self mapViewModelWithProposedModifications.
	anElement := GtWardleyMapElement new wardleyMapViewModel: aMapViewModel.

	^ anElement
]

{ #category : #'examples - highlights' }
GtWardleyMapDecoratorExamples >> mapViewModelWithNodeAndEdgeHighlight [
	"It exemplifies the case, when we add decorators to view models only.
	Such case is useful when we want to highlight items (nodes, edges)
	in a specific view, but not in other views."

	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aMap aMapViewModel aNodeA anEdgeAB |
	aMap := self mapWithNodes.
	aMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.

	aNodeA := aMap
			nodeWithName: 'Node A'
			ifFound: [ :aNode | aNode ]
			ifNone: [ nil ].
	aMapViewModel
		nodeViewModelFor: aNodeA
		ifFound: [ :aNodeViewModel | 
			aNodeViewModel
				addWardleyMapDecoratorViewModel: GtWardleyMapHighlight new asDecoratorViewModel ]
		ifNone: [  ].

	anEdgeAB := aMap
			edgeWithName: 'Edge A->B'
			ifFound: [ :aNode | aNode ]
			ifNone: [ nil ].
	aMapViewModel
		edgeViewModelFor: anEdgeAB
		ifFound: [ :anEdgeViewModel | 
			anEdgeViewModel
				addWardleyMapDecoratorViewModel: GtWardleyMapHighlight new asDecoratorViewModel ]
		ifNone: [  ].

	^ aMapViewModel
]

{ #category : #examples }
GtWardleyMapDecoratorExamples >> mapViewModelWithNodes [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aMap aMapViewModel |
	aMap := self mapWithNodes.
	aMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.

	^ aMapViewModel
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapViewModelWithProposedModifications [
	<gtExample>
	<return: #GtWardleyMapViewModel>
	| aMap aMapViewModel |
	aMap := self mapWithProposedModifications.
	aMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.

	^ aMapViewModel
]

{ #category : #examples }
GtWardleyMapDecoratorExamples >> mapWithNodes [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aMap anEdgeAtoC aNodeC aNodeA |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.

	aNodeA := aMap
			nodeWithName: 'Node A'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeC := aMap
			nodeWithName: 'Node C'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeC color: Color black.

	anEdgeAtoC := GtWardleyMapEdgeModel new
			fromNode: aNodeA;
			toNode: aNodeC;
			arrow: false;
			label: 'Edge A->C';
			isLabelVisible: false;
			labelCoordinate: 0.58 @ 0.53;
			width: 2.
	aMap addEdge: anEdgeAtoC.

	^ aMap
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapWithProposedModifications [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aMap aNodeA aNodeB aNodeC anAddA aRemoveC anEdgeAB anAddAB anRemoveAC anEdgeAC aRenameB |
	aMap := self mapWithNodes.
	aNodeA := aMap
			nodeWithName: 'Node A'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeB := aMap
			nodeWithName: 'Node B'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	aNodeC := aMap
			nodeWithName: 'Node C'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].
	anEdgeAB := aMap
			edgeFromNode: aNodeA
			toNode: aNodeB
			ifFound: [ :theEdge | theEdge ]
			ifNone: [ nil ].
	anEdgeAC := aMap
			edgeFromNode: aNodeA
			toNode: aNodeC
			ifFound: [ :theEdge | theEdge ]
			ifNone: [ nil ].

	anAddA := GtWardleyMapAddProposition new.
	aNodeA addWardleyMapDecoratorModel: anAddA.
	aRemoveC := GtWardleyMapRemoveProposition new.
	aNodeC addWardleyMapDecoratorModel: aRemoveC.

	anAddAB := GtWardleyMapAddProposition new.
	anEdgeAB addWardleyMapDecoratorModel: anAddAB.

	anRemoveAC := GtWardleyMapRemoveProposition new.
	anEdgeAC addWardleyMapDecoratorModel: anRemoveAC.

	aRenameB := GtWardleyMapRenameProposition new
			options: {'Node X'.
					'Node Y'.
					'Node Z'}.
	aNodeB addWardleyMapDecoratorModel: aRenameB.

	aMap ensureAllProposition.

	^ aMap
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapWithProposedRename [
	<gtExample>
	<return: #GtWardleyMapModel>
	| aMap aNodeA aRenameA |
	aMap := self mapWithNodes.
	aNodeA := aMap
			nodeWithName: 'Node A'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].

	aRenameA := GtWardleyMapRenameProposition new
			options: {'A Node'.
					'Node 1'.
					'Node #1'}.
	aNodeA addWardleyMapDecoratorModel: aRenameA.
	^ aMap
]
