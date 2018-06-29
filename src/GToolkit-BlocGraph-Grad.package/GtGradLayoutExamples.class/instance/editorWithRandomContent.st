examples - instance creation
editorWithRandomContent
	<gtExample>
	| anEditorModel anEditorElement |

	anEditorModel := BrTextEditor new.
	anEditorModel text: 'Some text'.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditorModel.
	anEditorElement size: 200@130.
	
	anEditorElement background: (Color random alpha: 0.2).
	anEditorElement geometry: (BlRectangle cornerRadius: 5).
	
	^ anEditorElement