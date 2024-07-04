Class {
	#name : #GtD3WebViewSourceProvider,
	#superclass : #Object,
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewSourceProvider >> htmlForViewWithName: aViewName dataUrl: aDataUrl selectionUrl: aSelectionUrl [
	^ (('.' asFileReference / ('d3-', aViewName, '.html')) contents
		copyReplaceAll: '{dataUrl}' with: aDataUrl asString)
		copyReplaceAll: '{selectionUrl}' with: aSelectionUrl asString
]
