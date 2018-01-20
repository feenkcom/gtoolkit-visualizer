scripting
forEach: aBlock in: aSymbol
	createdElements
		do: [ :child | 
			self mondrian
				with:
					(GtMondrianStep new
						root: (child graph childrenContainerNamed: aSymbol))
				do: [ aBlock value: child graph model ] ].
	^ createdElements