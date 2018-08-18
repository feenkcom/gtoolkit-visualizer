examples
simpleExample
	<gtExample>
		
	| view theNodes layout |
	
	view := self view.
	layout := GtGradKamadaKawaiLayout new.
	theNodes := self nodes: (1 to: 15).
	view addChildren: theNodes.
	view layout: layout.
	view forceLayout. 

	^ view