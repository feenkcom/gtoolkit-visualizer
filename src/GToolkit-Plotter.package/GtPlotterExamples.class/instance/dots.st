examples - basic
dots
	<gtExample>
	
	^ self data
		collect: [ :anObject | self dotElement constraintsDo: [ :c | c plotter domainObject: anObject ] ]