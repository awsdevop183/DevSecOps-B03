import requests

web_site = "https://reqres.in/api/users/"

response = requests.get(url=web_site)
print(response.json())

