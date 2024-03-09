Extension { #name : #Process }

{ #category : #'*Coypu' }
Process >> swapWith: anotherProcess [
"terminate the Process and start anotherProcess"
self terminate.
anotherProcess resume.
]
