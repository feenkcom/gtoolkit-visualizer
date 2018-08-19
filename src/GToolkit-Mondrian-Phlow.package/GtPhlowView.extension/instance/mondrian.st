*GToolkit-Mondrian-Phlow
mondrian
	^ GtPhlowMondrianView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition