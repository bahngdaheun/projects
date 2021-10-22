package com.noriteo.delinori.notice.controller;


import com.noriteo.delinori.notice.dto.NoticeUploadResponseDTO;
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

@Log4j2
@Controller
public class NoticeUploadController {

    @GetMapping("/notice/upload")
    public void uploadGET() {

    }

    @ResponseBody
    @PostMapping("/notice/removeFile")
    public ResponseEntity<String> removeFile(@RequestBody Map <String,String> data) throws Exception { //post 방식으로 axios 호출해야한다

        // 2021/09/08/
        File file = new File("/Users/cloud/upload" + File.separator + data.get("fileName"));

        boolean checkImage = Files.probeContentType(file.toPath()).startsWith("image");

        //원본 파일 삭제
        //파일을 찾아서 이미지 파일인지 확인을 하고 이미지였으면 썸네일이 있을 것 -> 같이 지워야한다.
        file.delete();

        //썸네일 삭제
        if (checkImage){
            File thumbnail = new File(file.getParent(), "s_" + file.getName());
            log.info(thumbnail);
            thumbnail.delete();
        }
        return ResponseEntity.ok().body("deleted"); // ok 는 응답코드 메세지를 만들어준다 - 콘솔에 헤더에 메시지를 준다 ok - 스프링 방식
    }

    @GetMapping("/notice/downFile")
    public ResponseEntity<byte[]> download(@RequestParam("file") String fileName) throws Exception { //여기까지 하면 파일은 찾는다.헤더 메시지가 달라져야하고 컨텐츠 타입도 달라져야한다.

        File file = new File("/Users/cloud/upload" + File.separator + fileName);

        String originalFileName = fileName.substring(fileName.indexOf("_") + 1);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/octet-stream"); // 지금부터 컨텐츠 타입은 무조건 다운로드 해줘!
        headers.add("Content-Disposition" , "attachment; filename= "
                + new String(originalFileName.getBytes(StandardCharsets.UTF_8),"ISO-8859-1"));
        byte[] data = FileCopyUtils.copyToByteArray(file);

        return ResponseEntity.ok().headers(headers).body(data);
    }


    @GetMapping("/notice/viewFile")
    @ResponseBody
    //파라미터를 받을 때는 파일로 받는데 실제로 받을 때는 변수로 받는다 -> 일치하지 않아도 받게끔. 파일 이름 -> 파일 변수
    public ResponseEntity<byte[]> viewFile(@RequestParam("file") String fileName) throws Exception { //순수한 이미지 데이터를 보내줌

        // C:\\upload\\2021\\09\\08\\cat.jpg
        File file = new File("/Users/cloud/upload" + File.separator+fileName);

        log.info(file);

        ResponseEntity<byte[]> result = null;

        byte[] data = FileCopyUtils.copyToByteArray(file);

        //mime type
        String mimeType = Files.probeContentType(file.toPath());

        log.info("mimeType : " + mimeType);

        // ok 는 응답코드 메세지를 만들어준다
        // 상황에 따라서 http 메시지를 가공 할 수 있다.
        //
        result = ResponseEntity.ok().header("Content-Type", mimeType).body(data);

        return result;
    }

    @ResponseBody  //rest 컨트롤러처럼 리턴 타입이 json으로 처리
    @PostMapping("/notice/upload")
    public List<NoticeUploadResponseDTO> uploadPost (MultipartFile[] uploadFiles) {

        log.info("---------------------");
        if (uploadFiles != null && uploadFiles.length > 0) {

            List<NoticeUploadResponseDTO> uploadedList = new ArrayList<>();

            for (MultipartFile multipartFile : uploadFiles) {
                try {
                    uploadedList.add(uploadProcess(multipartFile));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } //for
            return uploadedList;
        } //end
        return null;
    }

    private NoticeUploadResponseDTO uploadProcess(MultipartFile multipartFile) throws Exception{

        // window "C:\\upload";
        String uploadPath = "/Users/cloud/upload";

        String folderName = makeFolder(uploadPath); //21-09-07

//        log.info(multipartFile);//이미지 파일인지 여러가지 등등 체크할수있다


//        log.info(multipartFile.getOriginalFilename());//파일 이름
//        log.info(multipartFile.getSize());
//        log.info("----------------------------------------");//여기까지 파일 이름 사이즈 타입을 알수있고 이제 카피를 해야함
        String fileName = multipartFile.getOriginalFilename();//파일 이름 지정
        String uuid = UUID.randomUUID().toString();
        String originalFileName = fileName;

        fileName = uuid + "_" + fileName;

        File savedFile = new File(uploadPath + File.separator + folderName, fileName);

//        FileCopyUtils.copy(multipartFile.getBytes(), savedFile);//카피 성공

        FileCopyUtils.copy(multipartFile.getBytes(), savedFile);

        //썸네일 처리 (Thumbnail 처리)
        String mimeType = multipartFile.getContentType();  //이게 이미지라면 여기에 맞게 이미지 파일을 만들 필요가 있다?
        boolean checkImage = mimeType.startsWith("image");
        if (checkImage){
            File thumbnailFile =  new File(uploadPath + File.separator + folderName, "s_" + fileName);
            Thumbnailator.createThumbnail(savedFile, thumbnailFile, 100,100); //
        }

        return NoticeUploadResponseDTO.builder()
                                .uuid(uuid)
                                .uploadPath(folderName.replace(File.separator,"/"))  //    /로 통일
                                .fileName(originalFileName)
                                .image(checkImage)
                                .build();
                    }

    private String makeFolder(String uploadPath) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = simpleDateFormat.format(date); //2021-09-07 . 폴더를 만들어야함
        String folderName = str.replace("-", File.separator); //win  \\   mac /
        File uploadFolder = new File(uploadPath, folderName);
        // 폴더가 있는 지 확인
        if (uploadFolder.exists() == false) {
            uploadFolder.mkdirs(); //폴더가 자동으로 만들어진다
            //경로 반환
        }

        return folderName;
    }
}