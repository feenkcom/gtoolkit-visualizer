Class {
	#name : #GtGraphRectanglePackLayout,
	#superclass : #GtGraphLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Packing'
}

{ #category : #hook }
GtGraphRectanglePackLayout >> doExecute: theElements with: anExtentSpec [
	| sortedElements aTree |

	sortedElements := self sorted: theElements.
	
	aTree := GtGraphRectanglePackTree new.
	sortedElements do: [ :eachElement | self fit: eachElement in: aTree ]
]

{ #category : #hook }
GtGraphRectanglePackLayout >> fit: anElement in: aTree [
	| aRectangle |
	
	aRectangle := (GtGraphRectangle origin: 0.0@0.0 extent: anElement extent) margin: anElement margin.
	aTree add: aRectangle.

	anElement position: aRectangle origin
]

{ #category : #hook }
GtGraphRectanglePackLayout >> pickRoot: theElements [
	| width height margin |

	width := theElements
		ifEmpty: [ 0 ];
		ifNotEmpty: [ theElements first measuredWidth ].

	height := theElements
		ifEmpty: [ 0 ];
		ifNotEmpty: [ theElements first measuredHeight ].
		
	margin := theElements
		ifEmpty: [ BlInsets empty ];
		ifNotEmpty: [ theElements first margin ].

	^ GtGraphRectanglePackTreeNode new
		rectangle: ((GtGraphRectangle x: 0 y: 0 width: width height: height) margin: margin)
]

{ #category : #hook }
GtGraphRectanglePackLayout >> sorted: theElements [
	| sortedElements |

	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		larger perimeter > smaller perimeter ].
	sortedElements addAll: theElements.

	^ sortedElements
]
