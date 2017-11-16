public
addMethod: aMethod
	"Create a new editor on a given method, add it to the scene"
	
	(self hasOpenedMethod: aMethod)
		ifTrue: [ ^ self ].

	self openMethod: aMethod.