<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-2 text-gray-800">조회</h1>
            <p class="mb-4"> </p>
        </div>

        <form id="form1">
        <div class="card-body">
            <div class="form-group">
                <label for="exampleInputEmail10">글번호</label>
                <input type="text" name="nno" class="form-control" id="exampleInputEmail10" value="<c:out value="${noticeDTO.nno}"></c:out>" readonly>
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">내용</label>
                <input type="text" name="title" class="form-control" id="exampleInputEmail1" value="<c:out value="${noticeDTO.title}"></c:out>" readonly>
            </div>
            <div class="form-group">
                <label for="exampleInputEmail2">작성자</label>
                <input type="text" name="writer" class="form-control" id="exampleInputEmail2" value="<c:out value="${noticeDTO.writer}"></c:out>" readonly>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <!-- textarea -->
                    <div class="form-group">
                        <label>내용</label>
                        <textarea name="content" class="form-control" rows="3" disabled><c:out value="${noticeDTO.content}"></c:out>
                        </textarea>
                    </div>
                </div>
            </div>
        </div>


<%--        <div class="card-footer float-right">--%>
<%--            <button type="button" class="btn btn-default btnList"> LIST </button>--%>
<%--            <button type="button" class="btn btn-default btnDel"> Delete </button>--%>
<%--        </div>--%>

            <div class="form-inline justify-content-end">
                <button type="button" class="btn btn-primary ml-2 btnList">LIST</button>
                <button type="button" class="btn btn-danger ml-2 btnDel">DELETE</button>
            </div>

        </form>
        <br/><br/>
        <br/><br/>

        <!--파일이 있는지 확인하고 read에서 첨부파일 조회하는 코드-->
        <div>
            <c:forEach items="${noticeDTO.files}" var="attach">
                <div>
                    <!--첨부파일 링크를 보여주는 곳-->
                    <c:if test="${attach.image}">
                        <img onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/notice/viewFile?file=${attach.getThumbnail()}">    <!--attach.getFileLink()이 파라미터로 들어간다.-->
                    </c:if>
                        ${attach.fileName}
                </div>
            </c:forEach>
        </div>


<%--        <div>--%>
<%--            <form action="/notice/list" method="get">--%>
<%--                <input type="hidden" name="page" value="1"> <!--검색 시 결과가 1페이지부터 나오게 하려고 value값을 1 로 줬다.-->--%>
<%--                <input type="hidden" name="size" value="${pageMaker.size}">--%>
<%--            </form>  <!--버튼이 폼안에 있어야 작동을 해서 폼으로 감싸줬다.-->--%>
<%--        </div>--%>
    </div>






<form id="actionForm" action="/notice/list" method="get">

    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>

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




<!--원본 사진을 띄워줌-->
<div class="modal fade" id="modal-image">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <img id="targetImage">
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@ include file="../includes/footer.jsp" %>

<script>
    const actionForm = document.querySelector("#actionForm")

    const form1 = document.querySelector("#form1")

    document.querySelector(".btnList").addEventListener("click",()=> {actionForm.submit()}, false)

    document.querySelector(".btnDel").addEventListener("click",(e) => {

        e.preventDefault()
        e.stopPropagation()

        form1.setAttribute("action","/notice/remove")
        form1.setAttribute("method","post")
        form1.submit()
    },false)




</script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="/resources/js/notice-reply.js"></script>

<script>


     const modalImage = new bootstrap.Modal(document.querySelector('#modal-image')) //jquery를 사용하지 않으려고 new 이 후 부터 복붙

     function showOrigin(fileLink){

         //alert(fileLink);
         document.querySelector("#targetImage").src = `/notice/viewFile?file=\${fileLink}`
         modalImage.show()
     }

     function after(result){
         console.log("after............")
         console.log("result", result)
     }




    // //최초 실행 . 즉시실행 함수
    // (function() {
    //     getList()
    // })()







    document.querySelector(".btnRem").addEventListener("click",(e)=>{ //버튼 자체에 rno 가 있음. 위에서 가지고 있는 값을 진짜 삭제하는 기능

        const rno = e.target.getAttribute("data-rno")  //data-rno(속성값) 값을 가지고 있는 애를 넣는다.
        // alert(rno)
        removeReply(rno).then(result => {
            getList()   // 삭제 완료된 이후에 목록값 뿌리기
            modModal.modal("hide")
        })
    },false) // 비동기





</script>



</body>
</html>