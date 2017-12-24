# DocumentClassifier

![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/DocumentClassifier/badge.png) [![Swift](https://img.shields.io/badge/swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/) ![Platform](https://cocoapod-badges.herokuapp.com/p/DocumentClassifier/badge.png)

## Overview

DocumentClassifier is a Swift framework for classifying documents into one of five categories (Business, Entertainment, Politics, Sports, and Technology). It uses a CoreML model trained with 1,500 news articles from the BBC.

## Features

- iOS 11.0+, macOS 10.13+, tvOS 11.0+, watchOS 4.0+
- 100% Test Coverage
- Best CV Score: 0.965333333333

## Usage

[Swift 4 Released (Sample Article](https://swift.org/blog/swift-4-0-released/))

```swift
let text = articleText
guard let classification = classifier.classify(text) else { return }
print(classification.prediction) // Technology: 0.42115752953489294
print(classification.allResults) // Business: 0.141, Entertainment: 0.138, Politics: 0.113, Sports: 0.187, Technology: 0.421
```

## Installation

> _Note:_ DocumentClassifier requires Swift 4 (and [Xcode][] 9) or greater.
>
> Targets using DocumentClassifier must support embedded Swift frameworks.

[Xcode]: https://developer.apple.com/xcode/downloads/


### CocoaPods

[CocoaPods][] is a centralized dependency manager for Cocoa projects. To install
DocumentClassifier with CocoaPods:

1. Make sure the latest version of CocoaPods is [installed](https://guides.cocoapods.org/using/getting-started.html#getting-started).


2. Add DocumentClassifier to your Podfile:

``` ruby
use_frameworks!

pod 'DocumentClassifier', '1.0.0'
```

3. Run `pod install`.

[CocoaPods]: https://cocoapods.org

## Example App

NewsClassifier is an example app using the framework.

<div align="center">
<img src="https://github.com/toddkramer/DocumentClassifier/blob/master/NewsClassifier/Screenshot.png" alt="NewsClassifierExample" width="310" height="382" />
</div>

## Model

- [Model Link](https://github.com/toddkramer/DocumentClassifier/blob/master/Sources/DocumentClassification.mlmodel)
- Best CV Score: 0.965333333333
- Trained using 1,500 news articles from the BBC from 2004-2005 (see references)
- Converted from [scikit-learn Pipeline](http://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html) using [coremltools](https://pypi.python.org/pypi/coremltools).
- Based on the [LinearSVC](http://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVC.html) classifier.

## Author

Todd Kramer, todd@tekramer.com

## References
- [BBC Datasets](http://mlg.ucd.ie/datasets/bbc.html)
- D. Greene and P. Cunningham. "Practical Solutions to the Problem of Diagonal Dominance in Kernel Document Clustering", Proc. ICML 2006. [link](http://mlg.ucd.ie/files/publications/greene06icml.pdf)
- Vadym Markov, [SentimentPolarity](https://github.com/cocoa-ai/SentimentCoreMLDemo)
- [Awesome Core ML Models](https://github.com/likedan/Awesome-CoreML-Models)
- [scikit-learn](http://scikit-learn.org/stable/)
- [Apple Machine Learning](https://developer.apple.com/machine-learning/)
- [CoreML Framework](https://developer.apple.com/documentation/coreml)
- [coremltools](https://pypi.python.org/pypi/coremltools)
