package com.olive.olive.chat;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("chat.chatController")
@RequestMapping("/chat/*")
public class ChatController {
	@RequestMapping("main")
	public String main(Model model) throws Exception{
		model.addAttribute("menuIndex",2);
		return ".chat.chat";
	}

}
