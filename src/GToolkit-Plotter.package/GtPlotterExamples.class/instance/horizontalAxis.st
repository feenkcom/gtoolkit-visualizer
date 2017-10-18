examples - basic
horizontalAxis
	<gtExample>
	
	^ self axisElement
		size: 400@20;
		constraintsDo: [ :c | c plotter horizontal axis: self axis ]