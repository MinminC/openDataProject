package com.kh.opendata.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class APIController {

	private static final String SERVICE_KEY = "m%2BXQ6JZ8nOxT0%2B2ewkBZu5xzdEDAqebDxTFvI5yk%2BUl%2BNBdExNfOCji4u6PJkpZcGcujkx%2FLd26XQiHfFtraLw%3D%3D"; 
	
	@ResponseBody
	@RequestMapping(value="air.do", produces="text/xml; charset=UTF-8")
	public String airPollution(String location) throws IOException{
	
		String url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty";
		
		//서비스키(필수)
		url += "?serviceKey="+SERVICE_KEY;
		
		//시, 도 이름(필수). 요청 전달 값에 한글이 있으면 인코딩 작업 필수!!
		url += "&sidoName="+URLEncoder.encode(location, "UTF-8");
		
		//리턴 타입(선택)
		//url += "&returnType=json";//json은 application/json 형식으로 보내고 xml은 text/xml로 보냄
		url += "&returnType=xml";
		
		//브라우저에서 요청해오기
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		urlConnection.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String responseText = "";
		String line;
		while((line = br.readLine()) != null) {
			responseText += line;
		}
		
		br.close();
		urlConnection.disconnect();
		
		return responseText;
	}
	
	@ResponseBody
	@RequestMapping(value="earth.do", produces="text/xml; charset=UTF-8")
	public String earchquake(int pageNo, int numOfRows, String type) throws IOException {
		String url = "http://apis.data.go.kr/1741000/TsunamiShelter3/getTsunamiShelter1List";
		
		url += "?ServiceKey="+SERVICE_KEY;
		url += "&pageNo="+pageNo;
		url += "&numOfRows="+numOfRows;
		url += "&type="+type;
		
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		urlConnection.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String responseText = "";
		String line;
		while((line = br.readLine()) != null) {
			responseText += line;
		}
		
		br.close();
		urlConnection.disconnect();
		
		return responseText;
	}
}
