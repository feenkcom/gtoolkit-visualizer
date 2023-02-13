Class {
	#name : #GtWardleyMapConstants,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - constants' }
GtWardleyMapConstants class >> externalCanvasExtent [
	"The default extent was taken from a https://onlinewardleymaps.com website,
	inspecting a HTML elements. It was an optimal canvas extent of a particular
	wardley map graph for which all nodes where nicely located."

	^ 1024 @ 716
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> externalPipelineHeight [
	"I represent a pipeline height in pixels use in https://onlinewardleymaps.com."

	^ 24
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> minPipelineRelativeWidth [
	"I represent kind of padding in relative coordinates (0, 1)"

	^ 0.15
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodeColor [
	"I represent a default node model color"

	^ Color black
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodeSize [
	"I represent a default node model size"

	^ 12 @ 12
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> pipelineHeight [
	"I represent a pipeline height in pixels.
	It is a minimum pipeline height as we may need to enlarge considering inner node sizes."

	^ 20
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> pipelineRelativeOffset [
	"I represent a kind of padding in relative coordinates (0, 1).
	It is a space between an inner node and a pipeline border."

	^ 0.01
]
