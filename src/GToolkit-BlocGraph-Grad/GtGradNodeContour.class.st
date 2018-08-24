Class {
	#name : #GtGradNodeContour,
	#superclass : #Object,
	#instVars : [
		'upperTail',
		'upperHead',
		'lowerTail',
		'lowerHead'
	],
	#category : 'GToolkit-BlocGraph-Grad-Tree'
}

{ #category : #accessing }
GtGradNodeContour >> lowerHead [
	^lowerHead

]

{ #category : #accessing }
GtGradNodeContour >> lowerHead: aNodeContourLine [
	lowerHead := aNodeContourLine

]

{ #category : #accessing }
GtGradNodeContour >> lowerTail [
	^lowerTail

]

{ #category : #accessing }
GtGradNodeContour >> lowerTail: aNodeContourLine [
	lowerTail := aNodeContourLine

]

{ #category : #accessing }
GtGradNodeContour >> upperHead [
	^upperHead

]

{ #category : #accessing }
GtGradNodeContour >> upperHead: aNodeContourLine [
	upperHead := aNodeContourLine

]

{ #category : #accessing }
GtGradNodeContour >> upperTail [
	^upperTail

]

{ #category : #accessing }
GtGradNodeContour >> upperTail: aNodeContourLine [
	upperTail := aNodeContourLine

]
