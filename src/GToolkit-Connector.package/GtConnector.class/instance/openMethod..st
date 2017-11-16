private
openMethod: aMethod
	"Open a given method without connecting it to other"
	| aTargetElement |	
	self
		assert: [ (self hasOpenedMethod: aMethod) not ]
		description: [ 'Can not open already opened method' ].

	aTargetElement := self createAndAddElementForMethod: aMethod.	

	self link: aTargetElement.
	self connect: aTargetElement