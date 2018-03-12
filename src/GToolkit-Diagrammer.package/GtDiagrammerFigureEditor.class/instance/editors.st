accessing
editors
	^ Array streamContents: [ :aStream |
		editorDeclarations do: [ :anEditorDeclaration |
			| theEditors |
			
			theEditors := anEditorDeclaration editors.
			theEditors do: [ :anEditor | anEditor parent: self ].
			aStream nextPutAll: theEditors ] ]