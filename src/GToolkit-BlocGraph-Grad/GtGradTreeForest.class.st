Class {
	#name : #GtGradTreeForest,
	#superclass : #Object,
	#instVars : [
		'trees'
	],
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'api - visiting' }
GtGradTreeForest >> accept: aVisitor [
	aVisitor visitForest: self.
	self trees do: [ :aTreeNode | aTreeNode accept: aVisitor ]
]

{ #category : #'gt-inspector-extension' }
GtGradTreeForest >> gtInspectorNodesIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastTree
			title: 'Trees';
			display: [ self trees ];
			children: [ :aNode | aNode nodes ];
			allExpanded
]

{ #category : #initialization }
GtGradTreeForest >> initialize [
	super initialize.
	
	trees := OrderedCollection new
]

{ #category : #accessing }
GtGradTreeForest >> trees [
	<return: #Collection of: #GtGradTreeForest>

	^ trees
]

{ #category : #accessing }
GtGradTreeForest >> trees: aCollectionOfTreeNodes [
	trees := aCollectionOfTreeNodes
]
