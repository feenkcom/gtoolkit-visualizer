initialization
initialize
	super initialize.

	nodes := OrderedCollection new.
	depth := 0.

	"I get a parent when I am added to the other node as a child"
	parent := nil.
	"by default we are not attached to any element"
	element := nil.