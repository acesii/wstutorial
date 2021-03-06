package wstutorial

import grails.converters.*

class PointsOfInterestController {
  
  static poi = []

  def gazetteerService

  def index() { 
    def result = [:]
    result.poi=poi

    println("Result: ${result}");

    withFormat {
      html result
      json { render result as JSON }
      xml { render result as XML }
    }
  }

  def add() {

    def result = [:]

    println(params);
    if ( ( params.postcode != null ) && ( params.name != null ) ) {
      def geocode = gazetteerService.geocode(params.postcode);
      def new_poi = [name:params.name, geocode:geocode]
      poi.add(new_poi);
      result.poi = new_poi;
    }

    withFormat {
      html result
      json { render result as JSON }
      xml { render books as XML }
    }
  }
}
