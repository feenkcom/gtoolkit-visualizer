api - deletion
deleteSelected
	"Delete all selected figures from a diagrammer"
	
	self selectedFigures copy do: [ :anElement |
		self deselect: anElement.
		anElement removeFromParent ]