examples - layout
containerWithTreeLayoutAnd10SimpleNodes
	<gtExample>
	| aContainer theNodes |

	aContainer := self containerWithTreeLayout.
	theNodes := self simpleTreeNodes10.
	aContainer addChildren: theNodes.
	
	aContainer forceLayout.
