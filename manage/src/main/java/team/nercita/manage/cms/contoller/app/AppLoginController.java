/*
 * AppLoginController.java
 * 创建者：侯建玮
 * 创建日期：2017年12月4日 上午9:19:34
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.contoller.app;

import java.io.Console;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.nercita.manage.cms.contoller.BaseAPPController;
import team.nercita.manage.cms.model.Result;
import team.nercita.manage.cms.po.deptmanage.User;
import team.nercita.manage.cms.wechat.WechatUtil;
import team.nercita.manage.cms.wechat.vo.AccessToken;

/**
 * 
 * @author 侯建玮
 * @date： 2017年12月4日 上午9:19:34
 */
@Controller
@RequestMapping("/app")
public class AppLoginController extends BaseAPPController {
	
	public static Log log = LogFactory.getLog(AppLoginController.class);
	@RequestMapping("/v1.0/index")
	public ModelAndView index(@RequestParam(value="code",required=false) String code) {
		
		ModelAndView view = new ModelAndView("app/redirect");
		
		if(StringUtils.isBlank(code)) {
			view.addObject("type", "login");
		}
		AccessToken accessToken = WechatUtil.geOuthAccessToken(code);
		String openId = accessToken.getOpenId();
		//String openId = "test";
		User user = checkLogin(openId);
		view.addObject("openid", openId);
		if(user == null) {
			view.addObject("type", "login");
		} else {
			view.addObject("type", "index");
		}
		return view;
	}
	@RequestMapping("/v1.0/dk")
	public ModelAndView dk(@RequestParam(value="code",required=false) String code) {
		
		ModelAndView view = new ModelAndView("app/dk");
		if(StringUtils.isBlank(code)) {
			view.addObject("type", "login");
		}
		AccessToken accessToken = WechatUtil.geOuthAccessToken(code);
		String openId = accessToken.getOpenId();
		User user = checkLogin(openId);
		view.addObject("openid", openId);
		if(user == null) {
			view.addObject("type", "login");
		} else {
			view.addObject("type", "dk");
		}
		return view;
	}
	@RequestMapping("/v1.0/rz")
	public ModelAndView rz(@RequestParam(value="code",required=false) String code) {
		
		ModelAndView view = new ModelAndView("app/rz");
		if(StringUtils.isBlank(code)) {
			view.addObject("type", "login");
		}
		AccessToken accessToken = WechatUtil.geOuthAccessToken(code);
		String openId = accessToken.getOpenId();
		User user = checkLogin(openId);
		view.addObject("openid", openId);
		if(user == null) {
			view.addObject("type", "login");
		} else {
			view.addObject("type", "rz");
		}
		return view;
	}
	@RequestMapping("/v1.0/rw")
	public ModelAndView rw(@RequestParam(value="code",required=false) String code) {
		
		ModelAndView view = new ModelAndView("app/rw");
		if(StringUtils.isBlank(code)) {
			view.addObject("type", "login");
		}
		AccessToken accessToken = WechatUtil.geOuthAccessToken(code);
		String openId = accessToken.getOpenId();
		User user = checkLogin(openId);
		view.addObject("openid", openId);
		if(user == null) {
			view.addObject("type", "login");
		} else {
			view.addObject("type", "rw");
		}
		return view;
	}
	
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("/v1.0/login")
	@ResponseBody
	public Result login(@RequestParam(value="username",required=false) String username, @RequestParam(value="password",required=false) String password,@RequestParam(value="openid",required=false) String openid){
		if(StringUtils.isBlank(openid)) {
			return new Result(1100001, "请使用微信登录！");
		}
		
		if(loginapp(username, password, openid) == null) {
			return new Result(1100002, "用户名或密码错误！");
		}
		
		return new Result();
	}
}
