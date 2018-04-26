initialization
initialize
	super initialize.
	
	task := BlRepeatedTaskAction new.
	task delay: 50 milliSeconds.
	task action: [ self onUpdate ].
	limit := 100