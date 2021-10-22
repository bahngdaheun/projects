<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../includes/header.jsp" %> <!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%--<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>--%>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">자유게시판</h1>
        <a href="/board/list" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                class="fas fa-download fa-sm text-white-50"></i>list</a>
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
                <form action="/board/register" method="post" id="form1">
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Title</label>
                            <input type="text" name="title" class="form-control" id="exampleInputEmail1" placeholder="제목을 입력하세요.">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail2">Writer</label>
                            <input type="text" name="writer" class="form-control" id="exampleInputEmail2" placeholder="작성자를 입력하세요." readonly value="<sec:authentication property="principal.mid"/>">
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <!-- textarea -->
                                <div class="form-group">
                                    <label>Textarea</label>
                                    <textarea name="content" class="form-control" rows="3" placeholder="내용을 입력하세요"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="temp">

                    </div>

                    <div class="card-footer">
                        <button type="submit" id="submitBtn" class="btn btn-primary">Submit</button>
                    </div>

                </form>

                </form>
                <style>
                    .uploadResult {
                        display: flex;
                        justify-content: center;
                        flex-direction: row;
                    }
                </style>

                <label for="exampleInputFile">File input</label>
                <div class="input-group">
                    <div class="custom-file">
                        <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile" multiple>
                        <label class="custom-file-label" for="exampleInputFile" >Choose file</label>
                    </div>
                    <div class="input-group-append">
                        <span class="input-group-text" id="uploadBtn">Upload</span>
                    </div>
                </div>

                <div class="uploadResult">
                    <%--                            첨부파일 목록--%>

                </div>

            </div>
        </div>
    </div>
</div>
</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%--<form id="actionForm" action="/board/list" method="get">--%>
<%--    <input type="hidden" name="page" value="${pageRequestDTO.page}">--%>
<%--    <input type="hidden" name="size" value="${pageRequestDTO.size}">--%>

<%--        <c:if test="${pageRequestDTO.type != null}">--%>
<%--            <input type="hidden" name="type" value="${pageRequestDTO.type}">--%>
<%--            <input type="hidden" name="keyword" value="${pageRequestDTO.keyword}">--%>
<%--        </c:if>--%>
<%--        하단에 검색창에 보여지는것--%>
<%--</form>--%>

<%@ include file="../includes/footer.jsp" %> <!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

    const uploadResultDiv = document.querySelector(".uploadResult")//첨부파일 목록 클래스 불러온거

    document.querySelector("#uploadBtn").addEventListener("click",(e)=>{

        const formData = new FormData()//ajax로 폼 전송을 가능하게 해주는 친구
        const fileInput = document.querySelector("input[name='uploadFiles']")


        for(let i = 0; i <fileInput.files.length; i++) {//사용자가 파일을 몇개 추가했는지

            formData.append("uploadFiles", fileInput.files[i])//파일 인풋의 파일 i번쨰,
        }

        console.log(fileInput)

        //axios로 업로드
        const headerObj =  {hearders: {"Content-Type": "multipart/form-data"}}

        axios.post("/board/upload", formData, headerObj).then((response)=>{
            const arr = response.data
            console.log(arr)

            let str = ""
            for(let i =0; i<arr.length; i++){//돌려서
                const{uuid, fileName, uploadPath, image,thumbnail,fileLink} = {...arr[i]}// 하나로묶고

                if(image){//이미지라면
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}'data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <img src='/board/viewFile?file=\${thumbnail}'><span>\${fileName}</span>
                            <button onclick="javascript:removeFile('\${fileLink}',this/*삭제하려고*/)">X</button></div>`//버튼을 누르면 링크(경로)가 떠야함
                    //이미지를 쌓아도 안보이고 보안상 이렇게 하면 안됨,
                    // 이미지 서버가 따로 있으면 좋음,클라우를 사용하면 거기에 업로드를 하면좋다
                }else {//아니라면
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <a href='/board/downFile?file=\${fileLink}'>\${fileName}</a></div>`
                }


            }
            uploadResultDiv.innerHTML += str//쌓이게
        },false)
        //uploadController가서 PostMapping작성

    },false)

    function removeFile(fileLink,ele) {//삭제하는 메소드
        console.log(fileLink)
        axios.post("/board/removeFile", {fileName:fileLink}).then(response =>{
            const targetDiv = ele.parentElement
            targetDiv.remove()
        })
    }
    document.querySelector("#submitBtn").addEventListener("click", (e)=>{
        e.stopPropagation()
        e.preventDefault()
        //현재 화면에 있는 파일 정보를 hidden태그들로 변화
        const form1 = document.querySelector("#form1")
        const fileDivArr = uploadResultDiv.querySelectorAll("div")//for문돌려서 div에 쌓인 정보를 fileDivArr에 넣었다.

        if(!fileDivArr) {//첨부파일이 없다면 바로 등록해라
            form1.submit()
            return
        }
        let str = ""
        for(let i = 0; i<fileDivArr.length; i++) {
            const target = fileDivArr[i]
            const uuid = target.getAttribute("data-uuid")
            const fileName =target.getAttribute("data-filename")
            const uploadPath =target.getAttribute("data-uploadpath")
            const image =target.getAttribute("data-image")

            //\${}는 변수로(값)으로 받는거
            str += `<input type="hidden" name="files[\${i}].uuid" value="\${uuid}">`
            str += `<input type="hidden" name="files[\${i}].fileName" value="\${fileName}">`
            str += `<input type="hidden" name="files[\${i}].uploadPath" value="\${uploadPath}">`
            str += `<input type="hidden" name="files[\${i}].image" value="\${image}">`
        }
        document.querySelector(".temp").innerHTML += str
        // document.querySelector("#form1").innerHTML += str
        // //form을 submit
        // form1.innerHTML += str
        form1.submit()//첨부파일이 있을때
    },false)
</script>

</body>
</html>
