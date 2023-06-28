package com.kh.jaManChw.login.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.jaManChw.dto.Users;
import com.kh.jaManChw.login.dao.face.KakaoDao;
import com.kh.jaManChw.login.service.face.KakaoService;

@Service
public class KakaoServiceImpl implements KakaoService{
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired KakaoDao kakaoDao;
	
	// accessToken 가져오기
	@Override
	public String getAccessToken(String code) {
		String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code"); 
            sb.append("&client_id=e711b32da569918789a178e0f371949d"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://192.168.10.30:8888/oauth/kakao"); // TODO 인가코드 받은 redirect_uri 입력
            sb.append("&code=" + code); // 위에서 받은 코드
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            logger.info("Service responseCode : {}",responseCode);
            

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            logger.info("Service response body : {}",result);
          

            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            // JsonParser parser = new JsonParser();
            //JsonElement element = parser.parse(result);
            JsonElement element = JsonParser.parseString(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            logger.info("Service access_token : {}",access_Token);
            logger.info("Service refresh_token : {}",refresh_Token);
           

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
	}

	// 가져온 accessToken으로 유저 정보 가져오기
	@Override
	public Users getUserInfo(String access_Token) {
		
			//요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		    HashMap<String, Object> userInfo = new HashMap<>();
		    String reqURL = "https://kapi.kakao.com/v2/user/me";
		    
		    
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        
		        // 요청에 필요한 Header에 포함될 내용
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		        
		        
		        // 키값, 속성 적용
		        int responseCode = conn.getResponseCode();
		        logger.info("Service responseCode : {}", responseCode);
		      
		        //버퍼 사용해서 읽어올 것들
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String line = "";
		        String result = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        logger.info("response body : {}",result);
		        logger.info("여기까진가-2?");
		        
		        
		        // 아래 두 코드는 이제 사용 안하는 코드 - 정적메소드로 처리해야함
		        //JsonParser parser = new JsonParser();
		        //JsonElement element = parser.parse(result);
		        // 읽어온 데이터들 꺼내오기
//		        logger.info("여기까진가-1?");
		        JsonElement element = JsonParser.parseString(result);
//		        logger.info("여기까진가0?");
		        
		        String socialNum = element.getAsJsonObject().get("id").getAsString();
//		        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
//		        logger.info("여기까진가1? :{}", idJS);
		        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//		        logger.info("여기까진가2?");
		        
//		        String id = idJS.getAsJsonObject().getAsString();
//		        String id = kakao_account.getAsJsonObject().get("id").getAsString();
		        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//		        logger.info("여기까진가2?");
//		        String email = kakao_account.getAsJsonObject().get("email").getAsString();
		        
		        logger.info("socialId : {}",socialNum);
		        
		        logger.info("여기까진가2?");
		        userInfo.put("socialNum", socialNum);
		        userInfo.put("userNick", nickname);
//		        userInfo.put("email", email);
		        logger.info("userNick:{}",userInfo);
		        
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		    
		    // 카카오 정보 유무 확인
		    Users KakaoInfo = kakaoDao.findKakaoInfo(userInfo);
		    logger.info("KakaoInfo : {}",KakaoInfo);
		    
		    if(KakaoInfo == null) {
		    	// kakaoinfo 가 없으면 insert 하고 find카카오에 저장
		    	
		    	kakaoDao.insertKakaoInfo(userInfo);
		    	return kakaoDao.findKakaoInfo(userInfo);
		    }
		        
		    return KakaoInfo;
		   
	}
	// 카카오 로그인 로그아웃 하기
	@Override
	public void kakaoLogout(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
	        
	        int responseCode = conn.getResponseCode();
	        logger.info("Service responseCode : {}", responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        logger.info("확인 : {}",result);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}

}
