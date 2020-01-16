Class {
	#name : #GtNestedTreeItem,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-TreeMap-Data Structures'
}

{ #category : #'accessing - computed' }
GtNestedTreeItem >> children [
	<return: #Array>
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtNestedTreeItem >> gtSquarifiedTreemapFor: aView [
	<gtView>
	^ aView explicit
		title: 'Squarified';
		priority: 2;
		stencil: [ 
			GtNestedRectangleTreeMap new
				roots: self children;
				deep: [ :anItem | anItem nodes ];
				leaves: [ :anItem | anItem leaves ];
				leavesSize: [ :aLeaf | aLeaf weight ];
				leafEllipse: [ :anElement :aLeaf | 
					anElement 
						addChild: (BlElement new
							background: (Color veryLightGray alpha: 0.5);
							constraintsDo: [ :c | 
								c vertical matchParent.
								c horizontal matchParent ]) ]
			]
]

{ #category : #'gt-extension' }
GtNestedTreeItem >> gtTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Tree';
		priority: 1;
		items: [ { self } ];
		children: [ :anItem | anItem children ];
		expandUpTo: 1;
		column: 'Name' item: [ :anItem | anItem ];
		column: 'Weight' item: [ :anItem | anItem weight asFloat round: 2 ] width: 80;
		column: 'Porcentage' 
			item: [ :anItem | 
				| aWeight |
				aWeight := self weight.
				aWeight isZero
					ifFalse: [ (((anItem weight / self weight) * 100) asFloat round: 2) asString, '%' ]
					ifTrue: [ '' ] ]
			width: 80
]

{ #category : #'accessing - computed' }
GtNestedTreeItem >> weight [
	<return: #Number>
	^ self subclassResponsibility
]
