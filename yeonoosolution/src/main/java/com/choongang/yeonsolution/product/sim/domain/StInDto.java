package com.choongang.yeonsolution.product.sim.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class StInDto {
	private String 	inCode;
	private String 	orderCode;
	private String 	companyCode;
	private String 	customerCode;
	private Long 	beginEndInventory;
	private String 	inDate;
	private Date 	regDate;
	private String 	regUser;
	private Date	updateDate;
	private String 	updateUser;
	private String	inType;
	private String	deleteStatus;
	private String 	memo;
	
	// 검색
	private Long 	orderType;
	
	// 참조
	private List<StInDetailDto> stInDetailDto;
	private OrdersDto ordersDto;
	private CompanyDto companyDto;
}