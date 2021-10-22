<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>

<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>--%>

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">READ</h1>
                        </div>
                        <form id="form1">
                            <input type="hidden" name="page" value="${pageRequestDTO.page}">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">

                            <div class="form-group">
                                <label for="title">QNO</label>
                                <input type="text" name="qno" class="form-control form-control-user" id="qno" value="<c:out value="${qnaDTO.qno}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">TITLE</label>
                                <input type="text" name="title" class="form-control form-control-user" id="title" value="<c:out value="${qnaDTO.title}"></c:out>" readonly>
                            </div>
                            <label for="title">WRITER</label>
                            <div class="form-group">
                                <input type="text" name="writer" class="form-control form-control-user" id="writer" value="<c:out value="${qnaDTO.writer}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label>CONTENT</label>
                                <textarea name="content" class="form-control form-control-user" id="content" disabled><c:out value="${qnaDTO.content}"></c:out>
                                </textarea>
                            </div>
                            <hr>
                            <div>
                                <button type="button" class="btn btn-info btnList">LIST</button>
                                <button type="button" class="btn btn-info btnDel">DELETE</button>
                            </div>
                        </form>
                    </div>

                    <hr>

                    <div class="p-4 row">
                        <c:forEach items="${qnaDTO.files}" var="attach">
                            <div class="col-sm-2">
                                <div>
                                    <c:if test="${attach.image}">
                                        <img onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/qna/viewFile?file=${attach.getThumbnail()}">
                                    </c:if>
                                </div>
                                    ${attach.fileName}
                            </div>
                        </c:forEach>
                    </div>

                    <hr>
                    <!-- 댓글 -->
                    <div class="col-xl-12 col-md-12 mb-4">
                        <div class="qnaReply">

                        </div>

                        <div class="card-footer clearfix">
                            <ul class="pagination pagination-sm m-0 float-right">

                                <div class="col-sm-12 col-md-7">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                                        <ul class="pagination">
                                            <li class="paginate_button page-item active"><a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                            <li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
                                            <li class="paginate_button page-item "><a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
                                        </ul>
                                    </div>
                                </div>

                            </ul>
                        </div>

                    </div>

                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">REPLY</h6>
                    </div>
                    <!-- 댓글작성 -->
                    <div id="qnaReply-write" class="card o-hidden border-0 shadow-none my-5">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="p-5">
                                    <div class="form-group">
                                        <label for="title">작성자</label>
                                        <input type="text" name="replyer" class="form-control form-control-user" id="replyer">
                                    </div>

                                    <div class="form-group">
                                        <label for="title">댓글</label>
                                        <input type="text" name="qnaReply" class="form-control form-control-user" id="qnaReply">
                                    </div>
                                    <hr>
                                    <div class="input-group-append">
                                        <button class="btn btn-primary operBtn" type="button">작성</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">댓글 수정</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="rno">
                <input type="text" name="replyMod">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-primary btnModReply">수정하기</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
</div>

<form id="actionForm" action="/qna/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>


<form id="actionReply" action="/replies/list/{qno}/{page}" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">
</form>

<div id="modal-imge" class="modal">
    <span class="close">&times X &times</span>
    <img class="modal-content" id="targetImage">
    <div id="caption"></div>
</div>


<%@ include file="../includes/footer.jsp" %>

<script>
    const actionForm = document.querySelector("#actionForm")
    const form = document.querySelector("#form1")
    const actionReply = document.querySelector("#actionReply")

    document.querySelector(".btnList").addEventListener("click", ()=>{actionForm.submit()},false)

    document.querySelector(".btnDel").addEventListener("click", (e)=>{
        e.preventDefault()
        e.stopPropagation()

        form.setAttribute("action","/qna/remove")
        form.setAttribute("method","post")
        form.submit()

    },false)

</script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/qna-reply.js"></script>

<script>

    const modalImage = new bootstrap.Modal(document.querySelector("#modal-imge"))


    function showOrigin(fileLink){
        document.querySelector("#targetImage").src = `/qna/viewFile?file=\${fileLink}`
        modalImage.show()
    }

    function getList() {

        const target = document.querySelector(".qnaReply")
        const qno = '${qnaDTO.qno}'
        const page = '${PageRequestDTO.page}'

        function convertTemp(replyObj) {

            const {rno, sno, qnaReply, replyer, replyDate, modDate} = {...replyObj}

            const temp = `<div class="card mb-4 py-2 border-left-primary shadow">
                          <div class="col-auto " align="right">
                          <a class="fas fa-tools fa-1x text-gray-300 m-1 ModRno" href="javascript:ModReply(\${rno})" data-rno='\${rno}' data-qnaReply='\${qnaReply}'></a>
                          <a class="fas fa-trash fa-1x text-gray-300 m-1" href="javascript:delReply(\${rno})" data-rno='\${rno}'></a></div>
                          <div class="ml-4 mb-3">
                          <div class="row no-gutters align-items-start">
                          <div class="col mr-2">
                          <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                          \${rno}--\${replyer}</div>
                          <div class="mod">
                          <div class="h5 mb-0 font-weight-bold text-gray-800" data-replyer='\${replyer}' data-qnaReply='\${qnaReply}' data-rno='\${rno}'>
                          \${qnaReply}</div>
                          <div class="text-xs font-weight-light text-secondary text-uppercase mb-1">
                          \${replyDate}</div>
                          </div>
                          </div></div>
                        </div></div>`

            return temp

        }

        getReplyList(qno,page).then(data => {

            console.log(data)
            let str = ""

            const {replyCnt, list} = data

            list.forEach(qnaReply =>{
                str += convertTemp(qnaReply)
            });

            target.innerHTML = str
        })
    }

    (function () {
        getList()
    })()

    const replyDiv = document.querySelector("#qnaReply-write")

    let oper = null

    document.querySelector(".operBtn").addEventListener("click", function () {

        oper = 'add'

        const qno = '${qnaDTO.qno}'
        const replyer = document.querySelector("input[name='replyer']").value
        const qnaReply = document.querySelector("input[name='qnaReply']").value

        if (oper === 'add') {

            const replyObj = {qno, replyer, qnaReply}
            console.log(replyObj)

            addReply(replyObj).then(result => {
                getList()
                document.querySelector("input[name='replyer']").value = ""
                document.querySelector("input[name='qnaReply']").value = ""
            })
        }

    }, false)

    const modModal = $("#modal-sm")
    const modReply = document.querySelector("input[name='replyMod']")
    const modRno = document.querySelector("input[name='rno']")

    function ModReply(){

        const rno = document.querySelector(".ModRno").getAttribute("data-rno")
        const qnaReply = document.querySelector(".ModRno").getAttribute("data-qnaReply")

        console.log(rno,qnaReply)

        modRno.value = rno
        modReply.value = qnaReply

        modModal.modal('show')
    }

    function delReply(rno) {

        console.log(rno);
        removeReply(rno).then(result => {
            getList()
        })
    }

    document.querySelector(".btnModReply").addEventListener("click", (e)=>{
        const replyObj = {rno:modRno.value ,qnaReply:modReply.value }

        console.log(replyObj)

        modifyReply(replyObj).then(result=> {
            getList()
            modModal.modal("hide")
        })
        },false)

    function movePage(pageNum){
        actionReply.querySelector("input[name='page']").setAttribute("value",pageNum)
        actionReply.submit()
    }

</script>

</body>

</html>