Class {
	#name : #GtGradHierarchyModel,
	#superclass : #Object,
	#instVars : [
		'roots',
		'parent',
		'maxRank'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #initialization }
GtGradHierarchyModel >> constructHierarchyModel: nodes roots: theRoots parent: theParent [
	self roots: theRoots.
	self parent: theParent.
]

{ #category : #accessing }
GtGradHierarchyModel >> maxRank [
	^ maxRank
]

{ #category : #accessing }
GtGradHierarchyModel >> maxRank: anObject [
	maxRank := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> parent [
	^ parent
]

{ #category : #accessing }
GtGradHierarchyModel >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtGradHierarchyModel >> roots [
	^ roots
]

{ #category : #accessing }
GtGradHierarchyModel >> roots: anObject [
	roots := anObject
]
