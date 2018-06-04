examples - instance creation
editor
	<gtExample>
	| anEditorModel anEditorElement |

	anEditorModel := BrTextEditor new.
	anEditorModel text: 'a' asRopedText.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditorModel.
	anEditorElement size: 75@25.
	anEditorElement background: (Color random alpha: 0.2).
	anEditorElement geometry: (BlRectangle cornerRadius: 5).
	
	^ anEditorElement