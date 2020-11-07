from firebase import firebase
import requests
import sys
import os
sys.path.insert(1, 'hx711/hx711py')
import example

ENDPOINT_URL = 'INSERT URL'
firebase_db_url = 'INSERT URL'
firebase = firebase.FirebaseApplication(firebase_db_url, None)

previousValue = 0.0
VAL_THRESHOLD = 0.4 # TODO : this should be changed based on the item used
MIN_WEIGHT_THRESHOLD = 150.0 # TODO : this should be changed based on the item used

'''
TODOS:
This scale should be authed to firebase via the client app
Current thresholds are only suitable for an item like the disenfectant bottle
-> while adding an item via the app, these values should be updated
When scale is authed, remove hardcoded "scale_1" etc values from backend calls

Keeping the Firebase dependency here if we have time to do the aforementioned
'''

def uploadValue(newValue):
	requests.post(ENDPOINT_URL, data = {'scale': 'scale_1', 'weight': newValue})



def scaleCallback(newValue):
	global previousValue

	# setting of the inital value
	if previousValue == 0.0 and newValue > MIN_WEIGHT_THRESHOLD:
		previousValue = newValue
		print('Set new value ' + str(previousValue))
		uploadValue(newValue)
	# handle case when user presses on the item on the scale (pump bottle)
	elif (newValue - previousValue) > previousValue * 2 and (newValue - previousValue) >= 150:
		print('User most likely consumed by pressing on the scale skipping')
		return
	# should hit when a single usage is made
	elif (previousValue - newValue) >= VAL_THRESHOLD:
		diff = previousValue - newValue
		previousValue = newValue
		print('Value changed to ' + str(previousValue) + ' with diff ' + str(diff))
		uploadValue(newValue)
	else:
		print('Previous value is ' + str(previousValue) + ' new value is ' + str(newValue) + ' diff is too small, skipping')

def main():
	result = firebase.get('/scales', None)
	print(result)
	example.poll(scaleCallback)

if __name__ == "__main__":
	main()