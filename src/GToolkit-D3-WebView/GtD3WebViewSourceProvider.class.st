Class {
	#name : #GtD3WebViewSourceProvider,
	#superclass : #Object,
	#category : #'GToolkit-D3-WebView'
}

{ #category : #accessing }
GtD3WebViewSourceProvider >> htmlForViewWithName: aViewName withDataUrl: anUrl [
	^ ('.' asFileReference / ('d3-', aViewName, '.html')) contents
		copyReplaceAll: '{url}' with: anUrl asString
]
