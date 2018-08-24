Extension { #name : #GtExample }

{ #category : #'*GToolkit-Connector' }
GtExample >> gtInspectorBlocConnectedExamplesIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite bloc
		title: 'Connected (Bloc)';
		element: [ 
			| connector |
			connector := GtConnector new.
			connector addMethod: self method.
			connector asScalableElement ]
]
