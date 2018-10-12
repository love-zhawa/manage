/*
 * IndexController.java
 * 创建者：侯建玮
 * 创建日期：2017年6月16日 上午11:10:18
 *
 * 版权所有(C) 2015-2018。英泰伟业科技(北京)有限公司。
 * 保留所有权利。
 */

package team.nercita.manage.cms.contoller.index;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/welcome")
public class WelcomeController {
	
	 public  Document getDocument (String url){
         try {
        	 //5000是设置连接超时时间，单位ms
             return Jsoup.connect(url).timeout(5000).get();
         } catch (IOException e) {
             e.printStackTrace();
         }
         return null;
     }
	@RequestMapping("/list")
	public ModelAndView list(){
		ModelAndView view = new ModelAndView("welcome/list");
		WelcomeController t = new WelcomeController();
        Document doc = t.getDocument("http://www.nercita.org.cn/");
        // 获取目标HTML代码
        Elements elements1 = doc.select("[class=new-mid-lb]");
       
        Map<String,String> xwlist = new HashMap<String,String>();
        // 中心新闻
        Elements elements4 = elements1.select("a");
        
        for (Element element : elements4) {
        	xwlist.put(element.attr("abs:href"),element.text());
	    }
        view.addObject("xwlist",xwlist);
        
		return view;
	}
}
