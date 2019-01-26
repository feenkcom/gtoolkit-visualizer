Class {
	#name : #GtGradHierarchicalTreelLayout,
	#superclass : #GtGradLayout,
	#instVars : [
		'levelDistance',
		'nodesDistance',
		'componentsDistance',
		'alignment',
		'maxNumberOfTreeBackEdges'
	],
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> alignment [
	^ alignment
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> alignment: anAlignment [
	alignment := anAlignment
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> componentsDistance [
	^ componentsDistance
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> componentsDistance: aNum [
	componentsDistance := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> isATreeOrHasLessThanMaxBackEdges: anElementsCollection [
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> levelDistance [
	^ levelDistance
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> levelDistance: aNum [
	levelDistance := aNum
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> maxNumberOfTreeBackEdges [
	^ maxNumberOfTreeBackEdges
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> maxNumberOfTreeBackEdges: aNum [
	maxNumberOfTreeBackEdges := aNum
]

{ #category : #measure }
GtGradHierarchicalTreelLayout >> measurePositions: anElement with: anExtentSpec [

]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> nodesDistance [
	^ nodesDistance
]

{ #category : #accessing }
GtGradHierarchicalTreelLayout >> nodesDistance: aNum [
	nodesDistance := aNum
]
