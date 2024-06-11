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
	|  aMapViewModel anElement |
	aMapViewModel := self mapViewModelWithProposedModifications.
	anElement := GtWardleyMapElement new wardleyMapViewModel: aMapViewModel.
	
	^ anElement
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapViewModelWithProposedModifications [
	<gtExample>
	| aMap  aMapViewModel |
	aMap := self mapWithProposedModifications.
	aMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aMap.
	
	^ aMapViewModel
]

{ #category : #'examples -  decorators' }
GtWardleyMapDecoratorExamples >> mapWithLepiterPageLink [
	<gtExample>
	| aMap aNodeB aPageLink aPage |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.

	aNodeB := aMap
			nodeWithName: 'Node B'
			ifFound: [ :theNode | theNode ]
			ifNone: [ nil ].

	aPage := LeDatabasesRegistry defaultLogicalDatabase
			pageNamed: 'GT in 7'' videos'.

	aPageLink := GtWardleyMapAction new
			icon: LeIcons lepiterPage;
			label: aPage title;
			tooltip: 'Navigate to the page';
			action: [ :aButton | aButton phlow spawnTool: (LePagePhlowTool page: aPage) ].
	aNodeB addWardleyMapDecoratorModel: aPageLink.

	^ aMap
]

{ #category : #examples }
GtWardleyMapDecoratorExamples >> mapWithNodes [
	<gtExample>
	| aMap anEdgeAtoC aNodeC aNodeA |
	aMap := GtWardleyMapModelExamples new newMapWithNodes.
	
	aNodeA := aMap nodeWithName: 'Node A' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	aNodeC := aMap nodeWithName: 'Node C' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	aNodeC color: Color black.
	
	anEdgeAtoC := GtWardleyMapEdgeModel new
		fromNode: aNodeA;
		toNode: aNodeC;
		arrow: false;
		label: 'Edge A->B';
		isLabelVisible: false;
		width: 2.
	aMap addEdge: anEdgeAtoC.
	
	^ aMap
]

{ #category : #'examples - proposed modifications' }
GtWardleyMapDecoratorExamples >> mapWithProposedModifications [
	<gtExample>
	| aMap aNodeA aNodeB aNodeC anAddA aRemoveC anEdgeAB anAddAB anRemoveAC anEdgeAC aRenameB |
	aMap := self mapWithNodes.
	aNodeA := aMap nodeWithName: 'Node A' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	aNodeB := aMap nodeWithName: 'Node B' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	aNodeC := aMap nodeWithName: 'Node C' ifFound: [ :theNode | theNode] ifNone: [ nil ].
	anEdgeAB := aMap edgeFromNode: aNodeA toNode: aNodeB ifFound: [ :theEdge | theEdge ] ifNone: [ nil ].
	anEdgeAC := aMap edgeFromNode: aNodeA toNode: aNodeC ifFound: [ :theEdge | theEdge ] ifNone: [ nil ].
	
	anAddA := GtWardleyMapAddProposition new.
	aNodeA addWardleyMapDecoratorModel: anAddA.
	aRemoveC := GtWardleyMapRemoveProposition new.
	aNodeC addWardleyMapDecoratorModel: aRemoveC.
	
	anAddAB := GtWardleyMapAddProposition new.
	anEdgeAB addWardleyMapDecoratorModel: anAddAB.
	
	anRemoveAC := GtWardleyMapRemoveProposition new.
	anEdgeAC addWardleyMapDecoratorModel: anRemoveAC.
	
	aRenameB := GtWardleyMapRenameProposition new
			options: {'Node X'. 'Node Y'. 'Node Z'}.
	aNodeB addWardleyMapDecoratorModel: aRenameB.
	
	^ aMap
]

{ #category : #accessing }
GtWardleyMapDecoratorExamples >> mapwithProposedRename [
	<gtExample>
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
