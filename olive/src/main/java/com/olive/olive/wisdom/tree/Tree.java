package com.olive.olive.wisdom.tree;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Tree {
	private int listNum;
	private int num;
	private String userId;
	private String subject;
	private String content;
	private int hitCount;
	private String created;
	private String selected;
	 
	private int imageNum;
	private String imageFileName;
	private List<MultipartFile> upload;
	
	private int articleLike;
	private int articleLikeCount;
	
	
	

	public void setArticleLikeCount(int articleLikeCount) {
		this.articleLikeCount = articleLikeCount;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public int getImageNum() {
		return imageNum;
	}

	public void setImageNum(int imageNum) {
		this.imageNum = imageNum;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public List<MultipartFile> getUpload() {
		return upload;
	}

	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}

	public int getArticleLike() {
		return articleLike;
	}

	public void setArticleLike(int articleLike) {
		this.articleLike = articleLike;
	}


	public int getArticleLikeCount() {
		return articleLikeCount;
	}

	

}
