api - scripting
with: aCollection
	| theAnchors theLines |

	theAnchors := aCollection collect: [ :each |
		| aLineAnchorElement |
		aLineAnchorElement := self lineAnchorElementFor: each.
		aLineAnchorElement ].

	theLines := theAnchors overlappingPairsCollect: [ :aFromAnchorElement :aToAnchorElement |
		self lineElementFrom: aFromAnchorElement to: aToAnchorElement ].

	self topStep addChildren: { axisX . axisY }.
	self topStep addChildren: theAnchors.
	self topStep addChildren: theLines.