examples - layout
failingExampleWithLogger
	<gtExample>
	| aContainer theNodes logger |

	aContainer := self containerWithCircleLayout. 
	theNodes := 10 timesCollect: [
		| aNode |
		aNode := BlElement new
						background: (Color gray alpha: 0.5);
						border: (BlBorder builder width: 1; paint: Color black) build;
						size: 500@200.
		aNode graph beNode.
		aNode ].
	aContainer addChildren: theNodes.
	
	logger := MemoryLogger new.
	logger runDuring: [  
		aContainer forceLayout.
	].
	
	^ logger
