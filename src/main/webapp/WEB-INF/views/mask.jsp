<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>MASK FINDER</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="${rootPath}/resources/css/bootstrap-yeti.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx4230609294db4a8f8028dc8793b2a2fc"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

<script src="${rootPath}/resources/js/map.js"></script>

<script type="text/javascript">

	var rootPath = "${rootPath}"

</script>

<style>
* {
	margin: 0;
	padding: 0;
}

html {
	height: 100%;
}

body {
	height: 100%;
}

input {
	outline: none;
}

input:focus {
	outline: none;
}

input:hover {
	outline: none;
}

.mySidenav {
	position: fixed;
	top: 0;
	left: 0; 
	width : 100%;
	height: 100%;
	z-index: 1500;
	background-color: white;
	width: 100%;
	transition: 0.5s;
	overflow-x: hidden;
}

.explanation{
	width: 500px;
}

.get-location{
	cursor : pointer;
}

.main-Icon{
	position: fixed;
	z-index: 500;
	bottom: 0;
	left: 0;
	cursor: pointer;
}

.right-bottom-Icon{
	position: fixed;
	z-index: 500;
	bottom: 0;
	right : 0;
	border-radius: 15px;
}



@media ( min-width : 360px) {
	.explanation {
		max-width: 90%;
	}
}

@media ( min-width : 576px) {
	.explanation {
		max-width: 540px
	}
}

@media ( min-width : 768px) {
	.explanation {
		max-width: 720px
	}
}

@media ( min-width : 992px) {
	.explanation {
		max-width: 960px
	}
}

@media ( min-width : 1200px) {
	.explanation {
		max-width: 1140px
	}
}


</style>

</head>
<body>

	<div id="map_div"></div>

	<div class="container fixed-top mt-3">
		<div class="form-group p-3 bg-white rounded-pill shadow">
			<input class="form-control shadow-none border-0" id="search" placeholder="주소를 입력해주세요...">
		</div>
	</div>

	<div id="mySidenav" class="mySidenav shadow">
		<div class="container">
			
			<header class="text-center mt-5">
				<h1 class="font-weight-bold text-primary">MASK FINDER</h1>
			</header>
			
			<div class="container mt-4">
				<div class="form-group p-3 bg-white rounded-pill shadow">
					<input class="form-control shadow-none border-0" id="main-search" placeholder="주소를 입력해주세요...">
				</div>
			</div>
			
			<div class="container mt-5 mb-5">
				<div class="explanation shadow ml-auto mr-auto p-4">
					<p>공공데이터포털에서 제공하는 공적 마스크 판매 정보 제공 API를 활용하여 만든 사이트입니다.</p>
					<p>주소를 기준으로 해당 구 또는 동내에 존재하는 판매처 및 재고 상태 등의 판매 정보를 제공하고 있습니다.<p>
					<p>ex) '서울특별시 강남구' or '서울특별시 강남구 논현동'<br>
					<small class="text-primary">'서울특별시'와 같이 '시' 단위만 입력하는 것은 불가능합니다.</small>
					<div class="text-center">
						<p class="font-weight-bold text-primary">위치 기반으로 검색하기</p>
						<a href="#"><i class="fas fa-street-view fa-4x get-location text-primary"></i></a>					
					</div>
					<hr>
					<div class="text-center">
						<a href="https://github.com/jewon513/mask-project"><i class="fab fa-github-square fa-4x"></i></a>
						<p class="text-primary">Copyright &copy; 2020 by Jewon513@gmail.com<p>
					</div>			
				</div>
			</div>
		</div>
	</div>
	
	<div class="main-Icon">
		<div class="m-2 p-3 rounded-circle bg-white shadow text-primary text-center get-location">
			<i class="fas fa-map-marker-alt fa-2x"></i>
		</div>
		<div class="m-2 p-3 rounded-circle bg-white shadow text-primary text-center go-home">
			<i class="fas fa-home fa-2x"></i>
		</div>
	</div>
	
	<div class="right-bottom-Icon m-2 p-3 bg-white shadow text-primary text-center font-weight-bold">
		<div class="text-success ">
			<i class="fas fa-circle fa-2x"></i> 충분
		</div>
		<div class="text-warning">
			<i class="fas fa-circle fa-2x"></i> 보통
		</div>
		<div class="text-danger">
			<i class="fas fa-circle fa-2x"></i> 부족
		</div>
		<div class="text-secondary">
			<i class="fas fa-circle fa-2x"></i> 없음
		</div>
	</div>



</body>


</html>