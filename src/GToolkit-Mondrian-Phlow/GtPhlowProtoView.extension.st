Extension { #name : #GtPhlowProtoView }

{ #category : #'*GToolkit-Mondrian-Phlow' }
GtPhlowProtoView >> mondrian [
	^ GtPhlowMondrianView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition
]
