%%raw(`import './App.css';`)
@module("./logo.svg") external logo: string = "default"

// 타입은 이렇게 설정해줘야 함.
type todo = {
  title: string,
  isDone: bool,
}

type state = {
  // 배열의 타입은 제너릭 형식으로 해줘야 함.
  todoList: array<todo>,
  inputValue: string,
}

// 각 액션에 대한 타입을 정의
type actions =
  | AddTodo(string)
  | ClearTodos
  | ClearInput
  | InputChanged(string)
  | ToggleTodoDone(int)

let initialState: state = {
  todoList: [],
  inputValue: "",
}

let reducer = (state, action) => {
  // 정의한 타입을 이용해 switch를 통해 사용할 함수에 대해 작성한다.
  switch action {
  | AddTodo(todo) => {
      inputValue: "",
      todoList: state.todoList->Js.Array2.concat([
        {
          title: todo,
          isDone: false,
        },
      ]),
    }
  | ClearTodos => {
      ...state,
      todoList: [],
    }
  | ClearInput => {
      ...state,
      inputValue: "",
    }
  | InputChanged(value) => {
      ...state,
      inputValue: value,
    }
  | ToggleTodoDone(index) => {
      ...state,
      todoList: state.todoList->Belt.Array.mapWithIndex((i, todo) => {
        if i == index {
          {
            ...todo,
            isDone: !todo.isDone,
          }
        } else {
          todo
        }
      }),
    }
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  let handleInput = e => {
    let newValue = ReactEvent.Form.target(e)["value"]
    dispatch(InputChanged(newValue))
    // 값을 전달..? WoW
    newValue->InputChanged->dispatch
  }

  let handleSubmit = e => {
    // e.preventDefault()도 이런식으로 호출할 수 있음
    e->ReactEvent.Form.preventDefault
    state.inputValue->AddTodo->dispatch
    ClearInput->dispatch
  }

  let toggleTodo = (index: int) => {
    index->ToggleTodoDone->dispatch
  }

  <div className="App">
    <h1> {"Todo Items"->React.string} </h1>
    <form onSubmit={handleSubmit}>
      <input type_="text" value={state.inputValue} onChange={handleInput} />
      <button> {"Add Todo"->React.string} </button>
      {state.todoList
      ->Belt.Array.mapWithIndex((i, todo) =>
        <div key={i->string_of_int}>
          <input type_="checkbox" checked={todo.isDone} onClick={_ => toggleTodo(i)} />
          {todo.title->React.string}
        </div>
      )
      ->React.array}
    </form>
  </div>
}
