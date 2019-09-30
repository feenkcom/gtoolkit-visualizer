Extension { #name : #BlElement }

{ #category : #'*GToolkit-Connector' }
BlElement >> beConnectedTo: anObject [
	self connector
		beConnectedTo: anObject.
"		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection add: anObject ]
		ifAbsentPut: [ Set with: anObject ]"
]

{ #category : #'*GToolkit-Connector' }
BlElement >> beNotConnectedTo: anObject [
	self connector
		beNotConnectedTo: anObject.
]

{ #category : #'*GToolkit-Connector' }
BlElement >> connector [
	^ self userData
		at: #connector 
		ifAbsentPut: [ GtConnectorElementContext on: self ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> connectorSource [
	^ self userData at: #connectorSource
]

{ #category : #'*GToolkit-Connector' }
BlElement >> explainer [
	^ self userData
		at: #explainer 
		ifAbsentPut: [ GtExplainerElementContext on: self ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> isConnectedTo: anObject [
	^ self connector 
		isConnectedTo: anObject
	"	at: #connectorConnections
		ifPresent: [ :aCollection | aCollection includes: anObject ]
		ifAbsent: [ false ]"
]

{ #category : #'*GToolkit-Connector' }
BlElement >> isConnectorSource [
	^ self connector isNotNil and: [ self connector source isNotNil ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> isConnectorTarget [
	^ self connector isNotNil and: [ self connector isVisualTarget  ]

]
