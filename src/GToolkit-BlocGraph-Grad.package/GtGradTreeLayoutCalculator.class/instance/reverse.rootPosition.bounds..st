private - layout
reverse: aTreeNode rootPosition: theRootPosition bounds: bounds
	| newNodePosition |

	newNodePosition := self layout reversedPositionOfNode:
									aTreeNode rootPosition: theRootPosition
									bounds: bounds.

	aTreeNode element constraints gradTree computedPosition: newNodePosition.

	aTreeNode nodes do: [ :child |
		self reverse: child rootPosition: theRootPosition bounds: bounds
	].