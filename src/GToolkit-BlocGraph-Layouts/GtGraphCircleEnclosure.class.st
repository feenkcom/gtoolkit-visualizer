"
1. Smallest enclosing circle of circles

I compute the smallest circle that encloses the specified array of circles. The enclosing circle is computed using the [Matoušek-Sharir-Welzl](http://www.inf.ethz.ch/personal/emo/PublFiles/SubexLinProg_ALG16_96.pdf) algorithm.

The implementation is based on [d3.packEnclose(circles)](https://github.com/d3/d3-hierarchy/blob/master/src/pack/enclose.js)

Let's start with an empty enclosure:
{{gtExample:GtGraphCircleEnclosureExamples>>#emptyEnclosure|previewShow=#gtPreviewFor:|previewHeight=300}}

and add circles one by one, starting with a larger one. A circle enclosure is represented by a cyan circle. An enclosure of a single circle is a special case and can be computed directly by {{gtMethod:GtGraphCircleEnclosure class>>#enclosure:}}. Note, that the added circle has a margin set which is taken into account by enclosure:
{{gtExample:GtGraphCircleEnclosureExamples>>#enclosureWithOneCircle|previewShow=#gtPreviewFor:|previewExpanded|previewHeight=300}}

adding a second circle expands the enclosure circle to fit both circles `C1` and `C2`. Two circle enclosure is also a special case and can be derived directly by {{gtMethod:GtGraphCircleEnclosure class>>#enclosure:and:}}
{{gtExample:GtGraphCircleEnclosureExamples>>#enclosureWithTwoCircles|previewShow=#gtPreviewFor:|previewExpanded|previewHeight=300}}

Three circle enclosure is a special case too. {{gtMethod:GtGraphCircleEnclosure class>>#enclosure:and:and:}} is responsible for the computation. Let's add the third circle to our enclosure to see the result: 
{{gtExample:GtGraphCircleEnclosureExamples>>#enclosureWithThreeCircles|previewShow=#gtPreviewFor:|previewExpanded|previewHeight=300}}

Starting with four circles, an enclosure should be computed recursively by building and updating a basis enclosure consisting of one to three circles: {{gtMethod:GtGraphCircleEnclosure class>>#enclosureAll:}}. 

{{gtExample:GtGraphCircleEnclosureExamples>>#enclosureWithFourCircles|previewShow=#gtPreviewFor:|previewExpanded|previewHeight=300}}


"
Class {
	#name : #GtGraphCircleEnclosure,
	#superclass : #Object,
	#instVars : [
		'circles'
	],
	#category : #'GToolkit-BlocGraph-Layouts-Data Structures - Circle'
}

{ #category : #algebra }
GtGraphCircleEnclosure class >> enclosure: aCircle [
	<return: #GtGraphCircle>

	^ GtGraphCircle new
		center: aCircle center;
		radius: aCircle outerRadius
]

{ #category : #algebra }
GtGraphCircleEnclosure class >> enclosure: aCircle and: anotherCircle [
	<return: #GtGraphCircle>
	|
		x1 y1 r1
		x2 y2 r2
		x21 y21 r21
		l x y r
	|

	x1 := aCircle center x.
	y1 := aCircle center y.
	r1 := aCircle outerRadius.
	
	x2 := anotherCircle center x.
	y2 := anotherCircle center y.
	r2 := anotherCircle outerRadius.

	x21 := x2 - x1.
	y21 := y2 - y1.
	r21 := r2 - r1.
	
	l := ((x21 * x21) + (y21 * y21)) sqrt.

	x := (l closeTo: 0)
		ifTrue: [ (x1 + x2) / 2.0 ]
		ifFalse: [ (x1 + x2 + (x21 / l * r21)) / 2.0 ].
		
	y := (l closeTo: 0)
		ifTrue: [ (y1 + y2) / 2.0 ]
		ifFalse: [ (y1 + y2 + (y21 / l * r21)) / 2.0 ].

	r := (l + r1 + r2) / 2.0.
	
	^ GtGraphCircle new
		center: x @ y;
		radius: r
]

{ #category : #algebra }
GtGraphCircleEnclosure class >> enclosure: aFirstCircle and: aSecondCircle and: aThirdCircle [
	<return: #GtGraphCircle>
	|
		x1 y1 r1
		x2 y2 r2
		x3 y3 r3
		a2 a3
		b2 b3
		c2 c3
		d1 d2 d3
		ab xa xb ya yb
		a b c
		r x y |

	x1 := aFirstCircle center x.
	y1 := aFirstCircle center y.
	r1 := aFirstCircle outerRadius.
	
	x2 := aSecondCircle center x.
	y2 := aSecondCircle center y.
	r2 := aSecondCircle outerRadius.
	
	x3 := aThirdCircle center x.
	y3 := aThirdCircle center y.
	r3 := aThirdCircle outerRadius.

	a2 := x1 - x2.
	a3 := x1 - x3.
	b2 := y1 - y2.
	b3 := y1 - y3.

	c2 := r2 - r1.
	c3 := r3 - r1.
	d1 := (x1 * x1) + (y1 * y1) - (r1 * r1).
	d2 := d1 - (x2 * x2) - (y2 * y2) + (r2 * r2).
	d3 := d1 - (x3 * x3) - (y3 * y3) + (r3 * r3).
	ab := (a3 * b2) - (a2 * b3).
	
	xa := ((b2 * d3) - (b3 * d2)) / (ab * 2) - x1.
	xb := ((b3 * c2) - (b2 * c3)) / ab.
	ya := ((a3 * d2) - (a2 * d3)) / (ab * 2) - y1.
	yb := ((a2 * c3) - (a3 * c2)) / ab.
	
	a := (xb * xb) + (yb * yb) - 1.
	b := 2 * (r1 + (xa * xb) + (ya * yb)).
	c := (xa * xa) + (ya * ya) - (r1 * r1).
	r := (a isZero
		ifTrue: [ c / b ]
		ifFalse: [ (b + ((b * b) - (4 * a * c)) sqrt) / (2 * a) ]) negated.

	x := x1 + xa + (xb * r).
	y := y1 + ya + (yb * r).
	
	^ GtGraphCircle new
		center: x @ y;
		radius: r
]

{ #category : #algebra }
GtGraphCircleEnclosure class >> enclosureAll: theCircles [
	<return: #GtGraphCircle>
	| aBasis theShuffledCircles anIndex aLength anEnclosureCircle |
	
	aBasis := self new circles: {}.
	theShuffledCircles := theCircles shuffled.
	anIndex := 1.
	aLength := theShuffledCircles size.
	anEnclosureCircle := nil.
	
	[ anIndex <= aLength ]
		whileTrue: [
			| eachCircle |
			
			eachCircle := theShuffledCircles at: anIndex.
			(anEnclosureCircle isNotNil and: [ anEnclosureCircle enclosesWeak: eachCircle ])
				ifTrue: [ anIndex := anIndex + 1 ]
				ifFalse: [
					self extendBasis: aBasis with: eachCircle.
					anEnclosureCircle := aBasis basisEnclosureCircle.
					anIndex := 1 ] ].

	^ anEnclosureCircle
]

{ #category : #algebra }
GtGraphCircleEnclosure class >> enclosureOfZero [
	<return: #GtGraphCircle>

	^ GtGraphCircle new	
	
]

{ #category : #algebra }
GtGraphCircleEnclosure class >> extendBasis: anEnclosure with: aCircle [
	<return: #GtGraphCircleEnclosure>
	
	(aCircle enclosesWeakAll: anEnclosure circles)
		ifTrue: [ ^ anEnclosure circles: { aCircle } ].
	
	"If we get here then B must have at least one element."
	anEnclosure circles do: [ :eachCircle |
		((aCircle encloses: eachCircle) not
			and: [ (self enclosure: eachCircle and: aCircle) enclosesWeakAll: anEnclosure circles ])
				ifTrue: [ ^ anEnclosure circles: { eachCircle . aCircle } ] ].

	"If we get here then B must have at least two elements."
	
	anEnclosure circles withIndexDo: [ :eachCircle :i |
		i + 1 to: anEnclosure circles size do: [ :j |
			| anotherCircle |
			anotherCircle := anEnclosure circles at: j.
			
			(((self enclosure: eachCircle and: anotherCircle) encloses: aCircle) not
				and: [ ((self enclosure: eachCircle and: aCircle) encloses: anotherCircle) not
					and: [ ((self enclosure: anotherCircle and: aCircle) encloses: eachCircle) not
						and: [ (self enclosure: eachCircle and: anotherCircle and: aCircle) enclosesWeakAll: anEnclosure circles ] ] ])
				ifTrue: [ ^ anEnclosure circles: { eachCircle . anotherCircle . aCircle } ] ] ].
		
	self error: 'Something went very wrong!'
]

{ #category : #adding }
GtGraphCircleEnclosure >> addCircle: aCircle [
	self circles: circles, { aCircle }
]

{ #category : #'gt-inspector-extension' }
GtGraphCircleEnclosure >> asElement [
	^ GtGraphCircleEnclosureElement new enclosure: self
]

{ #category : #algebra }
GtGraphCircleEnclosure >> averageRadius [
	self circles
		ifEmpty: [ ^ 0 ].
	^ (self circles collect: #outerRadius) average
]

{ #category : #'private - algebra' }
GtGraphCircleEnclosure >> basisEnclosureCircle [
	<return: #GtGraphCircle>
	
	circles size = 0
		ifTrue: [ ^ self class enclosureOfZero ].
		
	circles size = 1
		ifTrue: [ ^ self class enclosure: circles first ].
		
	circles size = 2
		ifTrue: [ ^ self class enclosure: circles first and: circles second ].
		
	circles size = 3
		ifTrue: [ ^ self class enclosure: circles first and: circles second and: circles third ].
	
	^ self class enclosureAll: circles
]

{ #category : #accessing }
GtGraphCircleEnclosure >> circles [
	^ circles
]

{ #category : #accessing }
GtGraphCircleEnclosure >> circles: aCollectionOfCircles [
	circles := aCollectionOfCircles
]

{ #category : #algebra }
GtGraphCircleEnclosure >> enclosureCircle [
	<return: #GtGraphCircle>
	
	^ self class enclosureAll: circles
]

{ #category : #'gt-inspector-extension' }
GtGraphCircleEnclosure >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		stencil: [ self asElement asScalableElement margin: (BlInsets all: 10)]
]

{ #category : #initialization }
GtGraphCircleEnclosure >> initialize [
	super initialize.
	
	circles := #()
]
