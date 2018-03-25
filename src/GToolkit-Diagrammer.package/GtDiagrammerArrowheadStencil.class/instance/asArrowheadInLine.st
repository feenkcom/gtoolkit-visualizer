gt-inspector-extension
asArrowheadInLine
	| aLine |
	aLine := BlLineElement new.
	aLine border: (BlBorder paint: Color gray width: 5).
	aLine fromAnchor: (BlAbsolutePositionAnchor position: 30@50).
	aLine toAnchor: (BlAbsolutePositionAnchor position: 300@50).
	aLine toHead: (self createFor: aLine).
	^ aLine