<html>
  <head>
   <meta name="layout" content="main"/>

    <r:require modules="jquery"/>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>

    <style>
      html, body, #mapcanvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      #mapcanvas {
      }
      .pt {
        margin-top:50px;
      }
      .mc {
        height: 100%;
      }
    </style>

    <script language="Javascript">

    var map;

    var locations;

    function initialize() {

      var mapOptions = {
        zoom: 8,
      };
      map = new google.maps.Map(document.getElementById('mapcanvas'), mapOptions);
      var infowindow = new google.maps.InfoWindow();
      var markers = [];


      $.ajax({
        url: '<g:createLink controller="pointsOfInterest" action="index" params="${[format:'json']}"/>',
        success: function(data){
          locations = data.poi;
          var bounds = new google.maps.LatLngBounds();

          for (var i = 0; i < locations.length; i++) {  
            if ( locations[i] != null ) {
              marker = new google.maps.Marker({ position: new google.maps.LatLng(locations[i].geocode.response.geo.lat, locations[i].geocode.response.geo.lng), 
                                                map: map });

              markers.push(marker);
  
              //extend the bounds to include each markers position
              bounds.extend(marker.position);
            }
          }

          map.fitBounds(bounds);
        }
      });
    }

    google.maps.event.addDomListener(window, "load", initialize);
  </script>
  </head>

  <body>

    <div id="mapcanvas"></div>

  </body>

</html>
