package com.choongang.yeonsolution.sales.pm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PmWhDto {
	
	private String whCode;
	private String companyCode;
	private String whName;
	private String regUser;
	private String regDate;
	private String updateUser;
	private String updateDate;
	private String useYn;
	private String memo;

}