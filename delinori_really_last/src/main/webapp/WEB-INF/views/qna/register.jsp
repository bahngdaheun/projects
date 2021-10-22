<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--헤더 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/header.jsp" %>

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">REGISTER</h1>
                        </div>
                        <form id="form1" action="/qna/register" method="post">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" name="title" class="form-control form-control-user" id="title"
                                       placeholder="title">
                            </div>
                            <label for="writer">Writer</label>
                            <div class="form-group">
                                <input type="text" name="writer" class="form-control form-control-user" id="writer"
                                       placeholder="writer">
                            </div>
                            <label for="content">Content</label>
                            <div class="form-group">
                                <textarea name="content" class="form-control form-control-user" id="content"
                                          placeholder="content"></textarea>
                            </div>

                            <div class="temp">

                            </div>

                            <div class="form-inline justify-content-end">
                                <button type="submit" id="submitBtn" class="btn btn-primary">SUBMIT
                                </button>
                            </div>

                        </form>

                        <hr/>

                        <!-- upload -->

                        <div class="card-header py-3 ">
                            <h6 class="m-0 font-weight-bold text-primary">FILE UPLOAD</h6>
                        </div>

                        <div class="file-upload">
                            <div class="input-file-group form-inline justify-content-between">
                                <div class="form-inline">
                                    <input type="text" class="form-control bg-light border-0 small fileInput"
                                           id="fileName" value="선택된 파일 없음" readonly>
                                    <label for="inputFiles">
                                        <div type="button" class="btn btn-primary">
                                            <i class="fas fa-file-upload fa-sm"></i>
                                        </div>
                                    </label>
                                    <input type="file" name="uploadFiles" id="inputFiles" multiple hidden>
                                </div>

                                <div class="input-group-append flex-end">
                                    <span class="btn btn-primary" id="uploadBtn">UPLOAD</span>
                                </div>
                            </div>

                            <div class="uploadResult">

                            </div>

                        </div>
                    </div>
                    <!-- upload END -->

                </div>
            </div>
        </div>
    </div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>

    const uploadResultDiv = document.querySelector(".uploadResult")

    document.querySelector("#uploadBtn").addEventListener("click", (e) => {

        const formData = new FormData()
        const fileInput = document.querySelector("input[name='uploadFiles']")

        for (let i = 0; i < fileInput.files.length; i++) {
            formData.append("uploadFiles", fileInput.files[i])

        }

        console.dir(formData)

        const headerObj = {headers: {'Content-Type': 'multipart/form-data'}}

        axios.post("/qna/upload", formData, headerObj).then((response) => {
            const arr = response.data
            console.log(arr)
            let str = ""
            for (let i = 0; i < arr.length; i++) {

                const {uuid, fileName, uploadPath, image, thumbnail, fileLink} = {...arr[i]} //스프레드 연산자 써서 값 꺼냄

                if (image) {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <img src='/qna/viewFile?file=\${thumbnail}'/>
                            <button onclick="javascript:removeFile('\${fileLink}',this)">x</button></div>`
                } else {
                    str += `<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                            <a href="/qna/downFile?file=\${fileLink}">\${fileName}</a><button onclick="javascript:removeFile('\${fileLink}',this)">x</button></div>`
                }

            }//enf for

            uploadResultDiv.innerHTML += str

        })

    }, false)

    function removeFile(fileLink, ele) {
        console.log(fileLink)
        axios.post("/qna/removeFile", {fileName: fileLink}).then(response => {
            const targetDiv = ele.parentElement
            targetDiv.remove()
        })
    }

    const form1 = document.querySelector("#form1")

    document.querySelector("#submitBtn").addEventListener("click", (e) => {
        e.stopPropagation()
        e.preventDefault()

        const fileDivArr = uploadResultDiv.querySelectorAll("div")

        if (!fileDivArr) {
            form1.submit()
            return
        }

        let str = ""
        for (let i = 0; i < fileDivArr.length; i++) {
            const target = fileDivArr[i]
            const uuid = target.getAttribute("data-uuid")
            const fileName = target.getAttribute("data-filename")
            const uploadPath = target.getAttribute("data-uploadpath")
            const image = target.getAttribute("data-image")

            str += `<input type='hidden' name='files[\${i}].uuid' value='\${uuid}'>`
            str += `<input type='hidden' name='files[\${i}].fileName' value='\${fileName}'>`
            str += `<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}'>`
            str += `<input type='hidden' name='files[\${i}].image' value='\${image}'>`
        }

        document.querySelector(".temp").innerHTML = str

        form1.submit()

    }, false)

</script>

<!--푸터 붙여넣기( 앞으로 이거 긁어 쓰세요 ) -->
<%@ include file="../includes/footer.jsp" %>

</body>

</html>