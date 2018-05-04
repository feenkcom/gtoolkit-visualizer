examples - composite
containerWithCircleLayoutAnd10EditorNodes
	<gtExample>
	| aContainer theNodes |

	aContainer := self containerWithCircleLayout.
	theNodes := self editorNodes10.
	
	aContainer addChildren: theNodes.
	
	^ aContainer