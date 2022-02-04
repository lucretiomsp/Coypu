Extension { #name : #Process }

{ #category : #'*LiveCoding' }
Process >> swapWith: anotherProcess [
"terminate the Process and start anotherProcess"
self terminate.
anotherProcess resume.
]
