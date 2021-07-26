package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.QnaMapper;
import kr.or.profit.mapper.RecipeMapper;
import kr.or.profit.service.QnaService;
import kr.or.profit.service.RecipeService;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.QnaVO;

@Service("recipeService")
public class RecipeServicempl implements RecipeService {

	@Resource(name = "recipeMapper")
	private RecipeMapper mapper;

	//글목록
	@Override
	public List<Map<String, String>> recipeList(Criteria cri) throws Exception {
		System.out.println("서비스옴 글목록 " + cri);
		return mapper.recipeList(cri);
	}

	//글등록
	@Override
	public int recipeAddInsert(Map<String, Object> map) throws Exception {
		System.out.println("서비스옴 글등록 " + map);
		return mapper.recipeAddInsert(map);
	}

	//글상세보기
	@Override
	public Map<String, Object> recipeDetail(Map<String, Object> map) throws Exception {
		System.out.println("서비스옴 글상세보기 " + map);
		return mapper.recipeDetail(map);
	}

	//글수정
	@Override
	public int recipeModUpdate(Map<String, Object> map) throws Exception {
		System.out.println("서비스옴 글수정 " + map);
		return mapper.recipeModUpdate(map);
	}

	//글삭제
	@Override
	public int recipeDelete(Map<String, Object> map) throws Exception {
		System.out.println("서비스옴(삭제) = " + map);
		return mapper.recipeDelete(map);
	}

	//조회수
	@Override
	public int recipeCommonHit(Map<String, Object> map) throws Exception {
		return mapper.recipeCommonHit(map);
	}

	//댓글 등록
	@Override
	public int recipeReply(Map<String, Object> map) throws Exception {
		return mapper.recipeReply(map);
	}

	//댓글 목록
	@Override
	public List<?> recipeDetailReply(Map<String, Object> map) throws Exception {
		return mapper.recipeDetailReply(map);
	}

	//댓글 삭제
	@Override
	public int recipeReplyDelete(Map<String, Object> map) throws Exception {
		return mapper.recipeReplyDelete(map);
	}

	//대 댓글 등록
	@Override
	public int recipeReplyAdd(Map<String, Object> map) throws Exception {
		System.out.println("서비스옴(대댓글) = " + map);
		return mapper.recipeReplyAdd(map);
	}

	//대 댓글 목록
	@Override
	public List<?> recipeDetailReplyList(Map<String, Object> map) throws Exception {
		return mapper.recipeDetailReplyList(map);
	}

	//회원정보 확인
	@Override
	public Map<String, Object> recipeDetailMember(Map<String, Object> map) throws Exception {
		return mapper.recipeDetailMember(map);
	}

	//파일저장
	@Override
	public void imgFile(Map<String, Object> map) throws Exception {
		System.out.println("파일저장했다" + map);
		mapper.imgFile(map);

	}

	//파일이름 가지고옴
	@Override
	public String imgcnt() throws Exception {
		System.out.println("파일번호 온다");
		return mapper.imgcnt();
	}

	//인기글
	@Override
	public List<?> recipeTopList(String memberId) throws Exception {
		System.out.println("인기글 온다");
		return mapper.recipeTopList(memberId);
	}

	//최신글
	@Override
	public List<?> recipeNewList() throws Exception {
		System.out.println("최신글 온다");
		return mapper.recipeNewList();
	}

	//인기글(좋아요)
	@Override
	public List<?> recipeGoodList() throws Exception {
		System.out.println("인기글 온다");
		return mapper.recipeGoodList();
	}

	//목록 전부 (검색)
	@Override
	public List<?> recipeListKeyword(Map<String, Object> map) throws Exception {
		System.out.println("인기글 온다" + map);
		return mapper.recipeListKeyword(map);
	}

	//페이징
	@Override
	public int recipeSelectBoardCnt(Criteria cri) throws Exception {
		System.out.println("페이징 서비스 옴 = " + cri);
		return mapper.recipeSelectBoardCnt(cri);
	}

}
