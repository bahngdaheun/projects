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
                            <h1 class="h4 text-gray-900 mb-4">DELI READ</h1>
                        </div>
                        <form id="form1">
                            <input type="hidden" name="page" value="${pageRequestDTO.page}">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">

                            <div class="form-group">
                                <%--@declare id="title"--%><label for="title">DELI ID</label>
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
                            <div>
                                <c:forEach items="${memberDTO.files}" var="attach">
                                    <div>
                                        <c:if test="${attach.image}">
                                            <img onclick="javascript:showOrigin('${attach.getFileLink()}')" src="/member/viewFile?file=${attach.getThumbnail()}">
                                        </c:if>
                                        <a href="/downFile?file=${attach.getFileLink()}">${attach.fileName}</a>
                                    </div>
                                </c:forEach>
                            </div>
                            <hr>
                            <div>
                                <button type="button" class="btn btn-info btnGoList">LIST</button>
<%--                                <sec:authentication property="principal" var="memberDTO"/>--%>
                                <button type="button" class="btn btn-info btnDel">DELETE</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<form id="actionForm" action="/member/delilist" method="get">
    <input type="hidden" name="page" value="${pageRequestDTO.page}">
    <input type="hidden" name="size" value="${pageRequestDTO.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<div id="modal-image" class="modal">
    <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
    <img class="modal-content" id="targetImage">
    <div id="caption"></div>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
    const modalImage=new bootstrap.Modal(document.querySelector('#modal-image'))

    function showOrigin(fileLink){
        document.querySelector("#targetImage").src=`/member/viewFile?file=\${fileLink}`
        modalImage.show()
    }

    const actionForm = document.querySelector("#actionForm")
    const form = document.querySelector("#form1")

    document.querySelector(".btnGoList").addEventListener("click", ()=>{actionForm.submit()},false)

    document.querySelector(".btnDel").addEventListener("click", (e)=>{
        e.preventDefault()
        e.stopPropagation()

        form.setAttribute("action","/member/deliremove")
        form.setAttribute("method","post")
        form.submit()

    },false)

</script>

</body>

</html>