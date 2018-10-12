const urls = {
	LOGIN_URL: 'v1.0/login',
	PLAN_URL: 'v1.0/plan',
	PLAN_URLS: 'v1.0/plans',
	ABSENT_URL: 'v1.0/absent',
	ADD_JOUTANL_URL: 'v1.0/joutanl/add',
	DETAIL_JOUTANL_URL: 'v1.0/joutanl/detail',
	EDIT_JOUTANL_URL: 'v1.0/joutanl/edit',
	SIGN_URL: 'v1.0/sign',
	JOUTANL_LIST_URL: 'v1.0/joutanl/list',
	TXL_LIST:"v1.0/joutanl/txl",
	getDk:"v1.0/sing/dk",
};
var openid = '';
const pageCount = 100;

function onLogin (userName, password) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	$.showLoading("登录中");
	$.ajax({
		type: 'POST',
		url: urls.LOGIN_URL,
		data : {
			username : userName,
			password : password,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$.hideLoading();
			if (resp && (resp.ec === 200)) {
				setTimeout("javascript:location.href='main.html'", 10);
			} else if(resp.ec ===1100001){
				$.toptip('请使用微信登录！', 'error');
			} else if(resp.ec ===1100002){
				$.toptip('用户名或密码错误！', 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('登录失败', 'error');
		}
	});
}

function getPlanList (reload) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	let self= $('#tab1');
	if (self.loading)
		return;
	let startIndex = 0;
	if (!reload) {
		startIndex =  $('#planitems').children().length;
	}
	self.loading = true;
	$.ajax({
		type: 'POST',
		url: urls.PLAN_URL,
		data : {
			startindex : startIndex,
			maxresult : pageCount,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$('#tab1').pullToRefreshDone();
			self.loading = false;
			if (resp && (resp.ec === 200)) {
				if (resp && resp.result) {
					var info = '';
					resp.result.forEach((item) => {
						var element = "<a href=\"javascript:void(0);\" class=\"weui-media-box weui-media-box_appmsg\">" +
							"<div class=\"weui-media-box__bd\">" +
							"<h4 class=\"weui-media-box__title\">" +
							formatDateTime(item.startDate) + "---" + formatDateTime(item.endDate) +
							"</h4>" +
							"<p class=\"weui-media-box__desc\">" +
							item.content + "</p>" +
							"</div>" +
							"</a>";
						info = info + element;
					});
					if (reload) {
						$('#planitems').empty();
						$('#planitems').append(info);
					} else {
						$('#planitems').append(info);
					}
					if (resp.result.length < pageCount) {
						$('#footer1').addClass('hide')
					} else {
						$('#footer1').removeClass('hide')
					}
				}
			} else if(resp.ec === 1000000){
				window.location.href="index.html";
			}
			
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$('#tab1').pullToRefreshDone();
			self.loading = false;
			$.toptip('数据获取失败', 'error');
		}
	});
}
//已完成计划
function getPlanListywc (reload) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	let self= $('#tab4');
	if (self.loading)
		return;
	let startIndex = 0;
	if (!reload) {
		startIndex =  $('#planywc').children().length;
	}
	self.loading = true;
	$.ajax({
		type: 'POST',
		url: urls.PLAN_URLS,
		data : {
			startindex : startIndex,
			maxresult : pageCount,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$('#tab4').pullToRefreshDone();
			self.loading = false;
			if (resp && (resp.ec === 200)) {
				if (resp && resp.result) {
					var info = '';
					resp.result.forEach((item) => {
						var element = "<a href=\"javascript:void(0);\" class=\"weui-media-box weui-media-box_appmsg\">" +
							"<div class=\"weui-media-box__bd\">" +
							"<h4 class=\"weui-media-box__title\">" +
							formatDateTime(item.startDate) + "---" + formatDateTime(item.endDate) +
							"</h4>" +
							"<p class=\"weui-media-box__desc\">" +
							item.content + "</p>" +
							"</div>" +
							"</a>";
						info = info + element;
					});
					if (reload) {
						$('#planywc').empty();
						$('#planywc').append(info);
					} else {
						$('#planywc').append(info);
					}
					if (resp.result.length < pageCount) {
						$('#footer4').addClass('hide')
					} else {
						$('#footer4').removeClass('hide')
					}
				}
			} else if(resp.ec === 1000000){
				window.location.href="index.html";
			}
			
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$('#tab4').pullToRefreshDone();
			self.loading = false;
			$.toptip('数据获取失败', 'error');
		}
	});
}

