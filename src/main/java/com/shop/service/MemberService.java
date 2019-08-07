package com.shop.service;

import com.shop.vo.Member;

public interface MemberService {

	void insertMember(Member member);

	Member selectMemberByIdAndPasswd(String memberId, String pwd);

	void updateMember(Member member);

}
