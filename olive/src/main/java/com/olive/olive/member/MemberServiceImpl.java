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
		Member dto = null;

		try {
			// 로그인을 위한 아이디, 패스워드 불러오기
			dto = dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			// 시퀀스 가져오기
			long memberSeq = dao.selectOne("member.memberidx_Seq");
			dto.setMemberIdx(memberSeq);

			// member1, member2 테이블 동시에 insert 하기
			dao.updateData("member.insertMember12", dto);
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
		int result = 0;
		return result;
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;

		return list;
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		// TODO Auto-generated method stub

	}
}