Extension { #name : #GtPhlowProtoView }

{ #category : #'*GToolkit-Mondrian-Phlow' }
GtPhlowProtoView >> mondrian [
	^ GtPhlowMondrianView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]
