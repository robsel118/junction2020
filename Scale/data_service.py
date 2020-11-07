from firebase import firebase
import sys
sys.path.insert(1, 'hx711/hx711py')
import example
firebase = firebase.FirebaseApplication('https://junction2020-1d1be.firebaseio.com/', None)

previousValue = 0.0
VAL_THRESHOLD = 0.4 # TODO : this should be changed based on the item used
MIN_WEIGHT_THRESHOLD = 50.0


def scaleCallback(newValue):
	global previousValue
	if previousValue == 0.0 and newValue > MIN_WEIGHT_THRESHOLD:
		previousValue = newValue
		print('Set new value ' + str(previousValue))
	elif (previousValue - newValue) >= VAL_THRESHOLD:
		diff = previousValue - newValue
		previousValue = newValue
		print('Value changed to ' + str(previousValue) + ' with diff ' + str(diff))
		# set value to firebase!
	elif (newValue - previousValue) <= 200.0 and (newValue - previousValue) > 50:
		previousValue = newValuer
		print('New value set! ' + str(previousValue))
	else:
		print('Previous value is ' + str(previousValue) + ' new value is ' + str(newValue) + ' diff is too small, skipping')

def main():
	result = firebase.get('/scales', None)
	print(result)
	example.poll(scaleCallback)

if __name__ == "__main__":
    main()