---
title: "自签 ECC SSL 证书"
author: "Hertz Hwang"
description: "通过 openssl 制作自签 ECC SSL 证书"
categories: [
    "SSL/TLS",
]
tags: [
    "SSL",
    "TLS",
    "openssl",
]
cover: "https://www.ssl.com/wp-content/uploads/2019/10/ssl-logo-black.svg"

date: 2023-05-13T18:53:27+08:00
draft: false
---

## 一、新建 test_cert/ECC_test 目录用于存放证书以及相关文件
```bash
root@raksmartSV10MCN2:~# mkdir -p test_cert/ECC_test
root@raksmartSV10MCN2:~# cd test_cert/ECC_test
```

## 二、CA 根证书部分
### 2.1 制作根证书私钥
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl ecparam -out CA.key -name prime256v1 -genkey
```
### 2.2 制作根证书请求
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl req -key CA.key -new -out CA.csr -subj "/C=CN/ST=Fujian/L=Fuzhou/O=HertzCert, Inc./OU=HertzCert/CN=HertzCert TLS Hybrid ECC NistP-256 2023 CA1/emailAddress=hertz@26hz.com.cn"
```
### 2.3 制作根证书自签名证书
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl x509 -req -in CA.csr -signkey CA.key -out CA.crt -days 3650
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = "HertzCert, Inc.", OU = HertzCert, CN = HertzCert TLS Hybrid ECC NistP-256 2023 CA1, emailAddress = hertz@26hz.com.cn
Getting Private key
```
## 三、服务器证书部分
### 3.1 制作服务器私钥
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl ecparam -out server.key -name prime256v1 -genkey
```
### 3.2 制作服务器请求
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl req -key server.key -new -out server.csr -subj "/C=CN/ST=Fujian/L=Fuzhou/O=26hz, Std./OU=26hz/CN=*.h.lan/emailAddress=hertz@26hz.com.cn"
```
### 3.3 制作 extension.cnf
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# cat << EOF > ./extension.cnf
[ req ]
default_bits            = 4096
distinguished_name      = req_distinguished_name
req_extensions          = san
extensions              = san
[ req_distinguished_name ]
countryName             = Definesys
stateOrProvinceName     = Definesys
localityName            = Definesys
organizationName        = Definesys
organizationalUnitName  = Definesys
[ SAN ]
authorityKeyIdentifier  = keyid,issuer
basicConstraints        = CA:FALSE
keyUsage                = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName          = @SubjectAlternativename
[SubjectAlternativename]
DNS.1                   = h.lan
DNS.2                   = *.h.lan
EOF
```
### 3.4 制作服务器证书
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl x509 -req -in server.csr -CA CA.crt -CAkey CA.key -out server.crt -CAcreateserial -days 3650 -extfile extension.cnf -extensions SAN
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = "26hz, Std.", OU = 26hz, CN = *.h.lan, emailAddress = hertz@26hz.com.cn
Getting CA Private Key
```

## 四、客户端证书部分
### 4.1 制作客户端私钥
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl ecparam -out client.key -name prime256v1 -genkey
```
### 4.2 制作客户端请求
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl req -key client.key -new -out client.csr -subj "/C=CN/ST=Fujian/L=Fuzhou/O=26hz, Std./OU=26hz/CN=*.h.lan/emailAddress=hertz@26hz.com.cn"
```
### 4.3 制作客户端证书
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl x509 -req -in client.csr -CA CA.crt -CAkey CA.key -out client.crt -CAcreateserial -days 3650 -extfile extension.cnf -extensions SAN
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = "26hz, Std.", OU = 26hz, CN = *.h.lan, emailAddress = hertz@26hz.com.cn
Getting CA Private Key
```

