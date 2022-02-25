package com.kh.opendata.run;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.opendata.model.vo.AirVO;

public class AirPollutionJavaApp {

	private static final String SERVICE_KEY = "m%2BXQ6JZ8nOxT0%2B2ewkBZu5xzdEDAqebDxTFvI5yk%2BUl%2BNBdExNfOCji4u6PJkpZcGcujkx%2FLd26XQiHfFtraLw%3D%3D";
	public static void main(String[] args) throws IOException {
		//OpenAPI 서버로 요청하는 url 만들기
		
		//대기오염 주소
		String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
		
		//서비스키(필수)
		url += "?serviceKey="+SERVICE_KEY;
		
		//시, 도 이름(필수). 요청 전달 값에 한글이 있으면 인코딩 작업 필수!!
		url += "&sidoName="+ URLEncoder.encode("서울", "UTF-8");
		
		//리턴 타입(선택)
//		url += "&returnType=xml";
		url += "&returnType=json";
		
		
		//HttpURLConnection 객체를 활용해서 OpenAPI 요청 절차
		//1. 요청하고자하는 url을 전달하면서 java.net.URL 객체 생성
		URL requestUrl = new URL(url);
		//2. 1번 과정으로 생성된 URL 객체 가지고 HttpURLConnection 객체 생성
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		//3. 요청에 필요한 Header 설정하기
		urlConnection.setRequestMethod("GET");
		//4. 해당 OpenAPI 서버로 요청을 보낸 후 입력데이터로 읽어오기
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String responseText ="";
		String line;
		while((line = br.readLine()) != null) {//아직 읽을 내용이 남아있는 경우
			//System.out.println(line);
			responseText += line;
		}
		
		//System.out.println(responseText);
		//JSONObject, JSONArray -> JSON 라이브러리에서 제공하는 객체
		//JsonObject, JsonArray, JsonElement를 이용해서 파싱할 수 있음(GSON 제공)
		//각각의 item 정보를 AirVO객체에 담고 ArrayList
		JsonObject totalObj = JsonParser.parseString(responseText).getAsJsonObject();
		JsonObject responseObj = totalObj.getAsJsonObject("response");//response 한꺼풀 벗기기
		JsonObject bodyObj = responseObj.getAsJsonObject("body");//body 한꺼풀 벗기기
		
		int totalCount = bodyObj.get("totalCount").getAsInt();
		JsonArray itemArr = bodyObj.getAsJsonArray("items");
				
		//System.out.println(totalCount + " : " + itemArr);
		
		ArrayList<AirVO> list = new ArrayList<>();
		for(JsonElement item : itemArr) {
			JsonObject itemObj = item.getAsJsonObject();
			//System.out.println(itemObj);
			AirVO a = new AirVO();
			a.setCoValue(itemObj.get("coValue").getAsString());
			a.setDataTime(itemObj.get("dataTime").getAsString());
			a.setKhaiValue(itemObj.get("khaiValue").getAsString());
			a.setNo2Value(itemObj.get("no2Value").getAsString());
			a.setO3Value(itemObj.get("o3Value").getAsString());
			a.setPm10Value(itemObj.get("pm10Value").getAsString());
			a.setSo2Value(itemObj.get("so2Value").getAsString());
			a.setStationName(itemObj.get("stationName").getAsString());
			
			list.add(a);
		}
		
		System.out.println(list);
		//5. 다 사용한 스트림 반납
		br.close();
		urlConnection.disconnect();
	}

}
