package com.olive.olive.qna;

import java.util.List;
import java.util.Map;
 
public interface QnaService {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Qna> listQna(Map<String, Object> map);
	public void insertQna(Qna dto) throws Exception;
	public Qna readQna(int num) throws Exception;
	public Qna readAnswer(int parent) throws Exception;
	
	public Qna preReadQna(Map<String, Object> map);
	public Qna nextReadQna(Map<String, Object> map);
	
	public void updateHitCount(int num) throws Exception;

	public void deleteQuestion(int num) throws Exception;
	public void insertAnswer(Qna dto) throws Exception;

}
