# IaC를 활용한 AWS 인프라 구축
  Terraform File을 작성하여 AWS 인프라를 구축 및 3-Tier 웹 서비스 운영

## 🗓️ 진행 기간
- 2022.10.17 ~ 2022.10.21

</br>

## 👥 팀 구성
- Infra 구축 1명

</br>

## ⚙️ 사용 기술
#### CSP
<img src="https://img.shields.io/badge/Amazon AWS-232F3E?style=for-the-badge&logo=Amazon AWS&logoColor=white"> <!--AWS-->
#### IaC
<img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=Terraform&logoColor=white"> <!--Terraform--> 
#### Team Collabolation Tool
<img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white"> <!--Notion-->
<img src="https://img.shields.io/badge/Drawio-000000?style=for-the-badge&logo=Drawio&logoColor=white"> <!--Draw.io-->

</br>

## 📝 상세 내용 
### Infra Architecture
![aws terraform architecture](https://user-images.githubusercontent.com/117608997/215544478-e61a2989-b44c-4a55-9c3f-f56571a4c6d0.jpg)
> - 관리자는 클라우드 기반 IDE인 Cloud9을 사용해 Terraform으로 AWS Infra를 구축
> - 고객은 Route53에 등록된 도메인을 통해 3-Tier 웹 서비스 이용

</br>

## ⛓️ 구축 과정
### 🔗 Notion Link
#### [AWS Terraform Project](https://glen-party-257.notion.site/AWS-Terraform-Project-77b1eb82a2d74ec9a0aee5130734d885)


</br>

## 🙋🏻‍♂️ 담당 업무
- Provider tf 파일 작성
    - Terraform 버전 및 공급자 구성
- vpc tf 파일 작성 VPC 구성
    - Internet_gateway 구성
    - Public/Private Subnet 구성
    - subnet 생성 후 routing_table 구성 및 연동
- variable.tf을 작성 및 변수 활용
- RDS tf 파일 작성 및 DB 구성
- Ec2 tf 파일 작성 및 보안그룹, 인스턴스 구성
    - Web/Was 인스턴스 생성
    - Web Was 보안그룹 생성
- WEB/WAS/DB를 연동하여 3-Tier 구성
- AMI tf 파일 작성 및 이미지 생성
- ALB tf 파일 작성 및 ALB 정책 구성
    - 보안그룹, 대상그룹, 리스너 정의 구성
- AS tf 파일 작성 및 Auto Scaling 정책 구성
    - 시작구성, Autoscaling Group, 정책 구성
