package com.kh.jaManChw.login.service.impl;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kh.jaManChw.dto.Users;
import com.kh.jaManChw.login.service.face.NaverService;

@Service
public class NaverServiceImpl implements NaverService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public Map<String, String> getNaverApiInfo() {

		//애플리케이션 정보에 있는 client ID
		String clientId = "dn2raWizUA37TfJdvO2f";
		
		//애플리케이션 정보에 있는 로그인 오픈 API 서비스 환경 - 네이버 로그인 CallBack URL
		String callBackURI= "http://192.168.10.30:8888/naverlogincallback";
		String encodeType = "UTF-8";
		
		String redirectURI = null; 
		
		try {
			
			//인코딩 타입이 UTF-8인 callbackURI 
			redirectURI = URLEncoder.encode(callBackURI, encodeType);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		logger.info("redirectURI : {}",redirectURI);
		
		
		//난수 생성기 SecureRandom은 48비트만 있는 Random함수와 달리 최대 128비트를 포함할수있기때문에
		// 반복할가능성이 더적다
		SecureRandom random = new SecureRandom();
		
		//new BigInteger(int, random) - int바이트 만큼의 random값을 생성한다
	    String state = new BigInteger(130, random).toString();
	    
	    //최종적으로 우리에게 필요한 것은 이것 하나 뿐임...!
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    
	    /*
	     
	      apiURL은 

	      https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=dn2raWizUA37TfJdvO2f
	      	&redirect_uri=http://localhost:8888/naver/login/logintest&state=[랜덤으로 생성된 랜덤값]
	      
	      이 되는 것임...
	      
	      INFO : NaverServiceImpl - apiURL: https://nid.naver.com/oauth2.0/authorize?response_type=code
	      							&client_id=dn2raWizUA37TfJdvO2f
	      							&redirect_uri=http%3A%2F%2Flocalhost%3A8888%2Fnaverlogincallback
	      							&state=244828720411269639775611690261190343300
	      							
	      
	     */
	    
	    Map<String, String> naverMap = new HashMap<>();
	    naverMap.put("apiURL", apiURL);
	    naverMap.put("state", state);
	    logger.info("naverMap: {}",naverMap);
	    
		return naverMap;
	}
	
	@Override
	public JsonObject getNaverCallbackToken(String code, String state) {

		String clientId = "dn2raWizUA37TfJdvO2f";
		String clientSecret = "JQd7YyzxsC";
		String callbackURL = "http://192.168.10.30:8888/naverlogincallback";

		String redirectURI = "";
		try {
			redirectURI = URLEncoder.encode(callbackURL,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
	    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
	            + "&client_id=" + clientId
	            + "&client_secret=" + clientSecret
	            + "&redirect_uri=" + redirectURI
	            + "&code=" + code
	            + "&state=" + state;
	    
	    try {
			
	    	URL url = new URL(apiURL);
			
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			
			con.setRequestMethod("GET");
			
			int responseCode = con.getResponseCode();
			
			BufferedReader br;
			
			if (responseCode == 200) { //정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			
			String inputLine;
			
			//String끼리 연결해서 붙이는것은 효율적이지 않기에 StringBuilder를 사용한다
			StringBuilder res = new StringBuilder();
			
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			
			br.close();
			
			logger.info("res: {}",res);
			
			if (responseCode == 200) {
				
				Gson gson = new Gson();
				
				JsonObject jo = gson.fromJson(res.toString(), JsonObject.class);
				
				return jo;
			}
			
	    	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	@Override
	public Users getUserInfoFromNaver(JsonObject naverToken) {
		
		String host = "https://openapi.naver.com/v1/nid/me";
		
		logger.info("token: {}", naverToken.get("access_token") );
		String authorization = naverToken.get("token_type").getAsString() + " " + naverToken.get("access_token").getAsString();
		
		logger.info("authoriztion: {}", authorization );
		
		
		Users user = new Users();
		
		try {
      	  
            URL url = new URL(host);

            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            
            urlConnection.setRequestProperty("Authorization", authorization);
            urlConnection.setRequestMethod("GET");

            int responseCode = urlConnection.getResponseCode();
            logger.debug("responseCode : {} ", responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
            logger.debug("br? {} :", br);
            
            String line = "";
            String res = "";
            
            while((line=br.readLine())!=null) {
                res+=line;
            }

            logger.debug("res : {}", res);

            Gson gson = new Gson();
            
            JsonObject jsonObject = gson.fromJson(res, JsonObject.class);
            logger.debug("jsonObject : {}", jsonObject);
            
            JsonObject response = jsonObject.getAsJsonObject("response");
            logger.debug("response : {}", response);

            String email = response.get("email").getAsString().trim();
            String id = response.get("id").getAsString().trim();
            String name = response.get("name").getAsString().trim();
            String nickname = response.get("nickname").getAsString().trim();
            String gender = response.get("gender").getAsString();
            String phone = response.get("mobile").getAsString().replaceAll("[^0-9]", "").trim();
            Date birth = null;
            
			try {
				birth = new SimpleDateFormat("YYYY-MM-dd").parse(response.get("birthyear").getAsString() + "-" + response.get("birthday").getAsString());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            		
            
            logger.info("response: {}",response);
            
            user.setUserId(id); // 최초 소셜로그인시, 소셜 고유ID를 Id와 Pw로 설정
            user.setUserPw("naver"); // 최초 소셜로그인시, 소셜 고유ID를 Id와 Pw로 설정
            user.setUserName(name);
            user.setUserNick(nickname);
            user.setGender(gender);
            user.setEmail(email);
            user.setPhone(phone);
            user.setBirth(birth);
            user.setAddr1(0);
            user.setAddr2("naver");
            user.setAddr3("naver");
            user.setGrade("naver");
            user.setWarnCount(0);
            user.setPlatFormOption("naver");

            br.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
        
        logger.debug("user : {}", user);

        return user;

		
	}
}
