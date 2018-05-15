ui
asPannableElement
	| pannable |
	pannable := BlPannableElement new.
	pannable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	pannable contentElement: self topStep root.
	pannable zoomableElement clipChildren: false.
	self topStep root clipChildren: true.
	^ pannable