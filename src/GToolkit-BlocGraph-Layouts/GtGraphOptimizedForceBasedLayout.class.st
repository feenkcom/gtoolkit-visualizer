Class {
	#name : #GtGraphOptimizedForceBasedLayout,
	#superclass : #GtGraphForceBasedLayout,
	#instVars : [
		'mockElements'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Layouts'
}

{ #category : #hook }
GtGraphOptimizedForceBasedLayout >> executeOnElements: elements with: anExtentSpec [
	"The argument is the set of Roassal elements"
	mockElements := elements collect: [ :e | GtGraphMockElement new realElement: e ].
	super executeOnElements: mockElements with: anExtentSpec.
	mockElements do: #applyToRealElement
]

{ #category : #accessing }
GtGraphOptimizedForceBasedLayout >> setEdgesFromElements: elements [ 
	| view realElements realEdges mockEdges |
	elements isEmpty ifTrue: [ ^ self ].

	view := elements anyOne view.
	realElements := elements collect: #realElement.
	view ifNil: [ ^ self ].
	
	realEdges := view edges select: [ :el | 
		("el isUsedInLayout and: [ "realElements includes: el from "]") and: [ realElements includes: el to ] ].
	mockEdges := realEdges collect: [ :e | 
							GtGraphMockEdge new 
								from: (elements detect: [ :ee | ee realElement == e from ]);
								to: (elements detect: [ :ee | ee realElement == e to ]) ].
	self edges: mockEdges.
	
]
