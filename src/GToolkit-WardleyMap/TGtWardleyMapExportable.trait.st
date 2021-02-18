Trait {
	#name : #TGtWardleyMapExportable,
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #'api - export / import' }
TGtWardleyMapExportable >> asDictionaryForExport [
	"Answer the receiver as a dictionary ready for JSON serialisation.
	Users will override and add to the dictionary"

	^ self explicitRequirement
]

{ #category : #'api - export / import' }
TGtWardleyMapExportable >> asJSONForExport [ 
	"Answer the receiver serialised in JSON format"

	^ STONJSON toStringPretty: self asDictionaryForExport
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
