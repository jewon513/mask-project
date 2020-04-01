package com.biz.mask.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.biz.mask.domain.MaskItemVO;
import com.biz.mask.domain.MaskListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MaskService {

	private final String maskURL = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByAddr/json";
	private final String maskbyGeoURL = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json";
	
	// 주소로 찾기
	public List<MaskItemVO> getMaskStores(String address) throws UnsupportedEncodingException, URISyntaxException{
		
		String requestAddress = URLEncoder.encode(address, "UTF-8");
		String requestURL = maskURL + "?address=" + requestAddress;
		
		URI requestURI = new URI(requestURL);
		
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<MaskListVO> responseResult = null;
		responseResult = restTemplate.exchange(requestURI, HttpMethod.GET, null, MaskListVO.class);
		
		
		MaskListVO maskListVO = responseResult.getBody();
		log.debug("가져온 데이터의 개수 : " + maskListVO.getCount());
		
		
		List<MaskItemVO> maskItemList = maskListVO.getStores();
		
		return maskItemList;
		
	}

	// 위도 경도로 찾기
	public List<MaskItemVO> getMaskStores(String lat, String lng) throws UnsupportedEncodingException, URISyntaxException {
		// TODO Auto-generated method stub
		//?lat=35.1569526&lng=126.9003409&m=5000
		
		String requestLat = URLEncoder.encode(lat, "UTF-8");
		String requestLng = URLEncoder.encode(lng, "UTF-8");
		String requestURL = maskbyGeoURL + "?lat=" + requestLat +"&lng=" +requestLng + "&m=5000";
		URI requestURI = new URI(requestURL);
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<MaskListVO> responseResult = null;
		responseResult = restTemplate.exchange(requestURI, HttpMethod.GET, null, MaskListVO.class);
		
		
		MaskListVO maskListVO = responseResult.getBody();
		log.debug("가져온 데이터의 개수 : " + maskListVO.getCount());
		
		
		List<MaskItemVO> maskItemList = maskListVO.getStores();
		
		return maskItemList;
	}
	
}
