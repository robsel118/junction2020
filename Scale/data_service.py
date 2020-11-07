from firebase import firebase
import sys
sys.path.insert(1, 'hx711/hx711py')
import example
firebase = firebase.FirebaseApplication('https://junction2020-1d1be.firebaseio.com/', None)

def myCallback(scaleVAl):
	print('Received value: ' + str(scaleVAl))

def main():
	result = firebase.get('/scales', None)
	print(result)
	example.poll(myCallback)

if __name__ == "__main__":
    main()