Class {
	#name : #RandomTests,
	#superclass : #TestCase,
	#category : #'Coypu-Tests'
}

{ #category : #tests }
RandomTests >> testRandomNextInt [

self assert: ((Random new nextInt: 10) > 0 ) & ((Random new nextInt: 10) < 10 )equals: true


]
