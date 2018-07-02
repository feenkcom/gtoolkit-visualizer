api - scripting
with: aCollection
	| theAnchors theLines |

	self topStep removeChildren.

	self topStep addChildren: { axisX . axisY }.
	
	"we must not proceed, because overlapping pairs does not work with an empty collection :)"
	aCollection
		ifEmpty: [ ^ self ].

	theAnchors := aCollection collect: [ :each |
		| aLineAnchorElement |
		aLineAnchorElement := self lineAnchorElementFor: each.
		aLineAnchorElement ].

	theLines := theAnchors overlappingPairsCollect: [ :aFromAnchorElement :aToAnchorElement |
		self lineElementFrom: aFromAnchorElement to: aToAnchorElement ].

	self topStep addChildren: theAnchors.
	self topStep addChildren: theLines.