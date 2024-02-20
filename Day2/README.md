# DAY2 : 테라폼으로 Subnet 구축하기

- 일자 : 2024-02-20
- 주제 : 테라폼으로 Subnet 구축하기
- 적용 중인 공부법 : 파인만

## 학습 목표
- Terraform을 이용해 단일 가용 영역에서 3-Tier 구축하기
- 오늘은 Subnet 구축해보기
 
## 0. 오늘의 실습 아키텍쳐
![image](https://github.com/RoDawn/Terraform/assets/143478463/fa35cd0f-4542-4d8c-8d45-2ee496feb2c9)




## 1. 테라폼 코드 작성
![image](https://github.com/RoDawn/Terraform/assets/143478463/988652f3-69ba-4ff3-ac10-64f9f2c4778a)
- versions.tf를 통해 네이버 클라우드 플랫폼의 Provider 버전을 설정했다

![image](https://github.com/RoDawn/Terraform/assets/143478463/f8a04967-7aed-461c-b3bf-f524eda55622)
- vpc.tf 에서 vpc와 nacl을 생성했다.
- 여기서 nacl의 경우 'main' 이라는 새로운 nacl을 설정해주었다.
- subnet을 생성할 때, 옵션이 두 가지가 있었다. defaul nacl을 적용하느냐, 새로만든 것을 적용하느냐

![image](https://github.com/RoDawn/Terraform/assets/143478463/2052dbc6-e382-4384-9736-9f819f3291af)
![image](https://github.com/RoDawn/Terraform/assets/143478463/04039d09-3374-4058-affe-60a40a96c26a)
- 이를 '뤼튼' 에 물어봤고, 적용해봤다.


## 2. 결과
![스크린샷 2024-02-20 111514](https://github.com/RoDawn/Terraform/assets/143478463/67d8933d-f83c-4500-a1e1-7167ccd0b1cb)
![스크린샷 2024-02-20 111527](https://github.com/RoDawn/Terraform/assets/143478463/f5b1787f-be84-486b-8c84-7fa466ce8e0b)
- 내가 만든 Public, Private Subet에 별개의 NACL 성공!


## 3. 다음 목표
- ACG 생성 후 Rule 설정
- VM 1EA 생성


## 4. 참고했던 자료
https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/network_acl
