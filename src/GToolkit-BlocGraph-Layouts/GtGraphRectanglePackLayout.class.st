Class {
	#name : #GtGraphRectanglePackLayout,
	#superclass : #GtGraphLayout,
	#category : #'GToolkit-BlocGraph-Layouts-Layouts - Packing'
}

{ #category : #hook }
GtGraphRectanglePackLayout >> doExecute: theElements [
	| sortedElements aRoot |
	
	sortedElements := self sorted: theElements.
	aRoot := self pickRoot: sortedElements.

	sortedElements do: [ :eachElement | aRoot := self fit: eachElement in: aRoot ]
]

{ #category : #hook }
GtGraphRectanglePackLayout >> fit: anElement in: aRoot [
	| aTargetNode aNewRoot |

	aNewRoot := aRoot.
	
	aNewRoot
		detect: anElement measuredExtent
		ifFound: [ :aTreeNode | aTargetNode := aTreeNode ]
		ifNone: [
			"gives a new root"
			(aNewRoot := aNewRoot grow: anElement measuredExtent)
				detect: anElement measuredExtent
				ifFound: [ :aTreeNode | aTargetNode := aTreeNode ]
				ifNone: [ self error: 'Can not grow' ] ].

	self
		assert: [ aTargetNode isNotNil ]
		description: [ 'Target node must not be nil' ].

	anElement measuredBounds position: (aTargetNode split: anElement measuredExtent) origin.
	
	^ aNewRoot
]

{ #category : #'initialize-release' }
GtGraphRectanglePackLayout >> initialize [
	super initialize
]

{ #category : #hook }
GtGraphRectanglePackLayout >> pickRoot: theElements [
	| width height |

	width := theElements
		ifEmpty: [ 0 ];
		ifNotEmpty: [ theElements first measuredWidth ].

	height := theElements
		ifEmpty: [ 0 ];
		ifNotEmpty: [ theElements first measuredHeight ].

	^ GtGraphRectanglePackTree new
		x: 0;
		y: 0;
		width: width;
		height: height
]

{ #category : #hook }
GtGraphRectanglePackLayout >> sorted: theElements [
	| sortedElements |

	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		(larger measuredWidth + larger measuredHeight) > (smaller measuredWidth + larger measuredHeight) ].
	sortedElements addAll: theElements.

	^ sortedElements
]
