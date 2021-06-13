package com.olive.olive.auction;

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

@Controller("auction.auctionController")
@RequestMapping("/auction/*")
public class AuctionController {
	@Autowired
	private AuctionService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows=10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
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
	        
        List<Auction> list = service.listAuction(map);
        
        int listNum, n = 0;
        for(Auction dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/auction/list";
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/auction/list?" + query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
        
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".auction.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".auction.created";
	}

	@RequestMapping(value="/auction/created", method = RequestMethod.POST)
	public String createdSubmit(
			Auction dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		try {
			dto.setUserId(info.getUserId());
			service.insertAuction(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/auction/list";
	}
	
	@RequestMapping(value="article")
	public String article(@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session,
			Model model)throws Exception{
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.updateHitCount(num);
		
		Auction dto = service.readAuction(num);
		if(dto==null)
			return "redirect:/auction/list?"+query;
		
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);
		
		Auction preReadDto = service.preReadAuction(map);
		Auction nextReadDto = service.nextReadAuction(map);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("userId", info.getUserId());
		boolean b = service.isAuctionLikeUser(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		
		model.addAttribute("isAuctionLikeUser", b);

		model.addAttribute("page", page);
		model.addAttribute("query", query);

        return ".auction.article";
	}
	
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model)throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Auction dto = service.readAuction(num);
		if(dto==null) {
			return "redirect:/auction/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/auction/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".auction.created";
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String updateSubmit(
			Auction dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		try {
			service.updateAuction(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/auction/list?page="+page;
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.deleteAuction(num, info.getUserId());
		
		return "redirect:/auction/list?"+query;
	}
	
	@RequestMapping(value="insertAuctionLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertAuctionLike(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		String state="true";
		
		try {
			service.insertAuctionLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		int auctionLikeCount = service.auctionLikeCount(num);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("auctionLikeCount", auctionLikeCount);
		
		return model;
	}
	
	@RequestMapping(value = "deleteAuctionLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteAuctionLike(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		// 좋아요 취소
		String state="true";
		try {
			service.auctionLikeDelete(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		int auctionLikeCount = service.auctionLikeCount(num);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("auctionLikeCount", auctionLikeCount);
		return model;
	}
	
	@RequestMapping(value = "insertReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) throws Exception {
		
		String state="false";
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
			state="true";
		} catch (Exception e) {
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value = "listReply")
	public String listReply(
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue = "1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		
		dataCount=service.replyCount(map);
		total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		int offset=(current_page-1)*rows;
		if(offset<0)offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Reply> listReply = service.listReply(map);
		
		for(Reply dto:listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "auction/listReply";
	}
	
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	@RequestMapping(value = "listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer, Model model
			) throws Exception {
		List<Reply> list = service.listReplyAnswer(answer);
		for(Reply dto : list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		model.addAttribute("listReplyAnswer", list);
		return "auction/listReplyAnswer";
	}
	
	@RequestMapping(value = "countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@RequestParam int answer
			) throws Exception {
		int count=service.replyAnswerCount(answer);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("count", count);
		return model;
	}
	
}
