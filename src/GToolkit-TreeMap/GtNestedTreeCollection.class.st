Class {
	#name : #GtNestedTreeCollection,
	#superclass : #GtNestedTreeItem,
	#category : 'GToolkit-TreeMap-Data Structures'
}

{ #category : #testing }
GtNestedTreeCollection class >> isAbstract [
	^ self name = #GtNestedTreeCollection 
]

{ #category : #'gt-extension' }
GtNestedTreeCollection >> gtSquarifiedTreemapFor: aView [
	<gtView>
	^ aView explicit
		title: 'Squarified';
		priority: 2;
		stencil: [ 
			GtNestedRectangleTreeMap new
				tree: self;
				deep: [ :anItem | anItem nodes ];
				leaves: [ :anItem | anItem leaves ];
				leavesSize: [ :aLeaf | aLeaf weight ];
				containerElement: [ :anElement :aNodeContext | 
					anElement border: (BlBorder paint: (Color gray alpha: 0.5 / aNodeContext level) width: 2).
					anElement padding: (BlInsets all: 2) ];
				leafElement: [ :anElement :aLeafContext | 
					anElement border: (BlBorder paint: (Color gray alpha: 0.5 / aLeafContext level) width: 2).
					anElement background: (Color blue alpha: 0.2) ]
			]
]

{ #category : #private }
GtNestedTreeCollection >> sum: aBlockClosure in: aCollection [ 
	<return: #Number>
	^ aCollection
		ifEmpty: [ 0 ] 
		ifNotEmpty: [ aCollection sum: aBlockClosure ]
]
