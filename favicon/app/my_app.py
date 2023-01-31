import sys, requests
arg = sys.argv
if len(arg) != 3:
	print("Enter two arguments: url and name of favicon")
else:

	url = str(arg[1])
	filename = "/app/" + str(arg[2]) + "_favicon.ico"
	r = requests.get(url, allow_redirects=True)
	open(filename, 'wb').write(r.content)
