package com.biz.mask.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MaskListVO {

	private String address;
	private int count;
	private List<MaskItemVO> stores;
	
}
