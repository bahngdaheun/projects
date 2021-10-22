
const getReplyList = async  (bno) => {

    const response = await axios.get(`/board/replies/list/${bno}`)

    return response.data
}

async function addReply(obj) {//댓글을 post로 등록하는 방법
    const response = await axios.post("/board/replies",obj)
    return response.data
}

const removeReply = async  (rno) => {//댓글을 삭제하는친구
    const response = await axios.delete(`/board/replies/${rno}`)
    return response.data
}

const modifyReply = async (reply) => {//put이 수정해서 집어넣는 친구, 수정은 등록과 삭제의 기능이 섞여있다.

    const response = await axios.put(`/board/replies/${reply.rno}`,reply)

    return response.data
}