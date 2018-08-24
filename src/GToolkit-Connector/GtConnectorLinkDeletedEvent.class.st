"
Is sent by styler when logical link between methods disappeared since previous styling operation
"
Class {
	#name : #GtConnectorLinkDeletedEvent,
	#superclass : #GtConnectorStylerEvent,
	#instVars : [
		'link'
	],
	#category : 'GToolkit-Connector-Events'
}

{ #category : #'instance creation' }
GtConnectorLinkDeletedEvent class >> link: aConnectorLink [
	^ self new link: aConnectorLink
]

{ #category : #accessing }
GtConnectorLinkDeletedEvent >> link [
	^ link
]

{ #category : #accessing }
GtConnectorLinkDeletedEvent >> link: anObject [
	link := anObject
]

{ #category : #sending }
GtConnectorLinkDeletedEvent >> sendTo: anObject [
	anObject linkDeleted: self
]
