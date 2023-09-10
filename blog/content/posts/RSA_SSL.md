---
title: "自签 RSA SSL 证书"
author: "Hertz Hwang"
description: "通过 openssl 制作自签 RSA SSL 证书"
categories: [
    "SSL/TLS",
]
tags: [
    "SSL",
    "TLS",
    "openssl",
]

date: 2023-05-13T14:16:33+08:00
draft: false
---

## 一、新建 test_cert 目录用于存放证书以及相关文件
```bash
root@raksmartSV10MCN2:~# mkdir test_cert
root@raksmartSV10MCN2:~# cd test_cert
```

## 二、使用 openssl 分别生成服务端和客户端的公钥及私钥
### 2.1 生成服务端私钥
```bash
root@raksmartSV10MCN2:~/test_cert# openssl genrsa -out server.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
...................................................................................................................................................................+++++
.............................................................+++++
e is 65537 (0x010001)
```
### 2.2 生成服务端公钥
```bash
root@raksmartSV10MCN2:~/test_cert# openssl rsa -in server.key -pubout -out server.pem
writing RSA key
```
### 2.3 生成客户端私钥
```bash
root@raksmartSV10MCN2:~/test_cert# openssl genrsa -out client.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
................................+++++
......+++++
e is 65537 (0x010001)
```
### 2.4 生成客户端公钥
```bash
root@raksmartSV10MCN2:~/test_cert# openssl rsa -in client.key -pubout -out client.pem
writing RSA key
```

## 三、生成 CA 证书
### 3.1 生成CA私钥
```bash
root@raksmartSV10MCN2:~/test_cert# openssl genrsa -out ca.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
............................................................................+++++
..................+++++
e is 65537 (0x010001)
```
### 3.2 生成 CA 证书签名请求文件 CSR
```bash
root@raksmartSV10MCN2:~/test_cert# openssl req -new -key ca.key -out ca.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Fujian
Locality Name (eg, city) []:Fuzhou
Organization Name (eg, company) [Internet Widgits Pty Ltd]:26hz
Organizational Unit Name (eg, section) []:26hz
Common Name (e.g. server FQDN or YOUR name) []:test.26hz.local
Email Address []:hertz@26hz.com.cn

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:wH@teVertESt
An optional company name []:HertzSpace
```
### 3.3 使用私钥 KEY 文件和 CSR 文件签名生成 CRT 证书
```bash
root@raksmartSV10MCN2:~/test_cert# openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = 26hz, OU = 26hz, CN = test.26hz.local, emailAddress = hertz@26hz.com.cn
Getting Private key
```

## 四、生成服务器端和客户端 CRT 证书
### 4.1 生成服务端签名请求 CSR 文件
```bash
root@raksmartSV10MCN2:~/test_cert# openssl req -new -key server.key -out server.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Fujian
Locality Name (eg, city) []:Fuzhou
Organization Name (eg, company) [Internet Widgits Pty Ltd]:26hz
Organizational Unit Name (eg, section) []:26hz
Common Name (e.g. server FQDN or YOUR name) []:test.26hz.local
Email Address []:hertz@26hz.com.cn

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:wH@teVertESt
An optional company name []:HertzSpace
```
### 4.2 生成客户端签名请求 CSR 文件
```bash
root@raksmartSV10MCN2:~/test_cert# openssl req -new -key client.key -out client.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Fujian
Locality Name (eg, city) []:Fuzhou
Organization Name (eg, company) [Internet Widgits Pty Ltd]:26hz
Organizational Unit Name (eg, section) []:26hz
Common Name (e.g. server FQDN or YOUR name) []:test.26hz.local
Email Address []:hertz@26hz.com.cn

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:wH@teVertESt
An optional company name []:HertzSpace
```
### 4.3 向刚才生成的自己的 CA 机构申请签名 CRT 证书（服务端和客户端）
```bash
root@raksmartSV10MCN2:~/test_cert# openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = 26hz, OU = 26hz, CN = test.26hz.local, emailAddress = hertz@26hz.com.cn
Getting CA Private Key
root@raksmartSV10MCN2:~/test_cert# openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in client.csr -out client.crt
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = 26hz, OU = 26hz, CN = test.26hz.local, emailAddress = hertz@26hz.com.cn
Getting CA Private Key
```

## 五、生成需要的 key 和 crt 文件
```bash
root@raksmartSV10MCN2:~/test_cert# openssl rsa -in server.key -out server_nginx.key
writing RSA key
root@raksmartSV10MCN2:~/test_cert# openssl x509 -req -days 3650 -in server.csr -signkey server_nginx.key -out server_nginx.crt
Signature ok
subject=C = CN, ST = Fujian, L = Fuzhou, O = 26hz, OU = 26hz, CN = test.26hz.local, emailAddress = hertz@26hz.com.cn
Getting Private key
```
