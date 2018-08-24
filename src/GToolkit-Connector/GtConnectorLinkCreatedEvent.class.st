"
Is sent by styler when it detects a new logical link between methods since previous styling operation
"
Class {
	#name : #GtConnectorLinkCreatedEvent,
	#superclass : #GtConnectorStylerEvent,
	#instVars : [
		'link'
	],
	#category : 'GToolkit-Connector-Events'
}

{ #category : #'instance creation' }
GtConnectorLinkCreatedEvent class >> link: aConnectorLink [
	^ self new link: aConnectorLink
]

{ #category : #accessing }
GtConnectorLinkCreatedEvent >> link [
	^ link
]

{ #category : #accessing }
GtConnectorLinkCreatedEvent >> link: anObject [
	link := anObject
]

{ #category : #sending }
GtConnectorLinkCreatedEvent >> sendTo: anObject [
	anObject linkCreated: self
]
