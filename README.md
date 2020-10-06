# Script backup hệ thống GNU/Linux servers
**Tác giả:** Nguyễn Chí Thiện (https://nguyenchithien.vn)
#### Backup linux system scripts
Sử dụng những scripts này để tạo ra bản backup các folders/files trên hệ thống Linux và mã hóa bản backup bằng cách sử dụng OpenSSL

### Tính năng chính

- Backup các files và thư mục chỉ định (script-backup-system.sh)
- Tạo ra keys mã hóa và giải mã (script-generate-keys.sh)
- Mã hóa bản backup bằng cách sử dụng OpenSSL

### Hướng dẫn sử dụng

1. Tạo ra bộ keys để mã hóa/giải mã
    - Đổi tên *PROJECT_NAME, KEYS_PATH* theo vị trí tạo ra keys mà bạn mong muốn ở file **script-generate-keys.sh**
    - Chạy lệnh *sh script-generate-keys.sh* sau đó kiểm tra folder **keys** sẽ tạo ra 2 file **private-key và backup-key**
      ```
      sh script-generate-keys.sh
      ```
2. Sử dụng bộ keys đã tạo ở bước 1 để backup hệ thống
    - Đổi tên *PROJECT_NAME, PUBLIC_IP, BACKUP_PATH* theo vị trí tạo ra bản backup mà bạn mong muốn ở file **script-backup-system.sh**
    - Đổi tên *ENCRYPT_KEY* giống với backup-key ở bước 1
    - Chạy lệnh *sh script-backup-system.sh* sau đó kiểm tra xem có tạo ra file định dạng .enc không, đây là file bản backup đã mã hóa với key bạn tạo ra
      ```
      sh script-backup-system.sh
      ```

3. Tạo crontab tự động chạy backup theo chu kỳ bạn muốn
    - Tạo crontab theo chu kỳ mỗi tháng 1 lần vào lúc 5h15 sáng ngày 1 hàng tháng. Chạy lệnh *crontab -e*
      ```
      crontab -e
      ```
    - Thêm dòng sau vào cuối file: *15 5 1 \* \* sh /home/backup/script-backup-system.sh > /dev/null 2>&1*
      ```
      15 5 1 * * sh /home/backup/script-backup-system.sh > /dev/null 2>&1
      ```
      Nhớ chỉnh lại đường dẫn file script-backup-system.sh theo đường dẫn file của bạn. 

### Lưu ý
  - Để bảo mật các bạn nên chép file private-key ra chỗ khác, không lưu trên cùng 1 server. Vì đây là file bạn dùng để giải mã các bản backup.
  - Để **giải mã** bạn chạy lệnh sau và *đổi tên file enc và tên file private-key tương ứng*
      ```
      openssl smime -decrypt -binary -in backup-system-sample-project-123.123.123.123-2020106.tar.gz.enc -inform DER -out backup-system-sample-project-123.123.123.123-2020106.tar.gz -inkey keys/sample-project-private-key-20201006120928.pem
      ```

### Yêu cầu hệ thống

- openssl
- tar
