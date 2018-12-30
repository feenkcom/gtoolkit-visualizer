Class {
	#name : #GtGradHierarchicalWeightedElement,
	#superclass : #Magnitude,
	#instVars : [
		'element',
		'weight',
		'nudge',
		'visited',
		'rankIndex'
	],
	#category : #'GToolkit-BlocGraph-Grad-Hierarchical'
}

{ #category : #testing }
GtGradHierarchicalWeightedElement >> < otherWeightedElement [ 
	^ self weight > otherWeightedElement weight
]

{ #category : #comparing }
GtGradHierarchicalWeightedElement >> = otherWeightedElement [
	^ self weight = otherWeightedElement weight
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> element [
	^ element
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> element: anObject [
	element := anObject
]

{ #category : #comparing }
GtGradHierarchicalWeightedElement >> hash [
	^self weight hash
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> nudge [
	^ nudge
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> nudge: anObject [
	nudge := anObject
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> rankIndex [
	^ rankIndex
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> rankIndex: anObject [
	rankIndex := anObject
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> visited [
	^ visited
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> visited: anObject [
	visited := anObject
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> weight [
	^ weight
]

{ #category : #accessing }
GtGradHierarchicalWeightedElement >> weight: anObject [
	weight := anObject
]
