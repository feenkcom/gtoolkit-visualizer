Extension { #name : 'TBlTextStyleable' }

{ #category : '*GToolkit-Connector' }
TBlTextStyleable >> glamorousExplanationFor: anExplanationModel [
	self attributesBuilder attribute: (GtExplainerExplanationAttribute new explanationModel: anExplanationModel)
]
