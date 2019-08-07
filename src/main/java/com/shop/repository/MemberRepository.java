package com.shop.repository;

import com.shop.vo.Member;

public interface MemberRepository {

	void insertMember(Member member);

	Member selectMemberByIdAndPasswd(String memberId, String pwd);

	void updateMember(Member member);

}
