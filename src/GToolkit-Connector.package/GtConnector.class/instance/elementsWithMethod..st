search
elementsWithMethod: aMethod

	^ self editorElements 
		select: [ :anEditorElement | 
			anEditorElement userData
				at: #editedMethod
				ifPresent: [ :anEditedMethod | aMethod = anEditedMethod ]
				ifAbsent: [ false ] ]