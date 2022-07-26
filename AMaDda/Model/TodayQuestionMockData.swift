//
//  TodayQuestionMockData.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import Foundation

#if DEBUG
final class TodayQuestionMockData {
    static var mockData: [TodayQuestionData] {
        let data = [
            TodayQuestionData(question: "오늘 가족들이 먹은 점심은 무엇인가요?"),
            TodayQuestionData(question: "가족들의 MBTI는?"),
            TodayQuestionData(question: "고반의 생일은?"),
            TodayQuestionData(question: "이번 주말 가족들의 계획은?")
        ]
        return data
    }
}
#endif
