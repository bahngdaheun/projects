<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %> <!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">ProFile</h1>

                </div>
                <!-- /.container-fluid -->

                <div>

                    <div class="col-lg-6 mb-4">

                        <!-- Illustrations -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">내정보</h6>
                            </div>
                            <div class="card-body">
                                <div class="text-center">
                                    <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
                                         src="img/undraw_profile_3.svg" alt="...">
                                </div>
                                <div class="card shadow mb-4">
                                     <h6 class="m-0 font-weight-bold text-primary">&nbsp;&nbsp;이&nbsp; 름&nbsp;&nbsp;&nbsp;</h6><input value="최한빛" readonly><br>
                                     <h6 class="m-0 font-weight-bold text-primary">생년월일</h6><input value="1997년 06월 12일" readonly><br>
                                     <h6 class="m-0 font-weight-bold text-primary">&nbsp;&nbsp;주&nbsp; 소&nbsp;&nbsp;&nbsp;</h6><input value="경기도 의정부시 호원동" readonly><br>
                                     <h6 class="m-0 font-weight-bold text-primary">전화번호</h6><input value="010-3082-7201" readonly><br>
                                    <button type="button" id="inforBtn">정보 수정</button>
                                </div>
<%--                                <p>Add some quality, svg illustrations to your project courtesy of <a--%>
<%--                                        target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a--%>
<%--                                    constantly updated collection of beautiful svg images that you can use--%>
<%--                                    completely free and without attribution!</p>--%>
<%--                                <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on--%>
<%--                                    unDraw &rarr;</a>--%>
                            </div>
                        </div>

                        <!-- Approach -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">나의 활동</h6>
                            </div>
                            <div class="card-body">
                                <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce
                                    CSS bloat and poor page performance. Custom CSS classes are used to create
                                    custom components and custom utility classes.</p>
                                <p class="mb-0">Before working with this theme, you should become familiar with the
                                    Bootstrap framework, especially the utility classes.</p>
                            </div>
                        </div>

                    </div>

                </div>
            <!-- End of Main Content -->

<div class="modal fade" id="modal-lg">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">정보수정</h4>
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

<%@ include file="../includes/footer.jsp" %>

<script>
    const inforBtn = document.querySelector("#inforBtn")
</script>

</body>

</html>