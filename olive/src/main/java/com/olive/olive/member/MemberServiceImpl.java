package com.olive.olive.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.olive.common.dao.CommonDAO;


@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
 @Autowired
 private CommonDAO dao;
 
@Override
public Member loginMember(String userId) {
	Member dto=null;
	
	try {
		dto=dao.selectOne("member.loginMember", userId);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	return dto;
}

@Override
public void insertMember(Member dto) throws Exception {
	try {
		long memberSeq = dao.selectOne("member.memberSeq");
		dto.setMemberIdx(memberSeq);
	
		dao.updateData("member.insertMember12", dto); // member1, member2 테이블 동시에 
	} catch (Exception e) {
		e.printStackTrace();
		throw e;
	}

}
@Override
public void updateMembership(Map<String, Object> map) throws Exception {
}
@Override
public void updateLastLogin(String userId) throws Exception {
	
}

@Override
public void updateMember(Member dto) throws Exception {
	
}

@Override
public Member readMember(String userId) {
	// TODO Auto-generated method stub
	return null;
}

@Override
public Member readMember(long memberIdx) {
	// TODO Auto-generated method stub
	return null;
}

@Override
public void deleteMember(Map<String, Object> map) throws Exception {
	
}


@Override
public int dataCount(Map<String, Object> map) {
	int result=0;
	return result;
}

@Override
public List<Member> listMember(Map<String, Object> map) {
	List<Member> list=null;

	return list;
}

@Override
public void generatePwd(Member dto) throws Exception {
	// TODO Auto-generated method stub
	
	}
}