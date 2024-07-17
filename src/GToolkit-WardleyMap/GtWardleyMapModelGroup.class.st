Class {
	#name : #GtWardleyMapModelGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-WardleyMap'
}

{ #category : #accessing }
GtWardleyMapModelGroup >> gtItemsFor: aView [
<gtView>
	^ aView columnedList 
		title: 'Items';
		items: [ self items ];
		column: 'Title' text: [:each | each title];
		column: 'Nodes' text: [:each | each nodes size ];
		column: 'Edges' text: [:each | each edges size ]
]

{ #category : #accessing }
GtWardleyMapModelGroup >> gtNodeProfilesFor: aView [
	<gtView>
	| elements |
	^ aView columnedList
		title: 'Node profiles';
		items: [ ((self items flatCollect: [ :each | each nodes ])
				groupedBy: [ :each | each label ]) associations
				sorted: [ :a :b | a key < b key ] ];
		column: 'Label' text: [ :each | each key ];
		column: 'Positions'
			text: [ :each | 
				', '
					join: (each value collect: [ :node | node evolution printShowingDecimalPlaces: 2 ]) ];
		column: 'Profile'
			stencil: [ :association | 
				elements := association value
						collect: [ :aNode | 
							BlElement new
								aptitude: (BrStyleCommonAptitude new
										default: [ :s | s background: (Color black alpha: 0.2) ];
										hovered: [ :s | s background: BrGlamorousColors primaryBorderColor ];
										pressed: [ :s | s background: BrGlamorousColors pressedButtonBorderColor ]);
								when: BlClickEvent
									do: [ :e | 
										e target phlow spawnObject: aNode parent.
										e consumed: true ];
								size: 10 @ 10;
								geometry: BlCircleGeometry new;
								background: (Color black alpha: 0.2);
								relocate: (aNode evolution * 100 + 5) @ 5 ].
				BlElement new
					size: 110 @ 20;
					geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
					border: Color veryVeryLightGray;
					addChildren: elements ]
			width: 120
]
