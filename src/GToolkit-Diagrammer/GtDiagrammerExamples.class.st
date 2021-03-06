"
1. Diagrammer

[[[example=GtDiagrammerExamples>>#diagrammer|expanded=true|noCode=true|show=gtLiveIn:]]]


"
Class {
	#name : #GtDiagrammerExamples,
	#superclass : #Object,
	#category : #'GToolkit-Diagrammer-Examples'
}

{ #category : #ui }
GtDiagrammerExamples >> colorPicker [
	<noTest>
	<gtExample>
	| container picker |

	container := BlElement new.
	container layout: BlLinearLayout horizontal.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	picker := GtDiagrammerColorPicker new.
	picker constraintsDo: [ :c | 
		c linear vertical alignCenter ].

	container addChildren: { picker }.

	^ container
]

{ #category : #'instance creation' }
GtDiagrammerExamples >> diagrammer [
	<noTest>
	<gtExample>
	
	^ GtDiagrammerElement new
]

{ #category : #examples }
GtDiagrammerExamples >> diagrammerWithEllipse [
	<noTest>
	<gtExample>
	| aDiagrammer anEllipse |
	
	aDiagrammer := self diagrammer.
	anEllipse := self ellipseStencil.
	
	aDiagrammer canvas addChild: (anEllipse relocate: 100@100).
	
	^ aDiagrammer
]

{ #category : #examples }
GtDiagrammerExamples >> diagrammerWithSelectedEllipse [
	<noTest>
	<gtExample>
	| aDiagrammer anEllipse |
	
	aDiagrammer := self diagrammerWithEllipse.
	anEllipse := aDiagrammer canvas children first.
	aDiagrammer select: anEllipse.

	^ aDiagrammer
]

{ #category : #'instance creation' }
GtDiagrammerExamples >> ellipseStencil [
	<noTest>
	<gtExample>
	
	^ GtDiagrammerEllipseStencil new create
]
