api - selection
deselectAll
	"Deselect all selected figures"

	self selectedFigures copy do: [ :anElement | self deselect: anElement ]