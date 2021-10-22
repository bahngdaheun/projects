// //선언문
// async function doA(){ //비동기인데 동기화된 처리처럼 리턴받아서 처리
//
//     console.log("doA............................")
//
//     const response = await axios.get("/replies") // 기다렸다가 결과가 나오면 response에 할당해줘
//     const data = response.data //response에서 response.data를 끄집어내줘 -> 데이터 추출(배열)
//     console.log("doA..data", data)
//
//     return data //추출한데이터를 반환
// }
//
// //화살표함수 방식 : 선언식
// // 콜백함수 사용
// const doB = (fn) => {
//     console.log("doB............................")
//
//     //doB() 실행하면 -> axios 호출
//     try{
//     axios.get('/replies').then(response => { // 결과는 원래 비동기방식이어서 then을 처리해줘야한다.
//         console.log(response)
//         // console.log(response.data)
//         const arr = response.data //비동기 통신끝나고 들어온 파라미터가 함수여서 arr을 만들어 줬음
//         fn(arr) // 함수를 전달해주고 비동기방식이 끝나면 함수를 호출해줘 -> callBack방식
//     })
//     }catch (error){
//         console.log(err)
//     }
// }
//
// //-------------------------위쪽이 GET방식----------------밑에가 POST방식-------------------------
//
// async function doC(obj){
//
//     const respose = await axios.post("/replies",obj) // 비동기 처리 -> 응답오면 respose에 담음
//     // console.log('doC',respose)
//     return respose.data
// }
//
// const doD = async (rno) => {
//     const respose = await axios.delete(`/replies/${rno}`) // 비동기 처리 -> 응답오면 respose에 담음
//     return respose.data
// }
//
// const doE = async (reply) => { //reply 데이터를 주면 awit (async 다음은 꼭 await)
//
//     const response = await axios.put(`/replies/${reply.rno}`,reply) //put : 수정해서 다시 집어넣는 것
//     return response.data
// }

const getReplyList = async (qno,page) => {

    const pageValue = page || 1

    const response = await axios.get(`/qna/replies/list/${qno}/${pageValue}`)
    console.log("qno : " + qno)
    console.log("page : " + page)
    return response.data
}

async function addReply(obj){

    const respose = await axios.post("/qna/replies",obj) // 비동기 처리 -> 응답오면 respose에 담음
    // console.log('doC',respose)
    return respose.data
}

const removeReply = async (rno) => {
    const respose = await axios.delete(`/qna/replies/${rno}`) // 비동기 처리 -> 응답오면 respose에 담음
    return respose.data
}

const modifyReply = async (reply) => { //reply 데이터를 주면 awit (async 다음은 꼭 await)

    const response = await axios.put(`/qna/replies/${reply.rno}`,reply) //put : 수정해서 다시 집어넣는 것
    return response.data
}
