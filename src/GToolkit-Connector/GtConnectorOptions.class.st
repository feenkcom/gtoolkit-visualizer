Class {
	#name : #GtConnectorOptions,
	#superclass : #Object,
	#instVars : [
		'drawLines'
	],
	#category : #'GToolkit-Connector-Core'
}

{ #category : #accessing }
GtConnectorOptions >> drawLines [
	<return: #Boolean>

	^ drawLines
]

{ #category : #accessing }
GtConnectorOptions >> drawLines: aBoolean [
	drawLines := aBoolean
]

{ #category : #'gt-extension' }
GtConnectorOptions >> gtOptionsFor: aView [
	<gtExample>
	
	^ aView columnedList
		title: 'Styles' translated;
		priority: 10;
		items: [ { 
			'Draw Lines' -> self drawLines.
		} ];
		column: 'Option' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ]
]

{ #category : #accessing }
GtConnectorOptions >> initialize [
	super initialize.

	drawLines := true
]
