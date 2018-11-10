Class {
	#name : #GtGradHierarchicalLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'intraCellSpacing',
		'interRankCellSpacing',
		'interHierarchySpacing',
		'parallelEdgeSpacing',
		'orientation'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #constraints }
GtGradHierarchicalLayout class >> constraints [
	^ GtGradHierarchicalConstraints new
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interHierarchySpacing [
	^ interHierarchySpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interHierarchySpacing: anObject [
	interHierarchySpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRankCellSpacing [
	^ interRankCellSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> interRankCellSpacing: anObject [
	interRankCellSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraCellSpacing [
	^ intraCellSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> intraCellSpacing: anObject [
	intraCellSpacing := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> orientation [
	^ orientation
]

{ #category : #accessing }
GtGradHierarchicalLayout >> orientation: anObject [
	orientation := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayout >> parallelEdgeSpacing [
	^ parallelEdgeSpacing
]

{ #category : #accessing }
GtGradHierarchicalLayout >> parallelEdgeSpacing: anObject [
	parallelEdgeSpacing := anObject
]
