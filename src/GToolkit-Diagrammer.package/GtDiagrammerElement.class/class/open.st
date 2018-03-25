instance creation
open
	<script: 'self open'>
	| aSpace |
	aSpace := BlSpace new.
	aSpace title: 'GT-Diagrammer'.
	aSpace extent: 1200@800.
	aSpace root addChild: GtDiagrammerElement new.
	aSpace show