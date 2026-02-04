# 💾 Sentiric Database: Veri Şema Ağı (Data Mesh)

Bu depo, Sentiric platformunun **Veri Şeması Otoritesidir (Schema Authority)**.
Platformun **Database-per-Service** (Her Servis İçin Ayrı Veritabanı) mimarisine uygun olarak, tüm tabloların, indekslerin ve tetikleyicilerin (triggers) tanımlarını barındırır.

## 🏗️ Mimari Yapı: Granüler Klasörleme

Veritabanı yönetimi tek bir dosya yerine, servis bazlı izole klasörlerde yönetilir.

```text
sql/postgres/
├── 00_init/                    # Global Başlangıç
│   └── 00_create_databases.sql # Veritabanlarını yaratır
├── 00_global/                  # Global Eklentiler
│   └── 01_extensions.sql       # uuid-ossp vb.
├── user/                       # [User Service] Veritabanı
│   ├── 01_tables/              # Tablo Tanımları (CREATE TABLE)
│   ├── 02_indexes/             # Performans İndeksleri
│   └── 03_triggers/            # Otomasyonlar
├── dialplan/                   # [Dialplan Service] Veritabanı
├── agent/                      # [Agent Service] Veritabanı
└── ...
```

## 📜 Kurallar
1.  **Sadece Yapı:** Bu repoda asla `INSERT` (Veri) komutu bulunmaz. Veriler `sentiric-config` reposundadır.
2.  **Dokümantasyon:** Her `CREATE TABLE` komutu, tablo ve sütunların ne işe yaradığını açıklayan `COMMENT ON` komutlarını içermelidir.
3.  **İzolasyon:** Servisler arası `FOREIGN KEY` (Yabancı Anahtar) kullanımı yasaktır. Tutarlılık uygulama katmanında sağlanır.
