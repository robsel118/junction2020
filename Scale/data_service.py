from firebase import firebase
import sys
sys.path.insert(1, 'hx711/hx711py')
import example

def myCallback(scaleVAl):
	print(scaleVAl)

def main():
	firebase = firebase.FirebaseApplication('https://junction2020-1d1be.firebaseio.com/', None)
	#result = firebase.post('https://junction2020-1d1be.firebaseio.com/', {'cTemp':str(1.23),'ftemp':str(2.23), 'humidity':str(3.4)})
	result = firebase.get('/scales', None)
	print(result)
	example.poll()

if __name__ == "__main__":
    main()