<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %> <!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>--%>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">자유게시판</h1>
        <a href="/board/register" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                class="fas fa-download fa-sm text-white-50"></i>Register</a>
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
                <!-- Card Body -->
                <div class="card-body">
                    <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>BNO</th>
                                <th>TITLE</th>
                                <th>WRITER</th>
                                <th>REGDATE</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${dtoList}" var="dto">
                                <c:choose>
                                    <c:when test="${dto.show eq 'y'}">
                                <tr>
                                    <td><c:out value="${dto.bno}"></c:out></td>
                                    <td><a href="javascript:moveRead(${dto.bno})"><c:out value="${dto.title}"></c:out></a></td>
                                    <td><c:out value="${dto.writer}"></c:out></td>
                                    <td><c:out value="${dto.regDate}"></c:out></td>
                                </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4">
                                                삭제된 게시글 입니다.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            </tbody>
<%--                        <canvas id="myAreaChart"></canvas>--%>
                    </table>

                    <form action="/board/list" method="get">
<%--                        <input type="hidden" name="page" value="1">--%>
                        <%--                                검색한결과가 1페이지가 나오게 value값에 1을 넣어줬다--%>
<%--                        <input type="hidden" name="size" value="${pageMaker.size}">--%>
<%--                        <div class="col-sm-3">--%>
                            <!-- select -->
                            <div class="form-group">
                                <label>Search</label>
                                <select name="type" class="custom-select">
                                    <option value="">-----</option>
                                    <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                    <option value="TC" ${pageRequestDTO.type=="TC"?"selected":""}>제목+내용</option>
                                    <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>내용</option>
                                    <option value="TCW" ${pageRequestDTO.type=="TCW"?"selected":""}>전체</option>
                                </select>
                            </div>
<%--                        </div>--%>

                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="검색내용을 입력하세요."
                                   aria-label="Search" aria-describedby="basic-addon2" name="keyword" value="${pageRequestDTO.keyword}">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>

<%--                        <div class="col-sm-9">--%>
<%--                            <div class="input-group input-group-sm">--%>
<%--                                <input type="text" class="form-control" name="keyword" value="${pageRequestDTO.keyword}">--%>
<%--                                <span class="input-group-append"><button type="submit" class="btn btn-info btn-flat">Go!</button></span>--%>
<%--                                &lt;%&ndash;                                                                               submit은 form태그에 포함되어 있어야한다&ndash;%&gt;--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </form>

                </div>
                <div class="card-footer clearfix">
                    <ul class="pagination pagination-sm m-0 float-right">
                        <c:if test="${pageMaker.prev}">
                            <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start-1})"> << </a></li>
                        </c:if>
                        <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                            <li class="page-item ${pageMaker.page==num?'active':''}"><a class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                        </c:forEach>
                        <%--                                1부터10까지 반복해서 찍어주려고 forEach사용, c:out을 굳이 사용할 필요가 없어서 사용안함
                                                            a태그는 href링크가 매우 길어지고 에러발생 가능성 높아짐
                                                            자바스크립트는 재사용, 처리하기 쉽다, 링크가 간결하다--%>
                        <c:if test="${pageMaker.next}">
                            <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end+1})"> >> </a></li>
                        </c:if>
                    </ul>
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
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">
    <c:if test="${pageRequestDTO.type != null}">
        <%--        검색조건에만 url나오게--%>
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<%@ include file="../includes/footer.jsp" %> <!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<script>

    const actionForm=document.querySelector("#actionForm")//#으로 써줘야 가져올수있다

    <%--const result='${result}'--%>
    <%--//result 값이 없으면 공백, 값이 있으면 숫자 나옴, 안 바뀌니까 const로 선언--%>
    <%--//공백 문자면 모달 창이 아예 안 뜸: bno값을 BoardController에서 받아 옴--%>
    <%--if(result&&result !==''){--%>
    <%--    $('#modal-sm').modal('show')--%>
    <%--    window.history.replaceState(null,'','/board/list');--%>
    <%--    //뒤로 가기 했을 때 모달창이 안 보이게 함--%>
    <%--}--%>

    function movePage(pageNum) {

        actionForm.querySelector("input[name='page']").setAttribute("value",pageNum)

        actionForm.submit()

    }

    function moveRead(bno) {

        actionForm.setAttribute("action","/board/read")

        actionForm.innerHTML+=`<input type="hidden" name="bno" value="\${bno}">`

        actionForm.submit()

    }

</script>

</body>

</html>