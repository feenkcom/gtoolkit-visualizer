examples - basic
data
	<gtExample>

	^ (((1 to: 300) collect: [ :i | 200 atRandom @ 200 atRandom ])
		select: [ :aPoint | (aPoint y - (aPoint x / 2.0)) abs < 15 ])
		collect: [ :each | GtPlotterDomainObject new value: each ]