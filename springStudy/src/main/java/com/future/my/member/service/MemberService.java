package com.future.my.member.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.future.my.member.dao.IMemberDAO;
import com.future.my.member.vo.MemberVO;

@Service // 비즈니스 로직을 처리하는 계층
public class MemberService {
	@Autowired // spring 의존성 주입DI(dependency injection) 자동처리
			   // 스프링이 빈(bean)을 자동으로 관리 
	IMemberDAO dao;
	
	public void registMember(MemberVO vo) throws DuplicateKeyException, // ID 중복시에 발생 할 수 있는 오류시
												 DataAccessException,   // 입력값, DB에 맞지않는, DB 접속 오류시
												 Exception {
		int result = dao.registMember(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	
	public MemberVO loginMember(MemberVO vo) throws Exception {
		MemberVO user = dao.loginMember(vo);
		System.out.println(user);
		if(user == null) {
			throw new Exception();
		}
		return user;
	}
	
	public String profileUpload(MemberVO vo, String uploadDir, String webPath, MultipartFile file) throws Exception { // 사용자 정보, 서버 파일 위치, 웹페이지 사용 경로, 저장 파일 
		// 파일명 생성
		String origin = file.getOriginalFilename(); // 파일명 가져오기
		String unique = UUID.randomUUID().toString() + " " + origin; // 유니크하게 파일 만들기
		String dbPath = webPath + unique; // 경로 + 유니크한 파일명 (DB에 경로 저장)
		Path filePath = Paths.get(uploadDir, unique);
		
		// 서버에 물리적으로 저장
		try {
			Files.copy(file.getInputStream(), filePath); // 서버에 저장
		} catch (IOException e) {
			throw new Exception("file to save the tile", e);
		}
		
		// db 저장
		vo.setProfileImg(dbPath);
		int result = dao.profileUpload(vo);
		if(result == 0) {
			throw new Exception();
		}
		
		return dbPath;
	}
}
