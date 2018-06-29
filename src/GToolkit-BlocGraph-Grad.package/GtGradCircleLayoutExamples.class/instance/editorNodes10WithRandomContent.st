examples - composite
editorNodes10WithRandomContent
	<gtExample>

	^((Character space split: String loremIpsum) first: 10) collect: [ :word |
		| anEditor anEditorModel|
		
		anEditorModel := BrTextEditor new.
		anEditorModel text: word asRopedText.

		anEditor := BrEditorElement new.
		anEditor editor: anEditorModel.
		anEditor size: 140@80.
	
		anEditor background: (Color veryVeryLightGray ).
		anEditor border: (BlBorder builder width: 1; paint: Color black) build.
		anEditor geometry: (BlRectangle cornerRadius: 5)..
		anEditor graph beNode.
		anEditor 
	].
	

