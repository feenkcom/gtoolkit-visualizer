ui
asPannableElement
	| scalable |
	scalable := BlPannableElement new.
	scalable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	scalable contentElement: self topStep root.
	scalable background: (Color gray alpha: 0.2).
	scalable contentElement look: BrShadowLook new.
	scalable zoomableElement clipChildren: false.
	self topStep root clipChildren: true.
	
	^ scalable