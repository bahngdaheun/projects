const getReplyList=async (mid)=>{
    const response=await axios.get(`/member/replies/list/${mid}`)
    return response.data
}

async function addReply(obj){
    const response=await axios.post("/member/replies", obj)
    console.log(response, response.data)
    return response.data
}

const removeReply=async (rno)=>{
    const response=await axios.delete(`/member/replies/${rno}`)
    return response.data
}

const modifyReply=async (reply)=>{
    const response=await axios.put(`/member/replies/${reply.rno}`,reply)
    return response.data
}