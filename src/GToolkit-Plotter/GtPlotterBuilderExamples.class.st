Class {
	#name : #GtPlotterBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Plotter-Example - Builders'
}

{ #category : #'example - website visits' }
GtPlotterBuilderExamples >> sequoias [
	<gtExample>
	<return: #Array>
	^ self sequoiasRaw
		collect: [ :each | 
			{#species -> each first.
				#genus -> each second.
				#extinct -> each third not.
				#pages -> each fourth} asDictionary ]
]

{ #category : #'example - website visits' }
GtPlotterBuilderExamples >> sequoiasRaw [
	^ { 
		{ 'Sequoia affinis'. 'Sequoia'. false. 3360 }.
		{ 'Metasequoia glyptostroboides'. 'Metasequoia'. true . 29300 }.
		{ 'Sequoia langsdorfii'. 'Sequoia'. false . 5920 }.
		{ 'Metasequoia occidentalis'. 'Metasequoia'. false . 7020 }.
		{ 'Sequoia sempervirens'. 'Sequoia'. true . 53700 }.
		{ 'Sequoia dakotensis'. 'Sequoia'. false . 1630 }.
		{ 'Sequoiadendron chaneyi' . 'Sequoiadendron'. false . 1260 }.
		{ 'Metasequoia foxii'. 'Metasequoia'. false . 1690 }.
		{ 'Sequoia chinensis'. 'Sequoia'. false . 676 }.
		{ 'Metasequoia milleri'. 'Metasequoia'. false . 1530 }.
		{ 'Sequoiadendron giganteum'. 'Sequoiadendron'. true . 36900 }.
		{ 'Sequoia magnifica'. 'Sequoia'. false . 763 }.
		{ 'Metasequoia disticha'. 'Metasequoia'. false . 1380 } }
]

{ #category : #'example - website visits' }
GtPlotterBuilderExamples >> websiteVisits [
	<gtExample>
	<return: #Array>
	^ self websiteVisitsRaw
		collect: [ :each | 
			{#domain -> each first.
				#duration -> each second.
				#frequency -> each third} asDictionary ]
]

{ #category : #'example - website visits' }
GtPlotterBuilderExamples >> websiteVisitsRaw [
	^ { 
		{ 'Google.com'. (Duration days: 0 hours: 0 minutes: 12 seconds: 09). 14.66 }.
		{ 'Youtube.com'. (Duration days: 0 hours: 0 minutes: 11 seconds: 40). 6.67 }.
		{ 'Facebook.com'. (Duration days: 0 hours: 0 minutes: 17 seconds: 52). 7.85 }.
		{ 'Qq.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 49). 4.00 }.
		{ '360.cn'. (Duration days: 0 hours: 0 minutes: 3 seconds: 21). 3.96 }.
		{ 'Amazon.com'. (Duration days: 0 hours: 0 minutes: 9 seconds: 42). 9.04 }.
		{ 'Wikipedia.org'. (Duration days: 0 hours: 0 minutes: 3 seconds: 55). 2.96 }.
		{ 'Sina.com.cn'. (Duration days: 0 hours: 0 minutes: 2 seconds: 58). 3.51 }.
		{ 'Pages.tmall.com'. (Duration days: 0 hours: 0 minutes: 1 seconds: 16). 1.48 }.
		{ 'Reddit.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 58). 5.66 }.
		{ 'Blogspot.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 32). 2.70 }.
		{ 'Csdn.net'. (Duration days: 0 hours: 0 minutes: 3 seconds: 33). 4.99 }.
		{ 'Instagram.com'. (Duration days: 0 hours: 0 minutes: 7 seconds: 08). 6.79 }.
		{ 'Yahoo.co.jp'. (Duration days: 0 hours: 0 minutes: 8 seconds: 26). 7.46 }.
		{ 'Google.com.hk'. (Duration days: 0 hours: 0 minutes: 3 seconds: 21). 5.02 }.
		{ 'Twitter.com'. (Duration days: 0 hours: 0 minutes: 10 seconds: 44). 7.77 }.
		{ 'Twitch.tv'. (Duration days: 0 hours: 0 minutes: 5 seconds: 33). 3.00 }.
		{ 'Stackoverflow.com'. (Duration days: 0 hours: 0 minutes: 5 seconds: 56). 3.80 }.
		{ 'Amazon.co.jp'. (Duration days: 0 hours: 0 minutes: 7 seconds: 32). 9.52 }.
		{ 'Google.co.in'. (Duration days: 0 hours: 0 minutes: 5 seconds: 41). 9.22 }.
		{ 'Tianya.cn'. (Duration days: 0 hours: 0 minutes: 2 seconds: 59). 5.11 }.
		{ 'Panda.tv'. (Duration days: 0 hours: 0 minutes: 2 seconds: 47). 5.15 }.
		{ 'Apple.com'. (Duration days: 0 hours: 0 minutes: 3 seconds: 42). 3.69 }.
		{ 'Amazon.in'. (Duration days: 0 hours: 0 minutes: 11 seconds: 42). 9.64 }.
		{ 'Zhanqi.tv'. (Duration days: 0 hours: 0 minutes: 2 seconds: 49). 5.19 }.
	}
]
