wstutorial
==========

Web Services Tutorial

A useful web service:

Lookup a UK postcode and return a lat/long
http://uk-postcodes.com/postcode/S38PZ



    grails create-app wstutorial


Lets create a service which will look up a postcode for us

Firstly, we need to use a rest library. Add

       compile ":rest:0.8"

to grails-app/conf/BuildConfig.groovy

grails create-service gazetteer

Edit grails-app/services/GazetteerService.groovy

----
    import static groovyx.net.http.Method.*
    import groovyx.net.http.RESTClient
    import groovyx.net.http.*
    
    class GazetteerService {
    
      def geocode(address) {
        def  geo_result = codepointOpenGeocode(address);
        geo_result
      }
    
      def codepointOpenGeocode(postcode) {
        log.debug("looking up \"${postcode}\"");
        def result = null
        def http = new HTTPBuilder("http://uk-postcodes.com");
        http.request(Method.valueOf("GET"), ContentType.JSON) {
          uri.path = "/postcode/${postcode}.json"
          response.success = {resp, json ->
            log.debug("Process geocode response: ${json}");
            result = [ address:postcode,
                       response: [
                         postcode: json.postcode,
                         geo: [
                           lat: "${json.geo.lat}",
                           lng: "${json.geo.lng}",
                           easting: "${json.geo.easting}",
                           northing: "${json.geo.northig}",
                           geohash: json.geo.geohash
                         ],
                         administrative: json.administrative
                       ],
                       lastSeen: System.currentTimeMillis(),
                       created: System.currentTimeMillis() ]
          }
          response.failure = { resp ->
            log.debug("Not found: ${postcode}");
          }
        }
        result
      }
    }
    
Lets create a controller that will show a postcode on a map

    grails create-controller showPostcode
    
    package wstutorial
    
    class ShowPostcodeController {
    
      def gazetteerService
    
      def index() {
    
        def result = [:]
    
        if ( params.postcode != null ) {
          result.geocode = gazetteerService.geocode(params.postcode)
        }
    
        result
      }
    }
    


And a view

grails-app/views/showPostcode/index.gsp





curl "http://localhost:8080/wstutorial/pointsOfInterest/add?name=The+Red+Lion&postcode=S1+2ND"

Add withformat processing to pointsOfInterest controller

curl "http://localhost:8080/wstutorial/pointsOfInterest/add?name=The+Red+Lion&postcode=S1+2ND&format=json"

