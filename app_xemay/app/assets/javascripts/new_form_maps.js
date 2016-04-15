var markersArray = [];
var map;

$(document).on("ready", function() {
  function initialize() {
    var myLatlng = new google.maps.LatLng(21.004812, 105.841184);

    var options = {
      zoom: 13,
      center: myLatlng,
      mapTypeControl: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(document.getElementById("map-canvas"), options);

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

  google.maps.event.addDomListener(window, "load", initialize);
});

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
  document.getElementById("review_store_attributes_coodinate_lng").value = lng;
  document.getElementById("review_store_attributes_coodinate_lat").value = lat;
}
