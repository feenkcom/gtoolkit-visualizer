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
BlElement >> connectorEdge [
	^ self userData
		at: #connectorEdge 
		ifAbsentPut: [ GtConnectorLineContext on: self ]
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
BlElement >> gtExplainerTreeFor: aView [
	<gtView>
	self explainer isExplanationHolder ifFalse: [ ^ aView empty].
	^ aView mondrian
		title: 'Explainer';
		painting: [ :m | 
			m nodes 
				stencil: [ :each | 
					| el |
					el := (each explainer isExplanation or: [ each explainer isTarget ])
						ifTrue: [ BrLabel new aptitude: BrGlamorousLabelAptitude; text: ((each explainer model asString) asRopedText foreground: Color white); geometry: (BlRoundedRectangleGeometry cornerRadius: 4); background: Color orange]
						ifFalse: [ BlElement new geometry: BlEllipseGeometry new; border: (BlBorder paint: Color black); size: 5@5 ].
					el when: BlClickEvent do: [:e | e target phlow spawnObject: each ] 
				];
				with: self withAllChildrenBreadthFirst.
			m edges 
				fromRightCenter;
				toLeftCenter;
				connectFrom: #parent.
			m edges
				passive;
				fromRightCenter;
				toRightCenter;
				stencil: [ :e | 
					BlParabollaArcElement new 
						zIndex: 0;
						curvatureFraction: 0.3;
						border: (BlBorder paint: (Color orange alpha: 0.8) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color orange alpha: 0.8); width: 4; build)) ];
				connect: ((self withAllChildrenBreadthFirst select: [:each | each explainer model notNil]) groupedBy: [:each | each explainer model ]) values
				fromAll: [:assoc | assoc select: [:el | el explainer isExplanation ] ]
				toAll: [:assoc | assoc select: [:el | el explainer isTarget ] ].
			m layout horizontalTree.
			m ]
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
