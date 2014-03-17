echo Add some points of intetrest

curl "http://localhost:8080/wstutorial/pointsOfInterest/add?name=The+Red+Lion&postcode=S1+2ND&format=json"
curl "http://localhost:8080/wstutorial/pointsOfInterest/add?name=Genting+Club&postcode=S1+2PN&format=json"
curl "http://localhost:8080/wstutorial/pointsOfInterest/add?name=The+Rutland+Arms&postcode=S1+2BS&format=json"
curl "http://localhost:8080/wstutorial/pointsOfInterest/add?name=The+Sheffield+Tap&postcode=S1+2BP&format=json"


echo get them back

curl "http://localhost:8080/wstutorial/pointsOfInterest/index?format=json"
