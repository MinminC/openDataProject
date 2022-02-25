<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
	.redLine{
		background:red;
		color:white;
	}
</style>
</head>
<body>
	<h2>실시간 대기 오염 정보</h2>
	
	지역 : 
	<select id="location">
		<option>서울</option>
		<option>대전</option>
		<option>부산</option>
	</select>
	<button id="btn1">해당 지역 대기 오염 정보</button>
	
	<br><br>
	
	<table id="result1" border="1">
		<thead>
			<th>측정소 명</th>
			<th>측정 일시</th>
			<th>통합 대기 환경 수치</th>
			<th>미세먼지 농도</th>
			<th>일산화탄소농도</th>
			<th>이산화질소농도</th>
			<th>아황산가스농도</th>
			<th>오존농도</th>
		</thead>
		<tbody>
		</tbody>
	</table>
	<script>
		$(function(){
			checkAir();
			
			$('#btn1').click(function(){
				checkAir();
			});
		})
			function checkAir(){
				/*$.ajax({
					url:'air.do',
					data:{location: $('#location').val()},
					success:function(data){
						console.log(data.response.body.items);
						
						const itemArr = data.response.body.items;
						let value="";
						for(let i in itemArr){
							let item = itemArr[i];
							value += '<tr><td>'+item.stationName
									+'</td><td>'+item.dataTime
									+'</td><td>'+item.khaiValue
									+'</td><td>'+item.pm10Value
									+'</td><td>'+item.coValue
									+'</td><td>'+item.no2Value
									+'</td><td>'+item.so2Value
									+'</td><td>'+item.o3Value
									+'</td></tr>';
						}
						$('#result1 tbody').html(value);
					}
				})*/
				$.ajax({
					url:'air.do',
					data:{location: $('#location').val()},
					success:function(data){
						
						//console.log($(data).find("item"));
						let itemArr = $(data).find('item');
						
						let value='';
						itemArr.each(function(i,item){
							//console.log($(item).find('stationName').text());
							value += '<tr><td>'+$(item).find('stationName').text()
									+'</td><td>'+$(item).find('dataTime').text()
									+'</td><td>'+$(item).find('khaiValue').text()
									+'</td><td>'+$(item).find('pm10Value').text()
									+'</td><td>'+$(item).find('coValue').text()
									+'</td><td>'+$(item).find('no2Value').text()
									+'</td><td>'+$(item).find('so2Value').text()
									+'</td><td>'+$(item).find('o3Value').text()
									+'</td></tr>';
						})
						$('#result1 tbody').html(value);
					}
				})
			}
	</script>
	<hr>
	
	<h2>지진해일대피소</h2>
	
	<input type="button" value="1" class="btn2" disabled>
	<input type="button" value="2" class="btn2">
	<input type="button" value="3" class="btn2">
	<input type="button" value="4" class="btn2">
	<input type="button" value="5" class="btn2">
	<input type="button" value="6" class="btn2">
	<input type="button" value="7" class="btn2">
	<input type="button" value="8" class="btn2">
	<input type="button" value="9" class="btn2">
	<input type="button" value="10" class="btn2">
	<br><br>
	<div id="result2"></div>
	
	<script>
	/*
		자바스크립트에서는 익명 함수들을 =>(애로우 연산자)로 작성할 수 있음
		function(){//코드들}
		
		와
			
		() => {//코드들}
		
		가 동일
		-------------------
		function(data){//코드들}
		
		와
		
		data => {//코드들}
		
		가 동일
		
		-------------------
		function(a, b){//코드들}
		
		와
		
		(a, b) => {//코드들}
		
		가 동일
		
		-------------------
		function(){return 10;}
		와
		
		() => 10
		
		가 동일
	*/
		$(() =>{ 
			check2(1);
			$('.btn2').click(function(){
				check2($(this).val());
			})
		});
		function check2(e){
			$.ajax({
				url:'earth.do',
				data:{
					pageNo:e,
					numOfRows: 10,
					type:'xml'
				},
				success:function(data){
					var itemArr = $(data).find('row');
					var value = '<table border="1"><thead>'
								+'<th>시, 도</th>'
								+'<th>시군구</th>'
								+'<th>지구</th>'
								+'<th>도로</th>'
								+'<th>주소</th>'
								+'<th>수용인원수</th>'
								+'<th>해안과의 거리</th>'
								+'<th>타입</th>'
								+'<th>해수면</th>'
								+'<th>지도</th>'
								+'</tr></thead><tbody>';
					itemArr.each((i, item) => {
						value += '<tr><td>'+$(item).find('sido_name').text()
								+'</td><td>'+$(item).find('sigungu_name').text()
								+'</td><td>'+$(item).find('remarks').text()
								+'</td><td>'+$(item).find('shel_nm').text()
								+'</td><td>'+$(item).find('address').text()
								+'</td><td>'+$(item).find('shel_av').text()
								+'</td><td>'+$(item).find('lenth').text()
								+'</td><td>'+$(item).find('shel_div_type').text()
								+'</td><td>'+$(item).find('height').text()
								
								+'</td><td>'
								+'<input type="hidden" class="lon" value="'+$(item).find('lon').text()+'">'
								+'<input type="hidden" class="lat" value="'+$(item).find('lat').text()+'">'
								+'<button type="button" class="openMap">지도</button>'
								
								+'</td></tr>';
					})
					value += '</tbody></table>';
					
					$('#result2').html(value);
				},
				error:function(){
					alert('ㄴㄴ');
				}
			})
		}
	</script>
	
	<!-- 지도 구현 부분 -->
	<h3>대피소 위치</h3>
	<div id="map" style="width:500px;height:400px; border:1px solid gray;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7d2500a762fd13aaf0d56c73dfad929a"></script>
	<script>
		var container = document.getElementById('map');
		$(()=>{
			//.openMap을 클릭하면 
			$('#result2').on('click','table .openMap',(e)=>{
				$(e.target).parents('tr').addClass('redLine');
				$(e.target).parents('tr').siblings().removeClass('redLine');
				var lat = $(e.target).siblings('.lat').val();//위도
				var lon = $(e.target).siblings('.lon').val();//경도
				
				var options = {
					center: new kakao.maps.LatLng(lat, lon),
					level: 3
				};
				var map = new kakao.maps.Map(container, options);
				
				var markerPosition  = new kakao.maps.LatLng(lat, lon); 

				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});

				marker.setMap(map);
			})
		})

	</script>
</body>
</html>