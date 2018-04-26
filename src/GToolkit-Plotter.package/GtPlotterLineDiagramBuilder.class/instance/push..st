api - scripting
push: anObject
	| aLineAnchorElement aLastLineAnchorElement aLineElement |

	aLineAnchorElement := self lineAnchorElementFor: anObject.

	aLastLineAnchorElement := self domianElements
		ifEmpty: [
			self topStep addChildren: { aLineAnchorElement }.
			^ self ]
		ifNotEmpty: #last.

	aLineElement := self lineElementFrom: aLastLineAnchorElement to: aLineAnchorElement.

	self topStep addChildren: { aLineAnchorElement . aLineElement }