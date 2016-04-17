var map;
var currentPosition;

function index_maps() {
  var options = {
    center: new google.maps.LatLng(21.006645, 105.842414),
    zoom:13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var coordinates = $.parseJSON($("#map-index-reviews").attr("data-coordinates"));
  var stores = $.parseJSON($("#map-index-reviews").attr("data-stores"));
  var reviews = $.parseJSON($("#map-index-reviews").attr("data-reviews"));
  console.log(reviews);
  var markersArray = [];
  var infowindows = [];
  map = new google.maps.Map(document.getElementById("map-index-reviews"), options);

  if(stores < 1) {
    console.log("No stores");
  }
  else {
    for (i = 0; i < coordinates.length; i++) {
      markersArray[i] = new google.maps.Marker({
        position: new google.maps.LatLng(coordinates[i].lat, coordinates[i].lng),
        map: map
      });
      markerContent = "Lat: " + coordinates[i].lat +
                      "<br>Lng: " + coordinates[i].lng +"";

      markersArray[i].setMap(map);
      infowindows [i] = new google.maps.InfoWindow({
        maxWidth: 300
      });

      bindInfoWindow(markersArray[i], map, infowindows[i], markerContent);
    }
  }
}

function bindInfoWindow(marker, map, infowindows, markerContent) {
  marker.addListener("click", function() {
    infowindows.setContent(markerContent);
    infowindows.open(map, this);
  });
}
