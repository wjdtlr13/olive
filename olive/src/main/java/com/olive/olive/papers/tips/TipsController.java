package com.olive.olive.papers.tips;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("papers.tips.tipsController")
@RequestMapping("/papers/tips/*")
public class TipsController {
	@Autowired
	private TipsService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping()
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		 Map<String, Object> map = new HashMap<String, Object>();
	        map.put("condition", condition);
	        map.put("keyword", keyword);

	        dataCount = service.dataCount(map);
	        if(dataCount != 0)
	            total_page = myUtil.pageCount(rows, dataCount) ;
		
	        if(total_page < current_page) 
	            current_page = total_page;
	        
	        int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("rows", rows);
	        
	        List<Tips> list = service.listTips(map);
	        
	        int listNum, n = 0;
	        for(Tips dto : list) {
	        	listNum = dataCount - (offset + n);
	        	dto.setListNum(listNum);
	        	n++;
	        }
	        
	        String query = "";
	        String listUrl = cp+"/papers/tips/list";
	        if(keyword.length()!=0) {
	        	query = "condition=" +condition + 
	        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
	        }
	        
	        if(query.length()!=0) {
	        	listUrl = cp+"/papers/tips/list?" + query;
	        }
	        
	        String paging = myUtil.paging(current_page, total_page, listUrl);
	        
	        model.addAttribute("list", list);
	        model.addAttribute("page", current_page);
	        model.addAttribute("dataCount", dataCount);
	        model.addAttribute("total_page", total_page);
	        model.addAttribute("paging", paging);
	        
	        model.addAttribute("condition", condition);
			model.addAttribute("keyword", keyword);
	        
		return ".papers.tips.list";
	}
	
	@RequestMapping(value="/papers/tips/created", method = RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception{
		
		model.addAttribute("mode", "created");
		return ".papers.tips.created";
	}

	@RequestMapping(value="/papers/tips/created", method = RequestMethod.POST)
	public String createdSubmit(
			Tips dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("admin");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertTips(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/papers/tips/list";
	}
	
	@RequestMapping(value="/papers/tips/article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(num);
		
		Tips dto = service.readTips(num);
		if(dto==null)
			return "redirect:/papers/tips/list?"+query;
		
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);
		
		Tips preReadDto = service.preReadTips(map);
		Tips nextReadDto = service.nextReadTips(map);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("userId", info.getUserId());
		boolean b = service.isTipsLikeUser(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		
		model.addAttribute("isTipsLikeUser", b);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".papers.tips.article";
	}
	
	@RequestMapping(value=".papers.tips.update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("admin");
		
		Tips dto = service.readTips(num);
		if(dto==null) {
			return "redirect:/papers/tips/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId() ) ) {	// ${sessionScope.member.userId=='admin'}
			return "redirect:/papers/tips/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".papers.tips.created";
	}
	
	@RequestMapping(value="/papers/tips/update", method = RequestMethod.POST)
	public String updateSubmit(
			Tips dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		try {
			service.updateTips(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/papers/tips/list?page="+page;
	}
	
	@RequestMapping(value="/papers/tips/delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
	
		SessionInfo info=(SessionInfo)session.getAttribute("admin");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.deleteTips(num, info.getUserId());
		
		return "redirect:/papers/tips/list?"+query;
	}
	
	@RequestMapping(value = "/papers/tips/insertTipsLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertTipsLike(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		String state="true";
		try {
			service.insertTipsLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		int tipsLikeCount = service.tipsLikeCount(num);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("tipsLikeCount", tipsLikeCount);
		return model;
	}
	
	@RequestMapping(value="/papers/tips/deleteTipsLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteTipsLike(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		String state="true";
		try {
			service.tipsLikeDelete(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		int tipsLikeCount = service.tipsLikeCount(num);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("tipsLikeCount", tipsLikeCount);
		return model;
		
	}
	
}
