package kr.or.profit.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

//페이징처리에 필요한 클래스 2번
public class PageMaker {

	private int totalCount; // 게시물의 총개수
	private int startPage; // 현재 페이지의 시작번호
	private int endPage; // 현재 페이지의 끝 번호
	private boolean prev; // 이전 페이지로 이동하는 링크의 존재 여부
	private boolean next; // 다음 페이지로 이동하는 링크의 존재여부

	// 페이지 1,2,3,4,5 5개로 제한하는 곳
	private int displayPageNum = 5;

	private Criteria cri;

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	// 민선
	// 계산하는 메서드
	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	// url 만드는 메서드--각자 조건에 맞춰 이 부분이 달라져야 합니다!!
	// 얘는 selCate, selLev, keyword 3개가 있을 때 사용하는 url maker
	// 자유게시판용, 큰 온라인클래스용
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("selCate", cri.getSelCate())
				.queryParam("selLev", cri.getSelLev())
				.queryParam("keyword", cri.getKeyword())
				.query("#location123").build();
		return uriComponents.toUriString();
	}

	// 북마크용 메서드
	public String makeQuerySimple(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("commonSeq", cri.getCommonSeq())
				.build();
		return uriComponents.toUriString();
	}
	
	// 관리자 회원관리 탭 리스트
	public String makeQueryAdminMember(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("selGubun", cri.getSelGubun())
				.queryParam("selStatus", cri.getSelStatus())
				.queryParam("selIdentity", cri.getSelIdentity())
				.build();
		return uriComponents.toUriString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 민정
	// 언니꺼
	public String makeQueryLesson(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("lessonSeq", cri.getLessonSeq()).build();

		return uriComponents.toUriString();
	}

	// 마이페이지 강의구매 리스트페이징
	public String makeQueryBuyLesson(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page).build();

		return uriComponents.toUriString();
	}

	
	//관리자 온라인클래스 목록 페이징
	public String makeQueryAdminLessonList(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page).build();

		return uriComponents.toUriString();
	}
	
	//관리자 온라인클래스 결제/환물 목록 페이징
		public String makeQueryAdminLessonPayList(int page) {
			UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page).build();

			return uriComponents.toUriString();
	}
		
	//관리자 온라인클래스 결제/환물 목록 페이징
			public String makeQueryAdminTicketPayList(int page) {
				UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page).build();

				return uriComponents.toUriString();
	}
			
	//관리자 정산하기 목록 페이징
	public String makeQueryAdminSalesList(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page).build();

		return uriComponents.toUriString();
	}
	
	//관리자 정산하기 상세 목록 페이징
	public String makeQueryAdminSalesDetailList(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page).build();

		return uriComponents.toUriString();
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	///////////////////////////////////////////////////////////////////////////////
	// 예진
	// 관리자 이용권 목록
	public String makeQueryAdminChat(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("selStatus", cri.getSelStatus()).queryParam("selDate", cri.getSelDate())
				.queryParam("selIdentity", cri.getSelIdentity()).queryParam("searchKeyword", cri.getSearchKeyword())
				.build();

		return uriComponents.toUriString();
	}
	
	// 칼로리 정보 목록
	public String makeQueryKal(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("searchKeyword", cri.getSearchKeyword())
				.build();

		return uriComponents.toUriString();
	}
	
	// 상담 프로필 목록
	public String makeQueryChatProfile(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.build();

		return uriComponents.toUriString();
	}
	
	// 트레이너 페이지 상담 목록
	public String makeQueryChatList(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("selStatus", cri.getSelStatus()).queryParam("selDate", cri.getSelDate())
				.build();

		return uriComponents.toUriString();
	}
	
	public String makeQueryBuyTicketList(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("selDate", cri.getSelDate())
				.queryParam("selTicketName", cri.getSelTicketName())
				.build();

		return uriComponents.toUriString();
	}
	
	public String makeQueryUseTicketList(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("selDate", cri.getSelDate())
				.queryParam("keyword", cri.getKeyword())
				.build();

		return uriComponents.toUriString();
	}

}