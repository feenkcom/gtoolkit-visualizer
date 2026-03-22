Class {
	#name : #GtD3WebViewPhlowRegistry,
	#superclass : #Object,
	#instVars : [
		'phlowWrappersById'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewPhlowRegistry >> ensureWrapperIsRegisteredFor: aPhlowWrapper [
	phlowWrappersById 
		at: aPhlowWrapper id 
		ifAbsentPut: [ aPhlowWrapper ]
]

{ #category : #accessing }
GtD3WebViewPhlowRegistry >> gtViewRegisteredWrappersFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Registered view';
		items: [ phlowWrappersById associations ];
		column: 'Id' text: [ :assoc | assoc key ];
		column: 'View name' text: [ :assoc | assoc value viewName ]
]

{ #category : #initialization }
GtD3WebViewPhlowRegistry >> initialize [
	super initialize.
	
	phlowWrappersById := WeakValueDictionary new.
]

{ #category : #requests }
GtD3WebViewPhlowRegistry >> phlowWrapperWithId: anId ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ phlowWrappersById at: anId ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]
