Extension { #name : #BlElement }

{ #category : #'*GToolkit-Connector' }
BlElement >> beConnectedTo: anObject [
	self userData
		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection add: anObject ]
		ifAbsentPut: [ Set with: anObject ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> beConnectorSource [
	self userData at: #isConnectorSource put: true
]

{ #category : #'*GToolkit-Connector' }
BlElement >> beConnectorTarget [
	self userData at: #isConnectorTarget put: true
]

{ #category : #'*GToolkit-Connector' }
BlElement >> beNotConnectedTo: anObject [
	self userData
		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection remove: anObject ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> connectorSource [
	^ self userData at: #connectorSource
]

{ #category : #'*GToolkit-Connector' }
BlElement >> connectorSource: anObject [
	self userData at: #connectorSource put: anObject
]

{ #category : #'*GToolkit-Connector' }
BlElement >> connectorTarget [
	^ self userData at: #connectorTarget
]

{ #category : #'*GToolkit-Connector' }
BlElement >> connectorTarget: anObject [
	self userData at: #connectorTarget put: anObject
]

{ #category : #'*GToolkit-Connector' }
BlElement >> isConnectedTo: anObject [
	^ self userData
		at: #connectorConnections
		ifPresent: [ :aCollection | aCollection includes: anObject ]
		ifAbsent: [ false ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> isConnectorSource [
	^ self userData
		at: #isConnectorSource
		ifAbsent: [ false ]
]

{ #category : #'*GToolkit-Connector' }
BlElement >> isConnectorTarget [
	^ self userData
		at: #isConnectorTarget
		ifAbsent: [ false ]
]
