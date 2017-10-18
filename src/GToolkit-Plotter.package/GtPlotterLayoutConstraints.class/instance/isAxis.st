testing
isAxis
	"Return true if a holder of this constraint represents a vertical or horizontal axis"
	<return: #Boolean>
	
	^ self isHorizonalAxis or: [ self isVerticalAxis ]