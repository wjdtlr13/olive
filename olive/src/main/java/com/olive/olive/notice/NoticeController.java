package com.olive.olive.notice;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("notice.noticeController")
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Autowired
	private NoticeService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "")String keyword,
			HttpServletRequest req,
			Model model		
			) throws Exception {
		int rows = 10;
		int dataCount;
		int total_page=0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.dataCount(map);
		if(dataCount!=0) {
			//전체 페이지 수 
			total_page=myUtil.pageCount(rows, dataCount);
			
		}		
		
		
		if(current_page>total_page) {
			current_page=total_page;
		}
		
		int offset = (current_page-1)*rows;
		if(offset <0) {
			offset=0;
		}
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		
		List<Notice> list = service.listNotice(map);
		
		int listNum, n=0;
		for(Notice dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		
		
		String cp =req.getContextPath();
		String query = "";
		String listUrl=cp+"/notice/list";
		String articleUrl=cp+"/notice/article?page="+current_page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword="
					+ URLEncoder.encode(keyword, "UTF-8");
		}
		
		if(query.length()!=0) {
			listUrl=listUrl+"?"+query;
			articleUrl=cp+"/notice/article?page="+current_page+"&"+query;
		}
		
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("page",current_page);
		model.addAttribute("total_page",total_page);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
        model.addAttribute("condition",condition);
        model.addAttribute("keyword",keyword);	

		
		return ".notice.list";
	}
	
	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String createdForm(
			HttpSession session,
			Model model
			) throws Exception {
		
		model.addAttribute("mode","created");
		
		
		return ".notice.created";
	}
	
	
	@RequestMapping(value = "created", method = RequestMethod.POST)
	public String createSubmit(
			Notice dto, HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertNotice(dto, "created");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/notice/list";
	}
	
	@RequestMapping("article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			Model model
			) throws Exception {
		
		
		Notice dto = service.readNotice(num);
		String query="page="+page;
		if(dto==null) {
			return "redirect:/notice/list?"+query;
		}
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto",dto);
		model.addAttribute("page",page);
		model.addAttribute("query", query);

		
		return ".notice.article";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			) throws Exception {
		
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		
		Notice dto =service.readNotice(num);
		if(dto==null) {
			return "redirect:/notice/list?page="+page;
		}
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/notice/list?page="+page;
		}		
		
		
		model.addAttribute("dto",dto);
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		
		
		
		return ".notice.created";
	}
	
	@RequestMapping(value = "update",method = RequestMethod.POST)
	public String updateSubmit(
			@RequestParam String page,
			Notice dto,
			HttpSession session
			) throws Exception {
		
		try {
			service.updateNotice(dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "redirect:/notice/list?page="+page;
	}
	
	@RequestMapping(value = "delete" )
	public String deleteNotice(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		String query="page="+page;
		service.deleteNotice(num, info.getUserId());
		return "redirect:/notice/list?"+query;
	}
	
	
	
}
