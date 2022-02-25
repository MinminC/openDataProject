<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
	
	<table id="result1" border="1" align="center">
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
		document.getElementByTag
	</script>
	
	
	<h2>지진해일대피소</h2>
	
	<input type="button" value="실행" id="btn2">
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
			check2();
			$('#btn2').click(function(){
				check2();
			})
		});
		
		/*
		$(function(){
			check2();
			$('#btn2').click(function(){
				check2();
			})
		})
		*/
		function check2(){
			$.ajax({
				url:'earth.do',
				data:{
					pageNo:1,
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
								+'<th>위도</th>'
								+'<th>경도</th>'
								+'<th>수용인원수</th>'
								+'<th>해안과의 거리</th>'
								+'<th>타입</th>'
								+'<th>해수면</th>'
								+'</tr></thead><tbody>';
					itemArr.each((i, item) => {
						value += '<tr><td>'+$(item).find('sido_name').text()
								+'</td><td>'+$(item).find('sigungu_name').text()
								+'</td><td>'+$(item).find('remarks').text()
								+'</td><td>'+$(item).find('shel_nm').text()
								+'</td><td>'+$(item).find('address').text()
								+'</td><td>'+$(item).find('lon').text()
								+'</td><td>'+$(item).find('lat').text()
								+'</td><td>'+$(item).find('shel_av').text()
								+'</td><td>'+$(item).find('lenth').text()
								+'</td><td>'+$(item).find('shel_div_type').text()
								+'</td><td>'+$(item).find('height').text()
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
</body>
</html>