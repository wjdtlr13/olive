package com.olive.olive.qna;

public class Qna {
	private int listNum; 
	private int qnaNum;
	private String subject;
	private String questionContent;
	private String questionId;
	private String nickName;
	private String questioncreated;
	private String answerId;
	private String answerContent;
	private String answercreated;
	private String hitCount;
	
	
	
	public String getHitCount() {
		return hitCount;
	}



	public void setHitCount(String hitCount) {
		this.hitCount = hitCount;
	}



	public int getListNum() {
		return listNum;
	}
	
	
	
	public String getNickName() {
		return nickName;
	}



	public void setNickName(String nickName) {
		this.nickName = nickName;
	}



	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getQuestionContent() {
		return questionContent;
	}
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	public String getQuestionId() {
		return questionId;
	}
	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	public String getQuestioncreated() {
		return questioncreated;
	}
	public void setQuestioncreated(String questioncreated) {
		this.questioncreated = questioncreated;
	}
	public String getAnswerId() {
		return answerId;
	}
	public void setAnswerId(String answerId) {
		this.answerId = answerId;
	}
	public String getAnswerContent() {
		return answerContent;
	}
	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}
	public String getAnswercreated() {
		return answercreated;
	}
	public void setAnswercreated(String answercreated) {
		this.answercreated = answercreated;
	}
}
