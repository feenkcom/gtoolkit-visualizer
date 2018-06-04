examples - composite
containerWithTreeLayout
	<gtExample>
	| aContainer aTreeLayout |
	
	aContainer := self container.
	aTreeLayout := self treeLayout.

	aContainer layout: aTreeLayout.
	
	^ aContainer