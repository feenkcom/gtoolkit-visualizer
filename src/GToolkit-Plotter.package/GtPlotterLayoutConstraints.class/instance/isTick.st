testing
isTick
	"Return true if a holder of this constraint represents a vertical or horizontal tick"
	<return: #Boolean>
	
	^ self isHorizonalTick or: [ self isVerticalTick ]