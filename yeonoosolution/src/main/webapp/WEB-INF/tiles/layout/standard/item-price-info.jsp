<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">

.main-container {
	overflow: auto !important;
}

.main-content {
	width: 100%;
	height: 651px;
	margin: 0px auto;
	overflow: auto;
	border: 1px solid #ddd;
	margin-top: 8px;
}

.btn-group1 {
	width: 520px;
	margin: 3px;
}

.input-info {
	width: 100%;
	height: 210px;
	margin: 0px auto;
	padding: 16px;
    border-radius: 10px;
    margin-top: 8px;
    background-color: #F8F8F8;
	
}

.input-info label {
	display: inline-block;
    width: 100px;
    border-radius: 5px;
    border: 1px solid #E8EBF0;
    padding: 0;
    font-size: 14px;
    font-weight: bold;
    text-align: center;
    line-height: 30px;
    background-color: #9BABB8;
    margin-bottom: 15px;
}

.input-info input {
	display: inline-block;
    width: 150px;
    border-radius: 5px;
    border: 1px solid #E8EBF0;
    padding: 0px;
    font-size: 14px;
    text-align: center;
    line-height: 30px;
}

.btn-group1 button {
	display: inline-block;
	border: 1px solid #D6DAE2;
    outline: none;
    border-radius: 5px;
    padding: 0 12px;
    height: 30px;
	
}

.input-info button:hover {
	background-color: #D6D2C4;
}

#content-table th {
	background-color: #9BABB8;
	font-weight: bold;
	position: sticky;
	top: 0;
}

#content-table th, #content-table td {
	white-space: nowrap;
	padding: 8px;
	text-align: center;
	border: 1px solid #B3B3B3;
}


#content-table tr {
	height: 24px;
}

#content-table {
	width: 1305px;
	border-collapse: collapse;
	white-space: nowrap;
	font-size: 15px;
}


#content-table tr:hover {
  	background-color: #f5f5f5;
}


#content-table input[type="checkbox"] {
 	margin: 0;
}
	

