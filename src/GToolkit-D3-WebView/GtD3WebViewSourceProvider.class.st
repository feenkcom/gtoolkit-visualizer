Class {
	#name : #GtD3WebViewSourceProvider,
	#superclass : #Object,
	#instVars : [
		'sourcesFolder'
	],
	#category : #'GToolkit-D3-WebView'
}

{ #category : #'instance creation' }
GtD3WebViewSourceProvider class >> forGToolkitVisualiserExamplesFolder [
	^ self new 
		sourcesFolder: FileLocator gtResource 
			/ 'feenkcom' 
			/ 'gtoolkit-visualizer' 
			/ 'data' 
			/ 'd3'
]

{ #category : #'gt - extensions' }
GtD3WebViewSourceProvider >> gtViewFilesFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Sources folder';
		object: [ self sourcesFolder ];
		view: #gtTreeFor:
]

{ #category : #accessing }
GtD3WebViewSourceProvider >> htmlForViewWithName: aViewName dataUrl: aDataUrl selectionUrl: aSelectionUrl [
	^ ((self sourcesFolder / ('d3-', aViewName, '.html')) contents
		copyReplaceAll: '{dataUrl}' with: aDataUrl asString)
		copyReplaceAll: '{selectionUrl}' with: aSelectionUrl asString
]

{ #category : #accessing }
GtD3WebViewSourceProvider >> sourcesFolder [
	^ sourcesFolder ifNil: [
		'.' asFileReference ]
]

{ #category : #configuring }
GtD3WebViewSourceProvider >> sourcesFolder: aFolderOrFileLocator [
	sourcesFolder := aFolderOrFileLocator
]
