scripting
painting: aBlock
	self originalView stencil: [
		| mondrian | 
		mondrian := GtMondrian new.
		aBlock value: mondrian.
		mondrian asPannableElement ]