package com.olive.olive;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
/*
	@Autowired
	private FreeService freeService;	  
	@Autowired
	private NoticeService noticeService;	
	@Autowired 
	private MemberService membreService;
*/	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		/*	Map<String, Object> map = new HashMap<String, Object>();
		map.put("offset", 0);
		map.put("rows", 4);

		
		List<Notice> listNotice = noticeService.listNotice(map);
	    List<com.sp.app.board.Board> listBoard = boardService.listBoard(map);
		
		model.addAttribute("listNotice", listNotice);
		model.addAttribute("listBoard", listBoard); 
		
		*/

		return ".home";
	}
}
