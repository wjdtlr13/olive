package com.olive.olive.auctionck;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.olive.common.FileManager;
import com.olive.olive.junggock.Image;

@Controller("auctionck.imageController")
@RequestMapping("/acimage/*")
public class ImageController {
	@Autowired
	private FileManager fileManager;
	
	@PostMapping("upload")
	@ResponseBody
	public Map<String, Object> fileUpload(Image dto, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"aimage";
		
		String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
		
				
		String cp = req.getContextPath();
		boolean uploaded = false;
		String url = null;
		if(saveFilename != null) {
			uploaded = true;
			url = cp+"/uploads/aimage/" + saveFilename;
			model.put("url", url);
			model.put("uploaded", uploaded);
			
		} else {
			model.put("error", "{\"message\":\"upload error !!!\"}");
			model.put("uploaded", uploaded);
		}
		
		return model;
				
	}
}