function absent (type, reason, startTime, endTime, duration) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	$.showLoading("数据提交中");
	$.ajax({
		type: 'POST',
		url: urls.ABSENT_URL,
		data : {
			reason : reason,
			type : type,
			startTime : startTime,
			endTime : endTime,
			duration : duration,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$.hideLoading();
			if (resp && (resp.ec === 200)) {
				$.alert("提交成功，等待上级审批", "成功！", function () {
					window.history.go(-1);
				});
			} else {
				$.toptip('操作失败', 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('操作失败', 'error');
		}
	});
}

function addJoutanl (content) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	$.showLoading("数据提交中");
	$.ajax({
		type: 'POST',
		url: urls.ADD_JOUTANL_URL,
		data : {
			content : content,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$.hideLoading();
			if (resp && (resp.ec === 200)) {
				$.alert("提交成功", "成功！", function () {
					window.history.go(-1);
				});
			} else {
				$.toptip('操作失败', 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('操作失败', 'error');
		}
	});
}

function getJoutanlDetail(id) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	$.showLoading("数据获取中");
	$.ajax({
		type: 'POST',
		url: urls.DETAIL_JOUTANL_URL,
		data : {
			id : id,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$.hideLoading();
			if (resp && (resp.ec === 200)) {
				$('#done').val(resp.result.content);
			} else {
				$.toptip('操作失败', 'error');
			}
			
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('操作失败', 'error');
		}
	});
}

function editJoutanl(id, content) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	$.showLoading("数据提交中");
	$.ajax({
		type: 'POST',
		url: urls.EDIT_JOUTANL_URL,
		data : {
			id : id,
			content: content,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$.hideLoading();
			if (resp && (resp.ec === 200)) {
				$.alert("修改成功", "成功！", function () {
					window.history.go(-1);
				});
			} else {
				$.toptip('操作失败', 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('操作失败', 'error');
		}
	});
}
function sign(lat, lng, addr) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	$.showLoading("数据提交中");

	$.ajax({
		type: 'POST',
		url: urls.SIGN_URL,
		data : {
			lat : lat,
			lng: lng,
			addr: addr,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			$.hideLoading();
			if (resp && (resp.ec === 200)) {
				$.alert("打卡成功", "成功！", function () {
					//window.history.go(-1);
					history.go(0);
				});
			} else {
				$.toptip(resp.em, 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('签到失败', 'error');
		}
	});
}

function getJoutanlList (reload) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	let self= $('#tab3');
	if (self.loading)
		return;
	let startIndex = 0;
	if (!reload) {
		startIndex =  $('#joutanlitems').children().length;
	}
	self.loading = true;
	$.ajax({
		type: 'POST',
		url: urls.JOUTANL_LIST_URL,
		data : {
			startindex : startIndex,
			maxresult : pageCount,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			self.loading = false;
			$.hideLoading();
			$('#tab3').pullToRefreshDone();
			if (resp && (resp.ec === 200)) {
				if (resp && resp.result) {
					var info = '';
					resp.result.forEach((item) => {
						var element = '<a href="./ribao.html?id=' + item.id + '"' +
						    ' class="weui-media-box weui-media-box_appmsg">' +
							'<div class="weui-media-box__bd">' +
							'<h4 class="weui-media-box__title">' +
						    item.titile + '<span>' +
							formatDateTime(item.joutanlDate) + '</span></h4>' +
							'<p class="weui-media-box__desc">' +
							item.content + '</p>' +
							'</div>' +
							'</a>';
						info = info + element;
					});
					if (reload) {
						$('#joutanlitems').empty();
						$('#joutanlitems').append(info);
					} else {
						$('#joutanlitems').append(info);
					}
					if (resp.result.length < pageCount) {
						$('#footer3').addClass('hide')
					} else {
						$('#footer3').removeClass('hide')
					}
				}
			} else {
				$.toptip(resp.em, 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$('#tab3').pullToRefreshDone();
			self.loading = false;
			$.toptip('数据获取失败', 'error');
		}
	});
}

function getOpenId () {
	var wxid = getParamsString('openid');
	var storage = window.localStorage;
	if (wxid) {
		storage.setItem('openid', wxid);
		return wxid;
	} else {
		let id = storage.getItem('openid', null);
		return id;
	}
}

function formatDateTime(timeStamp) {
	var date = new Date();
	date.setTime(timeStamp);
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	m = m < 10 ? ('0' + m) : m;
	var d = date.getDate();
	d = d < 10 ? ('0' + d) : d;
	return y + '年' + m + '月' + d + '日';
}
function formatDateTime1(theDate) {
	var date = new Date();
	date.setTime(theDate);
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	m = m < 10 ? ('0' + m) : m;
	var d = date.getDate();
	d = d < 10 ? ('0' + d) : d;
	var h = date.getHours();
	h = h < 10 ? ('0' + h) : h;
	var mm = date.getMinutes();
	mm = mm < 10 ? ('0' + mm) : mm;
	var s = date.getSeconds();
	return y+'-'+m+'-'+d+' '+h+':'+mm;
}


function getParamsString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
}
/**
 * 通讯录
 */
function getTxl (reload) {
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	let self= $('#tabb');
	if (self.loading)
		return;
	let startIndex = 0;
	if (!reload) {
		startIndex =  $('#users').children().length;
	}
	self.loading = true;
	$.ajax({
		type: 'POST',
		url: urls.TXL_LIST,
		data : {
			startindex : startIndex,
			maxresult : pageCount,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			self.loading = false;
			$.hideLoading();
			$('#tabb').pullToRefreshDone();
			if (resp && (resp.ec === 200)) {
				if (resp && resp.result) {
					var info = '';
					resp.result.forEach((item) => {
						var element = '<a href="#"' +
					    ' class="weui-media-box weui-media-box_appmsg">' +
						'<div class="weui-media-box__bd">' +
						'<h4 class="weui-media-box__title">' +
					    item.name + '<span>' +
						item.phoneNumber + '</span></h4>' +
						'<p class="weui-media-box__desc"></p>' +
						'</div>' +
						'</a>';
						info = info + element;
					});
					if (reload) {
						$('#users').empty();
						$('#users').append(info);
					} else {
						$('#users').append(info);
					}
					if (resp.result.length < pageCount) {
						$('#footerr').addClass('hide')
					} else {
						$('#footerr').removeClass('hide')
					}
				}
			}else {
				$.toptip(resp.em, 'error');
			}
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$('#tabb').pullToRefreshDone();
			self.loading = false;
			$.toptip('数据获取失败', 'error');
		}
	});
}
//查询打卡记录
function getDk(id){
	let openId = getOpenId();
	if (!openId) {
		return $.toptip('获取微信openid失败', 'error');
	}
	//$.showLoading("数据提交中");
	$.ajax({
		type: 'POST',
		url: urls.getDk,
		data : {
			id : id,
			openid : openId
		},
		dataType: 'json',
		success: function (resp) {
			var day = new Date();
			
			resp.result.forEach((item) => {
				if(formatDateTime(day)==formatDateTime(item.attendanceTime)){
					$("#sb").val(formatDateTime1(item.attendanceTime));
					
					if(item.times==1){
						$("#submit").html("签退");
					}else if(item.times==2){
						
						$("#submit").html("签退");
						//document.getElementById('submit').style.display='none';
						$("#xb").val(formatDateTime1(item.attendanceTime2));
					}
				}
			});
		},
		error: function (XMLHttpRequest, textStatus, errorThrown) {
			$.hideLoading();
			$.toptip('操作失败', 'error');
		}
	});
}

