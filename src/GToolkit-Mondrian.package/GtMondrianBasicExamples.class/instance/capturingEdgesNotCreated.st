debugging edge creation
capturingEdgesNotCreated
	<gtExample>
	| l view |
	l := MemoryLogger new.
	l runDuring: [ 
		view := GtMondrian new.
		view nodes with: (1 to: 2).
		view edges connect: { 1->3 . 0->2 . 4->5 } from: #key to: #value.
		view ].
	self assert: l recordings size = 3.
	l recordings allSatisfy: [ :signal | signal isKindOf: GtMondrianEdgeNotCreated ].
	self assert: l recordings first fromModel = 1. 
	self assert: l recordings first fromElement notNil. 
	self assert: l recordings first toModel = 3.
	self assert: l recordings first toElement isNil.
	self assert: l recordings second fromModel = 0. 
	self assert: l recordings second fromElement isNil.
	self assert: l recordings second toModel = 2. 
	self assert: l recordings second toElement notNil. 
	self assert: l recordings third fromModel = 4.
	self assert: l recordings third fromElement isNil. 
	self assert: l recordings third toModel = 5.
	self assert: l recordings third toElement isNil. 
	^ l