Class {
	#name : #GtGraphRectanglePackTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Rectangle'
}

{ #category : #adding }
GtGraphRectanglePackTree >> add: aRectangle [

	root ifNil: [ root := GtGraphRectanglePackTreeNode new
		x: 0;
		y: 0;
		width: aRectangle outerWidth;
		height: aRectangle outerHeight ].

	root
		detect: aRectangle
		ifFound: [ :aNode | aNode put: aRectangle ]
		ifNone: [
			root := root grow: aRectangle.
			root detect: aRectangle
				ifFound: [ :aNode | aNode put: aRectangle ]
				ifNone: [  ]
		]
]

{ #category : #'gt-inspector-extension' }
GtGraphRectanglePackTree >> gtPreviewFor: aView [
	<gtView>
	
	root
		ifNil: [ ^ aView empty ].

	^ root gtPreviewFor: aView
]

{ #category : #'gt-inspector-extension' }
GtGraphRectanglePackTree >> gtTreeFor: aView [
	<gtView>
	
	root
		ifNil: [ ^ aView empty ].

	^ root gtTreeFor: aView
]

{ #category : #accessing }
GtGraphRectanglePackTree >> root [
	^ root
]
