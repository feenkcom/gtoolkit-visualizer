Trait {
	#name : #TGtWardleyMapExportable,
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - export / import' }
TGtWardleyMapExportable >> asJSONForExport [ 
	"Answer the receiver serialised in JSON format"

	^ STONJSON toStringPretty: (self acceptVisitor: GtWardleyMapAsDictionaryExporter new)
]

{ #category : #'api - export / import' }
TGtWardleyMapExportable >> gtJSONFor: aView [
	<gtView>

	^ aView textEditor
		title: 'JSON';
		priority: 8;
		look: [ BrGlamorousCodeEditorLook ];
		styler: [ JSONParser gtStyler ];
		text: [ self asJSONForExport ]
]
