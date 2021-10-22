package com.noriteo.delinori.board.controller;

import com.noriteo.delinori.board.dto.UploadResponseDTO;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Log4j2
public class BoardUploadController {


    @ResponseBody
    @PostMapping("/board/removeFile")
    public ResponseEntity<String> removeFile(@RequestBody Map<String, String> data)throws Exception{
        //가지고 올 정보가 String타입이여서 선언함, 뭐때문인지 모르지만 파라미터를 하나밖에 못쓰니까 여러개 쓰려고 Map<>사용

        File file = new File("C:\\upload"+ File.separator+data.get("fileName"));

        boolean checkImage = Files.probeContentType(file.toPath()).startsWith("image");//이미지인지 체크

        file.delete();//체크 했으니까 삭제

        if(checkImage) {//만약 이미지면
            File thumbnail = new File(file.getParentFile(),"s_" + file.getName());//썸네일 사진을 찾아서
            //file.getParentFile()는 상위폴더이고 거기서 썸네일을 찾는다 (부모폴더)
            log.info(thumbnail);//로그 찍어서 확인 주고
            thumbnail.delete();//삭제한다
        }
        return ResponseEntity.ok().body("deleted");//delete되는 정보를 Http에 넘겨준다. ok()찾아보기
    }

    @GetMapping("/board/downFile")//첨부파일만 별도로 만들어서 관리하는 서버
    //무슨 타입인지 모르니까 ResponseEntity<byte[]> 로 선언했다.
    public ResponseEntity<byte[]> download(@RequestParam("file") String fileName)throws Exception{//byte단위로 배열로 받아옴

        File file = new File("C:\\upload"+ File.separator+fileName);//업로드한 파일이 있는위치를 가리킨다

        String orignalFileName = fileName.substring(fileName.indexOf("_")+1);//uuid잘라주는역할

        HttpHeaders headers = new HttpHeaders();//HttpHeader에 여러기능이 있다
        headers.add("Content-Type","application/octet-stream");//다양한 타입의 파일을 처리해주는 역할(pdf,png..등등)
        headers.add("Content-Disposition","attachment; filename="//Disposition이 다운로드한 파일이름을 우리가 원하는 방식으로 지정하는 역할,
                + new String (orignalFileName.getBytes(StandardCharsets.UTF_8),"ISO-8859-1"));//attachment은 첨부라는 뜻
        byte[] data = FileCopyUtils.copyToByteArray(file);//copyToByteArray은 파일을 주면 자동으로 byte배열을 생성한다, byte단위로 카피한다(다운로드)

        return ResponseEntity.ok().headers(headers).body(data);//들어간 내용이 잘되면 ok! 그리고 반환
    }

    @GetMapping("/board/viewFile")//조회하는 친구
    @ResponseBody//순수한 이미지를 보낼때 사용
    public ResponseEntity<byte[]> viewFile(@RequestParam("file")/*실제 보낼때는 file로 보내고*/ String fileName/*filename으로 받는다*/)throws Exception {
        //ResponseEntity<byte[]>은 첨부파일 타입이 다르면 헤더 메세지를 조작하려고 사용한다

        //url호출할때 이렇게 적는다 C:\\upload\\2021/09/08/스크린샷.jpg 그후 로그에 그파일 경로가 찍히는지 확인인
        File file = new File("C:\\upload" + File.separator + fileName);
        log.info(file);//파일이 존재하는지 여부확인
        ResponseEntity<byte[]> result = null;//결과 데이터를 받아오기(초기화)

        byte[] data = FileCopyUtils.copyToByteArray(file);//바이트의 배열로 카피

        //mime type
        String mimeType = Files.probeContentType(file.toPath());//적절한 마임타입이 나온다

        log.info("mimeType:" + mimeType);
//        HttpHeaders httpHeaders = new HttpHeaders();
//        httpHeaders.add("Content-type", mimeType);

        result = ResponseEntity.ok().header("Content-Type", mimeType).body(data);//만들어진 공간에 헤더에 있는정보를 준다, 응답코드 메세지를 만들어준다
        //header 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송할 수 있다  body:HTTP의 request 또는 response가 전송하는 데이터

        return result;
    }


    @ResponseBody//Json으로 처리된다
    @PostMapping("/board/upload")
    public List<UploadResponseDTO> uploadPost(MultipartFile[] uploadFiles ) {

        log.info("------------------------------");
        if(uploadFiles != null && uploadFiles.length > 0 ){//파일이 비어있지 않다면

            List<UploadResponseDTO> uploadedList = new ArrayList<>();//어레이리스트를 선언하고

            for(MultipartFile multipartFile : uploadFiles) {//포문을 돌리는데
                try {
                    //어레이리스트에 추가하고
                    uploadedList.add(uploadProcess(multipartFile));//메소드 실행해라
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return uploadedList;//리스트로 반환

        }//end
        return null;
    }

    private UploadResponseDTO uploadProcess(MultipartFile multipartFile) throws Exception{
        String  uploadPath = "C:\\upload";//경로



        log.info(multipartFile);//이미지 파일인지 여러가지 등등 체크할수있다

        log.info(multipartFile.getOriginalFilename());//파일 이름
        log.info(multipartFile.getSize());//파일 사이즈
        log.info("----------------------------------------");//여기까지 파일 이름 사이즈를 알수있고 이제 카피를 해야함

        String folderName = makeFolder(uploadPath);
        String fileName = multipartFile.getOriginalFilename();//파일 이름 지정
        String uuid = UUID.randomUUID().toString();
        String originalFileName = fileName;

        fileName = uuid+"_"+fileName;//파일 이름이 랜덤하게 만들어진다(중복방지)
        File savedFile = new File(uploadPath/*경로*/+File.separator+folderName, fileName);//폴더 생성하고 경로랑 이름을 설정해준다.

        //FileCopyUtils: 카피할수있는 메소드들의 집합체인 클래스
        FileCopyUtils.copy(multipartFile.getBytes(), savedFile);//카피 성공

        //썸네일 처리
        String mimeType = multipartFile.getContentType();//파일 타입
        boolean checkImage = mimeType.startsWith("image");//이미지가 이미지라면
        if(checkImage){//내타입이 이미지라면
            File thumbnailFile = new File(uploadPath+File.separator+folderName,"s_"+fileName);//썸네일로(s_) 만든다
            Thumbnailator.createThumbnail(savedFile,thumbnailFile,100,100);//타입은 in,out으로 하면 썸네일이 생긴다,노래파일은 X
        }

        return UploadResponseDTO.builder()
                .uuid(uuid)
                .uploadPath(folderName.replace(File.separator,"/"))//경로를 통일 시켜주는것
                .fileName(originalFileName)
                .image(checkImage)
                .build();

    }

    private String makeFolder(String uploadPath) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();//날짜 생성
        String str = simpleDateFormat.format(date);//오늘날짜 만들어줌  2021-09-07
        String folderName = str.replace("-", File.separator);// /를 -로 바꿔준다(경로) win=\\
        File uploadFolder = new File(uploadPath, folderName);//파일이 있는지 확인
        if(uploadFolder.exists()==false){//만약에 없다면
            uploadFolder.mkdirs();//폴더(파일) 만들어준다
        }
        return folderName;
    }
}
