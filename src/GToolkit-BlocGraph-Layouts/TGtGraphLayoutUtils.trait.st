Trait {
	#name : #TGtGraphLayoutUtils,
	#category : #'GToolkit-BlocGraph-Layouts-Basic'
}

{ #category : #utils }
TGtGraphLayoutUtils >> fatherOf: aNode [
	^ aNode userData at: #father ifAbsent: [ nil ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> fatherOf: aNode put: aValue [
	aNode userData at: #father put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> layerOf: aNode [
	^ aNode userData at: #layout
]

{ #category : #utils }
TGtGraphLayoutUtils >> layerOf: aNode put: aValue [
	aNode userData at: #layout put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> leftContourOf: aNode [
	^ aNode userData at: #leftContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> leftContourOf: aNode put: aValue [
	aNode userData at: #leftContour put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> modOf: aNode [
	^ aNode userData at: #mod ifAbsent: [ ^ 0 ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> modOf: aNode put: aFloat [
	aNode userData at: #mod put: aFloat
]

{ #category : #utils }
TGtGraphLayoutUtils >> pointerOf: aNode [

	^ aNode userData at: #pointer ifAbsent: [ ^ nil ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> pointerOf: aNode put: aValue [

	^ aNode userData at: #pointer put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> rOf: aNode [ 
	^ aNode userData at: #r ifAbsent: [ 0 ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> rOf: aNode put: aValue [
	^ aNode userData at: #r put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> rightContourOf: aNode [
	^ aNode userData at: #rightContour ifAbsent: [ ^ nil ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> rightContourOf: aNode put: aValue [
	aNode userData at: #rightContour put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> thetaOf: aNode [
	^ aNode userData at: #theta ifAbsent: [ ^ 0 ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> thetaOf: aNode put: aValue [
	^ aNode userData at: #theta put: aValue
]

{ #category : #utils }
TGtGraphLayoutUtils >> xOf: aNode [ 
	^ aNode userData at: #x ifAbsent: [ 0 ]
]

{ #category : #utils }
TGtGraphLayoutUtils >> xOf: aNode put: aValue [
	aNode userData at: #x put: aValue
]
