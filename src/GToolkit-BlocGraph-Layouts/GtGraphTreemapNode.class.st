"
I represent a ${class:GtGraphTreemap}$ node.
I keep my weight and the ${class:GtGraphTreemap}$ is responsible for computing my position and extent.

"
Class {
	#name : #GtGraphTreemapNode,
	#superclass : #GtGraphTreemapRectangle,
	#instVars : [
		'weight'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Treemap'
}

{ #category : #accessing }
GtGraphTreemapNode >> aspectRatio [
	^ (self width / self height) max: (self height / self width)
]

{ #category : #'gt-extension' }
GtGraphTreemapNode >> gtWeightFor: aView [
	<gtView>
	self weight ifNil: [ ^ aView empty ].
	^ (self weight gtPreviewFor: aView)
		priority: 1;
		title: 'Weight'
]

{ #category : #initialization }
GtGraphTreemapNode >> initialize [
	super initialize.
	weight := 0.
]

{ #category : #printing }
GtGraphTreemapNode >> printOn: aStream [
	aStream nextPutAll: 'Node bounds: '.
	self hasBounds
		ifFalse: [ aStream nextPutAll: '<uninitialized>' ]
		ifTrue: [ 
				aStream 
					print: self bounds;
					nextPutAll: ', ratio ';
					print: (self aspectRatio asFloat round: 1) ].
]

{ #category : #accessing }
GtGraphTreemapNode >> weight [
	^ weight
]

{ #category : #accessing }
GtGraphTreemapNode >> weight: aNumber [
	self
		assert: [ aNumber between: 0 and: 1 ]
		description: [ 'Treemap node weight must be between 0 and 1' ].
	weight := aNumber
]
