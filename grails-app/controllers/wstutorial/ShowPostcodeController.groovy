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
