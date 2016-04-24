var markersArray = [];
var map;

function initialize() {
  var myLatlng = new google.maps.LatLng(21.004812, 105.841184);

  var options = {
    zoom: 13,
    center: myLatlng,
    mapTypeControl: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  map = new google.maps.Map(document.getElementById("new-map-canvas"), options);

  google.maps.event.addListener(map, "click", function(e) {
    if(markersArray.length !== 0) {
      clearMarker(map, markersArray);
    }

    var lat = e.latLng.lat();
    var lng = e.latLng.lng();

    markerClick(map, lat, lng, markersArray);
    getValueCoordinate(lat, lng);
  });
}

function clearMarker(map, markersArray) {
  for(var i = 0; i < markersArray.length; i++) {
    markersArray[i].setMap(null);
  }

  markersArray.length = 0;
}

function markerClick(map, lat, lng, markersArray) {
  var position = new google.maps.LatLng(lat, lng);
  marker = new google.maps.Marker({position: position, map: map});
  marker.setMap(map);
  markersArray.push(marker);
}

function getValueCoordinate(lat, lng) {
  document.getElementById("review_store_attributes_coordinate_attributes_lng").value = lng.toFixed(15);
  document.getElementById("review_store_attributes_coordinate_attributes_lat").value = lat.toFixed(15);
}
