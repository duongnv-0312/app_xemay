function search_gas_stations(gasPoint, rad, gasControlButton) {
  var service = new google.maps.places.PlacesService(map);

  gasControlButton.addEventListener("click", function() {
    service.nearbySearch({
      location: gasPoint,
      radius: rad,
      type: ['gas_station']
    }, gas_callback);

    gasPoint = undefined;
  });
}

function gas_callback(results, status) {
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarkerGas(results[i]);
    }
  }
}

function createMarkerGas(place) {
  var placeLoc = place.geometry.location;
  var image_gas_station = {
    url: "/assets/gas_station_marker.png",
    size: new google.maps.Size(40, 40),
    origin: new google.maps.Point(0, 0),
    anchor: new google.maps.Point(0, 25),
    scaledSize: new google.maps.Size(40, 40)
  };

  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location,
    icon: image_gas_station,
  });

  markersArray.push(marker);
}
