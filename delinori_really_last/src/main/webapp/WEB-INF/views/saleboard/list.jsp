<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">중고거래 게시판</h1>
        <a href="/saleboard/register" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">글쓰기</a>
    </div>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">팝니다.</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <div class="row">
                    <div class="col-sm-12 col-md-6">
                        <div class="dataTables_length" id="dataTable_length">
                            <form action="/saleboard/list" method="get" class="form-inline">
                                <label>
                                    Show
                                    <select id="selectSize" name="size" aria-controls="dataTable"
                                            class="custom-select custom-select-sm form-control form-control-sm"
                                            onchange="this.form.submit()">
                                        <option value="10" ${pageMaker.size==10?"selected":""}>10</option>
                                        <option value="25" ${pageMaker.size==25?"selected":""}>25</option>
                                        <option value="50" ${pageMaker.size==50?"selected":""}>50</option>
                                        <option value="100" ${pageMaker.size==100?"selected":""}>100</option>
                                    </select>
                                </label>
                            </form>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 align-items-end">
                        <div class="dataTables_length" id="dataTable_filter">
                            <!-- 검색처리 -->
                            <form action="/saleboard/list" method="get"
                                  class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                                <input type="hidden" name="page" value="1">
                                <input type="hidden" name="size" value="${pageMaker.size}">
                                <div class="dropdown mb-4 input-group">
                                    <select class="btn btn-primary dropdown-toggle" name="type"
                                            id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                        <div class="dropdown-menu animated--fade-in"
                                             aria-labelledby="dropdownMenuButton">
                                            <option value="T" ${pageRequestDTO.type=="T"?"selected":""}>제목</option>
                                            <option value="W" ${pageRequestDTO.type=="W"?"selected":""}>작성자</option>
                                            <option value="C" ${pageRequestDTO.type=="C"?"selected":""}>내용</option>
                                        </div>
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
                <div class="row">
                    <div class="col-sm-12">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                            <tr>
                                <th style="width: 20px">SNO</th>
                                <th>TITLE</th>
                                <th>WRITER</th>
                                <th>REGDATE</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${dtoList}" var="dto">
                                <tr>
                                    <form action="/saleboard/remove" method="post" class="deleteForm">
                                        <td><c:out value="${dto.sno}"></c:out></td>
                                        <td><a href="javascript:moveRead(${dto.sno})">
                                            <c:out value="${dto.title}"></c:out></a>
                                        </td>
                                        <td><c:out value="${dto.writer}"></c:out></td>
                                        <td><c:out value="${dto.regDate}"></c:out></td>
                                        <td><a href="javascript:deleteBoard(${dto.sno})"
                                               class="d-none d-sm-inline-block btn btn-sm btn-primary btnDel">x</a></td>
                                    </form>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- 페이징 -->
                <div class="row">
                    <div class="col-sm-12 col-md-7">
                        <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                            <ul class="pagination">

                                <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
                                        <a href="javascript:movePage(${pageMaker.start -1})"
                                           class="page-link">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="${pageMaker.start}" end="${pageMaker.end}" var="num">
                                    <li class="paginate_button page-item ${pageMaker.page==num?'active':''}">
                                        <a href="javascript:movePage(${num})" class="page-link">${num}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${pageMaker.next}">
                                    <li class="paginate_button page-item next" id="dataTable_next">
                                        <a href="javascript:movePage(${pageMaker.end +1})" class="page-link">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 페이징 End -->


            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
</div>
<!-- End of Main Content -->

<!-- Modal-->
<div class="modal fade" id="submitModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">작업 완료!</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">작업 완료 입니다.</div>
            <div class="modal-footer">
                <button class="btn btn-primary" type="button" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal End -->

<form id="actionForm" action="/saleboard/list" method="get">
    <input type="hidden" name="page" value="${pageMaker.page}">
    <input type="hidden" name="size" value="${pageMaker.size}">

    <c:if test="${pageRequestDTO.type != null}"> <!--검색조건이 있을때는 붙고 없을때는 떨어져-->
        <input type="hidden" name="type" value="${pageRequestDTO.type}">
        <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">
    </c:if>
</form>

<!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/footer.jsp" %>

<script>

    const actionForm = document.querySelector("#actionForm")
    const form = document.querySelector(".deleteForm")

    const result = '${result}'

    if (result && result !== '') {
        $('#submitModal').modal('show')
        window.history.replaceState(null, '', '/saleboard/list')
    }

    function moveRead(sno) {

        actionForm.setAttribute("action", "/saleboard/read")
        actionForm.innerHTML += `<input type='hidden' name='sno' value='\${sno}'>`
        actionForm.submit()

    }

    function movePage(pageNum) {

        actionForm.querySelector("input[name='page']").setAttribute("value", pageNum)

        actionForm.submit()

    }

    function deleteBoard(sno) {

        form.setAttribute("action", "/saleboard/remove")
        form.innerHTML += `<input type='hidden' name='sno' value='\${sno}'>`
        console.log(form)
        form.submit()

    }


</script>

</body>

</html>