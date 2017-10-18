examples - basic
verticalAxis
	<gtExample>
	
	^ self axisElement
		size: 20@400;
		constraintsDo: [ :c | c plotter vertical axis: self axis ]