as yet unclassified
exampleWithLogger
	<gtExample>
	| aContainer theNodes logger |

	"Previously falling example."
	aContainer := self containerWithCircleLayout.  

	theNodes := 10 timesCollect: [ :index |
		| aNode |
		aNode := BlElement new
						background: (Color lightGray alpha: 0.5);
						border: (BlBorder builder width: 1; paint: Color black) build;
						size: 500@200;
						labeled: 'Node ', index asString.
		aNode graph beNode.
		aNode ].
	aContainer addChildren: theNodes.
	
	logger := MemoryLogger new.
	logger runDuring: [  
		aContainer forceLayout.
	].
	
	^ aContainer
