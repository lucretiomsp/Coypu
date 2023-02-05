Extension { #name : #DateAndTime }

{ #category : #'*LiveCoding' }
DateAndTime >> asNTPTime [
"Unix uses an epoch located at 1/1/1970-00:00h (UTC) and NTP uses 1/1/1900-00:00h. This leads to an offset equivalent to 70 years in seconds (there are 17 leap years between the two dates so the offset is 2208988800"

	
^ self asUnixTime  + 2208988800 
]
