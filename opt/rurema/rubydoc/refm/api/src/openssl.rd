#@if (version >= "1.8.0")
OpenSSL �� Ruby ���鰷������Υ饤�֥��Ǥ���
#@# = openssl

[[url:http://www.openssl.org]] support library for Ruby.
ư���Ȥ���Ź�������

[[unknown:��ɮ���罸]]

=== Components

  * [[c:OpenSSL]]
  * OpenSSL::Cipher
    * [[c:OpenSSL::Cipher::Cipher]]
    * �ʲ��Υ��饹�� Cipher ��Ѿ����Ƥ��롣�Ȥ����� Cipher �򻲾ȡ�
    * OpenSSL::Cipher::AES
    * OpenSSL::Cipher::BF
    * OpenSSL::Cipher::CAST5
    * OpenSSL::Cipher::DES
    * OpenSSL::Cipher::IDEA
    * OpenSSL::Cipher::RC2
    * OpenSSL::Cipher::RC4
    * OpenSSL::Cipher::RC5
  * OpenSSL::Digest
    * [[c:OpenSSL::Digest::Digest]]
    * �ʲ��Υ��饹�� Digest ��Ѿ����Ƥ��롣�Ȥ����� Digest �򻲾ȡ�
    * OpenSSL::Digest::DSS1
    * OpenSSL::Digest::MD2
    * OpenSSL::Digest::MD4
    * OpenSSL::Digest::MD5
    * OpenSSL::Digest::MDC2
    * OpenSSL::Digest::RIPEMD160
    * OpenSSL::Digest::SHA
    * OpenSSL::Digest::SHA1
    * OpenSSL::Digest::SHA224
    * OpenSSL::Digest::SHA256
    * OpenSSL::Digest::SHA384
    * OpenSSL::Digest::SHA512
  * OpenSSL::X509
    * [[c:OpenSSL::X509::Certificate]]
    * [[c:OpenSSL::X509::CRL]]
    * [[c:OpenSSL::X509::Extension]]
    * [[c:OpenSSL::X509::Name]]
    * [[c:OpenSSL::X509::Store]]
    * [[c:OpenSSL::X509::StoreContext]]
  * [[c:OpenSSL::SSL]]
    * [[c:OpenSSL::SSL::SSLContext]]
    * [[c:OpenSSL::SSL::SSLServer]]
    * [[c:OpenSSL::SSL::SSLSocket]]
  * [[c:OpenSSL::PKCS7]]
    * [[c:OpenSSL::PKCS7::PKCS7]]
  * OpenSSL::PKey
    * [[c:OpenSSL::PKey::PKey]]
    * [[c:OpenSSL::PKey::RSA]]
    * [[c:OpenSSL::PKey::DSA]]
    * [[c:OpenSSL::PKey::DH]]
  * OpenSSL::Config
  * OpenSSL::Engine
  * [[c:OpenSSL::ASN1]]
    * [[c:OpenSSL::ASN1::ASN1Data]]
      * [[c:OpenSSL::ASN1::Primitive]]
        * OpenSSL::ASN1::Boolean
        * OpenSSL::ASN1::Integer
        * OpenSSL::ASN1::Enumerated
        * OpenSSL::ASN1::BitString
        * OpenSSL::ASN1::OctetString
        * OpenSSL::ASN1::UTF8String
        * OpenSSL::ASN1::NumericString
        * OpenSSL::ASN1::PrintableString
        * OpenSSL::ASN1::T61String
        * OpenSSL::ASN1::VideotexString
        * OpenSSL::ASN1::IA5String
        * OpenSSL::ASN1::GraphicString
        * OpenSSL::ASN1::ISO64String
        * OpenSSL::ASN1::GeneralString
        * OpenSSL::ASN1::UniversalString
        * OpenSSL::ASN1::BMPString
        * OpenSSL::ASN1::Null
        * [[c:OpenSSL::ASN1::ObjectId]]
        * OpenSSL::ASN1::UTCTime
        * OpenSSL::ASN1::GeneralizedTime
      * [[c:OpenSSL::ASN1::Constructive]]
        * OpenSSL::ASN1::Sequence
        * OpenSSL::ASN1::Set

=== ��

���ʽ�̾������κ�������Ǥ�����ʬ����̩���Ǽ�ʬ�θ������˽�̾���Ƥ��뤫�鼫�ʽ�̾�Ǥ���

  require 'openssl'
  
  key = OpenSSL::PKey::RSA.new(1024)
  digest = OpenSSL::Digest::SHA1.new()
  
  issu = sub = OpenSSL::X509::Name.new()
  sub.add_entry('C', 'JP')
  sub.add_entry('ST', 'Shimane')
  sub.add_entry('CN', 'Ruby Taro')
  
  cer = OpenSSL::X509::Certificate.new()
  cer.not_before = Time.at(0)
  cer.not_after = Time.at(0)
  cer.public_key = key  # <= ��̾�����оݤȤʤ������
  cer.serial = 1
  cer.issuer = issu
  cer.subject = sub
  
  cer.sign(key, digest) # <= ��̾����Τ˻Ȥ���̩���ȥϥå���ؿ�
  print cer.to_text

= module OpenSSL

���Υڡ�����������㳰�Τߤ��������Ƥ��ޤ���

== Constants

--- VERSION
#@todo

Ruby/OpenSSL �ΥС������Ǥ���

--- OPENSSL_VERSION
#@todo

�����ƥ�˥��󥹥ȡ��뤵��Ƥ��� OpenSSL ���ΤΥС�������ɽ����ʸ����Ǥ���

--- OPENSSL_VERSION_NUMBER
#@todo

�����ƥ�˥��󥹥ȡ��뤵��Ƥ��� OpenSSL ���ΤΥС�������ɽ�������Ǥ���
[[url:http://www.openssl.org/docs/crypto/OPENSSL_VERSION_NUMBER.html]]
�⻲�Ȥ��Ƥ���������
#@end

= module OpenSSL::SSL::SocketForwarder
= class OpenSSL::OpenSSLError < StandardError

#@include(openssl/ASN1)
#@include(openssl/ASN1__ASN1Data)
#@include(openssl/ASN1__Constructive)
#@include(openssl/ASN1__ObjectId)
#@include(openssl/ASN1__Primitive)
#@include(openssl/BN)
#@include(openssl/Cipher__Cipher)
#@include(openssl/Digest__Digest)
#@include(openssl/Engine) 
#@include(openssl/HMAC)
#@include(openssl/Netscape__SPKI)
#@include(openssl/OCSP)
#@include(openssl/PKCS12)
#@include(openssl/PKCS7)
#@include(openssl/PKCS7__PKCS7)
#@include(openssl/PKey__DH)
#@include(openssl/PKey__DSA)
#@include(openssl/PKey__PKey)
#@include(openssl/PKey__RSA)
#@include(openssl/Random)
#@include(openssl/SSL)
#@include(openssl/SSL__SSLContext)
#@include(openssl/SSL__SSLServer)
#@include(openssl/SSL__SSLSocket)
#@include(openssl/X509)
#@include(openssl/X509__Attribute)
#@include(openssl/X509__CRL)
#@include(openssl/X509__Certificate)
#@include(openssl/X509__Extension)
#@include(openssl/X509__ExtensionFactory)
#@include(openssl/X509__Name)
#@include(openssl/X509__Request)
#@include(openssl/X509__Revoked)
#@include(openssl/X509__Store)
#@include(openssl/X509__StoreContext)