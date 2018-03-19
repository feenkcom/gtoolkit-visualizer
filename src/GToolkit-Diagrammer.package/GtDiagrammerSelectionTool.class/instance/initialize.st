initialization
initialize
	super initialize.
	
	selector := BlVisualSelectionHandler new.

	selectedFigures := Set new.

	resizer := BlResizerElement new.
	resizer preventMouseEvents