/*
 * Generator.java
 * 创建者：侯建玮
 * 系统名称：农业自动化内部管理系统。
 * 创建日期：2017年6月17日 下午2:52:35
 * 创业小团队-后台
 */
package team.nercita.manage.cms.util;

import java.util.UUID;

/**
 * 生成工具
 * @author 侯建玮
 * @date 2017年6月17日 下午2:52:35
 */
public class Generator {
	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	public static void main(String[] args) {
		for (int i = 0; i < 10; i++) {
			System.out.println(getUUID());
		}
	}
}
