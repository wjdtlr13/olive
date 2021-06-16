package com.olive.olive.qna;

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


@Controller("qna.qnaController")
@RequestMapping("/qna/*")
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "")String keyword,
			HttpServletRequest req,
			Model model ) throws Exception {
		
		int rows=10;
		int total_page;
		int dataCount;
		
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);		
        
        List<Qna> list = service.listQna(map);
        
		// 글번호 만들기
		int listNum, n = 0;
		for(Qna dto:list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}       
        String cp = req.getContextPath();
        String query="";
        String listUrl=cp+"/qna/list";
        String articleUrl=cp+"/qna/article?page="+current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	         "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/qna/list?" + query;
        	articleUrl = cp+"/qna/article?page=" + current_page + "&"+ query;
        }		

		
        String paging = myUtil.paging(current_page, total_page, listUrl);
        
        model.addAttribute("list",list);
        model.addAttribute("dataCount",dataCount);
        model.addAttribute("page",current_page);
        model.addAttribute("total_page",total_page);
        model.addAttribute("articleUrl",articleUrl);
        model.addAttribute("paging",paging);
        model.addAttribute("condition",condition);
        model.addAttribute("keyword",keyword);

		return ".qna.list";
	}
	
	
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {
		
		model.addAttribute("mode","created");
		
		return ".qna.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String createdSubmit(
			Qna dto,
			HttpSession session		
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		try {
			dto.setQuestionId(info.getUserId());
			service.insertQna(dto);
		} catch (Exception e) {
		
		}
		
		return "redirect:/qna/list";
	}
	
	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(
			@RequestParam int qnaNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			
			HttpSession session,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}		
		Qna dto = service.readQna(qnaNum);
		
		if(dto==null) {
			return "redirect:/qna/list?query="+query;
		}
		
		dto.setQuestionContent(dto.getQuestionContent().replaceAll("\n", "<br>"));
		if(dto.getAnswerContent()!=null) {
			dto.setAnswerContent(dto.getAnswerContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("dto",dto);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
				
		return ".qna.article";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Qna dto = service.readQna(num);
		if(dto==null) {
			return "redirect:/qna/list?page="+page;
		}

		if(! info.getUserId().equals(dto.getQuestionId())) {
			return "redirect:/qna/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		
		return ".qna.created";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Qna dto, 
			@RequestParam String page,
			HttpSession session) throws Exception {
		

		try {
			service.updateQuestion(dto);		
		} catch (Exception e) {
		}
		
		return "redirect:/qna/list?page="+page;
	}	
	
	// AJAX -  답변 등록
	@RequestMapping(value="writeAnswer")
	public Map<String, Object> insertAnswer(
			Qna dto,
			HttpSession session			
			) throws Exception {
		
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		

		SessionInfo info = (SessionInfo)session.getAttribute("member");

		dto.setAnswerId(info.getUserId());

		try {
			service.insertAnswer(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return model;
	}
	
	
	
	
	
	
	

}
