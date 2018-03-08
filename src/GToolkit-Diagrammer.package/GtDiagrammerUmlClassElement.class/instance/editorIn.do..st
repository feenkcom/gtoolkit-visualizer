private - accessing
editorIn: aContainerSymbol do: aBlock
	"Search for an editor inside of a container by its name
	and evaluate a block if such an editor is found"

	self
		childrenContaner: aContainerSymbol
		ifFound: [ :aContainer |
			aContainer
				childrenContaner: #editor
				ifFound: aBlock
			ifNone: #yourself ]
		ifNone: #yourself