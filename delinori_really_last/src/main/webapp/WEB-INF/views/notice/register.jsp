<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/header.jsp"%>


<body class="bg-gradient-primary">

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
<%--                <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>--%>
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">게시물 등록</h1>
                        </div>
                        <form id="form1" action="/notice/register" method="post">
                            <div>
                                <div class="form-group">
                                    <label for="exampleInputEmail">작성자</label>
                                    <input type="text" name="writer" class="form-control form-control-user" id="exampleInputEmail"
                                           placeholder="writer" readonly>
                                </div>
                            </div>

                            <div>
                                <div class="form-group">
                                    <label for="exampleInputEmail2">제목</label>
                                    <input type="text" name="title" class="form-control form-control-user" id="exampleInputEmail2"
                                           placeholder="title">
                                </div>
                            </div>

                            <div>
                                <div class="form-group">
                                    <label for="content">내용</label>
                                    <textarea name="content" class="form-control form-control-user" id="content" placeholder="content"></textarea>
                                </div>
                            </div>

                            <div class="temp"></div>


                        </form>







                        <style>
                            .uploadResult {
                                display: flex;
                                justify-content: center;
                                flex-direction: row;
                            }
                        </style>


                        <label for="exampleInputFile">파일 등록</label>
                        <div class="input-group">
                            <div class="custom-file">
                                <input type="file" name="uploadFiles" class="custom-file-input" id="exampleInputFile" multiple>
                                <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                            </div>
                            <div class="input-group-append">
                                <span class="input-group-text" id="uploadBtn">Upload</span>
                            </div>
                        </div>


                        <div class="uploadResult">

                        </div>


                        <br/><br/>
                        <div>
                        <button type="submit" id="submitBtn" class="btn btn-primary btn-user btn-block">등록</button>
                        </div>




                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<%@ include file="../includes/footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

const form1 = document.querySelector("#form1")

document.querySelector("#submitBtn").addEventListener("click", ()=> {
    form1.submit()
},false)






const uploadResultDiv = document.querySelector(".uploadResult")

document.querySelector("#uploadBtn").addEventListener("click", (e) => {

    const formData = new FormData()
    const fileInput = document.querySelector("input[name = 'uploadFiles']")

    for (let i =0; i < fileInput.files.length; i++){
        formData.append("uploadFiles", fileInput.files[i]) //컨트롤에서 받는 이름 . 파라미터 이름. "uploadFiles"이름 중요

    } // 같은 이름으로 여러개를 담는게 핵심

    console.log(formData)   //dir - 속성 값들이 자세히 나옴. 폼 데이터가 어떻게 나오는지.....

    //axios 로 업로드
    const headerObj = { headers: {'Content-Type' : 'multipart/form-data'}}

    axios.post("/notice/upload", formData, headerObj).then((response) => {
        const arr = response.data
        console.log(arr)
        let str = ""
        // 루프생성, 스프레드 연산자 이용
        for(let i = 0; i < arr.length; i ++) {
            const {uuid,fileName,uploadPath, image, thumbnail, fileLink} = {...arr[i]}

            if (image) {
                str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><img src='/notice/viewFile?file=\${thumbnail}'/><span>\${fileName}</span>
                            <button onclick="javascript:removeFile('\${fileLink}',this)" >x</button></div>` // 업로드를 여러번 할 수 있어서 누적. this 는 현재 객체를 의미
            } else{
                str += `<div data-uuid='\${uuid}'data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'><a href='/notice/downFile?file=\${fileLink}'>\${fileName}</a></div>`
            }

        } //end for
        uploadResultDiv.innerHTML += str
    })

},false)

function removeFile(fileLink,ele) {
    console.log(fileLink)
    axios.post("/notice/removeFile", {fileName:fileLink}).then(response => {
        const targetDiv = ele.parentElement
        targetDiv.remove()
    })
}

document.querySelector("#submitBtn").addEventListener("click", (e) => {
    e.stopPropagation()
    e.preventDefault()
    //현재 화면에 있는 파일 정보를 hidden 태그들로 변화
    const form1 = document.querySelector("#form1") //원래 있던 innerHTML에 추가해서 str을 만든다?
    const fileDivArr = uploadResultDiv.querySelectorAll("div")

    if (!fileDivArr){ //첨부파일이 없으면 바로 등록해줘. 파일 정보 4개가 없으면 등록하면 돼~

        form1.submit()

        return
    }

    let str = "";
    for (let i = 0; i < fileDivArr.length ; i++) {
        const target = fileDivArr[i]
        const uuid = target.getAttribute("data-uuid")
        const fileName = target.getAttribute("data-filename")
        const uploadPath = target.getAttribute("data-uploadpath")
        const image = target.getAttribute("data-image")

        str += `<input type='hidden' name='files[\${i}].uuid' value='\${uuid}' >`
        str += `<input type='hidden' name='files[\${i}].fileName' value='\${fileName}' >`
        str += `<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}' >`
        str += `<input type='hidden' name='files[\${i}].image' value='\${image}' >`
    }

    document.querySelector(".temp").innerHTML = str
    //form1.innerHTML += str
    form1.submit()
    //form을 submit

},false)



</script>

</body>
</html>