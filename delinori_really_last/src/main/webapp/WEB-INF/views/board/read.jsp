<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %> <!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>--%>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">자유게시판</h1>
        <div class="card-footer float-right">
            <button type="button" class="btn btn-primary btnList" >LIST</button>
        </div>

    </div>


    <div class="row">
        <!-- Area Chart -->
        <div class="col-xl-12 row-cols-lg-12 col-lg-12 ">
            <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div
                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
                    <div class="dropdown no-arrow">
                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                             aria-labelledby="dropdownMenuLink">
                            <div class="dropdown-header">Dropdown Header:</div>
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </div>
                </div>
                <form id="form1">
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="form-group">
                            <label for="exampleInputEmail10">BNO</label>
                            <input type="text" name="bno" class="form-control" id="exampleInputEmail10" value="<c:out value="${boardDTO.bno}"></c:out>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Title</label>
                            <input type="text" name="title" class="form-control" id="exampleInputEmail1" value="<c:out value="${boardDTO.title}"></c:out>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail2">Writer</label>
                            <input type="text" name="writer" class="form-control" id="exampleInputEmail2" value="<c:out value="${boardDTO.writer}"></c:out>" readonly>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <!-- textarea -->
                                <div class="form-group">
                                    <label>Textarea</label>
                                    <textarea name="content" class="form-control" rows="3" disabled><c:out value="${boardDTO.content}"></c:out>
                                    </textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer">

                        <%--                <sec:authorize access="hasRole('ROLE_ADMIN')">--%>
                        <%--                    <button type="submit" class="btn btn-danger btnDel">삭제</button>--%>
                        <%--                </sec:authorize>--%>

                        <%--                <sec:authentication property="principal.authorities" var ="authList"/>--%>

                        <%--    <h4>${authList.toString().indexOf("ADMIN")}</h4>--%>

                        <%--                <sec:authentication property="principal" var="memberDTO"/>--%>


                        <c:if test="${(boardDTO.writer eq memberDTO.mid ) or (authList.toString().indexOf(\"ADMIN\") >0)  }">

                            <button type="submit" class="btn btn-danger btnDel">삭제</button>

                        </c:if>

                    </div>
                </form>

                <div>
                    <c:forEach items="${boardDTO.files}" var="attach">
                        <div>
                            <c:if test="${attach.image}">
                                <img onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/viewFile?file=${attach.getThumbnail()}">
                                <%--원본경로랑 썸네일 경로랑 파라미터로 줌--%>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>

                <div class="card direct-chat direct-chat-primary">
                    <h5 class="card-title">Replies</h5>

                    <!-- /.card-header -->
                    <div class="card-body">
                        <!-- Conversations are loaded here -->
                        <div class="direct-chat-messages">

                        </div>
                        <!--/.direct-chat-messages-->
                    </div>
                </div>
                <!--/.direct-chat -->
                <!-- Card Body -->


                <div class="card-body">
                    <div class="form-group">
                        <label for="exampleInputEmail10">writer</label>
                        <input type="text" name="replyer" class="form-control" id="exampleInputEmail13" placeholder="아이디를 입력하세요." >
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">content</label>
                        <input type="text" name="reply" class="form-control" id="exampleInputEmail4" placeholder="내용을 입력하세요." >
                    </div>
                </div>

                <div class="card-footer">
                    <button type="submit" class="btn btn-primary replyBtn">댓글등록</button>
                </div>


            </div>
        </div>
    </div>
</div>
</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<form id="actionForm" action="/board/list" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
    <%--    하단에 검색창에 보여지는것--%>
</form>

<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modify/Remove</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="rno">
                <input type="text" name="replyerMod">
                <input type="text" name="replyMod">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-info btnModReply">Modify</button>
                <button type="button" class="btn btn-danger btnRem">Remove</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<div id="modal-imge" class="modal">
    <span class="close">&times X</span>
    <img class="modal-content" id="targetImage">
    <div id="caption"></div>
</div>

