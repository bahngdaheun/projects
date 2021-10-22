<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">NORI READ</h1>
                        </div>
                        <form id="form1">
                            <input type="hidden" name="page" value="${pageRequestDTO.page}">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">

                            <div class="form-group">
                                <%--@declare id="title"--%><label for="title">NORI ID</label>
                                <input type="text" name="mid" class="form-control form-control-user" id="mid" value="<c:out value="${memberDTO.mid}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">NAME</label>
                                <input type="text" name="mname" class="form-control form-control-user" id="mname" value="<c:out value="${memberDTO.mname}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">ADDRESS</label>
                                <input type="text" name="maddress" class="form-control form-control-user" id="maddress" value="<c:out value="${memberDTO.maddress}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">EMAIL</label>
                                <input type="text" name="memail" class="form-control form-control-user" id="memail" value="<c:out value="${memberDTO.memail}"></c:out>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="title">PHONE</label>
                                <input type="text" name="mphone" class="form-control form-control-user" id="mphone" value="<c:out value="${memberDTO.mphone}"></c:out>" readonly>
                            </div>
                            <hr>
                            <div class="form-inline justify-content-end">
                                <button type="button" class="btn btn-info ml-2 btnGoList">LIST</button>
                                <sec:authentication property="principal" var="memberDTO"/>
                                <button type="button" class="btn btn-danger ml-2 btnDel">DELETE</button>
                            </div>
                        </form>
                        <br>

                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DETAILS</h6>
                        </div>
                        <div>
                            <div class="reply">
                            </div>
                        </div>
                        <!-- 댓글작성 -->
                        <div id="reply-write" class="form-inline justify-content-center mt-2">
                            <div class="reply-content">
                                <sec:authorize access="hasRole('ROLE_ADMIN')"/>
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="작성자"
                                       aria-label="replyer" aria-describedby="basic-addon2"
                                       name="replyer" readonly value="<sec:authentication property="principal.mid"/>">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="회원 상세 내용"
                                       aria-label="reply" aria-describedby="basic-addon2"
                                       name="reply">
                            </div>
                            <div class="input-group-append">
                                <button class="btn btn-primary operBtn" type="button">
                                    작성
                                </button>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form id="actionForm" action="/member/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>


<%@ include file="../includes/footer.jsp" %>

<script>
    const actionForm = document.querySelector("#actionForm")
    const form = document.querySelector("#form1")

    document.querySelector(".btnGoList").addEventListener("click", ()=>{actionForm.submit()},false)
    document.querySelector(".btnDel").addEventListener("click", (e)=>{
        e.preventDefault()
        e.stopPropagation()

        form.setAttribute("action","/member/remove")
        form.setAttribute("method","post")
        form.submit()

    },false)
</script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/member-reply.js"></script>

