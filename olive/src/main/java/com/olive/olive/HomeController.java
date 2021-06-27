package com.olive.olive;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.APISerializer;
import com.olive.olive.common.MyUtil;
import com.olive.olive.free.Free;
import com.olive.olive.free.FreeService;
import com.olive.olive.junggo.Junggo;
import com.olive.olive.notice.Notice;
import com.olive.olive.notice.NoticeService;

@Controller
public class HomeController {

	@Autowired
	private FreeService freeService;	
	@Autowired
	private HomeService homeService;
	@Autowired
	private NoticeService noticeService;	
	@Autowired
	private APISerializer apiSerializer;
	@Autowired
	private MyUtil myutil;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("offset", 0);
		map.put("rows", 5);

		List<Notice> listNotice = noticeService.listNotice(map);
		List<Free> listFree = freeService.listFree(map);
		List<Junggo> listJunggo= homeService.listJunggo();
		
		for(Junggo dto:listJunggo) {
			List<String> list= myutil.getImgSrc(dto.getContent());
			if(list!=null && list.size()>0)
				dto.setImageFileName(list.get(0));
		}
		
		model.addAttribute("listNotice", listNotice);
		model.addAttribute("listFree", listFree);
		model.addAttribute("listJunggo",listJunggo);
		
		return ".home";
	}
	
	@RequestMapping(value = "/covid", produces = "applcation/json;charset=utf-8")
	@ResponseBody
	public String covid(@RequestParam String today, String position) throws Exception{
		String result = null;
		
		int numOfRows=30;
		int pageNo=1;

		String serviceKey="TJFg5dxh8LbDA1dpxrguxo1azxhj6PDvr7QFpuoAve6wumUrZRp%2BXVEiB2uRukOS4akAdEn0lig3TNhTlqEmQA%3D%3D";
		String spec ="http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson";
		spec+="?serviceKey="+serviceKey+"&numOfRows="+numOfRows+"&pageNo="+pageNo;
		spec+="&startCreateDt="+today+"&endCreateDt="+today;			
		
		System.out.println(spec);
		result = apiSerializer.receiveXmlToJson(spec);
		return result;
		
	}
}
