package com.biz.mask.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.biz.mask.domain.MaskItemVO;
import com.biz.mask.service.MaskService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MaskController {

	
	private final MaskService maskService; 
	
	@RequestMapping(value = "mask", method = RequestMethod.GET)
	public String mask(String addr, Model model) {
		
		try {
			List<MaskItemVO> list = maskService.getMaskStores(addr);
			model.addAttribute("maskList",list);
		} catch (UnsupportedEncodingException | URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "mask";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "maskGeoJson", method = RequestMethod.GET, produces="application/json" )
	public List<MaskItemVO> maskByGeo(String lat, String lng){
		
		try {
			List<MaskItemVO> list = maskService.getMaskStores(lat, lng);
			return list;
		} catch (UnsupportedEncodingException | URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "maskJson", method = RequestMethod.GET, produces="application/json" )
	public List<MaskItemVO> maskJson(String addr) {
		
		try {
			List<MaskItemVO> list = maskService.getMaskStores(addr);
			return list;
		} catch (UnsupportedEncodingException | URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
}
