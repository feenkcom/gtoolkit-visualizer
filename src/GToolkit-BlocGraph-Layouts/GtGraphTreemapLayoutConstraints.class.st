"
I am a {{gtClass:BlLayoutConstraints}} for {{gtClass:GtGraphTreemapSquarifiedLayout}} layout.


"
Class {
	#name : #GtGraphTreemapLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'weight'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Treemap'
}

{ #category : #initialization }
GtGraphTreemapLayoutConstraints >> initialize [
	super initialize.
	weight := 0.
]

{ #category : #accessing }
GtGraphTreemapLayoutConstraints >> weight [
	<return: #Number>
	^ weight
]

{ #category : #accessing }
GtGraphTreemapLayoutConstraints >> weight: aNumber [
	weight := aNumber
]
