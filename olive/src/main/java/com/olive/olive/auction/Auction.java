package com.olive.olive.auction;

public class Auction {
	
//	CREATE TABLE auction (
//			num NUMBER PRIMARY KEY
//			,userId VARCHAR2(50) NOT NULL
//			,subject VARCHAR2(500) NOT NULL
//			,price VARCHAR2(500) NOT NULL
//			,content CLOB NOT NULL
//			,created DATE DEFAULT SYSDATE
//			,startDate date not null
//			,endDate date not null
//			,hitCount NUMBER DEFAULT 0
//			,CONSTRAINT fk_auction_userId FOREIGN KEY(userId)
//			REFERENCES member1(userId)
//			);
	
	private int num, listNum;
	private String userId;
	private String userName;
	private String subject;
	private String price;
	private String content;
	private String created;
	private String startDate;
	private String endDate;
	private int hitCount;
	
	private int replyCount;
	private int auctionLikeCount;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
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

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	
	public int getReplyCount() {
		return replyCount;
	}
	
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	
	public int getAuctionLikeCount() {
		return auctionLikeCount;
	}

	public void setAuctionLikeCount(int auctionLikeCount) {
		this.auctionLikeCount = auctionLikeCount;
	}

	
	
}
