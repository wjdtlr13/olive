package com.olive.olive.wisdom.tree;

import org.springframework.web.multipart.MultipartFile;

public class Tree {
	private int listNum;
	private int num;
	private String userId;
	private String nickName;
	private String subject;
	private String content;
	private int hitCount;
	private String created; 
	private String selected;

	private String categoryNum;
	private String category;
	
	private int wisdomLikeCount; 
	private int replyCount;
	
	private int imageNum;
	private String imageFileName; 
	private MultipartFile upload;
	
	private int articleLike; 
	private int articleLikeCount;	
	
	public int getWisdomLikeCount() {
		return wisdomLikeCount;
	}
	public void setWisdomLikeCount(int wisdomLikeCount) {
		this.wisdomLikeCount = wisdomLikeCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(String categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
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

	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
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
	public void setArticleLikeCount(int articleLikeCount) {
		this.articleLikeCount = articleLikeCount;
	}
	
	
	

}
