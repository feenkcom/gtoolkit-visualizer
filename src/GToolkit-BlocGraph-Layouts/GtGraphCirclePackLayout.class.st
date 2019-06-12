Class {
	#name : #GtGraphCirclePackLayout,
	#superclass : #GtGraphLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Packing'
}

{ #category : #measure }
GtGraphCirclePackLayout >> boundingBox: anElement [
	| theBounds aSideLength aDeltaX aDeltaY |
	
	theBounds := super boundingBox: anElement.
	aSideLength := theBounds extent max * 1.1.
	aDeltaX := (aSideLength - theBounds width) / 2.0.
	aDeltaY := (aSideLength - theBounds height) / 2.0.
	
	^ theBounds expandBy: aDeltaX @ aDeltaY
]

{ #category : #hook }
GtGraphCirclePackLayout >> doExecute: theElements [
	"Performs the layout"
	| sortedElements aChain |
	
	sortedElements := self sorted: theElements.
	aChain := self pickChain: sortedElements.

	4 to: sortedElements size do: [ :eachIndex | self fit: (sortedElements at: eachIndex) in: aChain ]
]

{ #category : #hook }
GtGraphCirclePackLayout >> fit: anElement in: aFrontChain [
	| aNewCircle |

	aNewCircle := GtGraphCirclePackNode for: anElement.
	
	aNewCircle alignTo: aFrontChain nearestCircle and: aFrontChain nextCircle.

	aFrontChain
		aroundLink: aFrontChain nextCircle
		detect: [ :eachCircle | aNewCircle intersects: eachCircle ]
		ifFound: [ :aCircle :anIndex |
			anIndex > 0
				ifTrue: [
					aFrontChain removeFrom: aFrontChain nearestCircle to: aCircle.
					aFrontChain nextCircle: aCircle ]
				ifFalse: [
					aFrontChain removeFrom: aCircle to: aFrontChain nextCircle.
					aFrontChain nearestCircle: aCircle ].
			
			aNewCircle alignTo: aFrontChain nearestCircle and: aFrontChain nextCircle. ]
		ifNone: [  ].

	aFrontChain add: aNewCircle afterLink: aFrontChain nearestCircle.
	aFrontChain nextCircle: aNewCircle
]

{ #category : #hook }
GtGraphCirclePackLayout >> pickChain: theElements [
	| aChain |
	
	aChain := GtGraphCirclePackFrontChain new.
	theElements
		ifEmpty: [ ^ aChain ].
		
	theElements size = 1
		ifTrue: [
			| aCircle |
			
			aCircle := GtGraphCirclePackNode for: theElements first.
			aCircle center: (GtGraphCircleNeighbourhood computeNeighbourCenter: aCircle circle).
			
			aChain add: aCircle.
			aChain nearestCircle: aChain firstLink ].

	theElements size >= 2
		ifTrue: [
			| aFirstCircle aSecondCircle |
			
			aFirstCircle := GtGraphCirclePackNode for: theElements first.
			aSecondCircle := GtGraphCirclePackNode for: theElements second.
			
			aFirstCircle center: (GtGraphCircleNeighbourhood computeNeighbourCenter: aFirstCircle circle).
			aSecondCircle center: (GtGraphCircleNeighbourhood computeNeighbourCenter: aFirstCircle circle near: aSecondCircle circle).
			
			aChain add: aFirstCircle.
			aChain add: aSecondCircle.
			
			aChain nearestCircle: aFirstCircle.
			aChain nextCircle: aSecondCircle ].

	theElements size >= 3
		ifTrue: [
			| aThirdCircle |
			
			aThirdCircle := GtGraphCirclePackNode for: theElements third.
			aThirdCircle alignTo: aChain nearestCircle and: aChain nextCircle.
			
			aChain add: aThirdCircle afterLink: aChain nearestCircle.
			aChain nearestCircle: aThirdCircle ].

	^ aChain
]

{ #category : #hook }
GtGraphCirclePackLayout >> sorted: theElements [
	| sortedElements |

	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		(larger measuredExtent max) > (smaller measuredExtent max) ].
	sortedElements addAll: theElements.

	^ sortedElements
]
