examples - composite
containerWithCircleLayoutAnd10EditorNodes
	<gtExample>
	| aContainer theNodes |

	aContainer := self containerWithCircleLayout.
	theNodes := self editorNodes10WithRandomContent.
	
	aContainer addChildren: theNodes. 
	
	^ aContainer