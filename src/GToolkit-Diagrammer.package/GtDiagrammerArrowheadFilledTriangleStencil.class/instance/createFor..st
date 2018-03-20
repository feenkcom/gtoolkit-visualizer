instance creation
createFor: aCurveElement
	<return: #BlArrowheadElement>

	^ (super createFor: aCurveElement)
		background: (aCurveElement border paint copy)