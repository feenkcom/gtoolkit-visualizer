Class {
	#name : #GtGradHierarchicalLayoutAlignment,
	#superclass : #Object,
	#instVars : [
		'maxNodeHeightPerRank'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #calculating }
GtGradHierarchicalLayoutAlignment >> calculateAlignmentCorrection: aNode [
	self subclassResponsibility
]

{ #category : #initialization }
GtGradHierarchicalLayoutAlignment >> initialize [
	self maxNodeHeightPerRank: Dictionary new
]

{ #category : #accessing }
GtGradHierarchicalLayoutAlignment >> maxNodeHeightPerRank [
	^ maxNodeHeightPerRank
]

{ #category : #accessing }
GtGradHierarchicalLayoutAlignment >> maxNodeHeightPerRank: anObject [
	maxNodeHeightPerRank := anObject
]

{ #category : #accessing }
GtGradHierarchicalLayoutAlignment >> updateNodeHeightPerRankAt: aRankValue value: aValue [
	self maxNodeHeightPerRank at: aRankValue put: aValue
]
