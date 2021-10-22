<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">문의사항</h1>
    </div>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">문의사항</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>QNO</th>
                        <th>TITLE</th>
                        <th>WRITER</th>
                        <th>REGDATE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${dtoList}" var="dto">
                        <tr>
                            <td><c:out value="${dto.qno}"></c:out></td>
                            <td><a href="javascript:moveRead(${dto.qno})"><c:out value="${dto.title}"></c:out></a></td>
                            <td><c:out value="${dto.writer}"></c:out></td>
                            <td><c:out value="${dto.regDate}"></c:out></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <form action="/qna/list" method="get">
                        <div class="form-group">
                            <label>검색</label>
                            <select name="type" class="custom-select">
                                <option value="">----</option>
                                <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목 & 내용</option>
                                <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                <option value="TCW" ${pageRequestDTO.type=="TCW"?"selected":""}>제목 & 내용 & 작성자</option>
                            </select>
                        </div>
                            <div class="input-group">
                                <input type="text" class="form-control bg-light border-0 small" placeholder="검색내용을 입력하세요."
                                       aria-label="Search" aria-describedby="basic-addon2" name="keyword" value="${pageRequestDTO.keyword}">
                                <div class="input-group-append">
                                    <button class="btn btn-primary" type="submit">
                                        <i class="fas fa-search fa-sm"></i>
                                    </button>
                                </div>
                            </div>
                        <hr>
                    </form>
                </table>
                <div class="card-footer clearfix">
                    <ul class="pagination pagination-sm m-0 float-right">

                        <c:if test="${pageMaker.prev}">
                            <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start -1})"> << </a></li>
                        </c:if>

                        <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                            <li class="page-item ${pageMaker.page == num?'active':''}"><a class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                        </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end +1})"> >> </a></li>
                        </c:if>

                    </ul>
                </div>
            </div>
        </div>



    </div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->
<form id="actionForm" action="/qna/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}">
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>


<!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/footer.jsp" %>

<script>
    const actionForm = document.querySelector("#actionForm")

    function moveRead(qno){
        actionForm.setAttribute("action","/qna/read")
        actionForm.innerHTML += `<input type='hidden' name='qno' value='\${qno}'>`

        actionForm.submit()
    }

    function movePage(pageNum){
        actionForm.querySelector("input[name='page']").setAttribute("value",pageNum)
        actionForm.submit()
    }

</script>

</body>

</html>