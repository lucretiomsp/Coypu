Extension { #name : #DateAndTime }

{ #category : #'*LiveCoding' }
DateAndTime >> asNTPTimeStamp [

	| sec microsec ntpTimeStamp |
	sec := self asUnixTime + 2208988800 asByteArrayOfSize: 4.
	microsec := (self nanoSecond * (2 raisedToInteger: 32)
	            / (10 raisedToInteger: 9)) asInteger asByteArrayOfSize: 4.
	ntpTimeStamp := sec , microsec.

	^ ntpTimeStamp
]

{ #category : #'*LiveCoding' }
DateAndTime >> microSecond [

^ nanos / 1000
]

{ #category : #'*LiveCoding' }
DateAndTime >> plusMicroseconds: microseconds [

	"operand conforms to protocol Duration"

	| extraSeconds extraNanoseconds |
	
	^ self class basicNew
		  setJdn: julianDayNumber 
		  seconds: seconds + extraSeconds 
		  nano: nanos + extraNanoseconds 
		  offset: self offset;
		  yourself
]
