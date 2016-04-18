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
  infoGeolocation = new google.maps.InfoWindow({map: map});
  geoMylocation(map, infoGeolocation);

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

function geoMylocation(map, infoGeolocation) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var image = {
        url: "/assets/geolocation-icon.png",
        size: new google.maps.Size(25, 25),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 25),
        scaledSize: new google.maps.Size(25, 25)
      };
      var markerGeolocation = new google.maps.Marker({
        position: pos,
        icon: image,
        map: map
      });

      markerGeolocation.setMap(map);
      markerGeolocation.addListener("click", function() {
        infoGeolocation.setContent("Your location");
        infoGeolocation.open(map, this);
      });
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoGeolocation, map.getCenter());
    });
  }
  else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoGeolocation, map.getCenter());
  }
}

function handleLocationError(browserHasGeolocation, infoGeolocation, pos) {
  infoGeolocation.setPosition(pos);
  infoGeolocation.setContent(browserHasGeolocation ?
    "Error: The Geolocation service failed." :
    "Error: Your browser doesn't support geolocation.");
}
