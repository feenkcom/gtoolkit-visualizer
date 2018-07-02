computation
calculateRadiusFor: aCollectionOfNodes threshold: threshold
	<return: #Number>

	| radius slice currentTheta previousTheta previousNode |
	aCollectionOfNodes size = 2
		ifTrue: [ ^ aCollectionOfNodes first measuredBounds width + aCollectionOfNodes second measuredBounds width + self distance ].
	
	radius := 0.
	slice := (2 * Float pi) / (aCollectionOfNodes size).
	currentTheta := 0.
	previousTheta := 0.
	previousNode := nil.
	aCollectionOfNodes doWithIndex: [ :each :i |
		|rx ry rCurrent angleCos angleSin|
		previousNode isNil
			ifFalse: [
					previousTheta := currentTheta.
					currentTheta := (i-1) * slice.
					(currentTheta > (2 * Float pi))
						ifTrue: [ currentTheta := 0].
					angleCos :=  2 * (((currentTheta cos) - (previousTheta cos)) abs).
					angleSin :=  2 * (((currentTheta sin) - (previousTheta sin)) abs).
					rx := 0.
					ry := 0.
					angleCos > 0.01
						ifTrue: [rx := ((each measuredBounds width) + (previousNode measuredBounds width) + threshold) / angleCos].
					angleSin > 0.01
						ifTrue: [ry := ((each measuredBounds height) + (previousNode measuredBounds height) + threshold) / angleSin].
		
					rCurrent := rx min: ry.
					((radius = 0) or: [radius > rCurrent])
						ifTrue: [radius := rCurrent].
				 ].	
		previousNode := each. 
	].
	^ radius.
		
	 