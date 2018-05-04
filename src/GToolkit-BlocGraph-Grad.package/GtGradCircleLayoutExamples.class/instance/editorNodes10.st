examples - composite
editorNodes10
	<gtExample>

	^ 10 timesCollect: [
		| anEditor |
		anEditor := self editor.
		anEditor graph beNode.
		anEditor ]