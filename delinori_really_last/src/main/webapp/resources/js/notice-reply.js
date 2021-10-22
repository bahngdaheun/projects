const getReplyList = async (nno) => {

    const  response = await  axios.get(`/notice/replies/list/${nno}`)

    return response.data
}


async function addReply(obj) { //post. 포스트 방식은 객체를 던진다. 댓글 등록    add 리플라이 호출-> 갱신 -> 다시 목록데이터를 가져와야함

    const response = await axios.post("/notice/replies", obj) //처리된 후에 응답이 올거니까 reponse 로 받음
    return response.data

}


const removeReply = async (rno) => { // 비동기
    const response = await axios.delete(`/notice/replies/${rno}`)
    return response.data
}

const modifyReply = async (reply) => { //댓글 수정 put방식. 비동기

    const response = await axios.put(`/notice/replies/${reply.rno}`, reply)

    return response.data
}