package com.noriteo.delinori.qna.controller;

import com.noriteo.delinori.common.dto.UploadResponseDTO;
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
public class QnaUploadController {

    @ResponseBody
    @PostMapping("/qna/removeFile")
    public ResponseEntity<String> removeFile(@RequestBody Map<String, String> data) throws Exception {

        File file = new File("C:\\upload" + File.separator + data.get("fileName"));

        boolean checkImage = Files.probeContentType(file.toPath()).startsWith("image");

        file.delete();

        if(checkImage) {
            File thumbnail = new File(file.getParent(), "s_" + file.getName());
            log.info(thumbnail);
            thumbnail.delete();
        }
        return ResponseEntity.ok().body("delete");
    }

    @GetMapping("/qna/downFile")
    public ResponseEntity<byte[]> download(@RequestParam("file") String fileName) throws Exception {

        File file = new File("C:\\upload" + File.separator + fileName);

        String originalFileName = fileName.substring(fileName.indexOf("_") + 1);

        HttpHeaders headers = new HttpHeaders();

        headers.add("Content-Type", "application/octet-stream");

        headers.add("Content-Disposition", "attachment; filename="
                + new String(originalFileName.getBytes(StandardCharsets.UTF_8),"ISO-8859-1"));
        byte[] data = FileCopyUtils.copyToByteArray(file);

        return ResponseEntity.ok().headers(headers).body(data);

    }

    @GetMapping("/qna/viewFile")
    @ResponseBody
    public ResponseEntity<byte[]> viewFile(@RequestParam("file") String fileName) throws Exception {//파라미터보낼 때는 파일 받을때는 변수 //타입 달라도 쓸 수 있게

        File file = new File("C:\\upload" + File.separator + fileName);

        log.info(file);

        ResponseEntity<byte[]> result = null;

        byte[] data = FileCopyUtils.copyToByteArray(file);

        String mimeType = Files.probeContentType(file.toPath());

        log.info("mimeType: " + mimeType);

        result = ResponseEntity.ok().header("Content-Type", mimeType).body(data);

        return result;

    }

    @ResponseBody
    @PostMapping("qna/upload")
    public List<UploadResponseDTO> uploadPost(MultipartFile[] uploadFiles) {//jsp에서 append()에 사용한 이름 파라미터로 줘야함

        log.info("c uploadPost-----------------------------------");

        if (uploadFiles != null && uploadFiles.length > 0) {

            List<UploadResponseDTO> uploadedList = new ArrayList<>(); //객체 담는 생성자

            for (MultipartFile multipartFile : uploadFiles) {
                try {
                    uploadedList.add(uploadProcess(multipartFile));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }//for

            return uploadedList;

        }//end

        return null;

    }

    private UploadResponseDTO uploadProcess(MultipartFile multipartFile) throws Exception {

        String uploadPath = "C:\\upload";

        String folderName = makeFolder(uploadPath); // 2021-09-07 //경로

        //log.info(multipartFile.getContentType()); //MIME 타입
        //log.info(multipartFile.getOriginalFilename());
        log.info(multipartFile.getSize());
        log.info("c uploadProcess-----------------------------------");

        String fileName = multipartFile.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
        String originalFileName = fileName;

        fileName = uuid + "_" + fileName; //uuid

        File savedFile = new File(uploadPath+File.separator+folderName, fileName);

        FileCopyUtils.copy(multipartFile.getBytes(), savedFile);

        //Thumbnail 처리
        String mimeType = multipartFile.getContentType();
        boolean checkImage = mimeType.startsWith("image");

        if(checkImage) {
            File thumbnailFile = new File(uploadPath+File.separator+folderName, "s_" + fileName);
            Thumbnailator.createThumbnail(savedFile, thumbnailFile, 100, 100);
        }

        return UploadResponseDTO.builder()
                .uuid(uuid)
                .uploadPath(folderName.replace(File.separator,"/"))
                .fileName(originalFileName)
                .image(checkImage)
                .build();

    }

    private String makeFolder(String uploadPath) {

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = simpleDateFormat.format(date); //2021-09-07
        String folderName = str.replace("-", File.separator);
        File uploadFolder = new File(uploadPath, folderName);

        if(uploadFolder.exists() == false) {
            uploadFolder.mkdirs();
        }

        return folderName;

    }


}
