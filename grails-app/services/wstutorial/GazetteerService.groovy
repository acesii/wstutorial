package wstutorial

import static groovyx.net.http.Method.*
import groovyx.net.http.RESTClient
import groovyx.net.http.*

class GazetteerService {

  /**
   *  geocode
   *  @param address The postcode to look up
   *  @return the response from the geocode service
   *  N.B. This is a simple form of loose coupling in code. We have clients call a geocode method and then
   *  directly call the codepointOpenGeocode method. This lets us easily switch out gazetteer implementations
   *  later on if we need to or want to. Also, the web service is a little slow, and this is an excellent place
   *  to build in caching of previously fetched geocode results.
   */
  def geocode(address) {
    def geo_result = codepointOpenGeocode(address);
    geo_result
  }

  /**
   *  Our actual implementation
   */
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