<%@ include file="../includes/footer.jsp" %> <!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<script>



    const form = document.querySelector("#form1")

    const actionForm = document.querySelector("#actionForm")

    document.querySelector(".btnList").addEventListener("click",(e) => {

        e.preventDefault()
        e.stopPropagation()

        actionForm.submit()

    })

    document.querySelector(".btnDel").addEventListener("click",(e) => {

        e.preventDefault()
        e.stopPropagation()

        actionForm.submit()

        form.setAttribute("action", "/board/remove")
        form.setAttribute("method", "post")
        form.submit()

    },false);
</script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/board-reply.js">//read.jsp랑 reply.js랑 연결하는코드,read에서 글을 읽어야 댓글을 달수 있기때문에 read랑 연결</script>

<script>


    const modalImage = $('#modal-imge')
    // const modalImage = new bootstrap.Modal(document.querySelector('#modal-image'))//제이쿼리를 안쓰려고 링크 받아옴

    function showOrigin(fileLink){
        document.querySelector('#targetImage').src = `/viewFile?file=\${fileLink}`
        modalImage.show()
    }

    function after(result) {
        console.log("after.........")
        console.log("result:" , result)
    }
    // function showReply(rno, event){
    //     alert('rno:' + rno);
    //     const target = event.target.closest('.direct-chat-msg');
    //
    //     console.log(target);
    // }

    function getList() {
        const target = document.querySelector(".direct-chat-messages")
        const bno = '${boardDTO.bno}'//130


        function convertTemp(replyObj) {

            // console.log(replyObj)

            const {rno,bno,reply,replyer,replyDate,modDate}  = {...replyObj}//스프레드 연산자 (전개 연산자)

            // onclick="javascript:showReply('\${rno}', event)"
            const temp =`<div class="direct-chat-msg" >
                        <div class="direct-chat-infos clearfix" >
                            <span class="direct-chat-name float-left">\${rno}--\${replyer}</span>
                            <span class="direct-chat-timestamp float-right">\${replyDate}</span>
                        </div>
                        <div class="direct-chat-text" data-rno='\${rno}' data-replyer='\${replyer}'>\${reply}
                        </div>
                     </div><hr>`

            return temp

        }



        getReplyList(bno).then(data => {
            console.log(data)//array
            let str = "";

            data.forEach(reply => {
                str += convertTemp(reply)
            })
            target.innerHTML = str
        })
    }

    //최초실행
    (function (){
        getList()
    })()


    document.querySelector(".replyBtn").addEventListener("click",(e) => {

        e.preventDefault();
        e.stopPropagation();

        const bno = `${boardDTO.bno}`
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value

        const replyObj = {bno, replyer, reply}//{bno:bno, replyer:replyer, reply:reply}
        console.log(replyObj)
        addReply(replyObj).then(result => {
            getList()
            modalDiv.modal('hide')
            document.querySelector("input[name='replyer']").value = ""
            document.querySelector("input[name='reply']").value = ""
        })


    },false)

    const modModal = $("#modal-lg")
    const modReplyer = document.querySelector("input[name='replyerMod']")
    const modReply = document.querySelector("input[name='replyMod']")
    const modRno = document.querySelector("input[name='rno']")

    document.querySelector(".direct-chat-messages").addEventListener("click",(e) => {
        const target = e.target
        const bno = '${boardDTO.bno}'

        if(target.matches(".direct-chat-text")){
            const rno = target.getAttribute("data-rno")
            const replyer = target.getAttribute("data-replyer")
            const reply = target.innerHTML
            console.log(rno,replyer,reply,bno)
            modRno.value = rno
            modReply.value = reply
            modReplyer.value = replyer

            document.querySelector(".btnRem").setAttribute("data-rno", rno)

            modModal.modal('show')

        }

    },false)

    document.querySelector(".btnRem").addEventListener("click",(e)=>{
        const rno = e.target.getAttribute("data-rno")
        //alert(rno)
        removeReply(rno).then(result => {
            getList()
            modModal.modal("hide")
        })
    },false)

    document.querySelector(".btnModReply").addEventListener("click",(e)=>{

        const replyObj = {rno: modRno.value, reply: modReply.value}

        console.log(replyObj)

        modifyReply(replyObj).then(result=>{
            getList()
            modModal.modal("hide")
        })

    },false)



</script>

</body>

</html>