package kr.or.profit.vo;


public class KakaoProfile {

	private Integer id;
	private String connected_at;
	private Properties properties;
	private KakaoAccount kakao_account;

	public KakaoAccount getKakao_account() {
		return kakao_account;
	}

	public void setKakao_account(KakaoAccount kakao_account) {
		this.kakao_account = kakao_account;
	}

	public String getConnected_at() {
		return connected_at;
	}

	public void setConnected_at(String connected_at) {
		this.connected_at = connected_at;
	}
	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}



	public Properties getProperties() {
		return properties;
	}

	public void setProperties(Properties properties) {
		this.properties = properties;
	}



	
	
	public class Properties {

		private String nickname;
		private String profile_image;
		private String thumbnail_image;
		
		
		public String getProfile_image() {
			return profile_image;
		}

		public void setProfile_image(String profile_image) {
			this.profile_image = profile_image;
		}

		public String getThumbnail_image() {
			return thumbnail_image;
		}

		public void setThumbnail_image(String thumbnail_image) {
			this.thumbnail_image = thumbnail_image;
		}
		
		public String getNickname() {
			return nickname;
		}

		public void setNickname(String nickname) {
			this.nickname = nickname;
		}

		

	}
	
	
	
	
	
	
	
	
	
	
	public class KakaoAccount {

		public Boolean getProfile_nickname_needs_agreement() {
			return profile_nickname_needs_agreement;
		}
		public void setProfile_nickname_needs_agreement(Boolean profile_nickname_needs_agreement) {
			this.profile_nickname_needs_agreement = profile_nickname_needs_agreement;
		}
		public Boolean getProfile_image_needs_agreement() {
			return profile_image_needs_agreement;
		}

		public void setProfile_image_needs_agreement(Boolean profile_image_needs_agreement) {
			this.profile_image_needs_agreement = profile_image_needs_agreement;
		}

		public Profile getProfile() {
			return profile;
		}

		public void setProfile(Profile profile) {
			this.profile = profile;
		}

		public Boolean getHas_email() {
			return has_email;
		}

		public void setHas_email(Boolean has_email) {
			this.has_email = has_email;
		}


		public Boolean getEmail_needs_agreement() {
			return email_needs_agreement;
		}
		public void setEmail_needs_agreement(Boolean email_needs_agreement) {
			this.email_needs_agreement = email_needs_agreement;
		}


		public Boolean getIs_email_valid() {
			return is_email_valid;
		}

		public void setIs_email_valid(Boolean is_email_valid) {
			this.is_email_valid = is_email_valid;
		}

		public Boolean getIs_email_verified() {
			return is_email_verified;
		}

		public void setIs_email_verified(Boolean is_email_verified) {
			this.is_email_verified = is_email_verified;
		}



		public String getEmail() {
			return email;
		}


		public void setEmail(String email) {
			this.email = email;
		}

		private Boolean profile_nickname_needs_agreement;
		private Boolean profile_image_needs_agreement;
		private Profile profile;
		private Boolean has_email;
		private Boolean email_needs_agreement;
		private Boolean is_email_valid;
		private Boolean is_email_verified;
		private String email;

		
		
		
		
		

public class Profile {

	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getThumbnail_image_url() {
		return thumbnail_image_url;
	}
	public void setThumbnail_image_url(String thumbnail_image_url) {
		this.thumbnail_image_url = thumbnail_image_url;
	}
	public String getProfile_image_url() {
		return profile_image_url;
	}
	public void setProfile_image_url(String profile_image_url) {
		this.profile_image_url = profile_image_url;
	}
	public Boolean getIs_default_image() {
		return is_default_image;
	}
	public void setIs_default_image(Boolean is_default_image) {
		this.is_default_image = is_default_image;
	}
	private String nickname;
	private String thumbnail_image_url;
	private String profile_image_url;
	private Boolean is_default_image;


}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


