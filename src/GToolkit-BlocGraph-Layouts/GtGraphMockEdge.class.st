Class {
	#name : #GtGraphMockEdge,
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #accessing }
GtGraphMockEdge >> from [
	^ from
]

{ #category : #accessing }
GtGraphMockEdge >> from: aMockElement [
	from := aMockElement
]

{ #category : #accessing }
GtGraphMockEdge >> to [
	^ to
]

{ #category : #accessing }
GtGraphMockEdge >> to: aMockElement [
	to := aMockElement
]
