//
//  Speaking04ViewModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 8/16/24.
//

import Foundation

struct Speaking04ViewModel {
    /// 대화주제
    let subTopic: SpeakingSubTopic
    
    /// 대화주제별 한국어 표현집
    var expressionSet: [ChatMessage] {
        switch subTopic {
        // MARK: 가족 소개하기
        case .family_introduce:
            return [
                ChatMessage(role: .ex_model, message: "가족이 몇 명이신가요?"),
                ChatMessage(role: .ex_user, message: "다섯 명이요"),
                ChatMessage(role: .ex_model, message: "가족이 많으시네요! 부모님, 형제자매 다섯 분이신가요?"),
                ChatMessage(role: .ex_user, message: "네. 부모님이랑 동생 하나 언니 한 명이 있어요."),
                ChatMessage(role: .ex_model, message: "아, 그렇군요! 가족 구성원이 참 보기 좋네요. 부모님은 무슨 일을 하시는지 여쭤봐도 될까요?"),
                ChatMessage(role: .ex_user, message: "부모님은 농사를 지으세요"),
                ChatMessage(role: .ex_model, message: "아, 농사를 지으시는구나! 멋지네요. 그럼 언니와 동생과는 나이차이가 어떤가요?"),
                ChatMessage(role: .ex_user, message: "언니랑은 몇 살 차이 안나는데 동생이랑은 나이차이가 많이 나요."),
                ChatMessage(role: .ex_model, message: "동생이랑 나이 차이가 많이 나는 편이라면, 동생을 챙기는 일이 많겠네요."),
                ChatMessage(role: .ex_user, message: "맞아요. 동생이 정말 귀여워요."),
                ChatMessage(role: .ex_model, message: "정말 화목한 가족이네요!")
            ]
        
        // MARK: 선생님과 대화하기
        case .school_teacher:
            return [
                ChatMessage(role: .ex_model, message: "요새 학교 생활은 어때요?"),
                ChatMessage(role: .ex_user, message: "힘들어요."),
                ChatMessage(role: .ex_model, message: "힘들다고? 왜 그래? 무슨 일이 있었어요?"),
                ChatMessage(role: .ex_user, message: "한국생활이 낯설어서 적응하는데에 힘이 드는 것 같아요."),
                ChatMessage(role: .ex_model, message: "그렇구나. 어떤 부분이 제일 힘들어요? 혹시 친구 사귀는 게 어려운가요?"),
                ChatMessage(role: .ex_user, message: "네. 한국어 실력이 미숙하다 보니까 친구랑 대화하는 것이 어렵더라고요."),
                ChatMessage(role: .ex_model, message: "그럴 수 있지. 한국어 공부는 잘 되고 있어요? 수업 내용이 어려운 부분은 없어요?"),
                ChatMessage(role: .ex_user, message: "네. 그래도 선생님께서 잘 알려주셔서 어려움은 없어요."),
                ChatMessage(role: .ex_model, message: "그래, 오늘 이야기 들려줘서 고마워요. 다음에 궁금한 점 있으면 언제든지 물어보러 와줘요.")
            ]
        
        // MARK: 처음 보는 학생과 대화하기
        case .school_stranger:
            return [
                ChatMessage(role: .ex_model, message: "내일 챙겨와야 하는 준비물이 뭐야?"),
                ChatMessage(role: .ex_user, message: "연필이랑 공책 챙겨와야 해."),
                ChatMessage(role: .ex_model, message: "그렇구나. 숙제는 다 했어?"),
                ChatMessage(role: .ex_user, message: "아직 다 못했어."),
                ChatMessage(role: .ex_model, message: "혹시 어떤 부분이 어려워? 혹시 내가 도와줄 수 있는 부분이 있으면 말해줘."),
                ChatMessage(role: .ex_user, message: "맞춤법이 가장 어려워"),
                ChatMessage(role: .ex_model, message: "맞춤법, 정말 어렵지. 나도 가끔 헷갈릴 때가 있어. 그래도 꾸준히 공부하다 보면 자연스럽게 익혀질거야! 혹시 좋아하는 취미나 관심사는 뭐야?"),
                ChatMessage(role: .ex_user, message: "피아노 치는 것을 좋아해."),
                ChatMessage(role: .ex_model, message: "피아노! 나도 좋아하는데. 앗, 쉬는시간이 벌써 끝났네. 이따가 이어서 이야기하자.")
            ]     
            
        // MARK: 날씨에 대해 이야기하기
        case .weatherSeason_weather:
            return [
                ChatMessage(role: .ex_model, message: "오늘 날씨가 어떤가요?"),
                ChatMessage(role: .ex_user, message: "흐리고 비가 올 것 같아요."),
                ChatMessage(role: .ex_model, message: "그럼 따뜻하게 옷 입으셔야겠어요. 감기에 걸리기 쉬운 날씨니까요. 혹시 오늘 외출 계획 있으신가요?"),
                ChatMessage(role: .ex_user, message: "아니요 날이 좋지 않아 외출은 안 하려구요."),
                ChatMessage(role: .ex_model, message: "그렇군요. 비 오는 날에는 따뜻한 차 한 잔 마시면서 책 읽는 것도 좋잖아요. 혹시 비 오는 날 좋아하는 활동이 있으신가요?"),
                ChatMessage(role: .ex_user, message: "저도 비 오는 날 창밖을 보며 차를 마시는 걸 좋아해요. 특히 비 오는 날에는 빗소리도 참 좋잖아요."),
                ChatMessage(role: .ex_model, message: "이런 날씨에 주의해야 할 점이 무엇이 있을까요?"),
                ChatMessage(role: .ex_user, message: "미끄러지기 쉬우니까 조심히 걸어야 해요. 비가 오면 습도가 높아져서 곰팡이가 생기기 쉬우니 집안 환기도 자주 시켜야 해요."),
                ChatMessage(role: .ex_model, message: "맞아요. 빗길 운전은 더욱 주의하셔야 해요")
            ]
            
        // MARK: 계절에 대해 이야기하기
        case .weatherSeason_Season:
            return [
                ChatMessage(role: .ex_model, message: "가족이 몇 명이신가요?"),
                ChatMessage(role: .ex_user, message: "다섯 명이요"),
                ChatMessage(role: .ex_model, message: "가족이 많으시네요! 부모님, 형제자매 다섯 분이신가요?"),
                ChatMessage(role: .ex_user, message: "네. 부모님이랑 동생 하나 언니 한 명이 있어요."),
                ChatMessage(role: .ex_model, message: "아, 그렇군요! 가족 구성원이 참 보기 좋네요. 부모님은 무슨 일을 하시는지 여쭤봐도 될까요?"),
                ChatMessage(role: .ex_user, message: "부모님은 농사를 지으세요"),
                ChatMessage(role: .ex_model, message: "아, 농사를 지으시는구나! 멋지네요. 그럼 언니와 동생과는 나이차이가 어떤가요?"),
                ChatMessage(role: .ex_user, message: "언니랑은 몇 살 차이 안나는데 동생이랑은 나이차이가 많이 나요."),
                ChatMessage(role: .ex_model, message: "동생이랑 나이 차이가 많이 나는 편이라면, 동생을 챙기는 일이 많겠네요."),
                ChatMessage(role: .ex_user, message: "맞아요. 동생이 정말 귀여워요."),
                ChatMessage(role: .ex_model, message: "정말 화목한 가족이네요!")
            ]
            
        // MARK: 여행 계획 이야기하기
        case .travel_plan:
            return [
                ChatMessage(role: .ex_model, message: "여행 계획이 있으신가요?"),
                ChatMessage(role: .ex_user, message: "네, 여름에 제주도로 여행갈거에요."),
                ChatMessage(role: .ex_model, message: "와, 좋은 계획이시네요. 누구랑 여행 가시나요?"),
                ChatMessage(role: .ex_user, message: "친구 두 명이랑 같이 가요."),
                ChatMessage(role: .ex_model, message: "멋지네요. 얼마나 머무르시나요?"),
                ChatMessage(role: .ex_user, message: "2박 3일이에요."),
                ChatMessage(role: .ex_model, message: "어디를 둘러볼 계획이세요?"),
                ChatMessage(role: .ex_user, message: "한라산이랑 우도에 가볼거에요."),
                ChatMessage(role: .ex_model, message: "한라산 등반이랑 우도 여행이라니, 정말 알차게 계획하셨네요! 즐거운 여행 되시길 바라요!")
            ]    
            
        // MARK: 여행 경험 이야기하기
        case .travel_experience:
            return [
                ChatMessage(role: .ex_model, message: "여행가는 걸 좋아하시나요?"),
                ChatMessage(role: .ex_user, message: "네, 좋아해요"),
                ChatMessage(role: .ex_model, message: "그렇군요! 어떤 나라를 가보셨나요?"),
                ChatMessage(role: .ex_user, message: "베트남 다낭에 가봤어요"),
                ChatMessage(role: .ex_model, message: "다낭이요! 다낭은 바다도 예쁘고 맛있는 음식도 많죠. 다낭에서 어떤 걸 하셨나요?"),
                ChatMessage(role: .ex_user, message: "반미도 먹고 대성당도 가봤어요"),
                ChatMessage(role: .ex_model, message: "반미 맛있었겠어요! 다낭 대성당도 멋지죠. 가장 좋았던 기억은 무엇인가요?"),
                ChatMessage(role: .ex_user, message: "음식도 너무 맛있었고 새로운 곳을 구경하는 게 정말 재미있었어요."),
                ChatMessage(role: .ex_model, message: "정말 즐거운 여행이었군요! 저도 다낭에 꼭 가보고 싶네요!")
            ]
        
        // MARK: 카페에서 주문하기
        case .shopping_cafe:
            return [
                ChatMessage(role: .ex_model, message: "어서오세요. 주문하시겠어요?"),
                ChatMessage(role: .ex_user, message: "추천해주실 수 있나요?"),
                ChatMessage(role: .ex_model, message: "오늘 날씨가 쌀쌀한데 따뜻한 차 어떠세요?"),
                ChatMessage(role: .ex_user, message: "좋아요. 마침 따뜻한 음료를 먹고싶었어요. 차는 무슨 종류가 있나요?"),
                ChatMessage(role: .ex_model, message: "저희는 홍차, 녹차, 허브차, 과일차를 준비하고 있어요. 어떤 종류가 드시고 싶으세요?"),
                ChatMessage(role: .ex_user, message: "홍차는 무슨 맛인가요?"),
                ChatMessage(role: .ex_model, message: "저희 홍차는 떫은 맛이 적고 향긋한 향이 특징이에요."),
                ChatMessage(role: .ex_user, message: "그럼 홍차 작은 사이즈로 하나 주세요. 먹고 갈게요."),
                ChatMessage(role: .ex_model, message: "총 4,500원입니다. 현금으로 계산하시겠어요?")
            ]        
            
        // MARK: 옷가게에서 쇼핑하기
        case .shopping_cloth:
            return [
                ChatMessage(role: .ex_model, message: "어서오세요. 필요한 게 있으면 말씀해주세요."),
                ChatMessage(role: .ex_user, message: "다음주 모임이 있는데 옷 좀 사려구요."),
                ChatMessage(role: .ex_model, message: "아, 다음 주 모임이 있으시군요! 어떤 스타일의 옷을 찾으시는지 알려주시면 옷 찾는 데 도움을 드릴 수 있어요."),
                ChatMessage(role: .ex_user, message: "단정하고 깔끔한 스타일을 원해요."),
                ChatMessage(role: .ex_model, message: "좋아요! 어떤 색상을 좋아하세요? 혹시 평소에 즐겨 입는 스타일이 있으신가요?"),
                ChatMessage(role: .ex_user, message: "추천해주세요."),
                ChatMessage(role: .ex_model, message: "베이지색이나 블랙 색상의 슬랙스에 화이트 셔츠나 블라우스를 코디해보는 건 어떠세요?"),
                ChatMessage(role: .ex_user, message: "화이트 셔츠는 얼마예요?"),
                ChatMessage(role: .ex_model, message: "직접 착용해보시고 맘에 드는 셔츠를 골라보세요.")
            ]
            
        // MARK: 마트에서 장보기
        case .shopping_mart:
            return [
                ChatMessage(role: .ex_model, message: "어서오세요! 필요한 것 있으시면 말씀해주세요."),
                ChatMessage(role: .ex_user, message: "오늘 저녁은 미역국을 하려고 반찬을 사러 왔어요."),
                ChatMessage(role: .ex_model, message: "미역국이라니, 든든하고 좋네요! 미역은 요기, 해산물 코너 쪽에 있어요. 싱싱한 미역이 많으니 골라보세요. 혹시 미역국에 넣을 다른 재료는 필요하신가요?"),
                ChatMessage(role: .ex_user, message: "소고기를 넣으면 맛있을 것 같아요."),
                ChatMessage(role: .ex_model, message: "소고기라면 딱이죠! 소고기는 정육 코너에 있는데, 오늘은 특가로 한우 불고기가 할인하고 있어요."),
                ChatMessage(role: .ex_user, message: "오늘 할인하는 상품은 뭐가 있나요?"),
                ChatMessage(role: .ex_model, message: "오늘은 과일 코너에서 샤인머스캣이 할인하고 있고요, 채소 코너에서는 애호박이 할인하고 있어요."),
                ChatMessage(role: .ex_user, message: "샤인머스캣은 얼마인가요?"),
                ChatMessage(role: .ex_model, message: "샤인머스캣은 1kg에 15,000원에서 10% 할인된 13,500원이에요. 달콤하고 맛있으니 드셔보세요!")
            ]
            
        // MARK: 좋아하는 K-POP 가수 말하기
        case .media_kpop:
            return [
                ChatMessage(role: .ex_model, message: "혹시 좋아하는 K-POP 가수 있어요?"),
                ChatMessage(role: .ex_user, message: "응 나는 블랙핑크 좋아해"),
                ChatMessage(role: .ex_model, message: "블랙핑크? 멋지다! 어떤 노래 좋아해요?"),
                ChatMessage(role: .ex_user, message: "Lovesick Girls라는 노래를 좋아해."),
                ChatMessage(role: .ex_model, message: "혹시 블랙핑크 콘서트 가본 적 있어요?"),
                ChatMessage(role: .ex_user, message: "가본 적 있어."),
                ChatMessage(role: .ex_model, message: "부럽다. 어땠어요?"),
                ChatMessage(role: .ex_user, message: "감동이였어. 또 가고 싶어."),
                ChatMessage(role: .ex_model, message: "혹시 나중에 같이 콘서트 가볼래요?"),
                ChatMessage(role: .ex_user, message: "진짜 좋아.")
            ]
            
        // MARK: 좋아하는 한국 드라마 말하기
        case .media_drama:
            return [
                ChatMessage(role: .ex_model, message: "혹시 좋아하는 한국 드라마 있어요?"),
                ChatMessage(role: .ex_user, message: "응 나는 “눈물의 여왕”을 재미있게 시청했어."),
                ChatMessage(role: .ex_model, message: "오. 어때, 재미있었어요? 어떤 부분이 제일 좋았어요?"),
                ChatMessage(role: .ex_user, message: "주인공의 러브라인을 보는 것이 가장 재미있었어."),
                ChatMessage(role: .ex_model, message: "혹시 어떤 배우가 출연했어요?"),
                ChatMessage(role: .ex_user, message: "김수현, 김지원이 주인공이야."),
                ChatMessage(role: .ex_model, message: "아하. 둘 다 인기 많은 배우잖아요. 혹시 좋아하는 영화도 있어요?"),
                ChatMessage(role: .ex_user, message: "액션, 코미디, SF, 판타지, 로맨스, 다큐 다 좋아해. 스릴러 빼고 다 좋아하는 것 같아."),
                ChatMessage(role: .ex_model, message: "장르 가리지 않고 다 좋아하는군요. 갑자기 영화 보고 싶어지네요.")
            ]
            
        // MARK: 좋아하는 게임 말하기
        case .media_game:
            return [
                ChatMessage(role: .ex_model, message: "혹시 좋아하는 게임 있어요?"),
                ChatMessage(role: .ex_user, message: "응 있어."),
                ChatMessage(role: .ex_model, message: "혹시 어떤 게임 좋아해요?"),
                ChatMessage(role: .ex_user, message: "“롤”을 좋아해."),
                ChatMessage(role: .ex_model, message: "하루에 몇 시간 정도 해요?"),
                ChatMessage(role: .ex_user, message: "한달에 2번정도 해."),
                ChatMessage(role: .ex_model, message: "그럼 게임을 많이 안 하는 군요. 혹시 좋아하는 프로게이머 있어요?"),
                ChatMessage(role: .ex_user, message: "T1의 Faker 선수를 좋아해."),
                ChatMessage(role: .ex_model, message: "그렇구나. 나중에 같이 게임 해요!"),
                ChatMessage(role: .ex_user, message: "진짜 좋아.")
            ]
        }
    }
}
