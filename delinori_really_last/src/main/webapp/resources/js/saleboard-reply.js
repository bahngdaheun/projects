const getReplyList = async (sno, page) => {

    const pageValue = page || 1

    const response = await axios.get(`/saleboard/replies/list/${sno}/${pageValue}`)

    console.log("sno : " + sno)
    console.log("page : " + page)

    console.log(response)

    return response.data
}

async function addReply(obj) {

    const response = await axios.post("/saleboard/replies", obj)

    return response.data

}

const removeReply = async (rno) => {

    const response = await axios.delete(`/saleboard/replies/${rno}`)
    return response.data

}

const modifyReply = async (reply) => {

    const response = await axios.put(`/saleboard/replies/${reply.rno}`, reply)

    return response.data
}