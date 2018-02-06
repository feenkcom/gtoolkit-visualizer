scripting
connect: aCollection from: aFromBlock toAll: aToAllBlock
	^ aCollection flatCollect: [ :each |
		self connect: (aToAllBlock value: each) from: [ :x | aFromBlock value: each ] to: [ :x | x ] ]