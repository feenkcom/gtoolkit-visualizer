Extension { #name : #GtSmaCCParserStyler }

{ #category : #'*GToolkit-WardleyMap' }
GtSmaCCParserStyler class >> wardleyMapStyler: aParserClass [
	"This is a generic styler that does a little formatting for any parser"

	<smaccStyler: #GtWardleyMapParser priority: 10>
	^ (self forParser: aParserClass)
		stylerRules: {
				GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMPresentationStyleNode
					variableNames: #(styleToken)
					styleBlock: [ :styler | styler foreground: Color purple ].
					
				GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMEvolutionNode
					variableNames: #(evolutionToken arrows)
					styleBlock: [ :styler | styler foreground: Color purple ].
		
				GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMTitleNode
					variableNames: #(titleToken)
					styleBlock: [ :styler | styler foreground: Color purple ].
					
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMElementNode
					variableNames: #(typeToken)
					styleBlock: [ :styler | styler foreground: Color purple ])
						continueOnMatch: true.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMElementNode
					variableNames: #(name)
					styleBlock: [ :styler | styler foreground: Color black ]).
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMLabelNode
					variableNames: #(labelToken)
					styleBlock: [ :styler | styler foreground: Color purple ])
						continueOnMatch: true.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMLabelNode
					variableNames: #(left x comma y right)
					styleBlock: [ :styler | styler foreground: Color blue darker ])
						continueOnMatch: false.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMPipelineNode
					variableNames: #(pipelineToken)
					styleBlock: [ :styler | styler foreground: Color purple ])
						continueOnMatch: true.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMPipelineNode
					variableNames: #(name)
					styleBlock: [ :styler | styler foreground: Color darkGray ])
						continueOnMatch: true.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMPipelineNode
					variableNames: #(left evolution1 comma evolution2 right)
					styleBlock: [ :styler | styler foreground: Color blue darker ])
						continueOnMatch: false.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMNoteNode
					variableNames: #(noteToken)
					styleBlock: [ :styler | styler foreground: Color purple ])
						continueOnMatch: true.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMNoteNode
					variableNames: #(label)
					styleBlock: [ :styler | styler foreground: Color darkGray ]).
						
				(GtSmaCCNodeStylerRule
					nodeClassName: #GtWMCoordsNode
					styleBlock: [ :styler | styler foreground: Color blue darker ]).
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMLinkNode
					variableNames: #(arrow)
					styleBlock: [ :styler | styler foreground: Color purple ])
						continueOnMatch: true.
						
				(GtSmaCCNodeVariableStylerRule
					nodeClassName: #GtWMLinkNode
					variableNames: #(start end)
					styleBlock: [ :styler | styler foreground: Color black ])
						continueOnMatch: false.
					
				GtSmaCCKeywordTokensStylerRule
					styleBlock: [ :styler | 
						styler
							bold;
							foreground: Color purple ].
							
				GtSmaCCCommentStylerRule
					styleBlock: [ :styler | styler foreground: Color lightGray ].
				GtSmaCCNodeVariableStylerRule
					nodeClassName: #SmaCCErrorNode
					variableNames: #(dismissedTokens errorToken)
					styleBlock: [ :styler | styler foreground: Color red ]}
]
