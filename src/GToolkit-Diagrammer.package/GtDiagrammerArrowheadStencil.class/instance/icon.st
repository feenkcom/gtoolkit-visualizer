instance creation
icon
	"Create an element playing a role of an icon in a UI picker"
	<return: #BlElement>
	| cellSize aLine aContainer |

	cellSize := self iconSize.
	
	aLine := BlLineElement new.
	aLine transformDo: [ :t | t origin: BlAffineTransformationLeftCenterOrigin new; scaleBy: 1.5 ].
	aLine border: (BlBorder paint: (Color lightGray) width: 3).
	aLine fromAnchor: (BlAbsolutePositionAnchor position: ((cellSize x / 5) @ cellSize y / 2.0)).
	aLine toAnchor: (BlAbsolutePositionAnchor position: (cellSize x / 1.5 @ (cellSize y / 2.0))).
	aLine toHead: self preview.
	
	aContainer := BlElement new.
	aContainer size: cellSize.
	aContainer addChild: aLine.
	
	^ aContainer