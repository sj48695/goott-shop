package com.shop.repository;

import java.util.HashMap;

import com.shop.mapper.MemberMapper;
import com.shop.vo.Member;

public class MemberRepositoryImpl implements MemberRepository{
	
	private MemberMapper memberMapper;

	public MemberMapper getMemberMapper() {
		return memberMapper;
	}

	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	@Override
	public void insertMember(Member member) {
		memberMapper.insertMember(member);
		
	}

	@Override
	public Member selectMemberByIdAndPasswd(String memberId, String pwd) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("memberId", memberId);
		params.put("pwd", pwd);
		
		Member member = memberMapper.selectMemberByIdAndPasswd(params);
		return member;
	}

}
