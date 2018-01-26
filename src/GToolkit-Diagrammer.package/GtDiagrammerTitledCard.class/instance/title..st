api - accessing
title: aString
	| aText |
	
	aText := aString asString asRopedText.
	aText attributes: {
		BrTextForegroundAttribute paint: Color gray.
		BrFontWeightAttribute thin }.
	
	titleElement text: aText