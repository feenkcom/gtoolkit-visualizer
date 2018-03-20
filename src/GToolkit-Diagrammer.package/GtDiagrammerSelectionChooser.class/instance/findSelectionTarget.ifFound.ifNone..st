private
findSelectionTarget: aSourceElement ifFound: foundBlock ifNone: exceptionBlock
	| theParents |

	theParents := self computeSelectionChainFor: aSourceElement.

	theParents
		detect: [ :anElement |
			anElement parent = self currentSelection
				or: [ anElement = self currentSelection
					and: [ anElement ~= self selectionTool canvas ] ] ]
		ifFound: [ :anElement | foundBlock cull: anElement ]
		ifNone: [
			theParents
				detect: [ :anElement | anElement parent = self selectionTool canvas ]
				ifFound: [ :anElement | foundBlock cull: anElement ]
				ifNone: [ exceptionBlock value ] ]