Extension { #name : #GtPhlowView }

{ #category : #'*GToolkit-Mondrian-Phlow' }
GtPhlowView >> mondrian [
	^ GtPhlowMondrianView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]
