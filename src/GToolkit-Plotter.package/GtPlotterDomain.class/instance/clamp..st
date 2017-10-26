as yet unclassified
clamp: aValue

	aValue < self interval min
		ifTrue: [ ^ self interval min ].
		
	aValue > self interval max
		ifTrue: [ ^ self interval max ].
		
	^ aValue