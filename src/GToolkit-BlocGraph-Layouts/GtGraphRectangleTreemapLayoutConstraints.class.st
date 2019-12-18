Class {
	#name : #GtGraphRectangleTreemapLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'weight'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphRectangleTreemapLayoutConstraints >> weight [
	<return: #Number>
	^ weight
]

{ #category : #accessing }
GtGraphRectangleTreemapLayoutConstraints >> weight: aNumber [
	weight := aNumber
]
