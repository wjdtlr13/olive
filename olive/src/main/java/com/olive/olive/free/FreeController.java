package com.olive.olive.free;

import java.io.File;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.FileManager;
import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;


@Controller("olive.oliveController")
@RequestMapping("/free/*")
public class FreeController {
	@Autowired
	private FreeService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(required=false) String categoryNum,
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
		
		if(categoryNum!=null) {
			int cNum = Integer.parseInt(categoryNum);
        	map.put("categoryNum", cNum);}
        
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
        List<Free> list = service.listFree(map);

        // 리스트의 번호
        int listNum, n = 0;
        for(Free dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
        
        String query = "";
        String listUrl = cp+"/free/list";
        String articleUrl = cp+"/free/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        	if(categoryNum!=null) {
        		query+="&categoryNum="+categoryNum;
        	}
        } else if(categoryNum!=null) {
        	query="categoryNum="+categoryNum;
        }
         
        
        if(query.length()!=0) {
        	listUrl = cp+"/free/list?" + query;
        	articleUrl = cp+"/free/article?page=" + current_page + "&"+ query;
        }
        
        String paging = myUtil.paging(current_page, total_page, listUrl);
        
        List<Category> categoryList = service.listCategory();

        model.addAttribute("list", list);
        //model.addAttribute("articleUrl", articleUrl);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("categoryNum", categoryNum);
     
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		model.addAttribute("menuIndex", 2);
		
		return ".free.list";
	}
	
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String createdForm(
			Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		model.addAttribute("menuIndex", 2);
		return ".free.created";
	}
	
	@RequestMapping(value="/free/created", method=RequestMethod.POST)
	public String createdSubmit(
			Free dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"free";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertFree(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/free/list";
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
		Free dto = service.readFree(num);
		if(dto==null)
			return "redirect:/free/list?"+query;
		
		// 스마트 에디터에서는 주석 처리
        // dto.setContent(myUtil.htmlSymbols(dto.getContent()));
        
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Free preReadDto = service.preReadFree(map);
		Free nextReadDto = service.nextReadFree(map);
        
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("menuIndex", 2);
		
        return ".free.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Free dto = service.readFree(num);
		if(dto==null) {
			return "redirect:/free/list?page="+page;
		}

		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/free/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("menuIndex", 2);
		
		return ".free.created";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Free dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"free";		

		try {
			service.updateFree(dto, pathname);		
		} catch (Exception e) {
		}
		
		return "redirect:/free/list?page="+page;
	}
	
	@RequestMapping(value="deleteFile")
	public String deleteFile(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"free";
		
		Free dto=service.readFree(num);
		if(dto==null) {
			return "redirect:/free/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/free/list?page="+page;
		}
		
		try {
			if(dto.getSaveFilename()!=null) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname); // 실제파일삭제
				dto.setSaveFilename("");
				dto.setOriginalFilename("");
				service.updateFree(dto, pathname); // DB 테이블의 파일명 변경(삭제)
			}
		} catch (Exception e) {
		}
		
		return "redirect:/free/update?num="+num+"&page="+page;
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
		String pathname=root+"uploads"+File.separator+"free";
		
		service.deleteFree(num, pathname, info.getUserId());
		
		return "redirect:/free/list?"+query;
	}
	
	@RequestMapping(value="download")
	public void download(
			@RequestParam int num,
			HttpServletRequest req,
			HttpServletResponse resp,
			HttpSession session
			) throws Exception {
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"free";
		
		Free dto=service.readFree(num);
		
		if(dto!=null) {
			boolean b=fileManager.doFileDownload(dto.getSaveFilename(),
					                   dto.getOriginalFilename(), pathname, resp);
			if(b) return;
		}
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print("<script>alert('파일 다운로드가 실패 했습니다.');history.back();</script>");
	}
	
	// 게시글 좋아요 추가 :  : AJAX-JSON
	@RequestMapping(value="insertBoardLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBoardLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int boardLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertFreeLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		boardLikeCount = service.freeLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("boardLikeCount", boardLikeCount);
		
		return model;
	}
	
	// 댓글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("num", num);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<Reply> listReply=service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// AJAX 용 페이징
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "free/listReply";
	}
	
	// 댓글 및 댓글의 답글 등록 : AJAX-JSON
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
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
	
	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
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
	
	 // 댓글의 답글 리스트 : AJAX-TEXT
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
		return "free/listReplyAnswer";
	}
	
	// 댓글의 답글 개수 : AJAX-JSON
	@RequestMapping(value="countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@RequestParam(value="answer") int answer
			) {
		
		int count=service.replyAnswerCount(answer);
		
		Map<String, Object> model=new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	// 댓글의 좋아요/싫어요 추가 : AJAX-JSON
	@RequestMapping(value="insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		String state="true";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> model=new HashMap<>();
		
		try {
			paramMap.put("userId", info.getUserId());
			service.insertReplyLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> countMap=service.replyLikeCount(paramMap);
				
		// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		
		model.put("likeCount", likeCount);
		model.put("state", state);
		return model;
	}

	// 댓글의 좋아요/싫어요 개수 : AJAX-JSON
	@RequestMapping(value="countReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		
		Map<String, Object> countMap=service.replyLikeCount(paramMap);
		// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		
		Map<String, Object> model=new HashMap<>();
		model.put("likeCount", likeCount);
			
		return model;
	}
}
