accessing
depth: aNumber
	| aChildDepth |
	"Changing my depth also updates the depth of my children"
	depth := aNumber.

	aChildDepth := depth + 1.
	self nodes do: [ :aTreeNode | aTreeNode depth: aChildDepth ]