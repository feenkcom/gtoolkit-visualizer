scripting
with: aCollection
	| elements |
	elements := aCollection collect: [ :each |
		| child |
		child := self nodeElementFor: each.
		mondrian nodeAt: each put: child.
		child ].
	self topStep addChildren: elements asOrderedCollection.
	createdElements addAll: elements.
	^ elements