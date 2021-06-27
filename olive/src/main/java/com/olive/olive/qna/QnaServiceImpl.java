package com.olive.olive.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;
 

@Service("qna.qnaService")
public class QnaServiceImpl implements QnaService{

	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result =0;
		try {
			result = dao.selectOne("qna.dataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list = null;
		
		try {
			list = dao.selectList("qna.qnaList",map);
		} catch (Exception e) {
			e.printStackTrace();

		}				
		return list;
	}

	@Override
	public void insertQna(Qna dto) throws Exception {
		try {
			
			int seq =dao.selectOne("qna.seq");
			
			
			dto.setQnaNum(seq);
			
			dao.insertData("qna.insertQuestion",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	

	@Override
	public Qna readQna(int num) throws Exception {
		Qna dto = null;
		
		try {
			dto = dao.selectOne("qna.readQna", num);
		} catch (Exception e) {
			e.printStackTrace();

		}
		
		return dto;
	}

	@Override
	public Qna readAnswer(int parent) throws Exception {
		Qna dto = null;
		
		try {
			dto = dao.selectOne("qna.readAnswer", parent);
		} catch (Exception e) {
			e.printStackTrace();

		}
		
		return dto;
	}


	@Override
	public void deleteQuestion(int num) throws Exception {
		try {
			dao.deleteData("qna.deleteQuestion",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		
	}

	@Override
	public void insertAnswer(Qna dto) throws Exception {
		try {
			dao.updateData("qna.insertAnswer", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Qna preReadQna(Map<String, Object> map) {
		Qna dto = null;
		
		try {
			dto = dao.selectOne("qna.preReadQna", map);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return dto;
	}

	@Override
	public Qna nextReadQna(Map<String, Object> map) {
		Qna dto = null;
		
		try {
			dto = dao.selectOne("qna.nextReadQna", map);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.selectOne("qna.updateHitCount",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
	}

}
