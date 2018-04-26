api - scripting
pop
	| aFirstLineAnchorElement |

	aFirstLineAnchorElement := self domianElements
		ifEmpty: [ ^ self ]
		ifNotEmpty: #first.
		
	aFirstLineAnchorElement removeFromParent