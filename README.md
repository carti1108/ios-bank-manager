# 은행창구 매니저

## 목차
1. [소개](#1.-소개)
2. [팀원](#2.-팀원)
3. [타임라인](#3.-타임라인)
4. [UML](#4.-UML)
5. [실행 화면](#5.-실행-화면)
6. [트러블 슈팅](#6.-트러블-슈팅)
7. [참고 링크](#7.-참고-링크)


## 1. 소개
3명의 은행원이 10~30명의 손님을 처리

## 2. 팀원
|[Kiseok](https://github.com/carti1108)|
|--|
|<img src=https://github.com/carti1108/ios-bank-manager/assets/114901495/4ab1532c-892f-4b68-9283-408d0b2086fe width="200" height="200">|

## 3. 타임라인
>프로젝트 기간: 23.11.13 ~ 23.11.24

|날짜|내용|
|--|--|
|23.11.13|`Linked List` 구현 및 `CustomerQueue` 구현|
|23.11.14|코드 컨벤션 수정 및 리팩토링|
|23.11.15|`Customer`타입 구현<br>`BankClerk`타입 구현<br>`Bank`타입 구현<br>`BankManager`타입 구현|
|23.11.16|은행 앱 동작 구현<br>코드 컨벤션 수정 및 리팩토링|
|23.11.17|코드 컨벤션 수정 및 리팩토링|
|23.11.20|`CustomerProtocol` 구현<br>코드 컨벤션 수정 및 리팩토링|
|23.11.21|Concurrency 공부|
|23.11.22|Concurrency 공부|
|23.11.23|`BankingCategory`타입 구현|
|23.11.24|은행 앱 동작 구현|

## 4. UML
![스크린샷 2023-11-25 오후 10 23 03](https://github.com/carti1108/ios-bank-manager/assets/114901495/fd5dce32-7128-4093-8703-eddac5ed0538)

## 5. 실행 화면

|시작|종료|
|--|--|
|![은행 시작](https://github.com/carti1108/ios-bank-manager/assets/114901495/541f01ba-253f-4220-8bab-a4e9ca8f5cca)|![은행 종료](https://github.com/carti1108/ios-bank-manager/assets/114901495/03370706-da6e-4a4a-a6b8-09692896d024)|

## 6. 트러블 슈팅
### 비동기 로직 관련
#### 1. 은행 업무가 끝나기 전에 은행 종료멘트가 출력되는 문제
task group을 이용하여 하나의 Task 생성 후 while문 안에 각각의 child task를 생성 후 bankClerk들이 업무를 하도록 구현. while문 바깥에 close메서드를 호출하여 while문이 끝나야 실행되도록 구현
<details>
<summary>코드</summary>

```swift
Task {
    let taskStart = CFAbsoluteTimeGetCurrent()
    while depositLine.hasCustomer != 0 || loanLine.hasCustomer != 0 {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                guard let loanCustomer = loanLine.dequeue() else {
                    return
                }
                await firstBankClerk.startTask(with: loanCustomer)
                    }
                    
            group.addTask {
                guard let depositCustomer = depositLine.dequeue() else {
                    return
                }
                await secondBankClerk.startTask(with: depositCustomer)
            }
                    
            group.addTask {
                guard let depositCustomer = depositLine.dequeue() else {
                    return
                }
                await thirdBankClerk.startTask(with: depositCustomer)
            }
        }
    }
    let taskEnd = CFAbsoluteTimeGetCurrent() - taskStart
    close(time: taskEnd)
    NotificationCenter.default.post(
                name: Bank.notificationName,
                object: nil
            )
}
```
</details>

#### 2. 은행 업무가 모두 종료되기 전 시작 메뉴가 출력되는 문제
NotificationCenter를 통하여 은행업무가 종료되는 시점에 post하고 addObserver를 통해 시작 메뉴를 출력하도록 구현

<details>
<summary>코드</summary>

```swift
let taskEnd = CFAbsoluteTimeGetCurrent() - taskStart
            
close(time: taskEnd)
NotificationCenter.default.post(
    name: Bank.notificationName,
    object: nil
)
```
    
```swift
case "1":
    bank.open()
    NotificationCenter.default.addObserver(
        forName: Bank.notificationName,
        object: nil,
        queue: nil) { _ in
            start()
        }
```
</details>

### RunLoop 관련
#### 1. 은행개점 메뉴 선택 시 프로그램이 바로 종료되는 문제
##### 해당 현상이 일어난 이유에 대한 개인적인 생각
Main Thread는 애플리케이션의 프레임워크가 자동으로 Run Loop를 생성하고 실행시키지만 다른 스레드들은 개발자가 명시적으로 실행시켜줘야하기 때문

#### 해결 방법
RunLoop.current.run() 메서드를 활용하여 정상 작동하도록 구현

## 7. 참고 링크
[Swift 공식문서 RunLoop](https://developer.apple.com/documentation/foundation/runloop)<br>[Apple Documentation Archive: Run Loops](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html)<br>[Point Free Concurrency](https://www.pointfree.co/collections/concurrency)<br>[Swift 공식문서 Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#app-top)<br>[야곰 닷넷 스위프트 동시성 프로그래밍](https://yagom.net/courses/swift-concurrency-programming/)

