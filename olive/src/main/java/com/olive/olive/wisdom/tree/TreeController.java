package com.olive.olive.wisdom.tree;

import java.io.File;

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

import com.olive.olive.common.FileManager;
import com.olive.olive.common.MyUtil;
import com.olive.olive.member.SessionInfo;

@Controller("wisdom.treeController")
@RequestMapping("/wisdom/*")
public class TreeController {
	
	@Autowired
	private TreeService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	
	@RequestMapping("list")
	public String listWisdom(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(required=false) String categoryNum,
			HttpServletRequest req,
			Model model
			)throws Exception {
		String cp = req.getContextPath();
		 
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		int rows=5;
		int total_page;
		int dataCount;

		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}		
		
		//전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(categoryNum!=null) {
			int cNum = Integer.parseInt(categoryNum);
        	map.put("categoryNum", cNum);
        }		
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		total_page=myUtil.pageCount(rows, dataCount);
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		int offset =(current_page-1)*rows;
		if(offset<0) offset=0;
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Tree> list = service.listWisdom(map);
		
        // 리스트의 번호
        int listNum, n = 0;
        for(Tree dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
		
        String query = "";
        String listUrl = cp+"/wisdom/list";
        String articleUrl = cp+"/wisdom/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        	if(categoryNum!=null) {
        		query+="&categoryNum="+categoryNum;
        	}
        }else if(categoryNum!=null) {
        	query="categoryNum="+categoryNum;
        }
        
        
        if(query.length()!=0) {
        	 listUrl = cp+"/wisdom/list"+query;
        	 articleUrl = cp+"/wisdom/article?page=" + current_page+"&"+ query;
        }
        
        
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
        List<Category> categoryList = service.listCategory();
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);		
		
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("categoryNum", categoryNum);		
        
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);		
		
		return ".wisdom.treeList";
		
	}
	
	
	@RequestMapping(value = "created", method = RequestMethod.GET)
	public String createForm(Model model) throws Exception {
		model.addAttribute("mode","created");
		
		
		return ".wisdom.treeCreated";
	}
	
	
	@RequestMapping(value = "created", method = RequestMethod.POST)
	public String createdSubmit(
			Tree dto,
			HttpSession session
			) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"wisdom";		
		
		SessionInfo info =(SessionInfo) session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertWisdom(dto, path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redireck:/wisdom/list";
	}
	
	@RequestMapping(value = "article",method = RequestMethod.GET)
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session,
			Model model
			) throws Exception{
		
		SessionInfo info =(SessionInfo) session.getAttribute("member");
				
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		
		
		Tree dto = service.readWisdom(num);
		if (dto == null)
			return "redirect:/wisdom/list?"+query;		
		

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		//이미지 불러오기
		List<Tree> listImg=service.listImg(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listImg",listImg);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".wisdom.treeArticle";
	}
	
	
	// 게시글 좋아요 추가 -> AJAX-JSON으로..
	@RequestMapping(value="insertWisdomLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertWisdomLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int wisdomLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertWisdomLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		wisdomLikeCount = service.wisdomLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("wisdomLikeCount", wisdomLikeCount);
		
		return model;
	}	
	
	
	
	//게시글 열매로 옮기기
	@RequestMapping("beanList")
	public String listBeen(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		String cp = req.getContextPath();
		 
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		int rows=5;
		int total_page;
		int dataCount;

		
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}		
		
		//전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("selected","y");
		
		dataCount = service.dataCount(map);
		
		total_page=myUtil.pageCount(rows, dataCount);
		
		if(total_page<current_page) {
			current_page=total_page;
		}
		
		int offset =(current_page-1)*rows;
		if(offset<0) offset=0;
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		
		List<Tree> list = service.listWisdom(map);
		
		
        // 리스트의 번호
        int listNum, n = 0;
        for(Tree dto : list) {
            listNum = dataCount - (offset + n);
            dto.setListNum(listNum);
            n++;
        }
		
        String query = "";
        String listUrl = cp+"/wisdom/beanList";
        String articleUrl = cp+"/wisdom/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);		
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);		
		
		
		return ".wisdom.beanList";
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
		
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "wisdom/listReply";
	}	
	
	//댓글 등록
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
	
	// 댓글의 좋아요추가 ->json
	@RequestMapping(value="insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam int replyNum,
			HttpSession session
			) {
		String state="true";
		int replyLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> paramMap=new HashMap<>();
		
		try {
			paramMap.put("userId", info.getUserId());
			paramMap.put("replyNum", replyNum);
			service.insertReplyLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		replyLikeCount =service.replyLikeCount(replyNum);
				
		Map<String, Object> model=new HashMap<>();
	
		model.put("replyLikeCount", replyLikeCount);
		model.put("state", state);
		
		return model;
	}
	
	//댓글의 좋아요 개수
	@RequestMapping(value = "countReplyLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@RequestParam int replyNum,
			HttpSession session
			) {
		
		int replyLikeCount=service.replyLikeCount(replyNum);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("replyLikeCount",replyLikeCount);
		
		return model;
	}
	
	
	
	
	
	
	
}
