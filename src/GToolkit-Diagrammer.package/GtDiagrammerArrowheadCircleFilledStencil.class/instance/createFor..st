instance creation
createFor: aCurveElement
	<return: #BlArrowheadCircle>

	^ (super createFor: aCurveElement)
		background: (aCurveElement border paint copy)