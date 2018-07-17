private - layout
calculateOffset: contour1 otherContourLine: contour2 x: x y: y
	<return: #Number>
	| offset contour1x contour1y contour2x contour2y |

	offset := 0.
	contour1x := contour1 position x.
	contour1y := contour1 position y.
	contour2x := contour2 position x.
	contour2y := contour2 position y.

	(contour2x <= x or: [ x + contour1x <= 0 ])
		ifTrue: [ ^ 0 ].
	((contour2x * contour1y) - (contour1x * contour2y)) > 0
		ifTrue: [ x < 0
				ifTrue: [ offset := ((x * contour1y) / contour1x) - y ].
			x > 0
				ifTrue: [ offset := ((x * contour2y) / contour2x) - y ].
			x = 0
				ifTrue: [ offset := 0 - y ]. ]
		ifFalse: [ offset := contour2x < (x + contour1x)
				ifTrue: [ contour2y - (y + (((contour2x - x) * contour1y) / contour1x)) ]
				ifFalse: [ contour2x > (x + contour1x)
						ifTrue: [ (((contour1x + x) * contour2y) / contour2x) - (y + contour1y) ]
						ifFalse: [ contour2y - (y + contour1y) ]. ]. ].
	offset > 0
		ifTrue: [ ^ offset ].
	^ 0