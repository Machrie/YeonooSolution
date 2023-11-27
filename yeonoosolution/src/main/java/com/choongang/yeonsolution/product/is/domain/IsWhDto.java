package com.choongang.yeonsolution.product.is.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class IsWhDto {
	private String whCode;
	private String companyCode;
	private String whName;
	private String regUser;
	private String regDate;
	private String updateUser;
	private String updateDate;
	private String useYn;
	private String memo;
	
	//join 데이터
	private String itemCode;
	private String itemName;
	private String wdCode;
	private String memberName;
	private	Long goodQuantity;
	private	Long badQuantity;
	
	//pagination 용도 데이터
	private int startRow;
	private int endRow;
}