<script>
    function getList(){
        const target=document.querySelector(".reply")
        const mid='${memberDTO.mid}'

        function convertTemp(replyObj){
            const {rno,mid,reply,replyer,replyDate,modDate, gno}={...replyObj}
            const originReply = `<div class="origin-reply-card mb-2 mt-1" data-rno='\${rno}'>
                                    <div class="col-auto" align="right">
                                        <a href="javascript:addReplyReply(\${rno})" class="fas fa-edit fa-sm text-gray-300 m-1"></a>
                                        <a href="javascript:modReply(\${rno})" class="fas fa-tools fa-sm text-gray-300 m-1"></a>
                                        <a href="javascript:deleteReply(\${rno})" class="fas fa-trash fa-sm text-gray-300 m-1" data-rno="\${rno}"></a>
                                    </div>`

            const reReply = `<div class="reply-reply-card ml-5 mb-2 mt-2" data-gno='\${gno}'>
                                <div class="col-auto " align="right">
                                    <a href="javascript:addReReplyReply(\${gno}, \${rno})" class="fas fa-edit fa-sm text-gray-300 m-1"></a>
                                    <a href="javascript:modReReply(\${gno})" class="fas fa-tools fa-sm text-gray-300 m-1"></a>
                                    <a href="javascript:deleteReply(\${rno})" class="fas fa-trash fa-sm text-gray-300 m-1"></a>
                                </div>`

            const step = rno === gno ? originReply : reReply

            const temp = `\${step}
                            <div class = form-inline>
                                <div class="profile-img btn btn-secondary btn-circle btn-lg">
                                    <i class="fa fa-user"></i>
                                </div>
                                <div class="reply-body ml-4 mb-3">
                                    <div class="reply-content row no-gutters align-items-start">
                                        <div class="reply-rno col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                \${rno}--\${replyer}
                                            </div>
                                            <div class="reply-mod" id="modRpl\${rno}">
                                                <div class="reply-content h5 mb-0 font-weight-bold text-gray-800" data-rno='\${rno}'
                                                     data-replyer='\${replyer}'>
                                                    \${reply}
                                                </div>
                                                <div class="reply-date text-xs font-weight-light text-secondary text-uppercase mb-1">
                                                    \${replyDate}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                            <div class="reply-reply" id="rpl\${rno}">
                            </div>
                            <hr class="mt-3 mb-0"/>`
            return temp
        }

        getReplyList(mid).then(data=>{
            let str="";
            data.forEach(reply=>{
                str+=convertTemp(reply)
            })
            target.innerHTML=str
        })
    }

    (function () {
        getList()
    })()

    let oper=null

    document.querySelector(".operBtn").addEventListener("click", function () {

        oper = 'add'

        const mid = '${memberDTO.mid}'
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value
        const gno = null

        if (oper === 'add') {
            const replyObj = {mid, replyer, reply, gno}
            console.log(replyObj)

            addReply(replyObj).then(result => {
                getList()
                document.querySelector("input[name='replyer']").value = ""
                document.querySelector("input[name='reply']").value = ""
            })
        }
    }, false)

    //댓글 수정
    function modReply(rno) {
        const target = document.getElementById("modRpl" + rno)
        console.log(target)
        const modStr = `<div>
                        <input type="text" class="form-control bg-light border-0 small"
                             placeholder="수정할 내용을 입력해 주세요"
                             aria-label="reply" aria-describedby="basic-addon2"
                             name="replyMod">
                        <div class="input-group-append">
                          <button class="btn btn-primary btnModReply" type="button">
                              수정
                          </button>
                        </div></div>`

        target.innerHTML = modStr

        document.querySelector(".btnModReply").addEventListener("click", (e) => {
            const modreply = document.querySelector("input[name='replyMod']").value
            const replyObj = {rno: rno, reply: modreply}
            console.log(replyObj)
            modifyReply(replyObj).then(result => {
                getList()
            })
        }, false)
    }

    //댓글 삭제
    function deleteReply(rno) {
        console.log(rno);
        removeReply(rno).then(result => {
            getList()
        })
    }

    //대댓글 입력
    function addReplyReply(rno) {
        console.log(rno);
        const target = document.getElementById("rpl" + rno)
        const str = `<div id="reply-reply-write" class="mt-1 mb-2 form-inline justify-content-center">
                            <div class="reply-content">
                                <input type="hidden" name="rno">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="작성자"
                                       aria-label="replyer" aria-describedby="basic-addon2"
                                       name="replyer" readonly value="<sec:authentication property="principal.mid"/>">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="추가 사항을 입력해 주세요"
                                       aria-label="reply" aria-describedby="basic-addon2"
                                       name="reply">
                            </div>
                            <div class="input-group-append">
                                <a href="javascript:regReply(\${rno})" class="btn btn-primary rplBtn" type="button">
                                    작성
                                </a>
                            </div>
                        <hr/>
                        </div>`
        target.innerHTML = str
    }

    //대댓글 등록
    function regReply(rno) {
        const mid = '${memberDTO.mid}'
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value
        const replyObj = {mid, replyer, reply, rno}
        console.log(replyObj)

        addReply(replyObj).then(result => {
            getList()
            document.querySelector("input[name='replyer']").value = ""
            document.querySelector("input[name='reply']").value = ""
        })
    }

    //대대댓글(인척) 입력
    function addReReplyReply(gno, rno) {
        console.log(gno);
        const target = document.getElementById("rpl" + rno)
        const str = `<div id="reply-reply-write" class="mt-1 mb-2 form-inline justify-content-center">
                            <div class="reply-content">
                                <input type="hidden" name="gno">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="작성자"
                                       aria-label="replyer" aria-describedby="basic-addon2"
                                       name="replyer" readonly value="<sec:authentication property="principal.mid"/>">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="추가 사항을 입력해주세요"
                                       aria-label="reply" aria-describedby="basic-addon2"
                                       name="reply">
                            </div>
                            <div class="input-group-append">
                                <a href="javascript:regReply(\${gno})" class="btn btn-primary rplBtn" type="button">
                                    작성
                                </a>
                            </div>
                        <hr/>
                        </div>`
        target.innerHTML = str
    }

    //대대댓글(인척) 등록
    function regReply(gno) {

        const mid = '${memberDTO.mid}'
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value
        const rno = gno

        const replyObj = {mid, replyer, reply, rno}
        console.log(replyObj)

        addReply(replyObj).then(result => {
            getList()
            document.querySelector("input[name='replyer']").value = ""
            document.querySelector("input[name='reply']").value = ""
        })
    }

</script>
</body>
</html>