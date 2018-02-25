initialization
initialize
	super initialize.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	self geometry: (BlRectangle cornerRadius: 4).
	self background: Color white.
	"self effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 0@0)."
	self border: (BlBorder paint: Color gray)