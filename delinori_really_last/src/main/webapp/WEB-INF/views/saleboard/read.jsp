<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">SALEBOARD READ</h1>
                        </div>
                        <input type="hidden" name="page" value="${pageRequestDTO.page}">
                        <input type="hidden" name="size" value="${pageRequestDTO.size}">

                        <c:if test="${pageRequestDTO.type != null}">
                            <input type="hidden" name="type" value="${pageRequestDTO.type}">
                            <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
                        </c:if>
                        <label for="title">Sno</label>
                        <div class="form-group">
                            <input type="text" name="sno" class="form-control form-control-user" id="sno"
                                   value="<c:out value="${saleBoardDTO.sno}"></c:out>"
                                   placeholder="sno" readonly>
                        </div>
                        <label for="title">Title</label>
                        <div class="form-group">
                            <input type="text" name="title" class="form-control form-control-user" id="title"
                                   value="<c:out value="${saleBoardDTO.title}"></c:out>"
                                   placeholder="title" readonly>
                        </div>
                        <label for="writer">Writer</label>
                        <div class="form-group">
                            <input type="text" name="writer" class="form-control form-control-user" id="writer"
                                   value="<c:out value="${saleBoardDTO.writer}"></c:out>"
                                   placeholder="writer" readonly>
                        </div>
                        <label for="content">Content</label>
                        <div class="form-group">
                                <textarea name="content" class="form-control form-control-user" id="content"
                                          disabled><c:out value="${saleBoardDTO.content}"></c:out></textarea>
                        </div>

                        <!-- 파일목록 -->
                        <div class="m-5 upload-list-box form-inline">
                            <span class="fas fa-caret-left fa-5x text-gray-300 prev"></span>
                            <div class="slide-wrapper">
                                <ul class="slides">
                                    <c:forEach items="${saleBoardDTO.files}" var="attach">
                                        <c:if test="${attach.image}">
                                            <li><img class="image"
                                                     onclick="javascript:showOrigin('${attach.getFileLink()}')"
                                                     src="/saleboard/viewFile?file=${attach.getThumbnail()}"></li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                            <span class="fas fa-caret-right fa-5x text-gray-300 next"></span>
                        </div>

                        <style>
                            li {
                                list-style: none;
                            }

                            .slide-wrapper {
                                position: relative;
                                width: 660px;
                                margin: 0 auto;
                                height: 200px;
                                overflow: hidden;
                            }

                            .slides {
                                position: absolute;
                                left: 0;
                                top: 0;
                            }

                            .slides.animated {
                                transition: 0.5s ease-out;
                            }

                            .slides li {
                                width: 200px;
                                height: 200px;
                                float: left;
                            }

                            .image {
                                width: 200px;
                                height: 200px;
                                object-fit: fill;
                            }

                            .slides li:not(:last-child) {
                                margin-right: 30px;
                            }

                        </style>
                        <!-- 파일목록 END -->

                        <div class="form-inline justify-content-end">
                            <button type="button" class="btn btn-primary ml-2 btnList">LIST</button>
                            <button type="button" class="btn btn-success ml-2 btnMod">MODIFY</button>
                            <button type="button" class="btn btn-danger ml-2 btnDel">DELETE</button>
                        </div>

                        <hr/>

                        <!-- 댓글 -->
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">REPLY</h6>
                        </div>
                        <div>
                            <div class="reply">

                            </div>
                        </div>
                        <!-- 댓글 페이징 -->
                        <div class = "reply-paging">

                        </div>
                        <!-- 댓글 페이징 END -->

                        <!-- 댓글작성 -->
                        <div id="reply-write" class="form-inline justify-content-center mt-2">
                            <div class="reply-content">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="작성자"
                                       aria-label="replyer" aria-describedby="basic-addon2"
                                       name="replyer">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="댓글을 입력해주세요"
                                       aria-label="reply" aria-describedby="basic-addon2"
                                       name="reply">
                            </div>
                            <div class="input-group-append">
                                <button class="btn btn-primary operBtn" type="button">
                                    작성
                                </button>
                            </div>
                        </div>
                        <!-- 댓글 END -->

                    </div>


                </div>
            </div>
        </div>
    </div>
</div>

<!-- Image Modal-->
<div class="modal fade" id="modal-image" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="targetImage">
            </div>
        </div>
    </div>
