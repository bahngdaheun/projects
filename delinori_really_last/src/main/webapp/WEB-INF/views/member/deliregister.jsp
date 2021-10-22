<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Deli Register</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

<div class="container">

    <div class="row justify-content-center">
        <div class="col-xl-10 col-lg-9 col-md-7">
            <div class="card o-hidden border-0 shadow-lg my-0">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-6 d-none d-lg-block"><img src="/resources/img/2.jpg" height="590px"></div>
                        <div class="col-lg-6">
                            <div class="p-4">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4">Create an Deli Account!</h1>
                                </div>

                        <form id="form1" action="/member/deliregister" method="post" class="user">
                            <div class="form-group">
                                <input type="text" name="mid" class="form-control form-control-user" id="mid"
                                       placeholder="ID">
                            </div>
                            <div class="form-group">
                                <input type="text" name="mname" class="form-control form-control-user" id="mname"
                                       placeholder="NAME">
                            </div>
                            <div class="form-group">
                                <input type="password" name="mpw" class="form-control form-control-user" id="mpw"
                                       placeholder="PASSWORD">
                            </div>
                            <div class="form-group">
                                <input type="text" name="maddress" class="form-control form-control-user" id="maddress"
                                       placeholder="ADDRESS">
                            </div>
                            <div class="form-group">
                                <input type="email" name="memail" class="form-control form-control-user" id="memail"
                                       placeholder="EMAIL">
                            </div>
                            <div class="form-group">
                                <input type="text" name="mphone" class="form-control form-control-user" id="mphone"
                                       placeholder="PHONE">
                            </div>
                            <div class="input-group">
                                <input type="file" class="form-control" name="uploadFiles" id="InputFile" multiple>
                                <span class="input-group-text" id="uploadBtn">Upload</span>
                            </div>
                            <div class="uploadResult"></div>
                            <div class="temp"></div>
                            <div class="form-group">
                                <br>
                                <button type="submit" id="submitBtn" class="btn btn-primary btn-user btn-block">
                                    Deli Register Account
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script>
    const uploadResultDiv=document.querySelector(".uploadResult")//div로 담아서 전달

    document.querySelector("#uploadBtn").addEventListener("click",(e)=>{
        const formData=new FormData()
        const fileInput=document.querySelector("input[name='uploadFiles']")

        for(let i=0; i<fileInput.files.length; i++){
            formData.append("uploadFiles", fileInput.files[i])
            //uploadFiles란 이름으로 컨트롤러에 보내준다
        }

        console.log(formData)

        const headerObj={headers:{'Content-Type': 'multipart/form-data'}}
        axios.post("/member/upload",formData,headerObj).then((response)=>{//버튼 누르면 upload 호출
            const arr=response.data
            console.log(arr)
            let str=""
            for(let i=0; i<arr.length; i++){//배열이니까 루프로 돌림
                const {uuid, fileName, uploadPath, image, thumbnail, fileLink}={...arr[i]}//스프레드 연산자로 쫙 펼침
                if(image){
                    str+=`<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                          <img src='/member/viewFile?file=\${thumbnail}'/><span>\${fileName}</span>
                          <button onclick="javascript:removeFile('\${fileLink}', event)">X</button></div>`
                }else {
                    str+=`<div data-uuid='\${uuid}' data-filename='\${fileName}' data-uploadpath='\${uploadPath}' data-image='\${image}'>
                          <a href='/member/downFile?file=\${fileLink}'>\${fileName}</a>
                          <button onclick="javascript:removeFile('\${fileLink}', event)">X</button></div>`
                }
            }
            uploadResultDiv.innerHTML+=str//업로드를 여러 번 할 수 있으니까 누적
        })
    },false)

    function removeFile(fileLink, event){

        event.preventDefault()
        event.stopPropagation()

        console.log(fileLink)
        axios.post("/member/removeFile", {fileName:fileLink}).then(response=>{
            const targetDiv=event.target.parentElement//버튼의 상위 요소를 가져 옴
            targetDiv.remove()//삭제
        })
    }


    document.querySelector("#submitBtn").addEventListener("click", (e)=> {
        e.stopPropagation()
        e.preventDefault()
        const form1 = document.querySelector("#form1")
        const fileDivArr=uploadResultDiv.querySelectorAll("div")

        if(!fileDivArr){//만약 첨부파일이 없다면 그걸로 끝이고 바로 등록
            form1.submit()
            return
        }
        let str="";
        for(let i=0; i<fileDivArr.length; i++){//첨부파일 1개당 배열 1개니까 배열 길이가 파일 개수와 같음
            //console.log(fileDivArr[i])
            const target=fileDivArr[i]
            const uuid=target.getAttribute("data-uuid")
            const fileName=target.getAttribute("data-filename")
            const uploadPath=target.getAttribute("data-uploadpath")
            const image=target.getAttribute("data-image")

            //input 태그 4개 생성
            str+=`<input type='hidden' name='files[\${i}].uuid' value='\${uuid}'>`
            str+=`<input type='hidden' name='files[\${i}].fileName' value='\${fileName}'>`
            str+=`<input type='hidden' name='files[\${i}].uploadPath' value='\${uploadPath}'>`
            str+=`<input type='hidden' name='files[\${i}].image' value='\${image}'>`
        }
        document.querySelector(".temp").innerHTML+=str
        form1.submit()
    }, false)

</script>

<!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>

</body>
</html>