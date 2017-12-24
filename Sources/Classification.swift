//
//  Classification.swift
//
//  Copyright (c) 2017 Todd Kramer (http://www.tekramer.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public struct Classification {

    public enum Category: String {
        case business = "Business"
        case entertainment = "Entertainment"
        case politics = "Politics"
        case sports = "Sports"
        case technology = "Technology"
    }

    public struct Result {
        public let category: Category
        public let probability: Double
    }

    public let prediction: Result
    public let allResults: [Result]

}

extension Classification {

    init?(output: DocumentClassificationOutput) {
        guard let category = Category(rawValue: output.classLabel),
            let probability = output.classProbability[output.classLabel]
            else { return nil }
        let prediction = Result(category: category, probability: probability)
        let allResults = output.classProbability.flatMap(Classification.result)
        self.init(prediction: prediction, allResults: allResults)
    }

    static func result(from classProbability: (key: String, value: Double)) -> Result? {
        guard let category = Category(rawValue: classProbability.key) else { return nil }
        return Result(category: category, probability: classProbability.value)
    }
}
