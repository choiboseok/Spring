package com.future.my.board.dao;

import java.util.ArrayList;
import com.future.my.board.vo.BoardVO;
import com.future.my.board.vo.ReplyVO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBoardDAO {
	
	// 게시글 목록 조회
	public ArrayList<BoardVO> getBoardList();
	
	// 게시글 작성
	public int writeBoard(BoardVO board);
	
	// 게시글 상세조회
	public BoardVO getBoard(int boardNo); // 변수타입이 있는 변수일때는 xml에서의 변수 이름과 같아야 함
	
	// 게시글 수정 
	public int updateBoard(BoardVO board);
	
	// 게시글 삭제
	public int deleteBoard(BoardVO board);
	
	// 댓글 등록
	public int writeReply(ReplyVO vo);
	
	// 댓글 조회
	public ReplyVO getReply(String replyNo);
	
	// 댓글 목록 조회
	public ArrayList<ReplyVO> getReplyList(int boardNo);
	
	// 댓글 삭제
	public int delReply(String replyNo);
}