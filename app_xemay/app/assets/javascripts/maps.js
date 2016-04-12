$(document).on("ready", function() {
  var map, marker;

  function initialize() {
    var myLatlng = new google.maps.LatLng(21.017030, 105.783902);

    var options = {
      zoom: 13,
      center: myLatlng,
      mapTypeControl: true,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(document.getElementById("map-canvas"), options);

    // var lat = $("#show-address-map").data("address-lat");
    // var lng = $("#show-address-map").data("address-lng");
    // var position = new google.maps.LatLng(lat, lng);

    // marker = new google.maps.Marker({position: position, map: map});
    // marker.setMap(map);
    // map.setCenter(position);
    // map.setZoom(14);
  }

  google.maps.event.addDomListener(window, 'load', initialize);
});
