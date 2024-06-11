Class {
	#name : #GtWardleyMapConstants,
	#superclass : #Object,
	#category : #'GToolkit-WardleyMap-Helpers'
}

{ #category : #'api - constants' }
GtWardleyMapConstants class >> edgeElevationIndex [
	"I represent a default edge z-index"

	^ -1
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> edgeLabelCoordinate [
	"I represent a default edge label model coordinate"

	^ 0.5 @ 0.5
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> edgePropositionElevationIndex [
	"I represent a proposition edge z-index"

	^ -5
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> edgePropositionExtraWidth [
	"I represent an extra edge proposition width"

	^ 3.0
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> edgePropositionWidth [
	"I represent a default edge proposition width"

	^ self edgeWidth + self edgePropositionExtraWidth
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> edgeWidth [
	"I represent a default edge model width"

	^ 1.0
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> evolveColor [
	"I represent a default evolve model color"

	^ Color red
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> evolveMaturity [
	"I represent a default evolve model maturity"

	^ 0.5
]

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
GtWardleyMapConstants class >> hoverColor [
	^ BrGlamorousColors hoveredButtonBorderColor
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> labelCoordinate [
	"I represent a default label model coordinate"

	^ 0.5 @ 2.0
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> maxButtonLabelCharacters [
	^ 20
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
GtWardleyMapConstants class >> nodeCoordinate [
	"I represent a default node model coordinate"

	^ 0.5 @ 0.5
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodeElevationIndex [
	"I represent a default node z-index"

	^ 2
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodePropositionElevationIndex [
	"I represent a proposition node z-index"

	^ -5
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodePropositionExtraSize [
	"I represent a default node proposition extra size"

	^ 5 @ 5
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodePropositionSize [
	"I represent a default node proposition size"

	^ self nodeSize + self nodePropositionExtraSize
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> nodeSize [
	"I represent a default node model size"

	^ 12 @ 12
]

{ #category : #'api - constants' }
GtWardleyMapConstants class >> noteColor [
	"I represent a default note model color"

	^ Color black
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
