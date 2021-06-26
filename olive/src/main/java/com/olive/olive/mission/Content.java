package com.olive.olive.mission;

import org.springframework.web.multipart.MultipartFile;

public class Content {
	private int contentNum;
	private int missionNum;
	private String userId;
	private String subject;
	private String content;
	private String startDate;
	private String endDate;
	private String attendContent;
	private String attendDate;
	private int accept;
	private String imageFileName;
	private MultipartFile upload;
	
	public int getContentNum() {
		return contentNum;
	}
	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}
	public int getMissionNum() {
		return missionNum;
	}
	public void setMissionNum(int missionNum) {
		this.missionNum = missionNum;
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
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getAttendContent() {
		return attendContent;
	}
	public void setAttendContent(String attendContent) {
		this.attendContent = attendContent;
	}
	public String getAttendDate() {
		return attendDate;
	}
	public void setAttendDate(String attendDate) {
		this.attendDate = attendDate;
	}
	public int getAccept() {
		return accept;
	}
	public void setAccept(int accept) {
		this.accept = accept;
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
	
	
	
}
