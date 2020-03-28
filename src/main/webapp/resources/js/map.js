$(function() {

	function openNav() {

		$("#mySidenav").css("left", "0");
	}

	function closeNav() {
		let widthSize = $(window).width()
		$("#mySidenav").css("left", -widthSize);
	}

	$(".go-home").click(function() {
		openNav()
	})

	var map;

	var latlng = new Tmapv2.LatLng(37.566481622437934, 126.98502302169841);

	var markers = [];

	// window 토글
	var toggle = 1

	// 지도 생성
	initTmap()

	// 페이지가 로딩이 된 후 호출하는 함수입니다.
	function initTmap() {
		// map 생성
		// Tmapv2.Map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
		map = new Tmapv2.Map("map_div", // "map_div" : 지도가 표시될 div의 id
		{
			center : new Tmapv2.LatLng(37.566481622437934, 126.98502302169841),
			width : "100%",
			height : "100%",
			zoom: 17
		});
		remove()
	}

	// 마커를 그리기 전 지도에서 모든 마커를 삭제하는 함수
	function removeMarkers() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
	}

	// json result 결과값을 받아서 마커를 그려주는 함수
	function makeMarker(result) {

		removeMarkers()

		$.each(result, function(index, item) {

			var imagePath = "/resources/image/"
			var maskState = ""

			if (item.remain_stat == "plenty") {
				imagePath += "marker_green.png"
				maskState = "충분"
			} else if (item.remain_stat == "some") {
				imagePath += "marker_yellow.png"
				maskState = "보통"
			} else if (item.remain_stat == "few") {
				imagePath += "marker_red.png"
				maskState = "부족"
			} else if (item.remain_stat == "empty") {
				imagePath += "marker_gray.png"
				maskState = "없음"
			} else if (item.remain_stat == "break") {
				imagePath += "marker_gray.png"
				maskState = "판매중단"
			} else {
				imagePath += "marker_gray.png"
				maskState = "알수없음"
			}

			var marker = new Tmapv2.Marker({
				position : new Tmapv2.LatLng(item.lat, item.lng), // Marker의
																	// 중심좌표 설정.
				draggable : true,
				title : item.name + "<br>" + item.addr + "<br>" + "재고 상태: "
						+ maskState,
				icon : imagePath,
				iconSize : new Tmapv2.Size(30, 30),
				map : map
			// Marker가 표시될 Map 설정..
			});

			marker.addListener("touchstart", function(evt) {
				
				

				if (toggle == 1) {
					infoWindow = new Tmapv2.InfoWindow({
						offset : new Tmapv2.Point(+100,+100),
						position : new Tmapv2.LatLng(item.lat, item.lng), 
						content : item.name + "<br>" + item.addr + "<br>"
								+ "재고 상태: " + maskState,
						type : 2,
						map : map
					});
				} else {
					infoWindow.setMap(null)
				}

				toggle = -toggle

			});

			markers.push(marker)

		})

	}

	// 메인 검색창에서 enter 입력시
	$("#main-search").keypress(function(key) {
		
		if (key.keyCode == 13) {

			let search = $("#main-search").val()
			getMask(search)

			$("#search").val($("#main-search").val())
		}
	})

	// 지도 검색창에서 enter 입력시
	$("#search").keypress(function(key) {

		if (key.keyCode == 13) {

			let search = $("#search").val()
			getMask(search)

		}

	})

	// 서버에 키워드를 보내 mask 정보를 얻어오는 ajax 함수
	function getMask(search) {

		$.ajax({

			url : "/maskJson",
			data : {
				addr : search
			},
			success : function(result) {

				if (result.length < 1) {
					alert("검색결과가 없습니다.")
					return false;
				}

				closeNav()
				latlng.setLatitude(result[0].lat)
				latlng.setLongitude(result[0].lng)
				map.setCenter(latlng)
				makeMarker(result)
				$('#search').blur();
				$('#main-search').blur();

			},
			error : function(error) {
				alert("서버 통신 오류")
			}

		})

	}

	// 지도 옵션 줌컨트롤 표출 비활성화
	function remove() {
		map.setOptions({
			zoomControl : false
		});
	}

	// 위치 정보 받아오기
	function getLocation() {
		
		if ("geolocation" in navigator) {
			  /* 지오로케이션 사용 가능 */
			navigator.geolocation.getCurrentPosition(function (position) { 

		        var lat = position.coords.latitude;

		        var lng = position.coords.longitude;

		        // 받아온 위치 정보로 ajax 요청
		        getMaskByGeo(lat, lng)

		},function(error){
				alert("에러 발생")
			});  
		}else {
			  /* 지오로케이션 사용 불가능 */
			alert("사용불가능")
		}
		
	}
	
	$(".get-location").click(function(){
		getLocation();
	})
	
	// 위치 정보 기반으로 정보를 받아오는 ajax
	function getMaskByGeo (lat, lng){
		
		$.ajax({
			url : "/maskGeoJson",
			data : {lat:lat, lng:lng},
			success : function(result){
				
				closeNav()
				latlng.setLatitude(lat)
				latlng.setLongitude(lng)
				map.setCenter(latlng)
				makeMarker(result)
				$('#search').blur();
				$('#main-search').blur();
				
			},
			error : function(){
				alert ("위치 기반 검색에 문제가 발생하였습니다.")
			}
		})
		
	}

})