</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

	// 숫자 형식 변환
	function formatNumber(number) {
		return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 원래 숫자 형식으로 되돌리기
	function defaultNumber(numberString) {
		  return numberString.replace(/,/g, '');
	}

	
	$(document).ready(function () {
		defaultItemList();
		getNow();
	});
	
	
	// 현재 날짜 가져오기
	function getNow() {
		let today = new Date();
		// 날짜를 yyyy/mm/dd 형식으로 변환
		let year = today.getFullYear();
		let month = String(today.getMonth() + 1).padStart(2, '0');
		let day = String(today.getDate()).padStart(2, '0');
		// 등록/수정일자 input에 오늘 날짜 설정
		$('#reg-date').val(year + '/' + month + '/' + day);
	};
	
	
	// 열 클릭시 라디오 박스 체크
	$(document).on('click', '#content-table tbody tr', function() {
		$(this).toggleClass('checked-row');
	});

	
	// 제품 단가 수정(업데이트)
	$(document).on('click', '#item-update', function() {
		if (!$('input[type="radio"]:checked').val()) {
		    alert("제품을 먼저 선택해주세요.");
		    return;
		}
		if ($('#reg-user').val() === "") {
			alert("필수 정보를 입력해주세요.")
		} else {
			let itemCode = $('#item-code').val();
			console.log(itemCode);
			
			$.ajax({
				url : '/standard/ipi/' + itemCode,
				type : 'PUT',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify({
					itemCode    	: itemCode,
					purchasePrice 	: $('#purchase-price').val(),
					salesPrice		: $('#sales-price').val(),
					memo 			: $('#memo').val(),
					startDate 		: $('#start-date').val(),
					endDate 		: $('#end-date').val(),
					updateUser  	: $('#reg-user').val(),
					updateDate  	: $('#reg-date').val(),
				}),
				success : function(updateResult){
					if (updateResult === 1) {
						alert("단가 등록이 완료되었습니다.");
					} else { 
						alert("단가 등록에 실패하였습니다. 잠시 후 다시 시도해주세요.");
					}
					location.reload();
				},
				error: function(xhr, status, error) {
				      console.log('Error:', error);
				}
			});
		}
	});

	
	// 제품 디폴트 리스트
	function defaultItemList() {
		$.ajax({
		    url : '/standard/ipi/items',
		    type : 'GET',
		    dataType : 'json',
		    success : function(itemList) {
		      let table = $('#content-table');
	
		      for (var i = 0; i < itemList.length; i++) {
			      let item = itemList[i];
			      let row = '<tr>' +
			      '<td>' + (i + 1) + '</td>' +
		          '<td><input type="radio" name="item-radio"></td>' +
		          '<td style="background-color: #D9D9D9">' + item.whCode	 + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.companyCode	 + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.itemType + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.itemCode + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.itemName + '</td>' +
		          '<td style="background-color: #E6F2FF">' + formatNumber(item.purchasePrice) + '</td>' +
		          '<td style="background-color: #E6F2FF">' + formatNumber(item.salesPrice) + '</td>' +
		          '<td style="background-color: #FFFFCC">' + item.startDate.substring(0, 10) + '</td>' +
		          '<td style="background-color: #FFFFCC">' + item.endDate.substring(0, 10) + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.stockUnit + '</td>' +
		          '<td>' + item.memo + '</td>' +
		          '<td style="background-color: #E6F2FF">' + item.regUser + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.regDate.substring(0, 10) + '</td>' +
		          '<td style="background-color: #E6F2FF">' + item.updateUser + '</td>' +
		          '<td style="background-color: #D9D9D9">' + item.updateDate.substring(0, 10) + '</td>' +
		          '</tr>';
		      	  table.append(row);
		      }
		    },
		    error: function(xhr, status, error) {
		      console.log('Error:', error);
		    }
		});
	}
	
	
	// 검색
	function search() {
		let searchKeyWord = $('#search-input').val();
		let table = $('#content-table');
		let tbody = table.find('tbody');
		if (searchKeyWord === "") {
			tbody.empty();
			defaultItemList();
		} else {
			$.ajax({
				url : '/standard/imi/search/' + searchKeyWord,
				type : 'GET',
				data : { searchKeyWord: searchKeyWord },
				success : function (searchResultList) {
					if (!tbody.length) {
					  tbody = $('<tbody></tbody>');
					  table.append(tbody);
					}
			        tbody.empty();
			        console.log(searchResultList);

					for (var i = 0; i < searchResultList.length; i++) {
						let item = searchResultList[i];
						let row =
					    '<tr>' +
					    '<td>' + (i + 1) + '</td>' +
					    '<td><input type="radio" name="item-radio"></td>' +
					    '<td style="background-color: #D9D9D9">' + item.whCode + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.companyCode + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.itemType + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.itemCode + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.itemName + '</td>' +
					    '<td style="background-color: #E6F2FF">' + formatNumber(item.purchasePrice) + '</td>' +
					    '<td style="background-color: #E6F2FF">' + formatNumber(item.salesPrice) + '</td>' +
					    '<td style="background-color: #FFFFCC">' + item.startDate.substring(0, 10) + '</td>' +
					    '<td style="background-color: #FFFFCC">' + item.endDate.substring(0, 10) + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.stockUnit + '</td>' +
					    '<td>' + item.memo + '</td>' +
					    '<td style="background-color: #E6F2FF">' + item.regUser + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.regDate.substring(0, 10) + '</td>' +
					    '<td style="background-color: #E6F2FF">' + item.updateUser + '</td>' +
					    '<td style="background-color: #D9D9D9">' + item.updateDate.substring(0, 10) + '</td>' +
					    '</tr>';
					    table.append(row);
					}
				},
				error: function (xhr, status, error) {
				    console.log('Error:', error);
				}
		    });
		}
	}

	$(document).on('click', '#search-btn', function () {
		search();
	});

	$(document).on('keydown', '#search-input', function (event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			search();
		}
	});

	
	// 체크 된 아이템 정보 가져오기
	function updateInputFields(selectedRow) {
		let companyCode = selectedRow.find('td:eq(3)').text();
		let itemCode = selectedRow.find('td:eq(5)').text();
		let itemName = selectedRow.find('td:eq(6)').text();
		let purchasePrice = selectedRow.find('td:eq(7)').text();
		let salesPrice = selectedRow.find('td:eq(8)').text();
		let startDate = selectedRow.find('td:eq(9)').text();
		let endDate = selectedRow.find('td:eq(10)').text();
		let stockUnit = selectedRow.find('td:eq(11)').text();
		let memo = selectedRow.find('td:eq(12)').text();
		let regUser = selectedRow.find('td:eq(13)').text();
		
		$('#company-code').val(companyCode);
		$('#item-code').val(itemCode);
		$('#item-name').val(itemName);
		$('#purchase-price').val(defaultNumber(purchasePrice));
		$('#sales-price').val(defaultNumber(salesPrice));
		$('#start-date').val(startDate);
		$('#end-date').val(endDate);
		$('#stock-unit').val(stockUnit);
		$('#memo').val(memo);
		$('#reg-user').val(regUser);
		
		let radioInput = selectedRow.find('td:eq(1) input[type="radio"]');
		radioInput.prop('checked', true);
		
	}

	// 입력 폼에서 값 수정 시  리스트 값 실시간 변동
	$(document).on('input', '#purchase-price', function () {
	  	let selectedRow = $('#content-table tr input[type="radio"]:checked').closest('tr');
	  	selectedRow.find('td:eq(7)').text($(this).val());
	});
	
	$(document).on('input', '#sales-price', function () {
	  	let selectedRow = $('#content-table tr input[type="radio"]:checked').closest('tr');
	  	selectedRow.find('td:eq(8)').text($(this).val());
	});
	
	$(document).on('input', '#start-date', function () {
	  	let selectedRow = $('#content-table tr input[type="radio"]:checked').closest('tr');
	  	selectedRow.find('td:eq(9)').text($(this).val());
	});
	
	$(document).on('input', '#end-date', function () {
	  	let selectedRow = $('#content-table tr input[type="radio"]:checked').closest('tr');
	  	selectedRow.find('td:eq(10)').text($(this).val());
	});
	
	$(document).on('input', '#memo', function () {
	  	let selectedRow = $('#content-table tr input[type="radio"]:checked').closest('tr');
	  	selectedRow.find('td:eq(12)').text($(this).val());
	});

	
	// 체크 된 값 입력폼 업데이트
	$(document).on('click', '#content-table tr', function () {
		let radioInput = $(this).find('td:eq(1) input[type="radio"]');
		radioInput.prop('checked', true);
		let selectedRow = $(this);
		updateInputFields(selectedRow);
	});

	
	// 초기화 버튼
	$(document).on('click', '#reset-btn', function(){
		$('#company-code').val('');
		$('#item-code').val('');
		$('#item-name').val('');
		$('#purchase-price').val('');
		$('#sales-price').val('');
		$('#stock-unit').val('');
		$('#memo').val('');
		$('#start-date').val('').prop('required', true);
		$('#end-date').val('').prop('required', true);
		$('#reg-user').val('');
		$('#content-table tr input[type="radio"]:checked').prop('checked', false);
		$('#content-table tr.checked-row').removeClass('checked-row');
		if ($('#search-input').val() !== '') {
			let table = $('#content-table');
			let tbody = table.find('tbody');
			tbody.empty();
			defaultItemList();
			$('#search-input').val('');
		}
	});


</script>