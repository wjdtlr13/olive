package com.olive.olive.auction;

import java.io.File;
import java.math.BigDecimal;
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
	
	@RequestMapping(value="list") 
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
   	    String cp = req.getContextPath();
   	    
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);

        // 글 리스트
        List<Auction> list = service.listAuction(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Auction dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/auction/list";
        String articleUrl = cp+"/auction/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/auction/list?" + query;
        	articleUrl = cp+"/auction/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		model.addAttribute("menuIndex", 2);
		
		return ".auction.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		model.addAttribute("menuIndex", 2);
		return ".auction.created";
	}
	
	@RequestMapping(value="/auction/created", method=RequestMethod.POST)
	public String createdSubmit(
			Auction dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"auction";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertAuction(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/auction/list";
	}
	
	@RequestMapping(value="article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(num);

		// 해당 레코드 가져 오기
		Auction dto = service.readAuction(num);
		if(dto==null)
			return "redirect:/auction/list?"+query;
        
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Auction preReadDto = service.preReadAuction(map);
		Auction nextReadDto = service.nextReadAuction(map);
        
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("menuIndex", 2);
		
        return ".auction.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
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
		model.addAttribute("menuIndex", 2);
		
		return ".auction.created";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Auction dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"auction";		

		try {
			service.updateAuction(dto, pathname);		
		} catch (Exception e) {
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
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"bbs";
		
		service.deleteAuction(num, pathname, info.getUserId());
		
		return "redirect:/auction/list?"+query;
	}
	
	@RequestMapping(value="insertAuctionLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertAuctionLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int auctionLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertAuctionLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		auctionLikeCount = service.auctionLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("auctionLikeCount", auctionLikeCount);
		
		return model;
	}
	
	// 댓글
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception{
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("num",num);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
				current_page = total_page;
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Reply> listReply = service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "auction/listReply";
	}

	// 댓글 및 댓글의 답글 등록
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state="true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	// 댓글, 댓글답글 삭제
	@RequestMapping(value="deleteReply", method = RequestMethod.POST)
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
	
	//댓글의 답글 리스트
	@RequestMapping(value="listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer,
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(answer);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "auction/listReplyAnswer";
	}
	
	// 댓글의 답글 개수
	@RequestMapping(value="countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@RequestParam(value="answer") int answer
			) {
		
		int count=service.replyAnswerCount(answer);
		
		Map<String, Object> model = new HashMap<>();
		model.put("count", count);
		
		return model;
	}
	
	// 댓글의 좋아요 싫어요
	@RequestMapping(value="insertReplyLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		String state="true";
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> model = new HashMap<>();
		
		try {
			paramMap.put("userId", info.getUserId());
			service.insertReplyLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> countMap = service.replyLikeCount(paramMap);
		
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
		
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
		model.put("state", state);
		
		return model;
	}
	 
	@RequestMapping(value="countReplyLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		
		Map<String, Object> countMap = service.replyLikeCount(paramMap);
		
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
		
		Map<String, Object> model=new HashMap<>();
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
			
		return model;
		
	}
	
}
