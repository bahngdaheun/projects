<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">노리 관리</h1>
       <sec:authorize access="hasRole('ROLE_ADMIN')"/>
        <a href="/member/register" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">노리 등록</a>
    </div>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">노리 정보</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>NORI ID</th>
                        <th>NAME</th>
                        <th>ADDRESS</th>
                        <th>EMAIL</th>
                        <th>PHONE</th>
                        <th>ENABLE</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${dtoList}" var="dto">
                        <tr>
                            <td><c:out value="${dto.mid}"></c:out></td>
                            <td><a href="javascript:moveRead('${dto.mid}')"><c:out value="${dto.mname}"></c:out></a></td>
                            <td><c:out value="${dto.maddress}"></c:out></td>
                            <td><c:out value="${dto.memail}"></c:out></td>
                            <td><c:out value="${dto.mphone}"></c:out></td>
                            <td><c:out value="${dto.enable}"></c:out></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <form action="/member/list" method="get">
                            <label>노리 검색</label>
                        <div class="dropdown mb-3 input-group">
                            <select class="btn btn-primary dropdown-toggle" name="type"
                                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                <div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton">
                                <option value="">----</option>
                                <option value="I" ${pageRequestDTO.type=="I"?"selected":""}>아이디</option>
                                <option value="IN" ${pageRequestDTO.type=="IN"?"selected":""}>아이디 & 이름</option>
                                <option value="A" ${pageRequestDTO.type=="A"?"selected":""}>주소</option>
                                <option value="INA" ${pageRequestDTO.type=="INA"?"selected":""}>아이디 & 이름 & 주소</option>
                                </div>
                            </select>
                            <input type="text" class="form-control bg-light border-0 small" placeholder="검색 내용을 입력하세요."
                                   aria-label="Search" aria-describedby="basic-addon2" name="keyword" value="${pageRequestDTO.keyword}">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        <hr>
                        </div>
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
<form id="actionForm" action="/member/list" method="get">
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

    function moveRead(mid){
        actionForm.setAttribute("action","/member/read")
        actionForm.innerHTML += `<input type='hidden' name='mid' value='\${mid}'>`

        actionForm.submit()
    }

    function movePage(pageNum){
        actionForm.querySelector("input[name='page']").setAttribute("value",pageNum)
        actionForm.submit()
    }

</script>

</body>
</html>