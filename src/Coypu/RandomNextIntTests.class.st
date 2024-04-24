Class {
	#name : #RandomNextIntTests,
	#superclass : #TestCase,
	#category : #'Coypu-Tests'
}

{ #category : #tests }
RandomNextIntTests >> testRandomNextInt [

	self 
		assert: ((Random new nextInteger: 10) > 0 ) & ((Random new nextInteger: 10) < 10 )
		equals: true


]
