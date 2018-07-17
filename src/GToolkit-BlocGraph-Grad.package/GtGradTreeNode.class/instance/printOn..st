printing
printOn: aStream

	aStream
		nextPutAll: 'Node';
		nextPut: $[;
		nextPutAll: self depth asString;
		nextPut: $];
		space;
		nextPut: $(;
		print: self element;
		nextPut: $)