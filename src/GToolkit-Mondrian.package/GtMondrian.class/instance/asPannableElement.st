ui
asPannableElement
	| pannable |
	pannable := BlPannableElement new.
	pannable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].	
	pannable contentElement: self root removeFromParent.
	pannable zoomableElement clipChildren: false.
	^ pannable