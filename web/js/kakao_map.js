window.kakaoMap = {
    initializeMap: function(lat, lng) {
      var container = document.getElementById('map');
      var options = {
        center: new kakao.maps.LatLng(lat, lng),
        level: 3
      };
      window.map = new kakao.maps.Map(container, options);
    },
  
    addMarker: function(lat, lng, title) {
      var markerPosition  = new kakao.maps.LatLng(lat, lng); 
      var marker = new kakao.maps.Marker({
        position: markerPosition,
        title: title
      });
      marker.setMap(window.map);
    }
  };
  