calculating
"protocol: #calculating"

"protocol: #calculating"

mergeContours: aNode child: childNode contours: aContoursDict
	| x y total upper lower parentUpperTail childUpperTail parentLowerTail childLowerTail|
	
	x := 0.
	y := 0.
	total := 0.
	
	parentUpperTail	 := (aContoursDict at: aNode) upperTail.
	childUpperTail	 := (aContoursDict at: childNode) upperTail.
	parentLowerTail	 := (aContoursDict at: aNode) lowerTail.
	childLowerTail	 := (aContoursDict at: childNode) lowerTail.
						
	upper := (aContoursDict at: aNode) lowerHead.
	lower := (aContoursDict at: childNode) upperHead.
	
	[lower isNotNil and: [ upper isNotNil ]]
		whileTrue: [
			| offset lowerX upperX lowerY upperY|
			offset := self calculateOffset: lower otherContourLine: upper x: x y: y.
			y := y + offset.
			total := total + offset.		
			lowerX := lower position x.
			upperX := upper position x.
			lowerY := lower position y.
			upperY := lower position y.

			((x + lowerX) <= upperX)
				ifTrue: [ 
					x := x + lowerX.
					y := y + lowerY.
					lower := lower next.
				]
				ifFalse: [ 
					x := x - upperX.
					y := y - upperY.
					upper := upper next.
				].
		 ].
	

	lower isNotNil
		ifTrue: [ 
			| connectingLine |
				connectingLine := parentUpperTail connectingLine: lower x1:0 y1:0 x2:x y2:y.
				(connectingLine next) isNotNil
					ifTrue: [ parentUpperTail := childUpperTail ]
					ifFalse: [ parentUpperTail := connectingLine ].
				parentLowerTail := childLowerTail.
		]
		ifFalse: [ 
			| connectingLine |
			connectingLine := childLowerTail connectingLine: upper x1:x y1:y x2:0 y2:0.
			(connectingLine next) isNil
				ifTrue: [ 
					parentLowerTail  := connectingLine
				].
		].

	lower := (aContoursDict at: childNode) lowerHead.
	
	^ total.
	
	

	