</div>
<!-- Image Modal End -->

<form id="actionForm" action="/saleboard/list" method="get">
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

<!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/footer.jsp" %>

<script>

    const actionForm = document.querySelector("#actionForm")
    const actionReply = document.querySelector("#actionReply")

    document.querySelector(".btnList").addEventListener("click", () => {
        actionForm.submit()
    }, false)

    document.querySelector(".btnMod").addEventListener("click", () => {

        const sno = '${saleBoardDTO.sno}'

        actionForm.setAttribute("action", "/saleboard/modify")
        actionForm.innerHTML += `<input type='hidden' name='sno' value='\${sno}'>`
        actionForm.submit()

    }, false)

    document.querySelector(".btnDel").addEventListener("click", (e) => {

        const sno = '${saleBoardDTO.sno}'

        actionForm.setAttribute("action", "/saleboard/remove")
        actionForm.innerHTML += `<input type='hidden' name='sno' value='\${sno}'>`
        actionForm.submit()

    }, false)

</script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/saleboard-reply.js"></script>
<script src="/resources/js/img-list.js"></script>

<script>

    //이미지 모달
    const modalImage = new bootstrap.Modal(document.querySelector('#modal-image'))

    function showOrigin(fileLink) {

        //alert(fileLink)
        document.querySelector("#targetImage").src = `/saleboard/viewFile?file=\${fileLink}` //src 실시간으로 받는게 더 빠름
        modalImage.show()

    }


    //댓글
    function getList() {

        const target = document.querySelector(".reply")
        const sno = '${saleBoardDTO.sno}'
        console.log(sno)

        function convertTemp(replyObj) {

            const {rno, sno, reply, replyer, replyDate, modDate, gno} = {...replyObj}

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

        getReplyList(sno, page).then(data => {

            console.log(data)
            let str = ""

            var {dtoList, count} = data

            dtoList.forEach(reply => {
                str += convertTemp(reply)
            })
            target.innerHTML = str

            showReplyPage(count)

        })
    }


    //댓글목록 뿌리기
    (function () {
        getList()
    })()


    //댓글 등록
    let oper = null

    document.querySelector(".operBtn").addEventListener("click", function () {

        oper = 'add'

        const sno = '${saleBoardDTO.sno}'
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value
        const gno = null

        if (oper === 'add') {

            const replyObj = {sno, replyer, reply, gno}
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
                             placeholder="수정할 댓글을 입력해주세요"
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
                                       name="replyer">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="대댓글을 입력해주세요"
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

        const sno = '${saleBoardDTO.sno}'
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value

        const replyObj = {sno, replyer, reply, rno}
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
                                       name="replyer">
                                <input type="text" class="form-control bg-light border-0"
                                       placeholder="대댓글을 입력해주세요"
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

        const sno = '${saleBoardDTO.sno}'
        const replyer = document.querySelector("input[name='replyer']").value
        const reply = document.querySelector("input[name='reply']").value
        const rno = gno

        const replyObj = {sno, replyer, reply, rno}
        console.log(replyObj)

        addReply(replyObj).then(result => {
            getList()
            document.querySelector("input[name='replyer']").value = ""
            document.querySelector("input[name='reply']").value = ""
        })

    }

    //댓글 페이징
    var page = 1;
    const replyPaging = $(".reply-paging")

    function showReplyPage(count){
        var endNum = Math.ceil(page/10.0) * 10
        var startNum = endNum - 9

        var prev = startNum != 1
        var next = false;

        if (endNum * 10 >= count){
            endNum = Math.ceil(count/10.0)
        }
        if (endNum * 10 < count){
            next = true;
        }
        var str = "<ul class='pagination'>"

        if (prev){
            str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Prev</a></li>"
        }

        for (var i = startNum; i <= endNum; i++){
            var active = page == i? "active":""

            str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>"
        }

        if (next){
            str += "<li class='page-item "+active+" '><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>"
        }

        str += "</ul></div>"

        replyPaging.html(str)

    }

    replyPaging.on("click", "li a", function (e) {
        e.preventDefault()
        console.log("page click")

        var targetPage = $(this).attr("href")

        console.log("targetPage: " + targetPage)

        page = targetPage

        getList()
    })


</script>

</body>

</html>