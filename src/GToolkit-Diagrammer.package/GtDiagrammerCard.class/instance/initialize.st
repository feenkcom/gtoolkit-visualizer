initialization
initialize
	super initialize.
	
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	self margin: (BlInsets top: 9 left: 15 bottom: 9 right: 15).

	self geometry: (BlRectangle cornerRadius: 4).
	self background: Color white.
	self effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 0@0).

	titleElement := BlTextElement new.
	titleElement margin: (BlInsets all: 5). 
	self addChild: titleElement as: #title.

	contentElement := BlElement new.
	self addChild: contentElement as: #content