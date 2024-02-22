# DAY3 : 테라폼으로 ACG, VM 구축하기

- 일자 : 2024-02-22
- 주제 : 테라폼으로 ACG, VM 구축하기
- 적용 중인 공부법 : 파인만

## 학습 목표
- Terraform을 이용해 단일 가용 영역에서 3-Tier 구축하기
- 오늘은 ACG, VM
 
## 0. 오늘의 실습 아키텍쳐
![image](https://github.com/RoDawn/Terraform/assets/143478463/5e1de864-a61f-44b0-a711-411e2c600018)


## 1. 테라폼 코드 작성
![image](https://github.com/RoDawn/Terraform/assets/143478463/67324bf6-9f56-4466-bf28-dcf16736551c)
- ACG 를 생성 후 인바운드, 아웃바운드 RULE을 추가했다.
- manager, web, was, db 용 acg를 각각 작성했다


![image](https://github.com/RoDawn/Terraform/assets/143478463/6a66cfdb-5faa-4876-ba2c-0412b28c4a9d)
- Day2에선 'subnet' 에 CIDR을 그대로 입력했으나, cidrsubnet 이라는 규칙을 이용해보고자 한다.
- 지금 이해하기론 어떤 규칙을 이용해 맨 끝에 있는 숫자만 바꾸면 되는 것 같다
- 차후 카운트 함수를 이용한다면 같은 대역대에 여러개의 서브넷을 편하게 생성할 수 있을 듯 하다

![image](https://github.com/RoDawn/Terraform/assets/143478463/92718b26-1172-429d-82ad-c652f0ab1cf7)
- VM 생성을 위한 서버 코드를 작성했다.
- Lloginkey도 작성했다.
- NIC를 생성한 뒤, acg, public ip를 부착했다.





## 2. 결과
![image](https://github.com/RoDawn/Terraform/assets/143478463/3412ee9d-1acd-4f89-924c-5a5d29bb9784)
- web, was, db 용의 acg가 생성 되었고, 의도했던대로 인바운드/아웃바운드 적용 완료




## 3. 트러블 슈팅
![image](https://github.com/RoDawn/Terraform/assets/143478463/74754cf7-3579-4873-b767-0da8d4c97d6a)
- resource나 name에 들어가는 영어는 대문자는 안된다
- 인바운드에서 나의 ip를 짚어넣었는데 오류가 났었다. 이를 /32 를 넣어줬다.

![image](https://github.com/RoDawn/Terraform/assets/143478463/00491313-0101-4878-938e-6705455b48c1)
- 테라폼으로 ACG Rule을 설정할 때 HTTP 프로토콜을 사용하지 못 하는 듯 하다.. 왜일까?
- 그래서 TCP /80으로 열었다

![image](https://github.com/RoDawn/Terraform/assets/143478463/385c9ca2-24ab-4520-b26e-7823b779e844)
![image](https://github.com/RoDawn/Terraform/assets/143478463/f01d3596-8335-4124-927f-07a8c2857eb0)
- VM 완료
- 서브넷, 인증키, OS, 공인 IP, NIC, ACG 모두 완료



## 4. 다음 목표
- 멀티존으로 WEB-WAS, 구성하기


## 5. 참고했던 자료
https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/network_acl
