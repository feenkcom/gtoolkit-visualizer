range
computeRange: anAxis
	| minValue maxValue |
	
	minValue := anAxis axisValueOf: domainElements first constraints plotter domainObject.
	maxValue := minValue.
	
	domainElements do: [ :aDomainElement |
		| anAxisValue |
		anAxisValue := anAxis axisValueOf: aDomainElement constraints plotter domainObject.
		
		(anAxis compare: anAxisValue with: minValue)
			ifTrue: [ minValue := anAxisValue ].
			
		(anAxis compare: maxValue with: anAxisValue)
			ifTrue: [ maxValue := anAxisValue ] ].
		
	^ GtPlotterFixedRange new
		min: minValue;
		max: maxValue