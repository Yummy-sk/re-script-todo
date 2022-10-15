# ReScript로 TodoList 만들기

![화면 기록 2022-10-15 오후 11 33 37](https://user-images.githubusercontent.com/60822846/195992097-a8bc402f-e9fb-4597-a773-2a5ed356a8dc.gif)

```
yarn install

yarn start & yarn start:re
```

## ReScript란?

ReScript 공식문서에 따르면.. ReScript는 JavaScript를 사랑하지는 않지만, 자바스크립트의 중요성을 인정하는 사람들을 위한 언어라고 합니다.. (저는 자바스크립트 좋아합니다..!) 

## 장점
+ JavaScript보다 빠르다. (Faster than JavaScript)
+ 죽은 코드를 잘 제거해 준다. (High Quality Dead Code Elimination)
+ 작은 JavaScript코드로 컴파일된 결과물이 출력된다. (Tiny JS Output)
+ 반복문이 빠르다. (Fast Iteration Loop)
+ 출력이 읽기 쉬우며 뛰어난 상호운용성을 갖는다. (Readable Output & Great Interop)
+ 코드 구조를 보존한다. (Preservation of Code Structure)

## 후기
일단 처음 마주쳤을 때는 TypeScript도 그랬듯이 JavaScript와 비슷할 것이라 생각했다. 하지만, 거의 다른 언어라는 생각이 들정도로 따로 공부가 필요함을 느끼게 되었다. 사용해보면서 가장 인상 깊었던 것은 파이프 문법이었다. 
```javascript

let handleSubmit = e => {
  e.preventDefault();
  dispatch(AddTodo(state.inputValue));
  dispatch(ClearInput())
}
```
위와 같은 코드가 존재했을 때, ReScript의 파이프 문법을 사용하면 아래와 같이 표현할 수 있어 흐름에 집중할 수 있음을 느끼게 되었다.👍
```javascript
let handleSubmit = e => {
  // e.preventDefault()도 이런식으로 호출할 수 있음
  e->ReactEvent.Form.preventDefault
  state.inputValue->AddTodo->dispatch
  ClearInput->dispatch
}
```
