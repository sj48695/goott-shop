package com.shop.service;

import com.shop.common.Util;
import com.shop.repository.MemberRepository;
import com.shop.vo.Member;

public class MemberServiceImpl implements MemberService{
	
	private MemberRepository memberRepository;

	public MemberRepository getMemberRepository() {
		return memberRepository;
	}

	public void setMemberRepository(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	@Override
	public void insertMember(Member member) {
		memberRepository.insertMember(member);
		
	}

	@Override
	public Member selectMemberByIdAndPasswd(String memberId, String pwd) {
		pwd = Util.getHashedString(pwd, "SHA-256");
		Member member = memberRepository.selectMemberByIdAndPasswd(memberId, pwd);
		return member;
	}

}
