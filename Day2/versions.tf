# 네이버 클라우드 플랫폼 Provider의 버전을 설정
terraform {
  required_providers {
    ncloud = {
      source  = "navercloudplatform/ncloud"
    }
  }
  required_version = ">= 0.13"
}
