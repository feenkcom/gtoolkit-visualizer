Extension { #name : #GtPhlowProtoView }

{ #category : #'*GToolkit-Mondrian-Phlow' }
GtPhlowProtoView >> mondrian [
	<return: #GtPhlowMondrianView>
	^ GtPhlowMondrianView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]
