private - instance creation
defaultLineElement
	<return: #BlLineElement>

	^ BlLineElement new
		border: (BlBorder paint: Color gray width: 1);
		yourself