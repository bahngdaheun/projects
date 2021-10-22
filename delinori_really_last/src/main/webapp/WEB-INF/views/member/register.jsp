<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Nori Register</title>

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
                <div class="col-lg-6 d-none d-lg-block"><img src="/resources/img/3.jpg" height="560px"></div>
                <div class="col-lg-6">
                    <div class="p-4">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">Create an Nori Account!</h1>
                        </div>

                        <form id="form1" action="/member/register" method="post" class="user">
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
                            <div class="form-group">
                            <button type="submit" id="submitBtn" class="btn btn-primary btn-user btn-block">
                                Nori Register Account
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

<script>
    document.querySelector("#submitBtn").addEventListener("click", (e)=> {
        e.stopPropagation()
        e.preventDefault()
        const form1 = document.querySelector("#form1")
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