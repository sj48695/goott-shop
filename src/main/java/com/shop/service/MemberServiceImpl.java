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
		String pwd = Util.getHashedString(member.getPwd(), "SHA-256"); //패스워드 암호화 (복원불가능)
		member.setPwd(pwd); 
		memberRepository.insertMember(member);
		
	}

	@Override
	public Member selectMemberByIdAndPasswd(String memberId, String pwd) {
		pwd = Util.getHashedString(pwd, "SHA-256");
		Member member = memberRepository.selectMemberByIdAndPasswd(memberId, pwd);
		return member;
	}

	@Override
	public void updateMember(Member member) {
		String pwd = Util.getHashedString(member.getPwd(), "SHA-256");
		member.setPwd(pwd); 
		memberRepository.updateMember(member);	
	}

}
