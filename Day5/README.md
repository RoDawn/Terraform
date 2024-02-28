# DAY5 : 멀티존 3-Tier 구축하기

- 일자 : 2024-02-28
- 주제 : 테라폼으로 멀티존으로 load-balancer, mysql 구축하기
- 적용 중인 공부법 : 파인만

## 학습 목표
- Terraform을 이용해 단일 가용 영역에서 3-Tier 구축하기
- 멀티존 3-Tier 구축하기
 
## 0. 오늘의 실습 아키텍쳐
![image](https://github.com/RoDawn/Terraform/assets/143478463/a069c84e-fc90-4075-8848-a11f738c6e5f)
- web - was - mysql 구성
- alb 생성 후 web은 alb-tg으로 지정
- was는 4ea 생성
- bastion 서버를 생성해 별도의 관리 서버 구축



## 1. 테라폼 코드 작성
### 여러가지 변수 구성
![image](https://github.com/RoDawn/Terraform/assets/143478463/97efd542-c97d-431c-a386-962f6a57ec97)
- web - was - mysql 구성
- alb 생성 후 web은 alb-tg으로 지정
- was는 4ea 생성
- bastion 서버를 생성해 별도의 관리 서버 구축

### VPC 구축
![image](https://github.com/RoDawn/Terraform/assets/143478463/1dea6471-dff5-4235-9ee1-6c561a02d19a)
- 앞서 설정한 var.test 를 이용해 네이밍을 했다
![image](https://github.com/RoDawn/Terraform/assets/143478463/6f0d5e7a-ae0b-4496-8edb-a5a07918b794)

### Sbunet 구축
![image](https://github.com/RoDawn/Terraform/assets/143478463/06cd3316-83f2-4b45-b1d2-f31b430a4717)
![image](https://github.com/RoDawn/Terraform/assets/143478463/3f5929d4-4f6d-4584-9515-3eb0ae13fb1c)
- lb 전용 subnet 을 2개 생성했다. 1개는 alb 즉 외부 통신용, 1개는 nal 즉 내부 통신용이다
- bastion 을 별도로 구축하기 때문에 전부 private으로 subnet을 구성했다.
- 멀티존으로 구성할 계획이었기에 kr1, kr2 교차로 생성, count를 통해 갯수를 조정했다.
- var.test와 ${count.index} 를 이용해 생성될 때마다 네이밍을 설정했다.
![image](https://github.com/RoDawn/Terraform/assets/143478463/35c6c778-b66c-4932-b42e-3edeb1fe29d2)

### ACG 구축
![image](https://github.com/RoDawn/Terraform/assets/143478463/09105d65-1487-462e-b0a4-e6116db3c74f)
![image](https://github.com/RoDawn/Terraform/assets/143478463/893568c8-fe47-4d94-a63a-6434e4890d83)
![image](https://github.com/RoDawn/Terraform/assets/143478463/796ac612-6c45-4815-ad45-861b982ea82a)
- ACG는 총 4개를 생성했다. Manager, web, was, db
- Manager는 bastion 전용이다. 모든 서버에 Manger를 적용해서 편리하게 관리하기 위함이다.
- 나머지는 필요한 포트만 열어줬다.
- web 에서는 alb subnet 대역만, was에선 web subnet 대역만, db에선 was subnet 대역만이다.
![image](https://github.com/RoDawn/Terraform/assets/143478463/78c88c02-c82b-49d5-9299-e5c934f49e22)

### Server 구축
![image](https://github.com/RoDawn/Terraform/assets/143478463/95a4dbb6-da6e-4071-a4c7-006aee7a2b73)
![image](https://github.com/RoDawn/Terraform/assets/143478463/c31227d7-62ff-4a69-98e6-a7e4818208ac)
- bastion은 관리용으로 구축했다. 공인IP를 부여했다.
- web, was 모두 private에 구축했으며, count.index를 이용해 multi zone subnet에 교차로 구축되도록 설정했다.
- var 를 이용해 os와 product 를 관리했다
![image](https://github.com/RoDawn/Terraform/assets/143478463/f90479a1-1bd7-42ba-9971-dbe2a47f7805)

### lb 구축 
![image](https://github.com/RoDawn/Terraform/assets/143478463/30faf1e4-151d-4e0d-85d1-329182cdad5c)
![image](https://github.com/RoDawn/Terraform/assets/143478463/6dc1f5f5-adc3-4333-bff2-87ef342516f2)
- alb를 생성했고 tg에 web만 지정했다
![image](https://github.com/RoDawn/Terraform/assets/143478463/c496a65c-db70-4cb1-8b1d-56b62040b814)

### DB-MySQL 구축 
![image](https://github.com/RoDawn/Terraform/assets/143478463/34386778-eb62-4e4a-abaf-6f2da993fcac)
- 관리형 DB를 사용했다
- var를 이용해 mysql version과 product를 관리했다
![image](https://github.com/RoDawn/Terraform/assets/143478463/047d4994-5aa1-41d0-9da8-d7b03bed2bb3)



## 2. 트러블 슈팅 
![image](https://github.com/RoDawn/Terraform/assets/143478463/712f09f3-8877-4d38-8566-d1f9e9d614b6)
- server 를 구축 할 때, 기존의 설정은 subnet : server 가 짝맞게 구축되었었다.
- subnet은 추가 생성되지 않고 server만 교차로 subnet에 넣고 싶었다.
- 뤼튼을 이용해 수 없이 시도해 위와 같은 코드를 알아냈고 성공했다.
![image](https://github.com/RoDawn/Terraform/assets/143478463/9cd059b0-eac4-410b-9dd6-cfd9d0c490b1)
- lb tager 에 web을 넣고 싶었다.
- 현재 web은 count.index 를 이용해 작성했기에 이에 맞게 list를 적어줬야했다
- 그래서 for ~ in 구문이 사용되었다.
![image](https://github.com/RoDawn/Terraform/assets/143478463/10a06dcc-44bb-4652-97f8-d84f3af6671d)
- 서버 OS 와 스펙을 어떻게 알아내야하나.. 하다가 Terraform 공식문서에 data 를 뽑아내는 코드를 발견했다.
- 이를 활용하니 확인할 수 있었다




## 3. 다음 목표
- 구성된 깡통(?) 위에 Nginx, apache Tomcat 을 설치해서 연동하자


## 4. 참고했던 자료
https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/network_acl

