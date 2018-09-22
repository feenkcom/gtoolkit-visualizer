Class {
	#name : #GtGradTreeLayouter,
	#superclass : #GtGradTreeVisitor,
	#instVars : [
		'layout'
	],
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #'instance creation' }
GtGradTreeLayouter class >> on: aGtGradTreeLayout [
	^ self new layout: aGtGradTreeLayout
]

{ #category : #accessing }
GtGradTreeLayouter >> layout [
	^ layout
]

{ #category : #accessing }
GtGradTreeLayouter >> layout: anObject [
	layout := anObject
]

{ #category : #'api - layout' }
GtGradTreeLayouter >> levelDistance [
	^ self layout levelDistance
]

{ #category : #'api - layout' }
GtGradTreeLayouter >> nodeDistance [
	^ self layout nodeDistance
]

{ #category : #'api - layout' }
GtGradTreeLayouter >> reverse [
	^ self layout reverse
]

{ #category : #'api - layout' }
GtGradTreeLayouter >> separateSubtrees [
	^ self layout separateSubtrees
]

{ #category : #'api - layout' }
GtGradTreeLayouter >> treesDistance [
	^ self layout treesDistance
]
