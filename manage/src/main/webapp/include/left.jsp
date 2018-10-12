<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>功能菜单</title>
<link rel="stylesheet"href="<%=request.getContextPath()%>/css/zxstyle.css" type="text/css" />
<script type="text/javascript"src="<%=request.getContextPath()%>/js/jquery.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css">
</head>
<body class="menu_bj" style="overflow-x: hidden;overflow-y: hidden;">
	<div class="leftmenu">
		<div class="leftmenuone">
			<ul class="topmenu">
				<shiro:hasPermission name="dept">
					<dt><a class="top_menuico3" target="" href="#">部门管理</a></dt>
					<dd>
					<ul id="ul1" class="top_menulist">
					
						<shiro:hasPermission name="user">
						<li><h2>
								<i class="layui-icon layui-icon-friends"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/user/list">人员管理</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="user">
						<li><h2>
								<i class="layui-icon layui-icon-username"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/student/list">学生管理</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="role">
							<li><h2>
								<i class="layui-icon layui-icon-template-1"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/role/list">角色管理</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="group">
							<li><h2>
								<i class="layui-icon layui-icon-group"></i><a target="mainFrame" style="padding-left:13px;"
									href="<%=request.getContextPath()%>/usergroup/list">小组管理</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="experts">
							<li><h2>
								<i class="layui-icon layui-icon-user"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/experts/list">专家管理</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="plan">
							<li><h2>
								<i class="layui-icon layui-icon-app"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/workplan/list">工作计划</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="attendance">
							<li><h2>
								<i class="layui-icon layui-icon-flag"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/attendance/stat">考勤管理</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="joutanl">
							<li><h2>
								<i class="layui-icon layui-icon-file-b"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/workjoutanl/detail">工作日志</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="apply_form">
							<li><h2>
								<i class="layui-icon layui-icon-form"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/apply/forms/list">文件上传</a>
							</h2></li>
						</shiro:hasPermission>
					</ul>
					</dd>
				</shiro:hasPermission>
				<shiro:hasPermission name="project">
					<dt><a class="top_menuico3" target="" href="#">项目管理</a></dt>
					<dd>
					<ul id="ul2" class="top_menulist" >
						<shiro:hasPermission name="project1">
						<li><h2>
							<i class="layui-icon layui-icon-template"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/project/1/list">横向课题</a>
						</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="project0">
						<li><h2>
							<i class="layui-icon layui-icon-read"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/project/0/list">纵向课题</a>
						</h2></li>
						</shiro:hasPermission>
					</ul>
					</dd>
				</shiro:hasPermission>
				<shiro:hasPermission name="funds">
				<dt><a class="top_menuico3" target="" href="#">经费管理</a></dt>
				<dd>
				<ul id="ul3" class="top_menulist" >
					
					<shiro:hasPermission name="funds_fund">
						<li><h2>
							<i class="layui-icon layui-icon-rmb"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/list">经费到账</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_reimbursement">
					<li><h2>
							<i class="layui-icon layui-icon-date"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/reimbursement/list">日常报销</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_out">
					<li><h2>
							<i class="layui-icon layui-icon-list"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/out/list">外拨经费</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_other">
					<li><h2>
							<i class="layui-icon layui-icon-dollar"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/other/list">其他支出</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_transfer">
					<li><h2>
							<i class="layui-icon layui-icon-senior"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/transfer/list">转账管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_cheque">
					<li><h2>
							<i class="layui-icon layui-icon-file-b"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/cheque/list">支票管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_trval">
					<li><h2>
							<i class="layui-icon layui-icon-release"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/trval/list">差旅管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_remuneration">
					<li><h2>
							<i class="layui-icon layui-icon-tree"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/remuneration/list">劳务管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="funds_expertfee">
					<li><h2>
							<i class="layui-icon layui-icon-friends"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/expertfee/list">专家费管理</a>
						</h2></li>
					</shiro:hasPermission>
					<li><h2>
							<i class="layui-icon layui-icon-table"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/include/buliding.jsp">调账管理</a>
						</h2></li>
					<shiro:hasPermission name="funds_expertfee">
					<li><h2>
							<i class="layui-icon layui-icon-search"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/funds/cx/list">查询管理</a>
						</h2></li>
					</shiro:hasPermission>
					</ul>
					</dd>
				</shiro:hasPermission>
				<shiro:hasPermission name="products">
				<dt><a class="top_menuico3" target="" href="#">生产管理</a></dt>
				<dd>
				<ul id="ul4" class="top_menulist" >
					<shiro:hasPermission name="product">
					<li><h2>
							<i class="layui-icon layui-icon-component"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/product/list">生产记录</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="repair">
					<li><h2>
							<i class="layui-icon layui-icon-fonts-del"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/repair/list">返修记录</a>
						</h2></li>
					</shiro:hasPermission>
				</ul>
				</dd>
				</shiro:hasPermission>
				<shiro:hasPermission name="project">
					<dt><a class="top_menuico3" target="" href="#">工程管理</a></dt>
					<dd>
					<ul id="ul5" class="top_menulist" >
					<shiro:hasPermission name="business">
					<li><h2>
							<i class="layui-icon layui-icon-template-1"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/project/business/list">项目商务</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="startup">
					<li><h2>
							<i class="layui-icon layui-icon-app"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/project/startup/list">项目实施</a>
						</h2></li>
					</shiro:hasPermission>
					<li><h2>
							<i class="layui-icon layui-icon-dialogue"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/project/xmsh/list">项目售后</a>
						</h2></li>
					<li><h2>
							<i class="layui-icon layui-icon-reply-fill"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/project/cpsh/list">产品售后</a>
						</h2></li>
				</ul>
				</dd>
				</shiro:hasPermission>
				
				
				<shiro:hasPermission name="assets">
				<dt><a class="top_menuico3" target="" href="#">固定资产管理</a></dt>
				<dd>
				<ul id="ul7" class="top_menulist" >
					<shiro:hasPermission name="assets_list">
						<li><h2>
							<i class="layui-icon layui-icon-chart-screen"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/assets/list">固定资产登记</a>
						</h2></li>
						<li><h2>
							<i class="layui-icon layui-icon-form"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/assets/borrow/list">借用记录</a>
						</h2></li>
						<li><h2>
							<i class="layui-icon layui-icon-templeate-1"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/assets/wlw/list">物联网卡管理</a>
						</h2></li>
					</shiro:hasPermission>
				</ul>
				</dd>
				</shiro:hasPermission>
				<shiro:hasPermission name="apply">
				<dt><a class="top_menuico3" target="" href="#">申请管理</a></dt>
				<dd>
					<ul id="ul8" class="top_menulist" >
						<shiro:hasPermission name="apply_form">
							<li><h2>
								<i class="layui-icon layui-icon-form"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/apply/form/list">常用表单</a>
							</h2></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="apply_online">
							<li><h2>
								<i class="layui-icon layui-icon-survey"></i><a target="mainFrame"
									href="<%=request.getContextPath()%>/apply/online/index">在线填报</a>
							</h2></li>
						</shiro:hasPermission>
				</ul>
				</dd>
				</shiro:hasPermission>
				<shiro:hasPermission name="jxc">
				<dt><a class="top_menuico3" target="" href="#">进销存管理</a></dt>
				<dd>
				<ul id="ul9" class="top_menulist" >
					<shiro:hasPermission name="jxc_purchase">
						<li><h2>
							<i class="layui-icon layui-icon-cart-simple"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/purchase/list">采购管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="jxc_income">
						<li><h2>
							<i class="layui-icon layui-icon-spread-left"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/income/list">入库管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="jxc_out">
						<li><h2>
							<i class="layui-icon layui-icon-shrink-right"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/out/list">出库管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="jxc_store">
					<li><h2>
							<i class="layui-icon layui-icon-template-1"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/store/list">库存管理</a>
						</h2></li>
					</shiro:hasPermission>
					<%-- <shiro:hasPermission name="jxc_store">
					<li><h2>
							<i class="layui-icon layui-icon-set-sm"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/yqj/list">元器件管理</a>
						</h2></li>
					</shiro:hasPermission> --%>
					<shiro:hasPermission name="jxc_production">
						<li><h2>
							<i class="layui-icon layui-icon-util"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/production/list">生产管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="jxc_manage">
						<li><h2>
							<i class="layui-icon layui-icon-component"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/manage/list">产品管理</a>
						</h2></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="jxc_dealer">
						<li><h2>
							<i class="layui-icon layui-icon-home"></i><a target="mainFrame"
								href="<%=request.getContextPath()%>/jxc/dealer/list">经销商管理</a>
						</h2></li>
					</shiro:hasPermission>
				</ul>
				</dd>
				</shiro:hasPermission>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		/* $('a').click(function(){
			$('li').removeClass('active');
		    $(this).parent().parent().addClass('active');
		    
		});
		function change(ulid){
			for(var i =1; i<10;i++) {
				$("#ul" + i).hide();
				
				$("#h" + i).removeClass('h1active');
			}
			
			$("#ul" + ulid).show();
			$("#h" + ulid).addClass('h1active');
		} */
		$(document).ready(function(){
		 $("dd").hide();
		 $("dt a").click(function(){ 
		 
			 $(this).parent().toggleClass("bg");
			 $(this).parent().prevAll("dt").removeClass("bg");
			 $(this).parent().nextAll("dt").removeClass("bg");
			 $(this).parent().next().slideToggle();
			 $(this).parent().prevAll("dd").slideUp("slow");
			 $(this).parent().next().nextAll("dd").slideUp("slow");
			 return false;
		 });
		});
	</script>
<style>
.topmenu dt a{display: block;width: 246px;height: 40px;line-height: 40px;font-size: 14px;color: #fff;text-indent: 36px;font-family: "微软雅黑";
background: url(../images/show1.png) no-repeat 28px 4px;background-size: 15px 15px; background-position-x: 19px;background-position-y: 13px;
text-indent: 48px;font-weight:bold;}
.topmenu .bg a{background: url(../images/show.png) no-repeat 28px 4px #17648c;background-size: 15px 15px;background-position-x: 19px;background-position-y: 13px;}
</style>
</body>
</html>