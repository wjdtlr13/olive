package com.olive.olive.admin.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("admin.adminController")
@RequestMapping("/admin/*")
public class AdminController {
	
	@RequestMapping("main")
	public String main() throws Exception {
		
		return ".adminLayout";
	}
	
	

}
