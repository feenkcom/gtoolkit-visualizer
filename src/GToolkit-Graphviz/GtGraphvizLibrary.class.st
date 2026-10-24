"
Common Graphviz shared-library discovery. Override library methods for nonstandard installations.
"
Class {
	#name : #GtGraphvizLibrary,
	#superclass : #FFILibrary,
	#category : #'GToolkit-Graphviz-FFI'
}

{ #category : #accessing }
GtGraphvizLibrary >> baseName [
	^ self subclassResponsibility
]

{ #category : #'library discovery' }
GtGraphvizLibrary >> macLibraryName [
	| name |
	name := 'lib', self baseName, '.dylib'.
	#('/opt/homebrew/lib/' '/usr/local/lib/' '/opt/local/lib/') do: [ :directory |
		(directory, name) asFileReference exists ifTrue: [ ^ directory, name ] ].
	^ name
]

{ #category : #'library discovery' }
GtGraphvizLibrary >> unixLibraryName [
	^ 'lib', self baseName, '.so.6'
]

{ #category : #'library discovery' }
GtGraphvizLibrary >> win32LibraryName [
	^ self baseName, '.dll'
]
