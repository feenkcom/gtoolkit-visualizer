Class {
	#name : #GtConnectorExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : 'GToolkit-Connector'
}

{ #category : #examples }
GtConnectorExamples class >> oneExampleMethod [
	<script: 'self oneExampleMethod'>
	self
		openInWindow: self new oneExampleMethod
		named: 'GT-Connector'
		extent: 960@790
]

{ #category : #examples }
GtConnectorExamples >> oneExampleMethod [
	<gtExample>
	| connector |
	connector := GtConnector new.
	connector addMethod: (BlFrameLayoutExamples>>#example).
	^ connector
]
