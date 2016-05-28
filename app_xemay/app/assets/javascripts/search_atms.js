function search_atms(ATMPoint, rad, ATMControlButton) {
  var service = new google.maps.places.PlacesService(map);

  ATMControlButton.addEventListener("click", function() {
    service.nearbySearch({
      location: ATMPoint,
      radius: rad,
      type: ['atm']
    }, atm_callback);

    ATMPoint = undefined;
  });
}

function atm_callback(results, status) {
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarker(results[i]);
    }
  }
}

function createMarker(place) {
  var placeLoc = place.geometry.location;
  var image_atm = {
    url: "/assets/ATM_marker.png",
    size: new google.maps.Size(40, 40),
    origin: new google.maps.Point(0, 0),
    anchor: new google.maps.Point(0, 25),
    scaledSize: new google.maps.Size(40, 40)
  };

  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location,
    icon: image_atm,
  });

  markersArray.push(marker);
}