## 五、生成 PKCS12 格式证书
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl pkcs12 -export -out CA.p12 -in CA.crt -inkey CA.key
Enter Export Password:
Verifying - Enter Export Password:
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl pkcs12 -export -out server.p12 -in server.crt -inkey server.key
Enter Export Password:
Verifying - Enter Export Password:
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl pkcs12 -export -out client.p12 -in client.crt -inkey client.key
Enter Export Password:
Verifying - Enter Export Password:
root@raksmartSV10MCN2:~/test_cert/ECC_test# ls -alh
total 64K
drwxr-xr-x 2 root root 4.0K May  6 04:31 .
drwxr-xr-x 5 root root 4.0K May  5 23:20 ..
-rw-r--r-- 1 root root  895 May  6 04:26 CA.crt
-rw-r--r-- 1 root root  578 May  6 04:26 CA.csr
-rw------- 1 root root  302 May  6 04:26 CA.key
-rw------- 1 root root 1.2K May  6 04:31 CA.p12
-rw-r--r-- 1 root root   41 May  6 04:30 CA.srl
-rw-r--r-- 1 root root 1.2K May  6 04:30 client.crt
-rw-r--r-- 1 root root  513 May  6 04:29 client.csr
-rw------- 1 root root  302 May  6 04:28 client.key
-rw------- 1 root root 1.4K May  6 04:31 client.p12
-rw-r--r-- 1 root root  542 May  6 04:27 extension.ext
-rw-r--r-- 1 root root 1.2K May  6 04:28 server.crt
-rw-r--r-- 1 root root  513 May  6 04:27 server.csr
-rw------- 1 root root  302 May  6 04:26 server.key
-rw------- 1 root root 1.4K May  6 04:31 server.p12
```

## 六、查看证书信息
```bash
root@raksmartSV10MCN2:~/test_cert/ECC_test# openssl x509 -in CA.crt -text
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number:
            1d:fa:f8:b0:38:2e:74:c3:46:84:8a:6b:44:0f:4e:69:8c:b5:00:8d
        Signature Algorithm: ecdsa-with-SHA256
        Issuer: C = CN, ST = Fujian, L = Fuzhou, O = "HertzCert, Inc.", OU = HertzCert, CN = HertzCert TLS Hybrid ECC NistP-256 2023 CA1, emailAddress = hertz@26hz.com.cn
        Validity
            Not Before: May  7 01:12:34 2023 GMT
            Not After : May  4 01:12:34 2033 GMT
        Subject: C = CN, ST = Fujian, L = Fuzhou, O = "HertzCert, Inc.", OU = HertzCert, CN = HertzCert TLS Hybrid ECC NistP-256 2023 CA1, emailAddress = hertz@26hz.com.cn
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (256 bit)
                pub:
                    04:8f:21:15:d1:a7:8d:ac:33:2f:9d:ca:e6:2a:d2:
                    54:5d:42:11:e9:b2:57:0a:b7:0e:1e:de:10:0a:76:
                    da:94:80:7b:5a:72:6b:f5:6f:da:94:2a:d3:94:c0:
                    17:9e:9f:4f:2c:cb:fa:62:f2:7c:7a:96:dd:20:63:
                    bc:ae:24:7d:2b
                ASN1 OID: prime256v1
                NIST CURVE: P-256
    Signature Algorithm: ecdsa-with-SHA256
         30:45:02:21:00:f2:4b:25:a5:a5:7d:1c:83:81:ca:73:a9:49:
         1a:23:f1:ac:49:a6:28:54:93:0c:92:90:c7:28:98:2e:39:73:
         cf:02:20:40:97:17:f6:7b:9b:86:24:95:45:dc:a5:cf:d8:05:
         fa:1f:31:25:d6:e9:b6:f7:b5:70:4a:3d:5a:e2:c5:83:38
-----BEGIN CERTIFICATE-----
MIICZzCCAg0CFB36+LA4LnTDRoSKa0QPTmmMtQCNMAoGCCqGSM49BAMCMIG1MQsw
CQYDVQQGEwJDTjEPMA0GA1UECAwGRnVqaWFuMQ8wDQYDVQQHDAZGdXpob3UxGDAW
BgNVBAoMD0hlcnR6Q2VydCwgSW5jLjESMBAGA1UECwwJSGVydHpDZXJ0MTQwMgYD
VQQDDCtIZXJ0ekNlcnQgVExTIEh5YnJpZCBFQ0MgTmlzdFAtMjU2IDIwMjMgQ0Ex
MSAwHgYJKoZIhvcNAQkBFhFoZXJ0ekAyNmh6LmNvbS5jbjAeFw0yMzA3MDcwMTEy
MzRaFw0zMzA3MDQwMTEyMzRaMIG1MQswCQYDVQQGEwJDTjEPMA0GA1UECAwGRnVq
aWFuMQ8wDQYDVQQHDAZGdXpob3UxGDAWBgNVBAoMD0hlcnR6Q2VydCwgSW5jLjES
MBAGA1UECwwJSGVydHpDZXJ0MTQwMgYDVQQDDCtIZXJ0ekNlcnQgVExTIEh5YnJp
ZCBFQ0MgTmlzdFAtMjU2IDIwMjMgQ0ExMSAwHgYJKoZIhvcNAQkBFhFoZXJ0ekAy
Nmh6LmNvbS5jbjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABI8hFdGnjawzL53K
5irSVF1CEemyVwq3Dh7eEAp22pSAe1pya/Vv2pQq05TAF56fTyzL+mLyfHqW3SBj
vK4kfSswCgYIKoZIzj0EAwIDSAAwRQIhAPJLJaWlfRyDgcpzqUkaI/GsSaYoVJMM
kpDHKJguOXPPAiBAlxf2e5uGJJVF3KXP2AX6HzEl1um297VwSj1a4sWDOA==
-----END CERTIFICATE-----
```
