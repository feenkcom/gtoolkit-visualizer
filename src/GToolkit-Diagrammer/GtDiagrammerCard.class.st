Class {
	#name : #GtDiagrammerCard,
	#superclass : #BlElement,
	#category : #'GToolkit-Diagrammer-UI'
}

{ #category : #initialization }
GtDiagrammerCard >> initialize [
	super initialize.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: Color white.
	"self effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 0@0)."
	self border: (BlBorder paint: Color gray)
]
