<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>--%>

<%--        <sec:authentication property="principal" var="memberDTO"/>--%>

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="d-sm-flex justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">공지</h1>
                    <a href="/notice/register" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">글쓰기</a>
                </div>





<%--                <div class="login_area">--%>
<%--                    <sec:authorize access="isAnonymous()">--%>
<%--&lt;%&ndash;                        <div class="login_button"><a href="/customLogin">로그인</a> </div>&ndash;%&gt;--%>
<%--                        <a href="/customLogin" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">로그인</a>--%>
<%--                    </sec:authorize>--%>



<%--                    <sec:authorize access="isAuthenticated()">--%>
<%--&lt;%&ndash;                        <div class="login_success_area">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <a href="/notice/logout">로그아웃</a>&ndash;%&gt;--%>
<%--                             <a href="/customLogout" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">로그아웃</a>--%>
<%--&lt;%&ndash;                        </div>&ndash;%&gt;--%>

<%--                    </sec:authorize>--%>
<%--                </div>--%>



<%--                <form action="/customLogout" method="post">--%>
<%--                    <sec:authorize access="isAuthenticated()">--%>
<%--                    <input type="hidden" id="${memberDTO.mid}" value="${memeberDTO.pw}"/>--%>
<%--                    <button>로그아웃</button>--%>
<%--                    </sec:authorize>--%>
<%--                </form>--%>





                <p class="mb-4"> </p>
                </div>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">공지</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>글번호</th>
                                    <th>내용</th>
                                    <th>작성자</th>
                                    <th>내용</th>
                                    <th>등록시간</th>
<%--                                    <th>수정시간</th>--%>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${dtoList}" var="dto">
                                    <tr onclick="javascript:moveRead(${dto.nno})">
                                        <td><c:out value="${dto.nno}"></c:out></td>
                                        <td> <c:out value="${dto.title}"></c:out></td>
                                        <td><c:out value="${dto.writer}"></c:out></td>
                                        <td><c:out value="${dto.content}"></c:out></td>
                                        <td><c:out value="${dto.regDate}"></c:out></td>
<%--                                        <td><c:out value="${dto.modDate}"></c:out></td>--%>
                                </c:forEach>
                                </tbody>
                            </table>


                            <form action="/notice/list" method="get"
                                  class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                                <input type="hidden" name="page" value="1">
                                <input type="hidden" name="size" value="${pageMaker.size}">


                                <div class="dropdown mb-4 input-group">
                                    <select class="btn btn-primary dropdown-toggle" name="type"
                                            id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                        <p class="st">
                                        <div class="dropdown-menu animated--fade-in"
                                             aria-labelledby="dropdownMenuButton">
                                            <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                            <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>작성자</option>
                                            <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                        </div>
                                        </p>
                                    </select>
                                    <input type="text" class="form-control bg-light border-0 small"
                                           placeholder="검색어를 입력해주세요"
                                           aria-label="Search" aria-describedby="basic-addon2"
                                           name="keyword" value="${pageRequestDTO.keyword}">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary" type="submit">
                                            <i class="fas fa-search fa-sm"></i>
                                        </button>
                                    </div>
                                </div>

                            </form>
                            <!-- 검색처리 END -->


                        </div>
                    </div>
                </div>


                <style>
                    .st{
                        margin-left: 5cm;
                    }
                </style>







                        </div>

                        <div class="card-footer clearfix">
                            <ul class="pagination pagination-sm m-0 float-right">
                                <c:if test="${pageMaker.prev}">
                                    <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.start -1})"> << </a></li>
                                </c:if>

                                <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                                    <li class="page-item ${pageMaker.page == num?'active': ''}"><a class="page-link" href="javascript:movePage(${num})">${num}</a></li>
                                </c:forEach>   <!--1부터 10까지 돌아서 페이지번호 찍히게 forEach 선언-->
                                <!--c아웃 대신 a태그를  쓴 이유가 단순 클릭해서 페이지를 넘기기는 때문에, c 아웃은 공격 방어-> 단순처리가 그럴 일이 없어서 a태그 사용-->

                                <c:if test="${pageMaker.next}">
                                    <li class="page-item"><a class="page-link" href="javascript:movePage(${pageMaker.end + 1})"> >> </a></li>
                                </c:if>

                            </ul>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->
</div>
<!-- End of Page Wrapper -->







<form id="actionForm" action="/notice/list" method="get">

    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}"> <!--검색 조건 있을 때만 URL에 나오게-->
        <input type="hidden" name="type" value= "${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value= "${pageRequestDTO.keyword}"> <!--검색 조건과 키워드가 유지를 해주려고 사용-->
    </c:if>

</form>


<%@ include file="../includes/footer.jsp" %>





<script>

    const actionForm = document.querySelector("#actionForm")  // 아이디 값을 가져옴

    const result = '${result}'

    if(result && result !== ''){
        $('#modal-sm').modal('show')

        window.history.replaceState(null, '', '/notice/list');
    }


    function movePage(pageNum) {

        //클릭한 페이지 번호 값으로 바꾼다.
        actionForm.querySelector("input[name='page']") .setAttribute("value",pageNum)  // 페이지 엘리먼트
        // 페이지번호 누르면 해당 페이지로 이동.
        actionForm.submit()

        //#이랑 . 이 css의 셀렉터 기능
    }


    function moveRead(nno){
        // alert(bno)
        actionForm.setAttribute("action","/notice/read") // read 로 이동하도로
        actionForm.innerHTML += `<input type = 'hidden' name = 'nno' value = '\${nno}'>` // 단순 문자로 인식하게 \$로 작성
        actionForm.submit()


    }


</script>



</body>
</html>